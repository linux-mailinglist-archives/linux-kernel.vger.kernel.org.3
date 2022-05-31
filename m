Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3D11538A99
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 06:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243837AbiEaEfr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 00:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbiEaEfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 00:35:45 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D380281981;
        Mon, 30 May 2022 21:35:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9156B320097C;
        Tue, 31 May 2022 00:35:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 31 May 2022 00:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm2; t=1653971742; x=1654058142; bh=5yElh59+3MPLd85cpFAqy7fHN
        oGUSso7fKbsFc/4EsI=; b=EcOxtSWidy5f15iZIilsNgHyLtTSb1YR/P6aTtnyO
        wgB3PgDVWWo7dO2WpA57jmeMyN0zUA7GUrCMqJRAFhTr3yYfgL87ntRP8Rsg1A5H
        QKh0HnWB2sW9ZO4uF3F0ujNjK8UozEQhKPOGbp4018PiiFEOj3qReDaoN3Q1xzvU
        q7omwzUIVYvGcAemuEqKBaddmZBUFuUZn4LxIz8vy8ulnzhzST7nlA+RN8LbWToK
        BgdMIstOfQX1+Dbp1ED5eFs/PM0dKAWFkIAv2T5Y+KJX2UOiySFB8+prySngd1N8
        W3WtTXDr7qbOxhEY7ebZzccdEx+LeFTzShho45SIv680A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1653971742; x=1654058142; bh=5yElh59+3MPLd85cpFAqy7fHNoGUSso7fKb
        sFc/4EsI=; b=isCK9nVu252CFAsbC6SQLVwhGpEdxexNR/OjWb6sZ0wBixwBoPG
        MWeig4gz7HMaGaGLNDPNCglLMj/heO2JqTooIc5qqNFVgADpluXuDMcM6r05uBM9
        qU1VrTKN29VOLmiLzUbopw61qaiQABfPOzVEosIf13IjS6YPCeIpLD7rWjv4nRUE
        4ZWqnj8S0e1fyj0FqqhagyZfq7Z5vnqVhrRgTTo9rrCqaxfGUWiMWNr6T9xi5DxI
        dh5vLlJUSwi/HEE0GJLm4sCvvAE9OXupOB7JkbEFUBTcv24XL1k3cP1LfFHxz5Xr
        1DV5IhxqX8TwWLhOn3xmdotoflx3XCJwWPg==
X-ME-Sender: <xms:HZuVYvIP_1WgpmewI3zhsZ_TmaI7KMV8tAJuI3PiiOIgIM_LkLLuHg>
    <xme:HZuVYjJS-5wVzrulxgOAEz3FO0Hk69GSdvFRkZyQ8abU9VL1xg81x1bNwQV5puXLs
    Bag7repkvx4jl_JXQ>
X-ME-Received: <xmr:HZuVYntDU7wRxUp-jeSKkCoZNYnCMWsAagjybwe-__q9jb76c9LZVP9zAOX52omQWhuTwikjujLak1iVyWcaRmrvAuee1i82T6QcS24h70wbCMIBiVAXB0jhB-pu_xO7R8LOyg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrkeejgdekhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:HZuVYoapWyJllEwL7n_52DJgt16WxsVb55o3hBtXYMDrNrXeB83QYw>
    <xmx:HZuVYmZWIbOgtGI_77KoiJASfSypLNJhzZQ3vbygljCtoKl80U3TaQ>
    <xmx:HZuVYsAJwNMdpjCAkHGfcyMp8yJC9l6KA7UKOGVQ-NyH_iru_ktKcw>
    <xmx:HpuVYu7MhcOdfN_AfN3IqrEiaLqvAHd9-46E3lkEBVlhCQvR41qlbw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 May 2022 00:35:41 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
Subject: [PATCH] clk: sunxi-ng: Deduplicate ccu_clks arrays
Date:   Mon, 30 May 2022 23:35:39 -0500
Message-Id: <20220531043539.41549-1-samuel@sholland.org>
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

