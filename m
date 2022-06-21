Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2AD5529E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345319AbiFUDnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345127AbiFUDmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:42:51 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EDA220BEB;
        Mon, 20 Jun 2022 20:42:38 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id CF57E32004AE;
        Mon, 20 Jun 2022 23:42:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 Jun 2022 23:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655782956; x=1655869356; bh=8+
        kpyGFjwm1UBofAO7xT80QECZvTQRm9biCZ/RYfokc=; b=it63xThXVfY3WE0i72
        vgILBXfJAv/1mQZfy9gvJqV6F3QvwtrmWk4dXoD6dBrMt2ZZwzwsj7OrQsjhka5N
        2rkmpqZ+9UnPfRru/xLSAZv6M8qk/FifY9VmlmPNRXhaH16grHnFc0CZGRNaRDKW
        1wghVFaos3Qu4InwwUvMlUP3kZXnda4ewbHm/WKv3l2CRvPX5OfLfKOAJWJJ0hwt
        iW/vDgaFXY+acOR9m452Opmukw/iWhMi4532hrQYnzydLwzKv9YpAtwm7px6Kjvp
        fffeSn0lEi5LZRZ+YPDQCfiNiLQsM9e2GRfuXSAuIeyXeJk9vvOGrZu2qGFeYHdS
        loJg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655782956; x=1655869356; bh=8+kpyGFjwm1UB
        ofAO7xT80QECZvTQRm9biCZ/RYfokc=; b=cuhN6LRnOFUy3ufxG2vB/PZV3wxn9
        gUbR4Uim8aGsnipy+pPtv8VcdzAHyrk7OxEUKkYZPAg3tXQQNObScwt9PluDLzBe
        Mo5+J0mV/O12kiJiDMuHBiITSpCjpaLUUmP6YAoKDx5hNF5pY+YdvyuLXjEIsEm6
        05NVocZ0TIOBghDcYG2JrmgvCB0XpH+KqYg7xctdQrfGMZy4X7QyoL+5R1hALZHW
        sTG3kFg2QQf0Auy2mbJgVOYXtq9tMcR/hRobsyeKkam5gf8S3M5lWtU4y83Ag1Bx
        qWEHOCvhvyXnCh1MJwb4bPyyqyyywFc0spapXRmj990evCnmkQOz8SAMA==
X-ME-Sender: <xms:LD6xYmARWSquplhF_PqNRp2R1AkDjr9fpNtDunDW8jurORgTu6oeXA>
    <xme:LD6xYgjC_plEkUCy_JVW0ynN_rZkg3vGNjRKfk_AMo9MxKc1HARHs9SHYyZxSuxGB
    b1RlT77wCpvt-b-BA>
X-ME-Received: <xmr:LD6xYpkljDpJuig50uoxL8myHBeO1c4MXZWY4WWLdYvnSSWh5bhVGBSNj914jRG5JcjnIhXJo-DD2yzLdoR2iwB8YWP-rxe0T1BPqQ53RwXbxzihWbOttZJgzD-dsboYgmfiqg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:LD6xYkzkYnMfslj3stjZGJyXuPy5tJwzoVtFrxO359L2SW7K44Ya7Q>
    <xmx:LD6xYrRAi5TYb1aJggJ0S6OSlQdNyKf7bM11tIHSzdAnvFmflugaeA>
    <xmx:LD6xYvbgQpoF0Mgf4c1scPrGBu55JYTmg8LoYD52RlNn18__zaObmg>
    <xmx:LD6xYmGm45Yi7ozDwslFHrqZIEZAUxwU9R4Ac1iafnq-sa3t6OQCbA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:42:35 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Cc:     devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] ARM: dts: axp22x/axp809: Add GPIO controller nodes
Date:   Mon, 20 Jun 2022 22:42:24 -0500
Message-Id: <20220621034224.38995-5-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621034224.38995-1-samuel@sholland.org>
References: <20220621034224.38995-1-samuel@sholland.org>
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

These PMICs all contain a GPIO controller. Now that the binding is
documented, wire up the controller in the device tree.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 arch/arm/boot/dts/axp22x.dtsi | 18 ++++++++++++++++++
 arch/arm/boot/dts/axp809.dtsi | 19 +++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index a020c12b2884..5c233c84be92 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -67,6 +67,24 @@ battery_power_supply: battery-power {
 		status = "disabled";
 	};
 
+	axp_gpio: gpio {
+		compatible = "x-powers,axp221-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		/omit-if-no-ref/
+		gpio0_ldo: gpio0-ldo-pin {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		/omit-if-no-ref/
+		gpio1_ldo: gpio1-ldo-pin {
+			pins = "GPIO1";
+			function = "ldo";
+		};
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
diff --git a/arch/arm/boot/dts/axp809.dtsi b/arch/arm/boot/dts/axp809.dtsi
index ab8e5f2d9246..da92b105f3b0 100644
--- a/arch/arm/boot/dts/axp809.dtsi
+++ b/arch/arm/boot/dts/axp809.dtsi
@@ -50,4 +50,23 @@ &axp809 {
 	compatible = "x-powers,axp809";
 	interrupt-controller;
 	#interrupt-cells = <1>;
+
+	axp_gpio: gpio {
+		compatible = "x-powers,axp809-gpio",
+			     "x-powers,axp221-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		/omit-if-no-ref/
+		gpio0_ldo: gpio0-ldo-pin {
+			pins = "GPIO0";
+			function = "ldo";
+		};
+
+		/omit-if-no-ref/
+		gpio1_ldo: gpio1-ldo-pin {
+			pins = "GPIO1";
+			function = "ldo";
+		};
+	};
 };
-- 
2.35.1

