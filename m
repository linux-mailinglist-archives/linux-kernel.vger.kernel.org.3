Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2901C501B60
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344877AbiDNSwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239861AbiDNSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:52:24 -0400
Received: from out29-50.mail.aliyun.com (out29-50.mail.aliyun.com [115.124.29.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E6E54BC5;
        Thu, 14 Apr 2022 11:49:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=SUSPECT;BC=0.6334277|-1;BR=01201311R441b1;CH=blue;DM=|SUSPECT|false|;DS=CONTINUE|ham_system_inform|0.00793506-0.00425178-0.987813;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047202;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.NQnX3DV_1649962180;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NQnX3DV_1649962180)
          by smtp.aliyun-inc.com(33.40.38.164);
          Fri, 15 Apr 2022 02:49:40 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v5 2/3] dt-bindings: timer: Add bindings for new Ingenic SoCs.
Date:   Fri, 15 Apr 2022 02:49:24 +0800
Message-Id: <1649962165-111806-3-git-send-email-zhouyanjie@wanyeetech.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1649962165-111806-1-git-send-email-zhouyanjie@wanyeetech.com>
References: <1649962165-111806-1-git-send-email-zhouyanjie@wanyeetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the OST bindings for the X1600 SoC, the X1700 SoC, the X1830 SoC,
the X2000 SoC and the X2500 SoC from Ingenic.

Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Notes:
    v1->v2:
    Remove imcompatible change.
    
    v2->v3:
    Add Rob Herring's Acked-by.
    
    v3->v4:
    Add bindings for the X1700 SoC.
    
    v4->v5:
    No change.

 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
index ea3f9c4..1a59ba7 100644
--- a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
+++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
@@ -20,6 +20,13 @@ properties:
   compatible:
     enum:
       - ingenic,x1000-ost
+      - ingenic,x1600-ost
+      - ingenic,x1700-ost
+      - ingenic,x1830-ost
+      - ingenic,x2000-ost64
+      - ingenic,x2000-ost32
+      - ingenic,x2500-ost64
+      - ingenic,x2500-ost32
 
   reg:
     maxItems: 1
-- 
2.7.4

