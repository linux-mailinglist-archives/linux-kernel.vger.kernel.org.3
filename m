Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72ADB4DD0FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 00:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230102AbiCQXCT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 19:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiCQXCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 19:02:14 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51C8152810
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:56 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 17so9234418lji.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 16:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=67Gg47WBDYq5WUX7O1pPL0ZsRMjTTDTDwwwbK5y73ZM=;
        b=iFl3eT+Cb3O7EJYyJnxZbDzWHcFUOsPk1mSkEf/kRDR/nhQG+uzQWfzV89US4AB8e/
         IC+JBjozVfC9hwE3+6WBkPqbWCOzwA690xRn9LZbqnUAB+MWcxrQHHkJoXPpqRlG+yRh
         GJOzhM4AhPjpM5TZNqeJR0rTfVIkqFVf1inUCD/U0cLer9ybo7DYYnlMIQB7mqK80Zi4
         pWY3lS3dsnDXyeFRbktyld7eiwt6Mu+Irh28lyncZX++vF6xvhDGfdNUZ2cjtzvJTH80
         u9N3bYEaBZ8msVNFHURMekpabIMRHQuToeRrNItJSfQisnA3x5jJhZmI1tf2/dLP9S5C
         y/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=67Gg47WBDYq5WUX7O1pPL0ZsRMjTTDTDwwwbK5y73ZM=;
        b=u2TSmKLzvPqNkTaQBFtl6KBEdeoN4ku7yprq9e0d5fsof2T/4d+vkte143l2Dnmnvn
         BvZERpCC3ObEh258G32OhBOc+HpTEzVwtnBahhcxUFZNDY1MsmV7t5p0xr0qQrrtPrUd
         18n+dt2rPsyKNFBBkR/uZQQtLzv+6fm21wWFATSsPBkTCvbHr9HyFnmg4THe8ds7XzDq
         XGq/Fnb61xF325SEhNV/AOBJENWFYuNxH8jD73PWY4z4shMAPwi8G0I8P8irGLaDFooD
         TXXSYaieKtO1lQVQ4+3enY33vu6VCmt2bquPwXNUh/V8wh+e7k+TOe36aHcSE8E7g0rk
         uPQA==
X-Gm-Message-State: AOAM533e35akWGgKcqLw6qgDwBQnRiWV6ttshkXudcYeePvRW7I6CQQ8
        ZDdvDu8x1/GIpMYJ7ERQxNIw2w==
X-Google-Smtp-Source: ABdhPJzyy7abJDPDvIRNJdA7GdH8ZGYstjjr50/OwVCX1P8uUBfQ50wPheUtR6G0hcDZ+9k1txeEpA==
X-Received: by 2002:a2e:b449:0:b0:249:388a:3dec with SMTP id o9-20020a2eb449000000b00249388a3decmr4337546ljm.346.1647558055113;
        Thu, 17 Mar 2022 16:00:55 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id 11-20020a2e154b000000b0024967cd674esm191876ljv.35.2022.03.17.16.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 16:00:54 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/5 v2] dt-bindings: gnss: Add two more chips
Date:   Thu, 17 Mar 2022 23:58:43 +0100
Message-Id: <20220317225844.1262643-4-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220317225844.1262643-1-linus.walleij@linaro.org>
References: <20220317225844.1262643-1-linus.walleij@linaro.org>
MIME-Version: 1.0
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

The CSR GSD4t is a CSR product using the SiRFstarIV core, and
the CSR CSRG05TA03-ICJE-R is a CSR product using the SiRFstarV
core.

These chips have a SRESETN line that can be pulled low to hard
reset the chip and in some designs this is connected to a GPIO,
so add this as an optional property.

Update the example with a reset line so users see that it need
to be tagged as active low.

Cc: devicetree@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Add maxItems: 1 to the reset-gpios
---
 Documentation/devicetree/bindings/gnss/sirfstar.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/gnss/sirfstar.yaml b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
index 9f80add3e61b..f3d8902dca04 100644
--- a/Documentation/devicetree/bindings/gnss/sirfstar.yaml
+++ b/Documentation/devicetree/bindings/gnss/sirfstar.yaml
@@ -25,6 +25,8 @@ description:
 properties:
   compatible:
     enum:
+      - csr,gsd4t
+      - csr,csrg05ta03-icje-r
       - fastrax,uc430
       - linx,r4
       - wi2wi,w2sg0004
@@ -39,6 +41,11 @@ properties:
     description:
       Main voltage regulator, pin names such as 3V3_IN, VCC, VDD.
 
+  reset-gpios:
+    maxItems: 1
+    description: An optional active low reset line, should be flagged with
+      GPIO_ACTIVE_LOW.
+
   timepulse-gpios:
     description: Comes with pin names such as 1PPS or TM
 
@@ -64,6 +71,7 @@ examples:
         gnss {
             compatible = "wi2wi,w2sg0084i";
             vcc-supply = <&gnss_vcc_reg>;
+            reset-gpios = <&gpio0 15 GPIO_ACTIVE_LOW>;
             sirf,onoff-gpios = <&gpio0 16 GPIO_ACTIVE_HIGH>;
             sirf,wakeup-gpios = <&gpio0 17 GPIO_ACTIVE_HIGH>;
             current-speed = <38400>;
-- 
2.35.1

