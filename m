Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526024C4D16
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiBYR71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:59:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbiBYR7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:59:21 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DA21BF93A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:48 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id bg16-20020a05600c3c9000b00380f6f473b0so2166268wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TToHHhQ9e3UF7DAGb1X/L762Cx9ZwKjwgUki3iHq62w=;
        b=b1l/w/YSXYX7+AXroPrKESOq2dTiEMdf9vimQ/VnLm62eIy2NGJVm3hk34x+wsIkOb
         f6+CDfRjN3t53enSilCo6dy/7VqHLKdtw9atzEJPMJ72cXMXR6S4r8DvXFxcnaaog2+z
         32+earhfFmLvPwkFwhDS4LLhzuu/me2zdDO8pVkg2+Spmyb1ZVdi5sc2bYqQiZicQswU
         EnzA3Va4hOiejHsk+lXoW7nS84JFbfks0n25/hbFeWxpHrPEj2iSj2ZVf2lSppGDkx/S
         L06LSbk4K/TFmKftG7fupA7EutWWsMU3GcHtTV0kJSzDOa+egw1Lh+tf3ytyAscbRqqb
         zqvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TToHHhQ9e3UF7DAGb1X/L762Cx9ZwKjwgUki3iHq62w=;
        b=iVrAgP32sddt/E8eZavmWJPjHY9C3pLvNL3rbrCNpvGBHyxvr3l9+4DLuGh4QeDar3
         TwskCJQPr7ZN51LpcTQQgQXFfbPD7v1mZwa3ZnW+f3bTk+CPb7jcJl51Jc3ezV33l2JL
         /hA/YXW/kyQPo1NJ98N2kgrNWY4QOliew00YrfH7NQCQlEFEwu8Et85fOXDeAMvkTpdD
         8gIya1TnINku1fGETw9fSgWBFc2Z4HMcVwI7Yj9tM+eLXKPnu65A5D1J9MAADRxgZS8L
         sRrooFaTWNb1pHn2JEXZNFm6b7NKSvdM0GZeG6ATUhpV9vP/KvubgG3JPaE1ad+ZggPd
         vlkw==
X-Gm-Message-State: AOAM532A2ED9joeR37kEGfpfgnQHlRGR8aBuzfhahABk9s+xRk4KRzs4
        S8Y8PObS1aSgpLM+W69cOCCL2Q==
X-Google-Smtp-Source: ABdhPJzIrSRHpSy3s2TEPlKdC96c8Ay/w1HBZW8pOPhVyk9/ZGKa99x9C3ugV7b3cxf64njV06CAJA==
X-Received: by 2002:a7b:c932:0:b0:381:c66:fff2 with SMTP id h18-20020a7bc932000000b003810c66fff2mr3752039wml.42.1645811927147;
        Fri, 25 Feb 2022 09:58:47 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id t8-20020a05600c2f8800b00381428ad88dsm74172wmn.15.2022.02.25.09.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 09:58:46 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/4] dt-bindings: nvmem: brcm,nvram: add basic NVMEM cells
Date:   Fri, 25 Feb 2022 17:58:22 +0000
Message-Id: <20220225175822.8293-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220225175822.8293-1-srinivas.kandagatla@linaro.org>
References: <20220225175822.8293-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rafał Miłecki <rafal@milecki.pl>

NVRAM doesn't have cells at hardcoded addresses. They are stored in
internal struct (custom & dynamic format). It's still important to
define relevant cells in DT so NVMEM consumers can reference them.

Update binding to allow including basic cells as NVMEM device subnodes.

Signed-off-by: Rafał Miłecki <rafal@milecki.pl>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../devicetree/bindings/nvmem/brcm,nvram.yaml | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
index 8c3f0cd22821..25033de3ef6b 100644
--- a/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
+++ b/Documentation/devicetree/bindings/nvmem/brcm,nvram.yaml
@@ -14,6 +14,8 @@ description: |
   NVRAM can be accessed on Broadcom BCM47xx MIPS and Northstar ARM Cortex-A9
   devices usiong I/O mapped memory.
 
+  NVRAM variables can be defined as NVMEM device subnodes.
+
 maintainers:
   - Rafał Miłecki <rafal@milecki.pl>
 
@@ -27,11 +29,30 @@ properties:
   reg:
     maxItems: 1
 
+  board_id:
+    type: object
+    description: Board identification name
+
+  et0macaddr:
+    type: object
+    description: First Ethernet interface's MAC address
+
+  et1macaddr:
+    type: object
+    description: Second Ethernet interface's MAC address
+
+  et2macaddr:
+    type: object
+    description: Third Ethernet interface's MAC address
+
 unevaluatedProperties: false
 
 examples:
   - |
     nvram@1eff0000 {
-            compatible = "brcm,nvram";
-            reg = <0x1eff0000 0x10000>;
+        compatible = "brcm,nvram";
+        reg = <0x1eff0000 0x10000>;
+
+        mac: et0macaddr {
+        };
     };
-- 
2.21.0

