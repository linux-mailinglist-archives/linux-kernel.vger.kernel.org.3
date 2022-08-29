Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 618F85A4E59
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 15:39:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbiH2Njp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 09:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiH2Njg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 09:39:36 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED992915E9;
        Mon, 29 Aug 2022 06:39:35 -0700 (PDT)
Received: from pan.home (unknown [IPv6:2a00:23c6:c311:3401:c9c8:35ca:a27e:68d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EFEF56601EF8;
        Mon, 29 Aug 2022 14:39:33 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1661780374;
        bh=fl7+lflxCH9Rw0rOoUbIJKkLQbH0fp7tF0ZZogSLMl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XWu7It+Y3R6i1jK0zlTO9mEQ5N1BRzolj3xJWDouS6D1y0nKw8sFTvMgIxFzp7UIk
         pbVenjrVt9+ySnAado7NKJmdH+UIibVF5QbYwSpOW8Yb+GDbaFlFTsKeUx6FyMaxKE
         2lnu1ovyC19YSfNiGYOFdXkSc/nX92GnrIpSWaY9fD0SzDjHOlb4rlkyUg1JUt0R/B
         7GgzNFJ5qPh8LIOmjc1HmUBarpjBWAwe4CsI2qJo7EzBc8DTofKmFY5uAsTqEyT8g2
         AoYPb30Pz8ce3TdKSGpaeJCMGziXRLWQIeo+ksrRZeXt+lWpS658Bt0IB/iVSrhIkS
         KZg3gqQw/1CLQ==
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@collabora.com, Martyn Welch <martyn.welch@collabora.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/5] dt-bindings: gpio: pca95xx: add entry for pcal6534 and PI4IOE5V6534Q
Date:   Mon, 29 Aug 2022 14:39:19 +0100
Message-Id: <20220829133923.1114555-2-martyn.welch@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220829133923.1114555-1-martyn.welch@collabora.com>
References: <20220829133923.1114555-1-martyn.welch@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the PCAL6524. The
Diodes PI4IOE5V6534Q is a functionally identical chip provided by Diodes
Inc.

Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
---
 Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
index 977b14db09b0..b8106348e025 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-pca95xx.yaml
@@ -16,6 +16,7 @@ description: |+
 properties:
   compatible:
     enum:
+      - diodes,pi4ioe5v6534q
       - exar,xra1202
       - maxim,max7310
       - maxim,max7312
@@ -49,6 +50,7 @@ properties:
       - nxp,pca9698
       - nxp,pcal6416
       - nxp,pcal6524
+      - nxp,pcal6534
       - nxp,pcal9535
       - nxp,pcal9554b
       - nxp,pcal9555a
-- 
2.35.1

