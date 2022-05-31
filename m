Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17660538AF0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 07:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244023AbiEaFgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 01:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243997AbiEaFge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 01:36:34 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA1E6FA10;
        Mon, 30 May 2022 22:36:33 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id B4D85320097A;
        Tue, 31 May 2022 01:36:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 31 May 2022 01:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1653975391; x=1654061791; bh=zU
        C8CyMrnP1Dd1IouLt0O7CCmsm4NnLg6v4G2wWFHoQ=; b=P47zN8x3sI4rryTo0D
        eoToGNYTSE2/cyuY41otupJZbhYhI6dFnVwUNvlyRuN+dQ/AiFNhnnuzgDWuK52M
        4BgaJwv4TLB1rDgJV5wu8WbQ+p7JbPahZMxQpGgbo5FXdPvdXw7ZM/dTa7StRLOf
        bhzMwx1S7RSIa141PWr2Vvg82ACXxWeU5PNEAhGafl1j+vz6EWgcSmNYvJb30Q6y
        yaXnbXyAjIQIpEk6GuKG9mpnMjjVG1RfYDJrBq5At/mjRLbj09xznXvEMHIcquZS
        2vgfpkEkPYUnlpQFUVp0qE/Osp5chy0yxzyN/pDqhKlanAj+CgF139O9XJ0DIwnD
        w/OQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1653975391; x=1654061791; bh=zUC8CyMrnP1Dd
        1IouLt0O7CCmsm4NnLg6v4G2wWFHoQ=; b=Zqd1MMzAs9P+Sn+H0XbDEs9HJ0B2o
        Urj88ULuX+lPMa/wNGtJhODwJH9mkxwC9iXjSm/WyEjVabXfcSBLtiUekV6vAsPY
        /KoJyhkMyDR0NepyIu7E2aDK4Uu1CeL7w2UFwfagjlHORhZF20k+GUOLQ3pHwqP+
        /7YVfXxIN3411ujNfM4ycpLjxa/NvIsNSjhX6IJ6rVNfoem5kiOjs3NLLTmLmypv
        hS++6EuNCVbus/YUxaEtDLB7W2VIumdE3HVQNo4ywuskJm14E50x8J9FNeQUxbCu
        R8FWbqFMKVgya8ysjJ3AE3MYkfDBkK5J3prSlMUipfnNv193oBcYO5bOQ==
X-ME-Sender: <xms:X6mVYhN9Ka7_tamRXQCq90KUKctPVmbMzgBGyqZk04eEOZhom9JE7A>
    <xme:X6mVYj9vg3290uQtiDTbc-L0TZb87mCK7LMotNT86OK8papio4plQHJ26ZJdMYa3q
    8KhBoAkFfSGNvmcLw>
X-ME-Received: <xmr:X6mVYgRQXa5GftoS01RvxiafvcAQX0GxHvUf6G8w3Onk0T3d2NBRbgRB_6B5jGfHk8gQPB8rfYwkPnNVEoYfCim96KyuoYyFV4WNb-dh8GdWuy7YbxTbABv2SYjUUw6Irh2-eA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeehgfdu
    feeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:X6mVYtsVMpRIEU_MNK25eZpM289Itetp2iQSuw4K6rOosY6oF0ppOg>
    <xmx:X6mVYpfUHWWvfb-Z6mnsw7qq9Y1_znCEVmsJ7TPuZyQsYWfygB3O6A>
    <xmx:X6mVYp3KzUhasQoS4wFDU1uV_Qc4aBhb-LNnBe1DkVcBY7f_Gsrbzw>
    <xmx:X6mVYn26-0oSu_2Br5IAYAL7WSJ_9_DyIYtHWVtN3AL0lbTd0evfjw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 01:36:30 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 2/3] ARM: dts: sunxi: Drop resets from r_pio nodes
Date:   Tue, 31 May 2022 00:36:22 -0500
Message-Id: <20220531053623.43851-3-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531053623.43851-1-samuel@sholland.org>
References: <20220531053623.43851-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of the sunxi pin controllers have a module reset line. This is
confirmed by documentation (A80) as well as experimentation (A33).

Let's remove the inaccurate properties.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm/boot/dts/sun6i-a31.dtsi     | 1 -
 arch/arm/boot/dts/sun8i-a23-a33.dtsi | 1 -
 arch/arm/boot/dts/sun9i-a80.dtsi     | 1 -
 3 files changed, 3 deletions(-)

diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
index 715d74854449..df3330073687 100644
--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -1387,7 +1387,6 @@ r_pio: pinctrl@1f02c00 {
 				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
-			resets = <&apb0_rst 0>;
 			gpio-controller;
 			interrupt-controller;
 			#interrupt-cells = <3>;
diff --git a/arch/arm/boot/dts/sun8i-a23-a33.dtsi b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
index 4461d5098b20..8d3dd9e2b54e 100644
--- a/arch/arm/boot/dts/sun8i-a23-a33.dtsi
+++ b/arch/arm/boot/dts/sun8i-a23-a33.dtsi
@@ -812,7 +812,6 @@ r_pio: pinctrl@1f02c00 {
 			interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apb0_gates 0>, <&osc24M>, <&rtc 0>;
 			clock-names = "apb", "hosc", "losc";
-			resets = <&apb0_rst 0>;
 			gpio-controller;
 			interrupt-controller;
 			#interrupt-cells = <3>;
diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index ce4fa6706d06..7d3f3300f431 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -1218,7 +1218,6 @@ r_pio: pinctrl@8002c00 {
 				     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&apbs_gates 0>, <&osc24M>, <&osc32k>;
 			clock-names = "apb", "hosc", "losc";
-			resets = <&apbs_rst 0>;
 			gpio-controller;
 			interrupt-controller;
 			#interrupt-cells = <3>;
-- 
2.35.1

