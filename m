Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 013B846A06D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351284AbhLFQEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:04:08 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:13128 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244404AbhLFPwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:52:40 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B6CA2bh031788;
        Mon, 6 Dec 2021 10:49:09 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3csj9d8vd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 10:49:09 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1B6Fn83F016089
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 6 Dec 2021 10:49:08 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 6 Dec 2021 10:49:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 6 Dec 2021 10:49:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 6 Dec 2021 10:49:07 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1B6Fn3pM002802;
        Mon, 6 Dec 2021 10:49:06 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v6 3/3] Documentation:ABI:testing:admv1013: add ABI docs
Date:   Mon, 6 Dec 2021 17:48:45 +0200
Message-ID: <20211206154845.268445-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206154845.268445-1-antoniu.miclaus@analog.com>
References: <20211206154845.268445-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: le9guNhiDhJ_mpz8UDlO3DkNCyKxwR7q
X-Proofpoint-ORIG-GUID: le9guNhiDhJ_mpz8UDlO3DkNCyKxwR7q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_05,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for the use of the Local Oscillator Feedthrough Offset
calibration.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
changes in v6:
 - update iio channels
 - remove frequency mode
 .../testing/sysfs-bus-iio-frequency-admv1013  | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
new file mode 100644
index 000000000000..3be68dd54ed4
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-admv1013
@@ -0,0 +1,38 @@
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_i_phase
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the Local Oscillatior path quadrature I phase shift.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0-1_i_phase
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the Local Oscillatior path quadrature Q phase shift.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_i_calibbias
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the Local Oscillatior Feedthrough Offset Calibration I Positive
+		side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage0_q_calibbias
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write value for the Local Oscillatior Feedthrough Offset Calibration Q Positive side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_i_calibbias
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration I Negative
+		side.
+
+What:		/sys/bus/iio/devices/iio:deviceX/in_altvoltage1_q_calibbias
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Read/write raw value for the Local Oscillatior Feedthrough Offset Calibration Q Negative
+		side.
-- 
2.34.1

