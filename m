Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373AF51489F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358764AbiD2L4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358734AbiD2L4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:56:31 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7898C6ED3;
        Fri, 29 Apr 2022 04:53:11 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id y6so3476763qke.10;
        Fri, 29 Apr 2022 04:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gGeL3vqvV+tsZXortm1bChbjn2BI/sUzqWi2Z5G5epg=;
        b=gHuIH+ICOFoIXkjGy7RKBQ2zwMf/vZuR/lkb7AySl9mTPbJVzIBHpa29CnhPA9ff/a
         if0iKwPV1lO7dw2PcKXUalir6wvcEcnmlgALlwkKyCkyV2KZLqMxshNVSJXBg19NSEvR
         58ZJ/4Wh+sky5VvR02xO4X6ptkonHKtR5yCP95AgD0V9VLLVN/w2RPTInDfEhFIPrjt4
         m/Im26teWUlAM9ZrH0swzoRQnXPpaj9sdrPTvvg//xuIesfW/fQYAlylw5nUJdBi9vdB
         +Eb0UgFeBnbQBfvyUIrLg9GRnqMN5x1yMX+LroCfYTRBAalNfckFiBWxi57jVnM3lrDB
         M4Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gGeL3vqvV+tsZXortm1bChbjn2BI/sUzqWi2Z5G5epg=;
        b=D2CMy4wBHd/eVAdsfoRofJ4UK64X95tmQqy5woXu1dLl/kLf/VSe7Mu77apUM8wBf8
         hAyT4PLHK060uA+gvBiKSQKJf7WU9JmjmsXu9ubMyefzlw7eHARA0RhpmaiQhizI8C2H
         9npQTU4EtTsq0Y+SU7+YBqcM3tLiNvdo8zTc/KqxtMfx4KhwqXim+YGph1PPzcV6DRsU
         34/VUNiBHRZuqDqiEL5kQfhb5aAqbrPV452oAlOt1u5i5G2/SFCnIFl8PpVoZsSjyrrM
         X0t6Qwp7oLIlvZfcHbpEwRUUCYTax2EKNQI4m+2MsrL0oY4sP7YYionAb8FR6etV+2eY
         30UA==
X-Gm-Message-State: AOAM531zMUMJwBWT0SlbGjA5lulVr0deCiedsRsnDwESorajisQD4Kuf
        b+fMNW9VzJxpXFZd2Gl70TI=
X-Google-Smtp-Source: ABdhPJw/jdE9yOwN6ajIW50uiF7ojyla0JcoEwOGAtnxxCReSGQD6/sAc4TCfGtIR586QfdVldxkbg==
X-Received: by 2002:a05:620a:4689:b0:69e:a3c7:4cfa with SMTP id bq9-20020a05620a468900b0069ea3c74cfamr22637948qkb.591.1651233190865;
        Fri, 29 Apr 2022 04:53:10 -0700 (PDT)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id 123-20020a370c81000000b0069fa408fdb7sm1382505qkm.24.2022.04.29.04.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 04:53:10 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v2 3/7] dt-bindings: arm: rockchip: Add Firefly Station M2
Date:   Fri, 29 Apr 2022 07:52:48 -0400
Message-Id: <20220429115252.2360496-4-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429115252.2360496-1-pgwipeout@gmail.com>
References: <20220429115252.2360496-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Station M2 is a compact single board computer based on the rk3566
SoC. It outputs on uart2 for debug and console purposes.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/rockchip.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/rockchip.yaml b/Documentation/devicetree/bindings/arm/rockchip.yaml
index b85a8e6c5e75..288d044d48bc 100644
--- a/Documentation/devicetree/bindings/arm/rockchip.yaml
+++ b/Documentation/devicetree/bindings/arm/rockchip.yaml
@@ -133,6 +133,11 @@ properties:
               - firefly,roc-rk3399-pc-plus
           - const: rockchip,rk3399
 
+      - description: Firefly Station M2
+        items:
+          - const: firefly,rk3566-roc-pc
+          - const: rockchip,rk3566
+
       - description: FriendlyElec NanoPi R2S
         items:
           - const: friendlyarm,nanopi-r2s
-- 
2.25.1

