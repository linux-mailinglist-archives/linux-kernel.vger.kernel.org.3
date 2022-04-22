Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C4750C06B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 21:37:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiDVTcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 15:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiDVTcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 15:32:04 -0400
Received: from out28-123.mail.aliyun.com (out28-123.mail.aliyun.com [115.124.28.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0E3263CAF;
        Fri, 22 Apr 2022 12:10:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.5166861|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00738068-0.00310186-0.989518;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=14;RT=14;SR=0;TI=SMTPD_---.NVyzeo5_1650654598;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NVyzeo5_1650654598)
          by smtp.aliyun-inc.com(33.37.68.185);
          Sat, 23 Apr 2022 03:09:59 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     broonie@kernel.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, paul@crapouillou.net,
        contact@artur-rojek.eu, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v2 2/3] dt-bindings: SPI: Add bindings for new Ingenic SoCs.
Date:   Sat, 23 Apr 2022 03:09:42 +0800
Message-Id: <1650654583-89933-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650654583-89933-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650654583-89933-1-git-send-email-zhouyanjie@wanyeetech.com>
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

