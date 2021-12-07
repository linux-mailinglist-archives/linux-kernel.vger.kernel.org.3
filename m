Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBC246C00E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239287AbhLGP7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:59:04 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7734 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239204AbhLGP6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:58:46 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B79c0dK031612;
        Tue, 7 Dec 2021 10:55:08 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3csj9debmk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Dec 2021 10:55:08 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 1B7Ft7ml042489
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 7 Dec 2021 10:55:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.14; Tue, 7 Dec 2021
 10:55:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Tue, 7 Dec 2021 10:55:06 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.181])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 1B7Ft0E7009082;
        Tue, 7 Dec 2021 10:55:04 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v3 4/4] iio:filter:admv8818: Add sysfs ABI documentation
Date:   Tue, 7 Dec 2021 17:54:45 +0200
Message-ID: <20211207155445.247444-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211207155445.247444-1-antoniu.miclaus@analog.com>
References: <20211207155445.247444-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: arVR6l2h62GUku6KnnKSOwnQIkcBohJe
X-Proofpoint-ORIG-GUID: arVR6l2h62GUku6KnnKSOwnQIkcBohJe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-07_06,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 mlxlogscore=993 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070097
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial ABI documentation for admv8818 filter sysfs interfaces.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 .../ABI/testing/sysfs-bus-iio-filter-admv8818    | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818 b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
new file mode 100644
index 000000000000..f6c035752639
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-filter-admv8818
@@ -0,0 +1,16 @@
+What:		/sys/bus/iio/devices/iio:deviceX/filter_mode_available
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		Reading this returns the valid values that can be written to the
+		on_altvoltage0_mode attribute:
+
+		- auto -> Adjust bandpass filter to track changes in input clock rate.
+		- manual -> disable/unregister the clock rate notifier / input clock tracking.
+
+What:		/sys/bus/iio/devices/iio:deviceX/filter_mode
+KernelVersion:
+Contact:	linux-iio@vger.kernel.org
+Description:
+		This attribute configures the filter mode.
+		Reading returns the actual mode.
-- 
2.34.1

