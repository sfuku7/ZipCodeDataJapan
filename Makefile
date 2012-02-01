
url_kogaki = www.post.japanpost.jp/zipcode/dl/kogaki/lzh
url_roman = www.post.japanpost.jp/zipcode/dl/roman

WORK_DIR=work
PRODUCT_DIR=utf8
ORG_DIR=org

fetch:
	-mkdir ${WORK_DIR}
	wget --output-document=${WORK_DIR}/ken_all.lzh ${url_kogaki}/ken_all.lzh
	touch ${WORK_DIR}/ken_all.lzh
	wget --output-document=${WORK_DIR}/ken_all_rome.lzh ${url_roman}/ken_all_rome.lzh
	touch ${WORK_DIR}/ken_all_rome.lzh
	make char-code
	cp ${WORK_DIR}/ken_all.utf8 ${PRODUCT_DIR}/
	cp ${WORK_DIR}/ken_all_rome.utf8 ${PRODUCT_DIR}/
	cp ${WORK_DIR}/ken_all.csv ${ORG_DIR}/
	cp ${WORK_DIR}/ken_all_rome.csv ${ORG_DIR}/

melt: ${WORK_DIR}/ken_all.csv ${WORK_DIR}/ken_all_rome.csv

char-code: ${WORK_DIR}/ken_all.utf8 ${WORK_DIR}/ken_all_rome.utf8

${WORK_DIR}/%.csv: ${WORK_DIR}/%.lzh
	-mkdir ${WORK_DIR}
	lha e -f -w=${WORK_DIR} $<
	touch $@

%.utf8: %.csv
	nkf -w80 $< > $@


