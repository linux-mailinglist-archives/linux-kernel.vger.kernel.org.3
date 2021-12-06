Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C953046A089
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:03:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445029AbhLFQFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:05:23 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:48620 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1444094AbhLFQCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:02:05 -0500
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B6AXUYw010394;
        Mon, 6 Dec 2021 16:58:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=selector1;
 bh=pDwLNxoPVdngPGAwJNxCRNmFgUdFa3lK4eYudZI1Jbk=;
 b=2P6Tv4nX5h07mFWourGbGL/m9oyNX13k+v78t3Lft/4/yNH8t2DOgoVKyybBdTdDcOX3
 d+nDYRSM5xC3AkpB+TTj3fb3Zmlk+AjlFK+T62XjGEPhmn4hVcJkRQLSBQBHLij5pQG+
 XIa/OHuw+If66RPQPf/w/NfYxdVq4T8W5qJe/BczNTUGhC35+i3DaBp8SaZSMFJVpTek
 KlKQAesEyFr2uYer36jf0Mtnt63agEiW0LgYVjOGXCpTap7ggZIgamnuyo4Upu8o3LKl
 LSTjEjp8gw9lQk6TdQYrWm9sYlFCgJvhkuhZ1J9N3Cynr21jppUGss0WL1L7kQpIrdT1 Ow== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3csb4j3dx2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 16:58:23 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 76D02100034;
        Mon,  6 Dec 2021 16:58:22 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag2node2.st.com [10.75.127.5])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 6EEC320930D;
        Mon,  6 Dec 2021 16:58:22 +0100 (CET)
Received: from localhost (10.75.127.51) by SFHDAG2NODE2.st.com (10.75.127.5)
 with Microsoft SMTP Server (TLS) id 15.0.1497.26; Mon, 6 Dec 2021 16:58:21
 +0100
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
To:     <hminas@synopsys.com>, <gregkh@linuxfoundation.org>,
        <robh+dt@kernel.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <amelie.delaunay@foss.st.com>,
        <fabrice.gasnier@foss.st.com>, <alexandre.torgue@foss.st.com>
Subject: [PATCH 1/3] dt-bindings: usb: document role-switch-default-mode property in dwc2
Date:   Mon, 6 Dec 2021 16:56:41 +0100
Message-ID: <1638806203-6624-2-git-send-email-fabrice.gasnier@foss.st.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638806203-6624-1-git-send-email-fabrice.gasnier@foss.st.com>
References: <1638806203-6624-1-git-send-email-fabrice.gasnier@foss.st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE3.st.com (10.75.127.6) To SFHDAG2NODE2.st.com
 (10.75.127.5)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_05,2021-12-06_02,2021-12-02_01
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

role-switch-default-mode property may be used with usb-role-switch
property to define the default operation mode (by forcing the a-valid or
b-valid) at init.

Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 94e7276..f00867e 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -114,6 +114,8 @@ properties:
 
   usb-role-switch: true
 
+  role-switch-default-mode: true
+
   g-rx-fifo-size:
     $ref: /schemas/types.yaml#/definitions/uint32
     description: size of rx fifo size in gadget mode.
@@ -145,6 +147,7 @@ properties:
 
 dependencies:
   port: [ usb-role-switch ]
+  role-switch-default-mode: [ usb-role-switch ]
 
 required:
   - compatible
-- 
2.7.4

