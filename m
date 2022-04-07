Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A457D4F887A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbiDGUba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiDGUbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:31:05 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D75B48B475
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 13:16:20 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id b21so8857712ljf.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 13:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OCnmWs2rmr8cYFHTJ+wh670qQpBRmZ1fGvJd72ctMc=;
        b=R4Gw59DtZuzxqZMIA9QzvVsPxn2Zb3jgT7ik71eBFeCa7eAT9wof86yzK5sh0jam6d
         nQDAobAftHyP1XJCCDlQ7qjHVDwWxdYiE94YnsPc+W1Geo8Fey6ISugqpJzZC7HTd1IB
         2CCowFM/iwG3ljgSrbd1yzYCZGVwoVadpVAc6cd9IMQiHMO3En5uyf/u/9qCegwmf49q
         hNJS2L8V9eUzVbYZPQhmX2auVbUtGC/9J4ePpbkyue/BUZjLK6D/DXMUT36XfuivEBpF
         QFtPyrhNAmxgl4RDV+ghLnlTfUPqLPmWzDihOKAjIaswAZv4R0BtLhhL5xfwVDWe/dCp
         ZirA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7OCnmWs2rmr8cYFHTJ+wh670qQpBRmZ1fGvJd72ctMc=;
        b=oYnyGnFlExohsRqJJ/flQgbRHMwrwwbIBZ/kzwf+9JyU4uZAZE1VschzxQ2KJ0Hli2
         DH7q0KoL47FGiAgWvKyTXwJyE/ZJV4+P9BVDvMz5t3RirpFf0V4Mv+TX1GiZpwgGkDPu
         pqQaVtgxeoNxq9ZoIE3/90uTOqkFm3Gqpl47UZtWAWS15io+0KzkVKHM57ujUxJw9/Wk
         VXOffcUrHc+zEAEFo7krt8XvJDyUZpLY1Xpt5pPp5gf1qsh/8BpozXMKMuKjVj8CiaQF
         aybThsRJtLBfUlX2/14LuA8ClG5Lj4q6Rwb30Qwq1OXgHQbfFAaghLbgspkPEuWXTpxY
         YK8Q==
X-Gm-Message-State: AOAM531LxDgmyPCOliVE52SC3elu1Bn19W04OY1I+1jGDT9mz+NR24Oo
        nwkknNQVJIp2Zfo9Olg2f0tHjIHsmMHfDQ2o
X-Google-Smtp-Source: ABdhPJzFjt8Y2FC0EcXNREN9rYFph6MLDJ+pNAArwPdf9YMf6CEER9rq/PpILF8at3Oxu2KoX39Y/w==
X-Received: by 2002:a5d:59a2:0:b0:204:20d9:a5b9 with SMTP id p2-20020a5d59a2000000b0020420d9a5b9mr11433031wrr.560.1649360147078;
        Thu, 07 Apr 2022 12:35:47 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id bg8-20020a05600c3c8800b0038e4c5967besm8566885wmb.3.2022.04.07.12.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 12:35:46 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [RESEND PATCH] dt-bindings: power: renesas,rcar-sysc: drop useless consumer example
Date:   Thu,  7 Apr 2022 21:35:42 +0200
Message-Id: <20220407193542.17230-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consumer examples in the bindings of resource providers are trivial,
useless and duplication of code.  Remove the example code for consumer.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/power/renesas,rcar-sysc.yaml         | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
index 62a49ca319ec..bd9608c83c3f 100644
--- a/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
+++ b/Documentation/devicetree/bindings/power/renesas,rcar-sysc.yaml
@@ -10,9 +10,11 @@ maintainers:
   - Geert Uytterhoeven <geert+renesas@glider.be>
   - Magnus Damm <magnus.damm@gmail.com>
 
-description:
+description: |
   The R-Car (RZ/G) System Controller provides power management for the CPU
   cores and various coprocessors.
+  The power domain IDs for consumers are defined in header files::
+  include.dt-bindings/power/r8*-sysc.h
 
 properties:
   compatible:
@@ -64,14 +66,3 @@ examples:
             reg = <0xe6180000 0x0200>;
             #power-domain-cells = <1>;
     };
-
-  - |
-    // Power Domain consumers
-    #include <dt-bindings/power/r8a7791-sysc.h>
-
-    cache-controller-0 {
-            compatible = "cache";
-            power-domains = <&sysc R8A7791_PD_CA15_SCU>;
-            cache-unified;
-            cache-level = <2>;
-    };
-- 
2.32.0

