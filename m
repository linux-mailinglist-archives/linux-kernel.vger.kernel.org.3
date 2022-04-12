Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43F64FE80B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 20:31:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358738AbiDLSdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 14:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358721AbiDLScc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 14:32:32 -0400
Received: from out28-49.mail.aliyun.com (out28-49.mail.aliyun.com [115.124.28.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500C84EA27;
        Tue, 12 Apr 2022 11:30:13 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1796213|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00899754-0.00548934-0.985513;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047198;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.NPNg.o-_1649788208;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NPNg.o-_1649788208)
          by smtp.aliyun-inc.com(33.37.68.114);
          Wed, 13 Apr 2022 02:30:09 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     gregkh@linuxfoundation.org, hminas@synopsys.com,
        robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     linux-usb@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dragancecavac@yahoo.com, hns@goldelico.com,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v2 1/2] dt-bindings: dwc2: Add bindings for new Ingenic SoCs.
Date:   Wed, 13 Apr 2022 02:30:00 +0800
Message-Id: <1649788201-87620-2-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649788201-87620-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1649788201-87620-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dwc2 bindings for the JZ4775 SoC, the JZ4780 SoC, the X1000
SoC, the X1600 SoC, the X1700 SoC, the X1830 SoC, and the X2000 SoC
from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v1->v2:
    Add Rob Herring's Acked-by.

 Documentation/devicetree/bindings/usb/dwc2.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 4cebce6..c6e8c0b 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -17,6 +17,13 @@ properties:
     oneOf:
       - const: brcm,bcm2835-usb
       - const: hisilicon,hi6220-usb
+      - const: ingenic,jz4775-otg
+      - const: ingenic,jz4780-otg
+      - const: ingenic,x1000-otg
+      - const: ingenic,x1600-otg
+      - const: ingenic,x1700-otg
+      - const: ingenic,x1830-otg
+      - const: ingenic,x2000-otg
       - items:
           - const: rockchip,rk3066-usb
           - const: snps,dwc2
-- 
2.7.4

