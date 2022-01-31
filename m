Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6DC4A3FD6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358099AbiAaKCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:02:32 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7716 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1357989AbiAaKCW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:02:22 -0500
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20V4DiXY032215;
        Mon, 31 Jan 2022 05:02:21 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3dx8jbrkjh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 05:02:21 -0500
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 20VA2K1Q023790
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jan 2022 05:02:20 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 31 Jan 2022 05:02:19 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Mon, 31 Jan 2022 05:02:19 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Mon, 31 Jan 2022 05:02:19 -0500
Received: from amiclaus-VirtualBox.ad.analog.com (AMICLAUS-L02.ad.analog.com [10.48.65.119])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 20VA26eQ009375;
        Mon, 31 Jan 2022 05:02:14 -0500
From:   Antoniu Miclaus <antoniu.miclaus@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Subject: [PATCH v5 4/4] MAINTAINERS: add maintainer for ADMV1014 driver
Date:   Mon, 31 Jan 2022 12:01:02 +0200
Message-ID: <20220131100102.15372-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220131100102.15372-1-antoniu.miclaus@analog.com>
References: <20220131100102.15372-1-antoniu.miclaus@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: 7dhsPbKV4TB1WvY1goA1rhTCvvdv22HF
X-Proofpoint-ORIG-GUID: 7dhsPbKV4TB1WvY1goA1rhTCvvdv22HF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_02,2022-01-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310067
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as maintainer for the ADMV1014 driver.

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
no changes in v5.
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 170bbbeefc3f..b05148cfd4aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1119,6 +1119,14 @@ W:	http://ez.analog.com/community/linux-device-drivers
 F:	Documentation/devicetree/bindings/hwmon/adi,adm1177.yaml
 F:	drivers/hwmon/adm1177.c
 
+ANALOG DEVICES INC ADMV1014 DRIVER
+M:	Antoniu Miclaus <antoniu.miclaus@analog.com>
+L:	linux-iio@vger.kernel.org
+S:	Supported
+W:	https://ez.analog.com/linux-software-drivers
+F:	Documentation/devicetree/bindings/iio/frequency/adi,admv1014.yaml
+F:	drivers/iio/frequency/admv1014.c
+
 ANALOG DEVICES INC ADP5061 DRIVER
 M:	Michael Hennerich <Michael.Hennerich@analog.com>
 L:	linux-pm@vger.kernel.org
-- 
2.35.0

