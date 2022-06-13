Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFA9549D8A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349858AbiFMTXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348575AbiFMTVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:21:40 -0400
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D8A326F6;
        Mon, 13 Jun 2022 10:18:14 -0700 (PDT)
Received: by mail-io1-f47.google.com with SMTP id i16so6782701ioa.6;
        Mon, 13 Jun 2022 10:18:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4fD13eHHlp2+lui4IoKUdeairGp7Zb+ZDDW9xWVxKeM=;
        b=kkQkwatVsJUTB940+aLm/kzHQYXd4YXdMr/sBVxzH4TsGU0pM95PqujaqYA0SnfyvS
         CSEQFl+5tWTal61BpzQvDbkyjL19q9zOlHVQCrRqj3cWwXr6UroFo6D+R6CuaKVOvUEW
         9K+wn669SmuSnAzhmRGiHKQEFQpKK0Hu1miDxr6Y/Bvtro4KGzw9KY7T4kZyIxVc6ZlU
         lGfG8Q4kuQV0q9ffP9wVOBOivM4L9ZN3oDP0VFBfoP5MpSs+Pv4eleWAXmif8wJdFyVv
         knoLMjni3WZyOjju7zBKYCKLzFvnrqePZtXkD2asRs09A7oMsOVN96t6DfTfQHi5l9Nc
         aoKA==
X-Gm-Message-State: AOAM532Q78t7biw9QmpujAmtTjSpa//iY3tjTcgBxxScF05kwFmTNPfl
        0Ct7/wyBs2WekQt+26Hlyg==
X-Google-Smtp-Source: ABdhPJzSTeYoSE44evzI9ByeP6HccjEciBVYXimkrxLpA763NQyy/uPTESBXfj9TzQcwZa4Wf5MCKQ==
X-Received: by 2002:a6b:b808:0:b0:669:b197:9615 with SMTP id i8-20020a6bb808000000b00669b1979615mr409129iof.122.1655140693052;
        Mon, 13 Jun 2022 10:18:13 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.251])
        by smtp.googlemail.com with ESMTPSA id ck19-20020a0566383f1300b00331a211407fsm3740374jab.93.2022.06.13.10.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:18:12 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andre Przywara <andre.przywara@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: vexpress-sysreg: Add deprecated GPIO provider properties
Date:   Mon, 13 Jun 2022 11:18:07 -0600
Message-Id: <20220613171809.3928949-1-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While the current binding expects a child GPIO node, the old style binding
with GPIO provider properties in the parent vexpress-sysreg node is
still in use. Add the GPIO provider properties as deprecated.

Cc: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml b/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
index b5e26e41f88c..2d2afada5ad1 100644
--- a/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
+++ b/Documentation/devicetree/bindings/arm/vexpress-sysreg.yaml
@@ -29,6 +29,13 @@ properties:
 
   ranges: true
 
+  gpio-controller:
+    deprecated: true
+
+  "#gpio-cells":
+    deprecated: true
+    const: 2
+
 additionalProperties: false
 
 patternProperties:
-- 
2.34.1

