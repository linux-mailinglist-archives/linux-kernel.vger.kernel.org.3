Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7300590D07
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 09:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237729AbiHLH4Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 03:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237674AbiHLH4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 03:56:11 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0118A9AF99;
        Fri, 12 Aug 2022 00:56:10 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 63E5E5C00E4;
        Fri, 12 Aug 2022 03:56:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 12 Aug 2022 03:56:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1660290969; x=1660377369; bh=C8
        3k0zYFtHbw8K7oTUWFJgU6C0PSTg2NOklbCSj4b78=; b=moKEoI7fuhgxU+xG+9
        ZzkzD3scCETDgLCE8uj4p/9uxXdnbjglHeAvzNer9BvSEayBwboYge+HWbemB/Hb
        Bxt+MfDrW/7Da8AeBXKVY7oESYO3h63ldW1GAf/mpC6zFs+1eg8NIm2mM7+/2Zb4
        1RGifN4gSCPiDSZx4YyHWsMzgZomjgF6dm16j6JjNYKIjvFFrwpNOvKGwRHfIUwe
        tuV+r4gFxhTwXeLv063pgNWRKdzuNWh7fLvNBPyIuN6WIPI4iR/g9d0J90fIxIVS
        5PYgmlLg0nk7lDHzIPkHXHyFqBR9Z90Ana/nwoDspMCKqyhHOL9rogIQWUc+1CLp
        gIzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1660290969; x=1660377369; bh=C83k0zYFtHbw8
        K7oTUWFJgU6C0PSTg2NOklbCSj4b78=; b=IbN+YSOH03n9UNkR2knEefGALM7I9
        98ti2IGb6HYFtkqeCRFU38IVxD22NV5aDZOxuJOEQ40mBeWHOsgeGLzpbb4LipIg
        J+dJjlBRvEKiljiYcUzOntuVByDaBorIHjrk6kVezL/saqChifagCGn7UkF7BPET
        uum7t0JC5g1cjzpiPuN+IX0c1CINUTqg0Eg2rD+/73wFzoCjhjx5ZtrV/RkDNGHZ
        X0kd2s/OqUFgPJicUIP31ZPTCQE+KfJfdW5L6UffdOhLhr4JsKZD8sw1FtSEH5o3
        CJQLhIpNme69ZzB7P6GuEaIAfzazAscIEUr9Y19AUa0gH5mrIvwuo/IqA==
X-ME-Sender: <xms:mQf2YqtsFbC0Ywzz2TvW97_0dhixuK_6xLKvxTJ_yi0Oxh1xRxpX7Q>
    <xme:mQf2YvcCW_gOwNmZj8PcLCj8SOrcfmXIC4Br45YppfIQO5ncBxOQWtBFtcVUmh2IU
    Tloeoe1SjONwIyykQ>
X-ME-Received: <xmr:mQf2YlyFfmgemIZSxQ7xsPvCclE_YAZXt4P_7cO2_JMmEPzXDmCThY_rvAR9PO9aOLYCST7SnR4J1Ycq2E5SRsgNKqfwkpVX6VqnxkFK5gGAT6VBSHMiHAOTUrUnbsXOS673Yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdeghedguddvjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedukeetueduhedtleetvefguddvvdejhfefudelgfduveeggeeh
    gfdufeeitdevteenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:mQf2YlPcYicktf9ADSK2L2L-DJ750riyNUiJOQ6mB46biSZsDG8hFw>
    <xmx:mQf2Yq8l0unsItoGRNfy19d0jOiZe2AwBDB5bMGcboQkay4GVr0WKw>
    <xmx:mQf2YtXhj1w1nRTVHSl8WGi3yaSbFaYdFxLS2ZFKm3jQWENiUZvVAw>
    <xmx:mQf2YuVjxeTP9Z7QTFZ4yruRpdYI8k9e_wQpJdPz2MuZytEBvRbctA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 03:56:08 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Samuel Holland <samuel@sholland.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH 3/8] arm64: dts: allwinner: a64: Add DPHY interrupt
Date:   Fri, 12 Aug 2022 02:55:58 -0500
Message-Id: <20220812075603.59375-4-samuel@sholland.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220812075603.59375-1-samuel@sholland.org>
References: <20220812075603.59375-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DPHY has an interrupt line which is shared with the DSI controller.

Fixes: 16c8ff571a16 ("arm64: dts: allwinner: a64: Add MIPI DSI pipeline")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 77b5349f6087..62f45f71ec65 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1199,6 +1199,7 @@ dphy: d-phy@1ca1000 {
 			compatible = "allwinner,sun50i-a64-mipi-dphy",
 				     "allwinner,sun6i-a31-mipi-dphy";
 			reg = <0x01ca1000 0x1000>;
+			interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&ccu CLK_BUS_MIPI_DSI>,
 				 <&ccu CLK_DSI_DPHY>;
 			clock-names = "bus", "mod";
-- 
2.35.1

