Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04DA949E181
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:47:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240835AbiA0Lrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:47:51 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:57268 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240800AbiA0Lru (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:47:50 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20RBWI96007284;
        Thu, 27 Jan 2022 06:47:43 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dtr97ndk9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Jan 2022 06:47:43 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20RBlgju054188
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jan 2022 06:47:42 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Jan 2022 06:47:20 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Thu, 27 Jan 2022 06:47:20 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Thu, 27 Jan 2022 06:47:19 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.119])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20RBlUdm014283;
        Thu, 27 Jan 2022 06:47:37 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v4 3/4] Documentation:ABI:testing:admv1014: add ABI docs
Date:   Thu, 27 Jan 2022 12:55:57 +0200
Message-ID: <20220127105558.59567-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220127105558.59567-1-antoniu.miclaus@analog.com>
References: <20220127105558.59567-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _MNz17-sHVQsM3EKAgOq9QonT0-hQsws
X-Proofpoint-GUID: _MNz17-sHVQsM3EKAgOq9QonT0-hQsws
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-27_03,2022-01-27_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201270070
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the use of the Digital Attenuator gain.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v4:
 - move `in_altvoltage_calibscale` to sysfs-bus-iio
 Documentation/ABI/testing/sysfs-bus-iio       |  7 ++++++
 .../testing/sysfs-bus-iio-frequency-admv1014  | 23 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014

diff --git a/Documentation/ABI/testing/sysfs-bus-iio b/Documentation/ABI/testing/sysfs-bus-iio
index c551301b33f1..d7d96d3d6b7c 100644
--- a/Documentation/ABI/testing/sysfs-bus-iio
+++ b/Documentation/ABI/testing/sysfs-bus-iio
@@ -476,6 +476,13 @@ What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_i_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY_q_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_i_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_q_calibscale
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Used in microwave converters to read/write value for the
+		digital attenuator gain (I/Q mode).
+
 What:		/sys/bus/iio/devices/iio:deviceX/in_voltage_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_x_calibscale
 What:		/sys/bus/iio/devices/iio:deviceX/in_accel_y_calibscale
diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
new file mode 100644
index 000000000000..5bcd96d77f45
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
@@ -0,0 +1,23 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_coarse
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the digital attenuator gain (IF_I) with coarse steps.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_coarse
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the digital attenuator gain (IF_Q) with coarse steps.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibscale_fine
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the digital attenuator gain (IF_I) with fine steps.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibscale_fine
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the digital attenuator gain (IF_Q) with fine steps.
-- 
2.35.0

