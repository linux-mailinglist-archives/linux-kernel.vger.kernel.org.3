Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4AF58D884
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 13:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243055AbiHIL6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 07:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240188AbiHIL6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 07:58:21 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C4BCE24
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 04:58:20 -0700 (PDT)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279BVgED012666;
        Tue, 9 Aug 2022 07:58:13 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3hudyckh6n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 07:58:13 -0400
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 279BwCQP033823
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 9 Aug 2022 07:58:12 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Aug 2022 07:58:11 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 9 Aug 2022 07:58:11 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 9 Aug 2022 07:58:11 -0400
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.134])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 279Bvw5I024498;
        Tue, 9 Aug 2022 07:58:04 -0400
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <jic23@kernel.org>, <nuno.sa@analog.com>,
        <cosmin.tanislav@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH] MAINTAINERS: fix Analog Devices forum links
Date:   Tue, 9 Aug 2022 14:57:47 +0300
Message-ID: <20220809115747.11303-1-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: yaBeWKavo-smfpchArCw2wutbg5WRm4q
X-Proofpoint-GUID: yaBeWKavo-smfpchArCw2wutbg5WRm4q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_03,2022-08-09_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 mlxscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2206140000 definitions=main-2208090052
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the links to redirect to the correct forum subsection for the latest
Analog Devices drivers added.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index b7221f4143cb..2c440f3d90e3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -615,7 +615,7 @@ ADXL367 THREE-AXIS DIGITAL ACCELEROMETER DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/accel/adi,adxl367.yaml
 F:	drivers/iio/accel/adxl367*
 
@@ -1147,7 +1147,7 @@ ANALOG DEVICES INC AD74413R DRIVER
 M:	Cosmin Tanislav <cosmin.tanislav@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/devicetree/bindings/iio/addac/adi,ad74413r.yaml
 F:	drivers/iio/addac/ad74413r.c
 F:	include/dt-bindings/iio/addac/adi,ad74413r.h
@@ -11913,7 +11913,7 @@ LTC2688 IIO DAC DRIVER
 M:	Nuno Sá <nuno.sa@analog.com>
 L:	linux-iio@vger.kernel.org
 S:	Supported
-W:	http://ez.analog.com/community/linux-device-drivers
+W:	https://ez.analog.com/linux-software-drivers
 F:	Documentation/ABI/testing/sysfs-bus-iio-dac-ltc2688
 F:	Documentation/devicetree/bindings/iio/dac/adi,ltc2688.yaml
 F:	drivers/iio/dac/ltc2688.c
-- 
2.37.1

