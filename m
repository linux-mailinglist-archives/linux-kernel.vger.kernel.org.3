Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C614C795B
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 20:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiB1TvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 14:51:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiB1Tum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 14:50:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D020F1180
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:49:05 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d3so17163190wrf.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 11:49:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Fkd5OgGZAYlE36QCfyuNvc5GmV+0MnZ1bSpfiAbg2cw=;
        b=JK0UxR8SULpByCcRzm2G2mLhbOG4xykXXoKOo615/erEm1wh4/Qdb0nI8qoCuj5IOg
         //zF3/xkExio5t4u7h0JGuVVrnPtro4rEjHcpnPlqQ3sb3Wdb5IGn0KY7d36oGFwvC3h
         jDOhMMfRC2DM+2qNxD0QocF8h1l/Iq70da74KrYxQiebHZWyI26VjHggnD8Sxi2o+D3F
         SMqlyIUrP1Hel5wlXVZbUKjj+As3G6ijk0spi8B6Ev/z7gsxhCkBFHetSHY4V9NqZZhd
         HiX6lYxpOua7x+1F1IsBo+kRVRMBXo3hUdq9qumD7B2axdycN6VMATakoOO06PvXb+eW
         1b2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Fkd5OgGZAYlE36QCfyuNvc5GmV+0MnZ1bSpfiAbg2cw=;
        b=aMTgq2Kgg6m2WI5aNc0piEleMHZZrme1NKp2FKc8yTxiHHDuc1CR4OnoUJV26/8l5R
         9WjGjgw5XQ8WN4P2gN0HevGz6f0+/0xtf3Q22Q0Il4adntyjFfPGXQ42IOzs0aW/3cit
         +oPspq6P++/vclU+oKxfyztDbtF+c95CqLkRUNpaM0XWreNqT8B2JMyLPva/RlNES49c
         GIVwTAoCWOWvMU/J1HShtvseidC87XfWmp1MpJjnh4LU9oUvaBDgPBvZuKgyODLX1wfx
         oL08x7xu9a1EgWSH/FhNwO9WeXeJPw33ijMoHqh284RQeBJoMYlRZKGmHw/JUVQ1UygL
         jNzA==
X-Gm-Message-State: AOAM531ypt9LS//0c2mVcu9uhFhFEnOfNiO28B0XAazRJnlJX62B2hEJ
        EL4buGn2h7xZDhi6DrWoY9jynGrXAw9PwA==
X-Google-Smtp-Source: ABdhPJzC8b6GL7WHeAsFebTLadlGbKT2RHM3vC7SGbZuhx23oAACfoFrTCtSq4XVrdzPXpQC6LKoxA==
X-Received: by 2002:a5d:6f0f:0:b0:1ef:f983:3887 with SMTP id ay15-20020a5d6f0f000000b001eff9833887mr2058062wrb.526.1646077254609;
        Mon, 28 Feb 2022 11:40:54 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id v25-20020a05600c215900b0038117f41728sm274143wml.43.2022.02.28.11.40.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 11:40:54 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski@canonical.com, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 15/16] arm64: dts: rockchip: add rk3328 crypto node
Date:   Mon, 28 Feb 2022 19:40:36 +0000
Message-Id: <20220228194037.1600509-16-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228194037.1600509-1-clabbe@baylibre.com>
References: <20220228194037.1600509-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rk3328 has a crypto IP handled by the rk3288 crypto driver so adds a
node for it.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index b822533dc7f1..b5b47ddc38f9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -1007,6 +1007,18 @@ gic: interrupt-controller@ff811000 {
 		      (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_HIGH)>;
 	};
 
+	crypto: crypto@ff060000 {
+		compatible = "rockchip,rk3288-crypto";
+		reg = <0x0 0xff060000 0x0 0x4000>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_CRYPTO_MST>, <&cru HCLK_CRYPTO_SLV>,
+			 <&cru SCLK_CRYPTO>;
+		clock-names = "aclk", "hclk", "sclk";
+		resets = <&cru SRST_CRYPTO>;
+		reset-names = "crypto-rst";
+		status = "okay";
+	};
+
 	pinctrl: pinctrl {
 		compatible = "rockchip,rk3328-pinctrl";
 		rockchip,grf = <&grf>;
-- 
2.34.1

