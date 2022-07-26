Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1F4E5813A9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 14:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239027AbiGZM47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 08:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238896AbiGZM4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 08:56:38 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC86A275DB
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:36 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso792377wmq.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 05:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:date:subject:mime-version:content-transfer-encoding:message-id
         :references:in-reply-to:cc;
        bh=Z13ENY+8S7e7mR5lKKViQxv3bJ9pD8bL59xMmRnI17k=;
        b=fTXqLeB+Ueyf/kQFYoQqCwqr9S5mAFaty7VxI+pA8+ddia5BvIAtZxhIdfLDcKEiD8
         uIQA6CQyneloEz3lUFwqsGWcHgZm98oX7fb+edSZ2K0EV1g3Qwz03Hj8HUI8/5nxt5uE
         isp1TfsivHl7QpCKGOWd4rQqmODsyyS4FpX78pdlcdg0iE+zZ9KmLHU72eY2xX+VdRUf
         zhsoSvqPy2NA41DMwk+j/nn6ukIwgmxr9YZf1KJWJRstRBKmeZArTQSB+yEIy30LGoni
         0cZuBdp4Cp2SYX1zl+NyNpzOwdOFMlwPRlZRjwBlWnYGXeKeu5oSxJJUt5JmJ+4Kbmfu
         HHKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:subject:mime-version
         :content-transfer-encoding:message-id:references:in-reply-to:cc;
        bh=Z13ENY+8S7e7mR5lKKViQxv3bJ9pD8bL59xMmRnI17k=;
        b=PzAWSm62/b0hZ0++zw6R+c8aqedORDi6aoldKL6uaXyZ0kKcWfbXQxrUonwwFqHfyU
         36kTce7OtHKkoA669y8A071MurweTDi9MnRC8z4bA2NT9NtFfqtBaJ9j/IpUyu84Xq5W
         83LMyyBjWK3xHPE6XlcayQ2VCwphWk+eWHC6gI+KcU7M8OJd4Bi1OxRG/bf18Xyncaev
         2VMTKPEiPrHgIzRunygSWt9FgkVXxbmS9uI8om64yV6jiiGtEwggpfqEits8GF6sup93
         uGsQu7XMGEgGSIEGuqiwsEp2bn1VQ3RbFrh1JmEGgI4IuoTkq1rSkV59HmOkduyT89dW
         Kjtw==
X-Gm-Message-State: AJIora+pGAShSAg6F1Z+OrLpqXSdXrtGi3Gd+VUrTObjy64o15s8vcQ/
        Zq5CiwWieccfPVM/LCoDmEbz2A==
X-Google-Smtp-Source: AGRyM1vl+YcUxJuwnM9p6qUahJHbYsyHSqdIeYD+E93+OvEhN+WoRh0CsBISgrEp4sQye2RUf1gZNw==
X-Received: by 2002:a05:600c:1f08:b0:3a3:1b00:c201 with SMTP id bd8-20020a05600c1f0800b003a31b00c201mr12396445wmb.171.1658840195057;
        Tue, 26 Jul 2022 05:56:35 -0700 (PDT)
Received: from [192.168.2.253] ([82.66.159.240])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020fff0ea0a3sm14171549wrp.116.2022.07.26.05.56.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 05:56:34 -0700 (PDT)
From:   Mattijs Korpershoek <mkorpershoek@baylibre.com>
Date:   Tue, 26 Jul 2022 14:56:11 +0200
Subject: [PATCH v2 6/7] arm64: dts: mediatek: mt8183: add keyboard node
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20220720-mt8183-keypad-v2-6-6d42c357cb76@baylibre.com>
References: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
In-Reply-To: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>
X-Mailer: b4 0.10.0-dev-78725
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,MISSING_HEADERS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Fabien Parent <fparent@baylibre.com>

MT8183 has an on-SoC keyboard controller commonly used for volume
up/down buttons.

List it in the SoC dts so that boards can enable/use it.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 9d32871973a2..9d8fdebaabe3 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -943,6 +943,15 @@ pwrap: pwrap@1000d000 {
 			clock-names = "spi", "wrap";
 		};
 
+		keyboard: keyboard@10010000 {
+			compatible = "mediatek,mt6779-keypad";
+			reg = <0 0x10010000 0 0x1000>;
+			interrupts = <GIC_SPI 186 IRQ_TYPE_EDGE_FALLING>;
+			clocks = <&clk26m>;
+			clock-names = "kpd";
+			status = "disabled";
+		};
+
 		scp: scp@10500000 {
 			compatible = "mediatek,mt8183-scp";
 			reg = <0 0x10500000 0 0x80000>,

-- 
b4 0.10.0-dev-78725
