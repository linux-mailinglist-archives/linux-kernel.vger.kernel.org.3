Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCF84DC540
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233283AbiCQL7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233278AbiCQL7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:59:09 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402591E747F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:47 -0700 (PDT)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id ECF073F5F3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647518263;
        bh=HVRdo0a9Zp5ow/1mp1AbDSb5pnZ9OyDrT3JP+Xnx0c8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=e+Pn0oQyQjy8ZLwNW+paYE8muqYFnFhK5Pb8WvkOB8wqyBK5mqYMj9PQB1jhqaTHM
         TyBryShlwadXJ6kAl4Nsf+8lkpVxlYwygnJoOX9jyOFkMdHby8xvM7o5XcbXt4KQtY
         UIpfYuZWIuQ+V8hXfa9NxbJ1OK785GQcUFNJaov5p+xtvXkigoxphZowuqNBp2npD6
         VtkSIUwX1epEQVntnzvozH9sK2IEGvXALLpOCsCckp5QIbFesbC3w9sE2PtIWB2jOH
         oHc8ZyYRYzUWd4YaQbqkwGjyvplOyvQ/PhwvqY+skCao6igL6X2eqP0dF/XBEnC1lt
         +e6m92CWtIykQ==
Received: by mail-wr1-f72.google.com with SMTP id q4-20020adfc504000000b00203e15159e8so1352007wrf.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:57:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVRdo0a9Zp5ow/1mp1AbDSb5pnZ9OyDrT3JP+Xnx0c8=;
        b=rKVaU1PVsPpN3KDftGGPPZx36EaEyhLsgb8IA7gJbO/PRYMbxJu73prDUk/ea6YuNG
         m1kDn23W+jIHtwDFSaQU+JLT+JYW79U+JUZatwHnM8jQ3VMt+nevQHcnn9UzBoUYuD6p
         Uo1pVX8pCkkzur9SM4kvw61Sue32qSMZSKYBo3vUrHAyxNARRVMOa03H+mhF4jUVyaYz
         vZfqk8K4FDtVmm6o5uzh1eCpYvhoQfY7FeKnsidCsxi3Sg475LvYdq4qL8LaqFrhCzuV
         ANokQXT5mpLpekCHZl2nZ2jhWR5eXpTc4qTVb6bFAzR0S0TXBLgCJFdETVO3EBNiK+sL
         q3Cg==
X-Gm-Message-State: AOAM530Rv6B8zEcLcM0KW9bqE/Zzj8cAAHEfffA+XSDPLXVJJ+Rq2Bns
        tWWjqPrfKCz6tPhLdhJKc2/Ww3v8DxgBh3zxCDZV6wR3SqsrgTRTYCDVGBzUh6wl6hS1UH+mBX8
        shMV3rcDqQUssFhldkqgjtLUgezMr6ZJH5PB3EEn16w==
X-Received: by 2002:a05:600c:3ac7:b0:38b:f9c6:27b8 with SMTP id d7-20020a05600c3ac700b0038bf9c627b8mr3514931wms.75.1647518253408;
        Thu, 17 Mar 2022 04:57:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx3/O+rMez/BwQ/7F1CSUo1QHlpo1ME2REeH/FIItXP6CKvP9B/nZFl1eiLRHNeDKPj7C+b9g==
X-Received: by 2002:a05:600c:3ac7:b0:38b:f9c6:27b8 with SMTP id d7-20020a05600c3ac700b0038bf9c627b8mr3514901wms.75.1647518253208;
        Thu, 17 Mar 2022 04:57:33 -0700 (PDT)
Received: from krzk-bin.. (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id r65-20020a1c4444000000b0038c48dd23b9sm5824900wma.5.2022.03.17.04.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Mar 2022 04:57:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Michael Walle <michael@walle.cc>,
        Mark-PK Tsai <mark-pk.tsai@mediatek.com>,
        Daniel Palmer <daniel@thingy.jp>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Dinh Nguyen <dinguyen@kernel.org>,
        Cristian Ciocaltea <cristian.ciocaltea@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Suman Anna <s-anna@ti.com>, Lokesh Vutla <lokeshvutla@ti.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-oxnas@groups.io
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 09/18] dt-bindings: irqchip: loongson: include generic schema
Date:   Thu, 17 Mar 2022 12:56:56 +0100
Message-Id: <20220317115705.450427-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
References: <20220317115542.450032-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include generic interrupt-controller.yaml and msi-controller.yaml
schema, which enforces node naming and other generic properties.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/interrupt-controller/loongson,htvec.yaml        | 5 ++++-
 .../bindings/interrupt-controller/loongson,pch-msi.yaml      | 5 ++++-
 .../bindings/interrupt-controller/loongson,pch-pic.yaml      | 5 ++++-
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
index 87a74558204f..d58cbc852b09 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,htvec.yaml
@@ -13,6 +13,9 @@ description:
   This interrupt controller is found in the Loongson-3 family of chips for
   receiving vectorized interrupts from PCH's interrupt controller.
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     const: loongson,htvec-1.0
@@ -37,7 +40,7 @@ required:
   - interrupt-controller
   - '#interrupt-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
index 1f6fd73d4624..9b6d69066e54 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-msi.yaml
@@ -14,6 +14,9 @@ description:
   transforming interrupts from PCIe MSI into HyperTransport vectorized
   interrupts.
 
+allOf:
+  - $ref: msi-controller.yaml#
+
 properties:
   compatible:
     const: loongson,pch-msi-1.0
@@ -46,7 +49,7 @@ required:
   - loongson,msi-base-vec
   - loongson,msi-num-vecs
 
-additionalProperties: true #fixme
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
index fdd6a38a31db..0c7bee42946a 100644
--- a/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
+++ b/Documentation/devicetree/bindings/interrupt-controller/loongson,pch-pic.yaml
@@ -14,6 +14,9 @@ description:
   transforming interrupts from on-chip devices into HyperTransport vectorized
   interrupts.
 
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
 properties:
   compatible:
     const: loongson,pch-pic-1.0
@@ -41,7 +44,7 @@ required:
   - interrupt-controller
   - '#interrupt-cells'
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.32.0

