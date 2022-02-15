Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F094B65A3
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 09:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234718AbiBOIOk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 03:14:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234881AbiBOIOe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 03:14:34 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A786D846;
        Tue, 15 Feb 2022 00:14:24 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21F3PeE5022896;
        Tue, 15 Feb 2022 03:14:23 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3e7kt2mqmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Feb 2022 03:14:23 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 21F8EMZQ024160
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 03:14:22 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 15 Feb 2022 03:14:21 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Tue, 15 Feb 2022 03:14:21 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 15 Feb 2022 03:14:20 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.131])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 21F8Dwti002120;
        Tue, 15 Feb 2022 03:14:14 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v8 3/4] Documentation:ABI:testing:admv1014: add ABI docs
Date:   Tue, 15 Feb 2022 10:12:15 +0200
Message-ID: <20220215081216.67706-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220215081216.67706-1-antoniu.miclaus@analog.com>
References: <20220215081216.67706-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: qr9JO4D7bFgZyyz0jnc1cMqBqqQ-te1x
X-Proofpoint-ORIG-GUID: qr9JO4D7bFgZyyz0jnc1cMqBqqQ-te1x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-15_03,2022-02-14_04,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=999 phishscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202150047
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the use of the Digital Attenuator gain.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 Documentation/ABI/testing/sysfs-bus-iio       |  1 +
 .../testing/sysfs-bus-iio-frequency-admv1014  | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index c551301b33f1..2b5770017a84 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -476,6 +476,7 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
new file mode 100644
index 000000000000..395010a0ef8b
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
@@ -0,0 +1,23 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_coarse
+KernelVersion: 5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the digital attenuator gain (IF_I) with coarse steps.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_coarse
+KernelVersion: 5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the digital attenuator gain (IF_Q) with coarse steps.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_fine
+KernelVersion: 5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the digital attenuator gain (IF_I) with fine steps.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_fine
+KernelVersion: 5.18
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the digital attenuator gain (IF_Q) with fine steps.
-- 
2.35.1

