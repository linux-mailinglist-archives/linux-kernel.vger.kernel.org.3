Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 198774BA1F6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241344AbiBQNw3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:52:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241328AbiBQNwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:52:23 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8511ADBA;
        Thu, 17 Feb 2022 05:52:09 -0800 (PST)
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21HDi0SJ022455;
        Thu, 17 Feb 2022 08:52:07 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e9fu11tqy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 08:52:07 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 21HDq6mx050799
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Feb 2022 08:52:06 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Thu, 17 Feb
 2022 08:52:05 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 17 Feb 2022 08:52:05 -0500
Received: from chegbeli-l02.ad.analog.com ([10.48.65.189])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21HDppjX000640;
        Thu, 17 Feb 2022 08:52:02 -0500
From:   chegbeli <ciprian.hegbeli@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     chegbeli <ciprian.hegbeli@analog.com>
Subject: [PATCH 1/3] iio: add meter subdirectory
Date:   Thu, 17 Feb 2022 15:51:38 +0200
Message-ID: <20220217135140.5658-2-ciprian.hegbeli@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220217135140.5658-1-ciprian.hegbeli@analog.com>
References: <20220217135140.5658-1-ciprian.hegbeli@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: i3MvWGBzQIxWxAB9HA5hGQhm56pGP1UV
X-Proofpoint-GUID: i3MvWGBzQIxWxAB9HA5hGQhm56pGP1UV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-17_05,2022-02-17_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202170063
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For IIO devices which are designed to measure and process power
readings.

Signed-off-by: chegbeli <ciprian.hegbeli@analog.com>
---
 drivers/iio/Kconfig        | 1 +
 drivers/iio/Makefile       | 1 +
 drivers/iio/meter/Kconfig  | 9 +++++++++
 drivers/iio/meter/Makefile | 5 +++++
 4 files changed, 16 insertions(+)
 create mode 100644 drivers/iio/meter/Kconfig
 create mode 100644 drivers/iio/meter/Makefile

diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
index b190846c3dc2..892c7f575416 100644
--- a/drivers/iio/Kconfig
+++ b/drivers/iio/Kconfig
@@ -86,6 +86,7 @@ source "drivers/iio/humidity/Kconfig"
 source "drivers/iio/imu/Kconfig"
 source "drivers/iio/light/Kconfig"
 source "drivers/iio/magnetometer/Kconfig"
+source "drivers/iio/meter/Kconfig"
 source "drivers/iio/multiplexer/Kconfig"
 source "drivers/iio/orientation/Kconfig"
 source "drivers/iio/test/Kconfig"
diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
index 3be08cdadd7e..c8afc053fccf 100644
--- a/drivers/iio/Makefile
+++ b/drivers/iio/Makefile
@@ -32,6 +32,7 @@ obj-y += humidity/
 obj-y += imu/
 obj-y += light/
 obj-y += magnetometer/
+obj-y += meter/
 obj-y += multiplexer/
 obj-y += orientation/
 obj-y += position/
diff --git a/drivers/iio/meter/Kconfig b/drivers/iio/meter/Kconfig
new file mode 100644
index 000000000000..d1c91eed5283
--- /dev/null
+++ b/drivers/iio/meter/Kconfig
@@ -0,0 +1,9 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Energy meter drivers
+#
+# When adding new entries keep the list in alphabetical order
+
+menu "Active energy metering"
+
+endmenu
diff --git a/drivers/iio/meter/Makefile b/drivers/iio/meter/Makefile
new file mode 100644
index 000000000000..c27cba44fc0b
--- /dev/null
+++ b/drivers/iio/meter/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for enrgy metering drivers
+#
+# When adding new entries keep the list in alphabetical order
-- 
2.34.1