The ccu_clks arrays are used to link ccu_common objects to a platform
device during probe. There is no requirement that the clk_hw inside the
ccu_common object ever gets registered with the clock framework. So the
drivers do not need a separate ccu_clks array for each CCU variant.
A single array per driver, containing the union of the CCU clocks from
all variants, is sufficient.

Let's save some space by combining the ccu_clks arrays in each driver.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c |  16 +---
 drivers/clk/sunxi-ng/ccu-sun8i-de2.c   |  77 +++++------------
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c    | 113 +------------------------
 drivers/clk/sunxi-ng/ccu-sun8i-r.c     |  40 ++-------
 drivers/clk/sunxi-ng/ccu-sun8i-v3s.c   |  80 +----------------
 5 files changed, 37 insertions(+), 289 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
index 29a8c710ae06..001582ea71ba 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c
@@ -138,19 +138,9 @@ static struct ccu_common *sun50i_h6_r_ccu_clks[] = {
 	&r_apb2_rsb_clk.common,
 	&r_apb1_ir_clk.common,
 	&r_apb1_w1_clk.common,
-	&ir_clk.common,
-	&w1_clk.common,
-};
-
-static struct ccu_common *sun50i_h616_r_ccu_clks[] = {
-	&r_apb1_clk.common,
-	&r_apb2_clk.common,
-	&r_apb1_twd_clk.common,
-	&r_apb2_i2c_clk.common,
-	&r_apb2_rsb_clk.common,
-	&r_apb1_ir_clk.common,
 	&r_apb1_rtc_clk.common,
 	&ir_clk.common,
+	&w1_clk.common,
 };
 
 static struct clk_hw_onecell_data sun50i_h6_r_hw_clks = {
@@ -218,8 +208,8 @@ static const struct sunxi_ccu_desc sun50i_h6_r_ccu_desc = {
 };
 
 static const struct sunxi_ccu_desc sun50i_h616_r_ccu_desc = {
-	.ccu_clks	= sun50i_h616_r_ccu_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun50i_h616_r_ccu_clks),
+	.ccu_clks	= sun50i_h6_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun50i_h6_r_ccu_clks),
 
 	.hw_clks	= &sun50i_h616_r_hw_clks,
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
index e7e3ddf4a227..2f6f02f00be2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-de2.c
@@ -53,65 +53,26 @@ static SUNXI_CCU_M(wb_div_a83_clk, "wb-div", "pll-de", 0x0c, 8, 4,
 static SUNXI_CCU_M(rot_div_a83_clk, "rot-div", "pll-de", 0x0c, 0x0c, 4,
 		   CLK_SET_RATE_PARENT);
 
-static struct ccu_common *sun8i_a83t_de2_clks[] = {
+static struct ccu_common *sun8i_de2_ccu_clks[] = {
 	&mixer0_clk.common,
 	&mixer1_clk.common,
 	&wb_clk.common,
-
-	&bus_mixer0_clk.common,
-	&bus_mixer1_clk.common,
-	&bus_wb_clk.common,
-
-	&mixer0_div_a83_clk.common,
-	&mixer1_div_a83_clk.common,
-	&wb_div_a83_clk.common,
-
-	&bus_rot_clk.common,
 	&rot_clk.common,
-	&rot_div_a83_clk.common,
-};
-
-static struct ccu_common *sun8i_h3_de2_clks[] = {
-	&mixer0_clk.common,
-	&mixer1_clk.common,
-	&wb_clk.common,
-
-	&bus_mixer0_clk.common,
-	&bus_mixer1_clk.common,
-	&bus_wb_clk.common,
-
-	&mixer0_div_clk.common,
-	&mixer1_div_clk.common,
-	&wb_div_clk.common,
-};
-
-static struct ccu_common *sun8i_v3s_de2_clks[] = {
-	&mixer0_clk.common,
-	&wb_clk.common,
-
-	&bus_mixer0_clk.common,
-	&bus_wb_clk.common,
-
-	&mixer0_div_clk.common,
-	&wb_div_clk.common,
-};
-
-static struct ccu_common *sun50i_a64_de2_clks[] = {
-	&mixer0_clk.common,
-	&mixer1_clk.common,
-	&wb_clk.common,
 
 	&bus_mixer0_clk.common,
 	&bus_mixer1_clk.common,
 	&bus_wb_clk.common,
+	&bus_rot_clk.common,
 
 	&mixer0_div_clk.common,
 	&mixer1_div_clk.common,
 	&wb_div_clk.common,
-
-	&bus_rot_clk.common,
-	&rot_clk.common,
 	&rot_div_clk.common,
+
+	&mixer0_div_a83_clk.common,
+	&mixer1_div_a83_clk.common,
+	&wb_div_a83_clk.common,
+	&rot_div_a83_clk.common,
 };
 
 static struct clk_hw_onecell_data sun8i_a83t_de2_hw_clks = {
@@ -219,8 +180,8 @@ static struct ccu_reset_map sun50i_h5_de2_resets[] = {
 };
 
 static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
-	.ccu_clks	= sun8i_a83t_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_a83t_de2_clks),
+	.ccu_clks	= sun8i_de2_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
 
 	.hw_clks	= &sun8i_a83t_de2_hw_clks,
 
@@ -229,8 +190,8 @@ static const struct sunxi_ccu_desc sun8i_a83t_de2_clk_desc = {
 };
 
 static const struct sunxi_ccu_desc sun8i_h3_de2_clk_desc = {
-	.ccu_clks	= sun8i_h3_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_de2_clks),
+	.ccu_clks	= sun8i_de2_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
 
 	.hw_clks	= &sun8i_h3_de2_hw_clks,
 
@@ -239,8 +200,8 @@ static const struct sunxi_ccu_desc sun8i_h3_de2_clk_desc = {
 };
 
 static const struct sunxi_ccu_desc sun8i_r40_de2_clk_desc = {
-	.ccu_clks	= sun50i_a64_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun50i_a64_de2_clks),
+	.ccu_clks	= sun8i_de2_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
 
 	.hw_clks	= &sun50i_a64_de2_hw_clks,
 
@@ -249,8 +210,8 @@ static const struct sunxi_ccu_desc sun8i_r40_de2_clk_desc = {
 };
 
 static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc = {
-	.ccu_clks	= sun8i_v3s_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3s_de2_clks),
+	.ccu_clks	= sun8i_de2_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
 
 	.hw_clks	= &sun8i_v3s_de2_hw_clks,
 
@@ -259,8 +220,8 @@ static const struct sunxi_ccu_desc sun8i_v3s_de2_clk_desc = {
 };
 
 static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc = {
-	.ccu_clks	= sun50i_a64_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun50i_a64_de2_clks),
+	.ccu_clks	= sun8i_de2_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
 
 	.hw_clks	= &sun50i_a64_de2_hw_clks,
 
@@ -269,8 +230,8 @@ static const struct sunxi_ccu_desc sun50i_a64_de2_clk_desc = {
 };
 
 static const struct sunxi_ccu_desc sun50i_h5_de2_clk_desc = {
-	.ccu_clks	= sun8i_h3_de2_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_de2_clks),
+	.ccu_clks	= sun8i_de2_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_de2_ccu_clks),
 
 	.hw_clks	= &sun8i_h3_de2_hw_clks,
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index e058cf691aea..d3fcb983c17c 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -562,6 +562,7 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&bus_uart2_clk.common,
 	&bus_uart3_clk.common,
 	&bus_scr0_clk.common,
+	&bus_scr1_clk.common,
 	&bus_ephy_clk.common,
 	&bus_dbg_clk.common,
 	&ths_clk.common,
@@ -612,114 +613,6 @@ static struct ccu_common *sun8i_h3_ccu_clks[] = {
 	&gpu_clk.common,
 };
 
-static struct ccu_common *sun50i_h5_ccu_clks[] = {
-	&pll_cpux_clk.common,
-	&pll_audio_base_clk.common,
-	&pll_video_clk.common,
-	&pll_ve_clk.common,
-	&pll_ddr_clk.common,
-	&pll_periph0_clk.common,
-	&pll_gpu_clk.common,
-	&pll_periph1_clk.common,
-	&pll_de_clk.common,
-	&cpux_clk.common,
-	&axi_clk.common,
-	&ahb1_clk.common,
-	&apb1_clk.common,
-	&apb2_clk.common,
-	&ahb2_clk.common,
-	&bus_ce_clk.common,
-	&bus_dma_clk.common,
-	&bus_mmc0_clk.common,
-	&bus_mmc1_clk.common,
-	&bus_mmc2_clk.common,
-	&bus_nand_clk.common,
-	&bus_dram_clk.common,
-	&bus_emac_clk.common,
-	&bus_ts_clk.common,
-	&bus_hstimer_clk.common,
-	&bus_spi0_clk.common,
-	&bus_spi1_clk.common,
-	&bus_otg_clk.common,
-	&bus_ehci0_clk.common,
-	&bus_ehci1_clk.common,
-	&bus_ehci2_clk.common,
-	&bus_ehci3_clk.common,
-	&bus_ohci0_clk.common,
-	&bus_ohci1_clk.common,
-	&bus_ohci2_clk.common,
-	&bus_ohci3_clk.common,
-	&bus_ve_clk.common,
-	&bus_tcon0_clk.common,
-	&bus_tcon1_clk.common,
-	&bus_deinterlace_clk.common,
-	&bus_csi_clk.common,
-	&bus_tve_clk.common,
-	&bus_hdmi_clk.common,
-	&bus_de_clk.common,
-	&bus_gpu_clk.common,
-	&bus_msgbox_clk.common,
-	&bus_spinlock_clk.common,
-	&bus_codec_clk.common,
-	&bus_spdif_clk.common,
-	&bus_pio_clk.common,
-	&bus_ths_clk.common,
-	&bus_i2s0_clk.common,
-	&bus_i2s1_clk.common,
-	&bus_i2s2_clk.common,
-	&bus_i2c0_clk.common,
-	&bus_i2c1_clk.common,
-	&bus_i2c2_clk.common,
-	&bus_uart0_clk.common,
-	&bus_uart1_clk.common,
-	&bus_uart2_clk.common,
-	&bus_uart3_clk.common,
-	&bus_scr0_clk.common,
-	&bus_scr1_clk.common,
-	&bus_ephy_clk.common,
-	&bus_dbg_clk.common,
-	&ths_clk.common,
-	&nand_clk.common,
-	&mmc0_clk.common,
-	&mmc1_clk.common,
-	&mmc2_clk.common,
-	&ts_clk.common,
-	&ce_clk.common,
-	&spi0_clk.common,
-	&spi1_clk.common,
-	&i2s0_clk.common,
-	&i2s1_clk.common,
-	&i2s2_clk.common,
-	&spdif_clk.common,
-	&usb_phy0_clk.common,
-	&usb_phy1_clk.common,
-	&usb_phy2_clk.common,
-	&usb_phy3_clk.common,
-	&usb_ohci0_clk.common,
-	&usb_ohci1_clk.common,
-	&usb_ohci2_clk.common,
-	&usb_ohci3_clk.common,
-	&dram_clk.common,
-	&dram_ve_clk.common,
-	&dram_csi_clk.common,
-	&dram_deinterlace_clk.common,
-	&dram_ts_clk.common,
-	&de_clk.common,
-	&tcon_clk.common,
-	&tve_clk.common,
-	&deinterlace_clk.common,
-	&csi_misc_clk.common,
-	&csi_sclk_clk.common,
-	&csi_mclk_clk.common,
-	&ve_clk.common,
-	&ac_dig_clk.common,
-	&avs_clk.common,
-	&hdmi_clk.common,
-	&hdmi_ddc_clk.common,
-	&mbus_clk.common,
-	&gpu_clk.common,
-};
-
 static const struct clk_hw *clk_parent_pll_audio[] = {
 	&pll_audio_base_clk.common.hw
 };
@@ -1116,8 +1009,8 @@ static const struct sunxi_ccu_desc sun8i_h3_ccu_desc = {
 };
 
 static const struct sunxi_ccu_desc sun50i_h5_ccu_desc = {
-	.ccu_clks	= sun50i_h5_ccu_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun50i_h5_ccu_clks),
+	.ccu_clks	= sun8i_h3_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_ccu_clks),
 
 	.hw_clks	= &sun50i_h5_hw_clks,
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-r.c b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
index 5b7fab832a52..4221649b311f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-r.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-r.c
@@ -114,32 +114,7 @@ static struct ccu_mp a83t_ir_clk = {
 	},
 };
 
