Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4794790C4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238729AbhLQP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:57:15 -0500
Received: from out28-173.mail.aliyun.com ([115.124.28.173]:42467 "EHLO
        out28-173.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234564AbhLQP5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:57:14 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2192577|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0087708-0.00148364-0.989746;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047201;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.MHd6KPK_1639756624;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.MHd6KPK_1639756624)
          by smtp.aliyun-inc.com(10.147.44.118);
          Fri, 17 Dec 2021 23:57:12 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: timer: Remove unreasonable binding.
Date:   Fri, 17 Dec 2021 23:57:02 +0800
Message-Id: <1639756624-46435-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639756624-46435-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1639756624-46435-1-git-send-email-zhouyanjie@wanyeetech.com>
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
---

Notes:
    v2:
    New patch.

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

