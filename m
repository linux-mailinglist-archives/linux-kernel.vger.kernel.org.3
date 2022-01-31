Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B149E4A3FC9
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:01:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358070AbiAaKBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:01:41 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:46676 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1358114AbiAaJ7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:59:54 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20V8vMww027165;
        Mon, 31 Jan 2022 10:59:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=selector1;
 bh=fXiYuBUyotv54LQyPZgnEfOt06j2LWRZLDd1yz76l+0=;
 b=jc5cAI3BkAgTG6dNsMw71QR2Jn2ankB6Si2/WODU8SwKEbxDYZ7YgBFVfcBcJX9wRM57
 Hv0JSc+jTvJO6He/tE9vly49ogRqX020NBLTXGIJWyZZOER9q82NMPsowZez7TyOrOKY
 2BlyuCgG22SY6rzi22tA2gvXjSEwmDyRSpydVDg9RcIFUye4t84kq2+6c91h4sBQedyc
 F3EV4jJkUvJjmDl9cqI5CVi8QXY1w86zY0l5/Ya/3kMfugNuN9EPwO9xUcBywgD8R54x
 la5iTr9SmsxNUT0f/x+bgUk8wYb8EDMz5AvlfbGMVpBaEk7xUZny/dJGVqK6mArkVtfX SQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3dwwf3uktb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 10:59:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 0010810002A;
        Mon, 31 Jan 2022 10:59:16 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EB54B212FB3;
        Mon, 31 Jan 2022 10:59:16 +0100 (CET)
Received: from localhost (10.75.127.48) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 31 Jan 2022 10:59:16
 +0100
From:   Christophe Kerello <christophe.kerello@foss.st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <srinivas.kandagatla@linaro.org>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <chenshumin86@sina.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/4] dt-binding: mtd: nand: Document the wp-gpios property
Date:   Mon, 31 Jan 2022 10:57:52 +0100
Message-ID: <20220131095755.8981-2-christophe.kerello@foss.st.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220131095755.8981-1-christophe.kerello@foss.st.com>
References: <20220131095755.8981-1-christophe.kerello@foss.st.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_02,2022-01-28_01,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A few drivers use this property to describe the GPIO pin used to protect
the NAND during program/erase operations.

Signed-off-by: Christophe Kerello <christophe.kerello@foss.st.com>
Acked-by: Rob Herring <robh@kernel.org>
---
Changes in v2:
 - add Rob Acked-by.

 Documentation/devicetree/bindings/mtd/nand-controller.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/mtd/nand-controller.yaml b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
index bd217e6f5018..53b21aed0ac5 100644
--- a/Documentation/devicetree/bindings/mtd/nand-controller.yaml
+++ b/Documentation/devicetree/bindings/mtd/nand-controller.yaml
@@ -154,6 +154,13 @@ patternProperties:
           Ready/Busy pins. Active state refers to the NAND ready state and
           should be set to GPIOD_ACTIVE_HIGH unless the signal is inverted.
 
+      wp-gpios:
+        description:
+          Contains one GPIO descriptor for the Write Protect pin.
+          Active state refers to the NAND Write Protect state and should be
+          set to GPIOD_ACTIVE_LOW unless the signal is inverted.
+        maxItems: 1
+
       secure-regions:
         $ref: /schemas/types.yaml#/definitions/uint64-matrix
         description:
-- 
2.25.1

