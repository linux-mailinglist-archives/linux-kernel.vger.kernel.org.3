Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CDC4A942F
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 07:55:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345140AbiBDGzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 01:55:24 -0500
Received: from out29-5.mail.aliyun.com ([115.124.29.5]:53291 "EHLO
        out29-5.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242660AbiBDGzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 01:55:20 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2207622|-1;BR=01201311R341S88rulernew998_84748_2000303;CH=blue;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00879315-0.00140259-0.989804;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047188;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.MlUck3X_1643957718;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.MlUck3X_1643957718)
          by smtp.aliyun-inc.com(10.147.43.95);
          Fri, 04 Feb 2022 14:55:19 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: timer: Remove unreasonable binding.
Date:   Fri,  4 Feb 2022 14:54:40 +0800
Message-Id: <1643957682-39450-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1643957682-39450-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1643957682-39450-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the hardware of X2000 SoC, the OST has been split into two parts,
two 32bit timers for clockevent and one 64bit timer for clocksource
(with different addresses), so it not appropriate to use only one
"ingenic,x2000-ost", just remove it, "ingenic,x2000-ost32" and
"ingenic,x2000-ost64" will be introduced in a later commit.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v2:
    New patch.
    
    v2->v3:
    Add Rob Herring's Acked-by.

 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
index 98648bf..ea3f9c4 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
@@ -20,7 +20,6 @@ properties:
   compatible:
     enum:
       - ingenic,x1000-ost
-      - ingenic,x2000-ost
 
   reg:
     maxItems: 1
-- 
2.7.4

