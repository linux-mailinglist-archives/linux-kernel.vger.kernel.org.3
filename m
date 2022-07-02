Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EF456405C
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 15:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232179AbiGBN2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 09:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiGBN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 09:28:23 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B29F2BD4;
        Sat,  2 Jul 2022 06:28:21 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 659945C017F;
        Sat,  2 Jul 2022 09:28:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 02 Jul 2022 09:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1656768498; x=1656854898; bh=+AqbgLoYyakIVw/H+M02HHIDl
        M4/A07bAgTwMtULFUk=; b=T3yvNvQjCgXnAuByTYEBrdtqVoJ0zB5izBeJKFvvp
        47/mHK3oFEChkvr5ICZhVsu84a+m3jd+Fq+AjC5ATMfrtXEx9hk1T6gq/MQItD+e
        3kKSuhi6nso2nrQ60onKhDP0dSCaLKw6FptjaWIy/JbE40I/AGNx6dABYvMosIwm
        3CMIgQnetxqC85Yvx93OAfx9l3B1nAU6BstAM4T+KVKNhu9miVdDn8P60moCLgHc
        bCWGuAl2AWlLgzZKELglt9yYBgne9LWQMx4VK+Otu/5BDVcoc40tUr6dCYEhrSkY
        lLX8oC11AjywT9n/JUb1WsOQdBDRMZU7krvHIYY53vA6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1656768498; x=1656854898; bh=+AqbgLoYyakIVw/H+M02HHIDlM4/A07bAgT
        wMtULFUk=; b=Fu8yENJWSfHoWSw7d4V7MRrHE6w53vuZmqp+3A8doYafxDrNMSe
        1mqXSyOPS9/hxOqenYpp0NquCDMJ7ScmJxr0pmqee3Tm6fvCR+x9g5g0Jrn7m0yJ
        CWM7v2EHDL3D3j9Y7FF8ZTIRcPj+rLHe6oW15mQIcrp3mQvPAQwWyOUUjaGnNygo
        z8EaRMlYWmcAw48LAAiKsAXs/uoo9D7GyyySiv8fphuaBUKXd8xt3jIwl/6kC9LL
        V17aQIxodj7/mV+Cr4HV9JRkyF/TwTdhDJbviD+tFPDspCUqsCE9SFSNR6PIdIC8
        JlLBmCp7kWqNYMO0g7BGyaIuHJAXwcNw1PQ==
X-ME-Sender: <xms:8UfAYrPglMCs8mARVBri31dK_l6v1_fplULyBSFRMcxvGckBBSyfcw>
    <xme:8UfAYl-aPmjLZxz78Z4Upfys-Cclxpn1tgggak77FDOCm69sKZX6uoU7tWDX7Kzp1
    bWXcHHM2tdTEKLb1Q>
X-ME-Received: <xmr:8UfAYqRsTUpfkbqdf4uDkHLxLUzy__lg-o0mISxKpmJpMZ-xzlMYVIXncPlcjjCEZf55j39NvCU6OslqRMKU9PYRFy3K4FOfQwSqPm5Uamjl4Uf4u0Gf7VKVVsYqHhTyI6Ghsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehhedgieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:8UfAYvsFptapOPM3fqpbtLPco-d8trPioeFmVLeet6kRGkN_ygYIUQ>
    <xmx:8UfAYjfSt_fmfnSparmmZOEosUGbpyHEiKgmZuXMafpZ8EdfImwzlA>
    <xmx:8UfAYr2HvJ1SrA14egTqZr65rruc_xNkP15CVOO7_5xokV4cVaMS5A>
    <xmx:8kfAYlt6j3pD7tp-ZuQyzVPZesN58zF5iN3dZgyKu1H1musIg1AUKQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 2 Jul 2022 09:28:17 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH] arm64: dts: allwinner: a64: orangepi-win: Fix LED node name
Date:   Sat,  2 Jul 2022 08:28:15 -0500
Message-Id: <20220702132816.46456-1-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
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

"status" does not match any pattern in the gpio-leds binding. Rename the
node to the preferred pattern. This fixes a `make dtbs_check` error.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index c519d9fa6967..3d2c68d58f49 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -40,7 +40,7 @@ hdmi_con_in: endpoint {
 	leds {
 		compatible = "gpio-leds";
 
-		status {
+		led-0 {
 			label = "orangepi:green:status";
 			gpios = <&pio 7 11 GPIO_ACTIVE_HIGH>; /* PH11 */
 		};
-- 
2.35.1

