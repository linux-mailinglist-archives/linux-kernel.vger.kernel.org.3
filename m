Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A78A552A08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 06:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345384AbiFUDm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 23:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345190AbiFUDmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 23:42:43 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979B2205E1;
        Mon, 20 Jun 2022 20:42:35 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 43C1F32008FC;
        Mon, 20 Jun 2022 23:42:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 Jun 2022 23:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1655782953; x=1655869353; bh=E1
        xy502tT2o6kQP7RzONuNL2uQA+shIpVy7y307P1/M=; b=ejrcg7P9aU9tLfhcw0
        aBFwTRROuKoxX2lFcWhQqjciNpZv3cjTYCUXfs7UyDA0CxLGT1db5h0DpsMsyl70
        pwugrcNneV03xT8/ZWjoCnY1b/nW1Y4sMYNhwESMCXwRaybOnSo299yO4ULi482S
        FvmxuGHtvftHIMDNoNALcGvSzIaizP/j1azMhaB6cWpkg2WSGh93lTPbXDzpoukC
        Jadph9oSW4KE0Wyh2Qd6xakf23+fZ/LhDvYWnR0A0XY8FYEkC1oab6utDNQzQyF4
        XwhAYbqT12HLmAwRy2sgwfqjZ9SWH2h8FrfIqdGP7XB+TyumQPydz+VVq/5pq7jq
        3O0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1655782953; x=1655869353; bh=E1xy502tT2o6k
        QP7RzONuNL2uQA+shIpVy7y307P1/M=; b=ZSIKUCA8opETMy25KJ6SqrKdb7Hh4
        llyj18qehsm7khzQqYkFBIulQUc4ZetBpAjZURyUPv6L6fMmXrijdCrEC7jJJ6JN
        V2DpVJe1wIlRNZcgR9qM9aTCkvQrxkQOPakHXgn0zcqtXh1NACZwOu+2RUX7rz7V
        u0oD3StsXxupoGWQk5uYkBKO1oeWWZDSligbG7/KLjNRxGETblFK8qJt+QVaIyux
        1duztXOZi+IupN+sMpRshywnZdYd6JpsFswY6GDcQc01YTv1+LmAxPiMnOlZm4Jj
        b2uwOO9+jJG1b7wNtNBR/9/1s5n0zW5z+GIklZXwTSlfJ9xMq1f1ACg/Q==
X-ME-Sender: <xms:KT6xYpsECMyCj1RgGMdRCcJySkYVcDWpnvT2YelH8orC8urqVEueGw>
    <xme:KT6xYidUZwR73MpF3BSBxfsqGdAPFqsWN_Dbuo-jVZlAmy2-R23YHRZ5wQ_3bL0qQ
    LEk9nUpieG4xZrpYg>
X-ME-Received: <xmr:KT6xYsw27hLcHNTm1qRa8QBn5qjdPC9QjeHJIojh9Q_Pi1jii4Ua5ZRsFgRH61yE3Ey5ikqRqAROLjBc4sVxh2kCQ-rTstI2KSpe-Lm2h42dqWZMD9If6BV_J1443m2Lg-GwJA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudefvddgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:KT6xYgMJnMWUZwtUM4uj1ImS4k6CiRSbdOdjRQKolOgUX-8hAz38xA>
    <xmx:KT6xYp9MkHi88g0xyTi8f34gbMJw-2Z1P5nIe0wVKrdWTGxTUi1JcA>
    <xmx:KT6xYgUWwv9byEQ5386HPmzj4ZqtrGekqkB5N_zWkRCPSL1xdG3A-g>
    <xmx:KT6xYlRqCDd5ITpRsQtxtw5y2Y2aSh4VLU7DgQEYWSOCvMKTetI4tA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 20 Jun 2022 23:42:33 -0400 (EDT)
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
Subject: [PATCH v2 3/4] pinctrl: axp209: Support the AXP221/AXP223/AXP809 variant
Date:   Mon, 20 Jun 2022 22:42:23 -0500
Message-Id: <20220621034224.38995-4-samuel@sholland.org>
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

These PMICs each have 2 GPIOs with the same register layout as AXP813,
but without an ADC function. They all fall back to the AXP221 compatible
string, so only that one needs to be listed in the driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/pinctrl/pinctrl-axp209.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-axp209.c b/drivers/pinctrl/pinctrl-axp209.c
index 207cbae3a7bf..7ab20ac15391 100644
--- a/drivers/pinctrl/pinctrl-axp209.c
+++ b/drivers/pinctrl/pinctrl-axp209.c
@@ -73,7 +73,7 @@ static const struct pinctrl_pin_desc axp209_pins[] = {
 	PINCTRL_PIN(2, "GPIO2"),
 };
 
-static const struct pinctrl_pin_desc axp813_pins[] = {
+static const struct pinctrl_pin_desc axp22x_pins[] = {
 	PINCTRL_PIN(0, "GPIO0"),
 	PINCTRL_PIN(1, "GPIO1"),
 };
@@ -87,9 +87,16 @@ static const struct axp20x_pctrl_desc axp20x_data = {
 	.adc_mux = AXP20X_MUX_ADC,
 };
 
+static const struct axp20x_pctrl_desc axp22x_data = {
+	.pins	= axp22x_pins,
+	.npins	= ARRAY_SIZE(axp22x_pins),
+	.ldo_mask = BIT(0) | BIT(1),
+	.gpio_status_offset = 0,
+};
+
 static const struct axp20x_pctrl_desc axp813_data = {
-	.pins	= axp813_pins,
-	.npins	= ARRAY_SIZE(axp813_pins),
+	.pins	= axp22x_pins,
+	.npins	= ARRAY_SIZE(axp22x_pins),
 	.ldo_mask = BIT(0) | BIT(1),
 	.adc_mask = BIT(0),
 	.gpio_status_offset = 0,
@@ -388,6 +395,7 @@ static int axp20x_build_funcs_groups(struct platform_device *pdev)
 
 static const struct of_device_id axp20x_pctl_match[] = {
 	{ .compatible = "x-powers,axp209-gpio", .data = &axp20x_data, },
+	{ .compatible = "x-powers,axp221-gpio", .data = &axp22x_data, },
 	{ .compatible = "x-powers,axp813-gpio", .data = &axp813_data, },
 	{ }
 };
-- 
2.35.1

