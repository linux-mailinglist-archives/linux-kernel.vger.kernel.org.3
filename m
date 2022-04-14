Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBF501B62
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 20:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345008AbiDNSwo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 14:52:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238885AbiDNSwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 14:52:24 -0400
Received: from out28-3.mail.aliyun.com (out28-3.mail.aliyun.com [115.124.28.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB9B444A1E;
        Thu, 14 Apr 2022 11:49:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2269944|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00810461-0.00132846-0.990567;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047206;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.NQnX3C._1649962178;
Received: from zhouyanjie-virtual-machine.localdomain(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.NQnX3C._1649962178)
          by smtp.aliyun-inc.com(33.40.38.164);
          Fri, 15 Apr 2022 02:49:39 +0800
From:   =?UTF-8?q?=E5=91=A8=E7=90=B0=E6=9D=B0=20=28Zhou=20Yanjie=29?= 
        <zhouyanjie@wanyeetech.com>
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        krzk+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, reimu@sudomaker.com
Subject: [PATCH v5 1/3] dt-bindings: timer: Remove unreasonable binding.
Date:   Fri, 15 Apr 2022 02:49:23 +0800
Message-Id: <1649962165-111806-2-git-send-email-zhouyanjie@wanyeetech.com>
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
    
    v3->v4:
    No change.
    
    v4->v5:
    No change.

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