-static struct ccu_common *sun8i_a83t_r_ccu_clks[] = {
-	&ar100_clk.common,
-	&apb0_clk.common,
-	&apb0_pio_clk.common,
-	&apb0_ir_clk.common,
-	&apb0_timer_clk.common,
-	&apb0_rsb_clk.common,
-	&apb0_uart_clk.common,
-	&apb0_i2c_clk.common,
-	&apb0_twd_clk.common,
-	&a83t_ir_clk.common,
-};
-
-static struct ccu_common *sun8i_h3_r_ccu_clks[] = {
-	&ar100_clk.common,
-	&apb0_clk.common,
-	&apb0_pio_clk.common,
-	&apb0_ir_clk.common,
-	&apb0_timer_clk.common,
-	&apb0_uart_clk.common,
-	&apb0_i2c_clk.common,
-	&apb0_twd_clk.common,
-	&ir_clk.common,
-};
-
-static struct ccu_common *sun50i_a64_r_ccu_clks[] = {
+static struct ccu_common *sun8i_r_ccu_clks[] = {
 	&ar100_clk.common,
 	&apb0_clk.common,
 	&apb0_pio_clk.common,
@@ -150,6 +125,7 @@ static struct ccu_common *sun50i_a64_r_ccu_clks[] = {
 	&apb0_i2c_clk.common,
 	&apb0_twd_clk.common,
 	&ir_clk.common,
+	&a83t_ir_clk.common,
 };
 
 static struct clk_hw_onecell_data sun8i_a83t_r_hw_clks = {
@@ -226,8 +202,8 @@ static struct ccu_reset_map sun50i_a64_r_ccu_resets[] = {
 };
 
 static const struct sunxi_ccu_desc sun8i_a83t_r_ccu_desc = {
-	.ccu_clks	= sun8i_a83t_r_ccu_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_a83t_r_ccu_clks),
+	.ccu_clks	= sun8i_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_r_ccu_clks),
 
 	.hw_clks	= &sun8i_a83t_r_hw_clks,
 
@@ -236,8 +212,8 @@ static const struct sunxi_ccu_desc sun8i_a83t_r_ccu_desc = {
 };
 
 static const struct sunxi_ccu_desc sun8i_h3_r_ccu_desc = {
-	.ccu_clks	= sun8i_h3_r_ccu_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_h3_r_ccu_clks),
+	.ccu_clks	= sun8i_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_r_ccu_clks),
 
 	.hw_clks	= &sun8i_h3_r_hw_clks,
 
@@ -246,8 +222,8 @@ static const struct sunxi_ccu_desc sun8i_h3_r_ccu_desc = {
 };
 
 static const struct sunxi_ccu_desc sun50i_a64_r_ccu_desc = {
-	.ccu_clks	= sun50i_a64_r_ccu_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun50i_a64_r_ccu_clks),
+	.ccu_clks	= sun8i_r_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_r_ccu_clks),
 
 	.hw_clks	= &sun50i_a64_r_hw_clks,
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
index 87f87d6ea3ad..fbb3529f0d3e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
@@ -421,6 +421,7 @@ static struct ccu_common *sun8i_v3s_ccu_clks[] = {
 	&bus_de_clk.common,
 	&bus_codec_clk.common,
 	&bus_pio_clk.common,
+	&bus_i2s0_clk.common,
 	&bus_i2c0_clk.common,
 	&bus_i2c1_clk.common,
 	&bus_uart0_clk.common,
@@ -439,6 +440,7 @@ static struct ccu_common *sun8i_v3s_ccu_clks[] = {
 	&mmc2_output_clk.common,
 	&ce_clk.common,
 	&spi0_clk.common,
+	&i2s0_clk.common,
 	&usb_phy0_clk.common,
 	&usb_ohci0_clk.common,
 	&dram_clk.common,
@@ -463,80 +465,6 @@ static const struct clk_hw *clk_parent_pll_audio[] = {
 	&pll_audio_base_clk.common.hw
 };
 
-static struct ccu_common *sun8i_v3_ccu_clks[] = {
-	&pll_cpu_clk.common,
-	&pll_audio_base_clk.common,
-	&pll_video_clk.common,
-	&pll_ve_clk.common,
-	&pll_ddr0_clk.common,
-	&pll_periph0_clk.common,
-	&pll_isp_clk.common,
-	&pll_periph1_clk.common,
-	&pll_ddr1_clk.common,
-	&cpu_clk.common,
-	&axi_clk.common,
-	&ahb1_clk.common,
-	&apb1_clk.common,
-	&apb2_clk.common,
-	&ahb2_clk.common,
-	&bus_ce_clk.common,
-	&bus_dma_clk.common,
-	&bus_mmc0_clk.common,
-	&bus_mmc1_clk.common,
-	&bus_mmc2_clk.common,
-	&bus_dram_clk.common,
-	&bus_emac_clk.common,
-	&bus_hstimer_clk.common,
-	&bus_spi0_clk.common,
-	&bus_otg_clk.common,
-	&bus_ehci0_clk.common,
-	&bus_ohci0_clk.common,
-	&bus_ve_clk.common,
-	&bus_tcon0_clk.common,
-	&bus_csi_clk.common,
-	&bus_de_clk.common,
-	&bus_codec_clk.common,
-	&bus_pio_clk.common,
-	&bus_i2s0_clk.common,
-	&bus_i2c0_clk.common,
-	&bus_i2c1_clk.common,
-	&bus_uart0_clk.common,
-	&bus_uart1_clk.common,
-	&bus_uart2_clk.common,
-	&bus_ephy_clk.common,
-	&bus_dbg_clk.common,
-	&mmc0_clk.common,
-	&mmc0_sample_clk.common,
-	&mmc0_output_clk.common,
-	&mmc1_clk.common,
-	&mmc1_sample_clk.common,
-	&mmc1_output_clk.common,
-	&mmc2_clk.common,
-	&mmc2_sample_clk.common,
-	&mmc2_output_clk.common,
-	&ce_clk.common,
-	&spi0_clk.common,
-	&i2s0_clk.common,
-	&usb_phy0_clk.common,
-	&usb_ohci0_clk.common,
-	&dram_clk.common,
-	&dram_ve_clk.common,
-	&dram_csi_clk.common,
-	&dram_ohci_clk.common,
-	&dram_ehci_clk.common,
-	&de_clk.common,
-	&tcon_clk.common,
-	&csi_misc_clk.common,
-	&csi0_mclk_clk.common,
-	&csi1_sclk_clk.common,
-	&csi1_mclk_clk.common,
-	&ve_clk.common,
-	&ac_dig_clk.common,
-	&avs_clk.common,
-	&mbus_clk.common,
-	&mipi_csi_clk.common,
-};
-
 /* We hardcode the divider to 1 for SDM support */
 static CLK_FIXED_FACTOR_HWS(pll_audio_clk, "pll-audio",
 			    clk_parent_pll_audio,
@@ -798,8 +726,8 @@ static const struct sunxi_ccu_desc sun8i_v3s_ccu_desc = {
 };
 
 static const struct sunxi_ccu_desc sun8i_v3_ccu_desc = {
-	.ccu_clks	= sun8i_v3_ccu_clks,
-	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3_ccu_clks),
+	.ccu_clks	= sun8i_v3s_ccu_clks,
+	.num_ccu_clks	= ARRAY_SIZE(sun8i_v3s_ccu_clks),
 
 	.hw_clks	= &sun8i_v3_hw_clks,
 
-- 
2.35.1

