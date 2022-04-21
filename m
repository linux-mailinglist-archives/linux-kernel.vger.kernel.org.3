Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DE6150A6CB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390655AbiDURSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387072AbiDURSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:18:20 -0400
Received: from out28-219.mail.aliyun.com (out28-219.mail.aliyun.com [115.124.28.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6F812082;
        Thu, 21 Apr 2022 10:15:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1899639|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.00659511-0.00270009-0.990705;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047194;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.NVFIb9j_1650561319;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NVFIb9j_1650561319)
          by smtp.aliyun-inc.com(33.40.31.76);
          Fri, 22 Apr 2022 01:15:20 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org, tsbogend@alpha.franken.de,
        paul@crapouillou.net
Cc:     linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v4 1/3] dt-bindings: dwc2: Add bindings for new Ingenic SoCs.
Date:   Fri, 22 Apr 2022 01:15:06 +0800
Message-Id: <1650561308-54704-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650561308-54704-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1650561308-54704-1-git-send-email-zhouyanjie@wanyeetech.com>
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

Add the dwc2 bindings for the JZ4775 SoC, the JZ4780 SoC, the X1000 SoC,
the X1600 SoC, the X1830 SoC, and the X2000 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v1->v2:
    Add Rob Herring's Acked-by.
    
    v2->v3:
    No change.
    
    v3->v4:
    Remove the compatible string of X1700 since it could use the X1600 string
    as the fallback.

 Documentation/devicetree/bindings/usb/dwc2.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 4cebce6..2218df8 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -17,6 +17,12 @@ properties:
     oneOf:
       - const: brcm,bcm2835-usb
       - const: hisilicon,hi6220-usb
+      - const: ingenic,jz4775-otg
+      - const: ingenic,jz4780-otg
+      - const: ingenic,x1000-otg
+      - const: ingenic,x1600-otg
+      - const: ingenic,x1830-otg
+      - const: ingenic,x2000-otg
       - items:
           - const: rockchip,rk3066-usb
           - const: snps,dwc2
-- 
2.7.4

