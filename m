Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A83D8493615
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 09:19:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352263AbiASITl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 03:19:41 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:8262 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233064AbiASITl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 03:19:41 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20J3KsQU004038;
        Wed, 19 Jan 2022 03:19:34 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dnw0vcks8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Jan 2022 03:19:34 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20J8JXjM048123
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Jan 2022 03:19:33 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jan 2022 03:19:32 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 19 Jan 2022 03:19:32 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 19 Jan 2022 03:19:32 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20J8JLn8004163;
        Wed, 19 Jan 2022 03:19:28 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 3/4] Documentation:ABI:testing:admv1014: add ABI docs
Date:   Wed, 19 Jan 2022 10:18:37 +0200
Message-ID: <20220119081838.70210-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220119081838.70210-1-antoniu.miclaus@analog.com>
References: <20220119081838.70210-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: _X6ymW-ToAoVnfkpGd7Sn5NxHjg3KG60
X-Proofpoint-GUID: _X6ymW-ToAoVnfkpGd7Sn5NxHjg3KG60
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-19_06,2022-01-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 suspectscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201190044
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the use of the Digital Attenuator gain.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v3:
 - add description for calibscale in I/Q mode
 .../testing/sysfs-bus-iio-frequency-admv1014  | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
new file mode 100644
index 000000000000..77c1691e6910
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1014
@@ -0,0 +1,29 @@
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
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage_calibscale
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the digital attenuator gain (I/Q).
-- 
2.34.1

