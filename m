Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DBC50CB57
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbiDWOmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiDWOmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:42:02 -0400
Received: from out28-221.mail.aliyun.com (out28-221.mail.aliyun.com [115.124.28.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7DD205D99;
        Sat, 23 Apr 2022 07:39:04 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5245325|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00738897-0.00306992-0.989541;FP=7703943434367737258|1|1|8|0|-1|-1|-1;HT=ay29a033018047192;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=15;RT=15;SR=0;TI=SMTPD_---.NWMtVeT_1650724739;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NWMtVeT_1650724739)
          by smtp.aliyun-inc.com(33.37.75.176);
          Sat, 23 Apr 2022 22:39:00 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        paul@crapouillou.net, contact@artur-rojek.eu,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v3 2/3] dt-bindings: SPI: Add bindings for new Ingenic SoCs.
Date:   Sat, 23 Apr 2022 22:38:44 +0800
Message-Id: <1650724725-93758-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650724725-93758-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650724725-93758-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SPI bindings for the JZ4775 SoC, the X1000 SoC,
and the X2000 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Paul Cercueil <paul@crapouillou.net>
---

Notes:
    v1->v2:
    No change.
    
    v2->v3:
    No change.

 Documentation/devicetree/bindings/spi/ingenic,spi.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/ingenic,spi.yaml b/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
index 5b1c7a2..360f76c 100644
--- a/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
+++ b/Documentation/devicetree/bindings/spi/ingenic,spi.yaml
@@ -18,7 +18,10 @@ properties:
     oneOf:
       - enum:
           - ingenic,jz4750-spi
+          - ingenic,jz4775-spi
           - ingenic,jz4780-spi
+          - ingenic,x1000-spi
+          - ingenic,x2000-spi
       - items:
           - enum:
               - ingenic,jz4760-spi
-- 
2.7.4

