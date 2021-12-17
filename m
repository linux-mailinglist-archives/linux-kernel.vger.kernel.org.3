Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138BB4790C6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238778AbhLQP5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:57:17 -0500
Received: from out29-101.mail.aliyun.com ([115.124.29.101]:57406 "EHLO
        out29-101.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238669AbhLQP5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:57:15 -0500
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.5915537|-1;BR=01201311R871b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_regular_dialog|0.00895818-0.00341371-0.987628;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.MHd6KPK_1639756624;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.MHd6KPK_1639756624)
          by smtp.aliyun-inc.com(10.147.44.118);
          Fri, 17 Dec 2021 23:57:12 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v2 2/3] dt-bindings: timer: Add bindings for new Ingenic SoCs.
Date:   Fri, 17 Dec 2021 23:57:03 +0800
Message-Id: <1639756624-46435-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1639756624-46435-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1639756624-46435-1-git-send-email-zhouyanjie@wanyeetech.com>
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

Notes:
    v1->v2:
    Remove imcompatible change.

 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
index ea3f9c4..a3b1429 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
@@ -20,6 +20,12 @@ properties:
   compatible:
     enum:
       - ingenic,x1000-ost
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

