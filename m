Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C010E4C47F2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:55:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241973AbiBYOzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:55:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238622AbiBYOzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:55:10 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2FB22558A;
        Fri, 25 Feb 2022 06:54:37 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id t21so4650376qkg.6;
        Fri, 25 Feb 2022 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gwYHMhbRHXQxrol3Z4onOOebIeXrEkEaF8cW1M7ix2U=;
        b=ZER9dqeve3GLpay7/CeKXOHvRdxd93sDJdphtL21FC+B6K6WJp6rNACTQcU+GbsI4t
         psKHa0gSnah0AxamhlomcPSyWhXvgNBJx5Ov2n0gZ0EQJccwuAg8aBiaQCDEqTS2TYu1
         8xJzWTDSlPaHtP1pAm/m83wknHob1hbJMDrX0NdHofMSn1GKsJ0IbiOXr4DXfBFv4WpQ
         0syJTQljhm8Lt6E4cfR8d9sGYmO76mbLi98cYOLSc4htvG19pBm/3JEJC9u8w9jRk0r0
         SqwpvisiVAWYdkiKq3fZz6cg/rdtG0NYGlQVKpNTz94HjV6oVcJ6GjJGDkRj8iuadVJh
         QBhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gwYHMhbRHXQxrol3Z4onOOebIeXrEkEaF8cW1M7ix2U=;
        b=W3tw1Boqg3fjXuXOjQfdFZE3zXy6ES8KaBjBpNNRlfSiyg5cIAvQIHzqluNuAiHRmX
         fGXq7ihlI4Uu2Bv/I6IhytVdPzGEtJI4zsR2Vss8fEZ1F0u/a03Z9u/HdUdT0fr3uZ3O
         MHP+Q3AZIX47UBMyKQXzdxISpfzoyTEFAW/BKGp82GAWi0lkt5xfu28sWOMuxvrVP8XY
         Q/xy8tovQdVVsHjkFg3cifk9qAVCzAYCJN/RM2FGpJx4dIyGSKxGgjPgmkeBdM6LXzrW
         srbtsOpuo2Pfb94LgM7Q+5YKw4yk8Lz1gU0uDKiKNh9SWOUH+zS5SQ9bSFshsXjQlYla
         b25g==
X-Gm-Message-State: AOAM532Fbj5uiMgkJIpYcPqZT9+hZa+D41p5qBxL+zo2iq3+18AZkRSt
        7rcmcuEMXP40DmLtPlEVZLo=
X-Google-Smtp-Source: ABdhPJwee8UY1BnbzYFvaxa8NG4VwTthJ6UyhjOsZwLH2qycERTg1bJl7POhSx3GuOb0jru6PA+/jw==
X-Received: by 2002:ae9:e114:0:b0:609:b256:ee5 with SMTP id g20-20020ae9e114000000b00609b2560ee5mr5028795qkm.93.1645800876714;
        Fri, 25 Feb 2022 06:54:36 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id d202-20020a3768d3000000b005f18706845dsm1318292qkc.73.2022.02.25.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 06:54:36 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/8] dt-bindings: soc: grf: add rk3566-pipe-grf compatible
Date:   Fri, 25 Feb 2022 09:54:24 -0500
Message-Id: <20220225145432.422130-2-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225145432.422130-1-pgwipeout@gmail.com>
References: <20220225145432.422130-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk3566 requires special handling for the dwc3-otg clock in order for
the port to function correctly.
Add a binding for the rk3566-pipe-grf so we can handle setup with the
grf driver.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 Documentation/devicetree/bindings/soc/rockchip/grf.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
index 5079e9d24af6..75a2b8bb25fb 100644
--- a/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
+++ b/Documentation/devicetree/bindings/soc/rockchip/grf.yaml
@@ -15,6 +15,7 @@ properties:
       - items:
           - enum:
               - rockchip,rk3288-sgrf
+              - rockchip,rk3566-pipe-grf
               - rockchip,rk3568-pipe-grf
               - rockchip,rk3568-pipe-phy-grf
               - rockchip,rk3568-usb2phy-grf
-- 
2.25.1

