Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B58D55DFF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238177AbiF0RcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 13:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiF0RcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 13:32:18 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0686153;
        Mon, 27 Jun 2022 10:32:16 -0700 (PDT)
Received: from notapiano.myfiosgateway.com (unknown [194.36.25.20])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2C504660163E;
        Mon, 27 Jun 2022 18:32:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656351135;
        bh=pmO4Ykqu/l20TUXuLhKhk6GbE3MTS3qlWrVbXnn/+6U=;
        h=From:To:Cc:Subject:Date:From;
        b=g/nB/8IAeor6UrcJ/kdz+O718V+XFBHN9Zq3n8MTcJdc8FRc5LcQ6SWSxfipd22Me
         paFkUhw9ToV3wCp9P+PIBY91UjrQCPMr5ksUMPO+ra5sTUdybdVNEV4a3fNQcrpHy1
         dN7I6+iYlLzslQKvfNRclWUjNkIcrJmjXB8nx/77mi3ZbcC88/wHEXv2KKM0cEHJKq
         oBLOIVk6hln1mQOxKF9PGN3+nVzfTm6qNVjNQvNde8S9l+bcOIqw1Zj8xZN6JPyIgD
         kgO7jphOwrI2a5BJMlzFfeNSPAcBNhsRU4OwGmtNv/bz9eXG++K+J0ExqnZ0/k7PsG
         dhwWV56rPC4Og==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: [PATCH] dt-bindings: pinctrl: mt8192: Add RSEL values to bias-pull-{up,down}
Date:   Mon, 27 Jun 2022 13:32:08 -0400
Message-Id: <20220627173209.604400-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fe44e4984018 ("pinctrl: mediatek: add rsel setting on mt8192")
added RSEL bias type definition for some pins on mt8192. In order to be
able to configure the bias on those pins, add the RSEL values in the
bias-pull-up and bias-pull-down properties in the binding.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 .../devicetree/bindings/pinctrl/pinctrl-mt8192.yaml         | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
index e39f5893bf16..e0e943e5b874 100644
--- a/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/pinctrl-mt8192.yaml
@@ -90,6 +90,9 @@ patternProperties:
               - enum: [100, 101, 102, 103]
                 description: PUPD/R1/R0 pull down type. See MTK_PUPD_SET_R1R0_
                   defines in dt-bindings/pinctrl/mt65xx.h.
+              - enum: [200, 201, 202, 203]
+                description: RSEL pull down type. See MTK_PULL_SET_RSEL_
+                  defines in dt-bindings/pinctrl/mt65xx.h.
 
           bias-pull-up:
             oneOf:
@@ -98,6 +101,9 @@ patternProperties:
               - enum: [100, 101, 102, 103]
                 description: PUPD/R1/R0 pull up type. See MTK_PUPD_SET_R1R0_
                   defines in dt-bindings/pinctrl/mt65xx.h.
+              - enum: [200, 201, 202, 203]
+                description: RSEL pull up type. See MTK_PULL_SET_RSEL_
+                  defines in dt-bindings/pinctrl/mt65xx.h.
 
           bias-disable: true
 
-- 
2.36.1

