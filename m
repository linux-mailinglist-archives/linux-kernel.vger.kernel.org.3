Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01F9446ED78
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241287AbhLIQwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:52:44 -0500
Received: from out28-147.mail.aliyun.com ([115.124.28.147]:54517 "EHLO
        out28-147.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236947AbhLIQwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:52:23 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5673928|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0144348-0.0113035-0.974262;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047187;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.M7WqoBf_1639068516;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.M7WqoBf_1639068516)
          by smtp.aliyun-inc.com(10.147.44.145);
          Fri, 10 Dec 2021 00:48:48 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: timer: Add bindings for new Ingenic SoCs.
Date:   Fri, 10 Dec 2021 00:48:34 +0800
Message-Id: <1639068516-5577-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639068516-5577-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1639068516-5577-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OST bindings for the X1600 SoC, the X1830 SoC,
the X2000 SoC and the X2500 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
---
 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
index 98648bf..a3b1429 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
@@ -20,7 +20,12 @@ properties:
   compatible:
     enum:
       - ingenic,x1000-ost
-      - ingenic,x2000-ost
+      - ingenic,x1600-ost
+      - ingenic,x1830-ost
+      - ingenic,x2000-ost64
+      - ingenic,x2000-ost32
+      - ingenic,x2500-ost64
+      - ingenic,x2500-ost32
 
   reg:
     maxItems: 1
-- 
2.7.4

