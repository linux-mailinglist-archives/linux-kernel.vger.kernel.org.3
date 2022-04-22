Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C14350C55C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiDVX5x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 19:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiDVX5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 19:57:44 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5618618CE7A;
        Fri, 22 Apr 2022 16:54:46 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 9753F3201DB0;
        Fri, 22 Apr 2022 19:54:44 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 22 Apr 2022 19:54:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1650671684; x=
        1650758084; bh=bIORmVGxF8GzLIS1apB89GoRxus2DX+lmmNkIPvHyl8=; b=T
        zskOs5mekx97JHksNwUgq9YPhd3xRyFXh3Z9GxQZRrLiEOfT3T2Fza9/C4+bInUh
        WymLAjC7TVpuETRcX/w0y+bV2voYuHErYUJlv0x+GgS8VoFSdwcgSGvvJoNtDt7b
        b5u+SDlxEejqiVLTkOFdRBvlJqzL7xTLqlM28g6YrfM1Z6Uu1Mqvfe17hVJuwrun
        G/ZSsbDiFKpb/mfvdauVAxugfPiwtNV9jxQNT9VjgcgnclVDSYLOHVsUi5DLWecV
        oL7WEl1GLpZfnFrd+Spq6XBGtGTvpYz43B33kScXSX/pKDMqJiAwbyFPvrOzfnPG
        c5YKciOFKuqQ8Cw6OZmFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1650671684; x=1650758084; bh=bIORmVGxF8GzL
        IS1apB89GoRxus2DX+lmmNkIPvHyl8=; b=FqPCey5OF7RqXlhREjIa0xaypYger
        PbWrJJvFPfmyXczd8QkVgUbaWlKBIq/i5Laxte2xv48xgq0gN4LA6ca+k9zP97In
        noRNcTO7rZOWBzliRs2+jb+Ybpil44mIvL1Xov2PziUMlELx6ubbb5NnlzG9unq2
        a4fhss4dTWCYXd38/mfxpqjAUVKxRN1JayrBdStv2HLEsOEk6vYsQzrKZom5qypO
        MyhC9N4+xeb66KM13Yk5W9S2ewR3VMXsPXpWil7qoutC8PIc4h/LWUNB/Z++WLxJ
        vS1lfAtatzjClVbNul54dkR7KJXocDb6m1G6ZcOwQBpAOXU3hmPbjaAEA==
X-ME-Sender: <xms:Q0BjYn3I9QnhnJmd10plq-N14trhpmzD7zk-1mss0DSKmKk7XRCX5Q>
    <xme:Q0BjYmHH-JA59ibPl5AD-IU8jXoOwwz9qA-Np9KTOGe4BcJYtbufbXQ3D3qiajROw
    rW-mO56IkwCApfFAQ>
X-ME-Received: <xmr:Q0BjYn5i2h-lMhBK7Z49O3nvHS5TaVtaWNQ7cHWOZiT58UcqnxnoXYYPo1isKElOlJ3aboBPHigTt5tIqg2Ph_Ekp7jNG7r3FJbYYVipsHEtvpg1lQ13wObvtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrtdehgddvkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfevfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepffdtveekvdegkeeuueetgfetffeileevudekuefhheelvdfhiedt
    heduhfduhefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:Q0BjYs2PhBkWXXX24KDYjqIkhjecYf_DuFW1mGab9QYNdz-r0CZX3w>
    <xmx:Q0BjYqEs44nOwbxivKVteXb9eDo2zw3WOQzrZUKfh71vY7RfXb8wVQ>
    <xmx:Q0BjYt9CJROv94ATQuSSmx-cdbWkpSgh0y4_j-BFGz27SBYO4cTwFg>
    <xmx:REBjYtA9wanLN-CrrlEmRAKpyZNbDmusyH-8RtqgGRRiaoKbbD2ySw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 Apr 2022 19:54:43 -0400 (EDT)
Subject: Re: [PATCH 3/4] spi: sun6i: add quirk for in-controller clock divider
To:     Icenowy Zheng <icenowy@aosc.io>, Mark Brown <broonie@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, Icenowy Zheng <icenowy@aosc.io>
References: <20220422155639.1071645-1-icenowy@outlook.com>
 <BYAPR20MB24728A99C2F7505873A091B5BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <d1c09ca7-dc25-843c-2f64-fbf5111a9118@sholland.org>
Date:   Fri, 22 Apr 2022 18:54:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <BYAPR20MB24728A99C2F7505873A091B5BCF79@BYAPR20MB2472.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/22 10:56 AM, icenowy@outlook.com wrote:
> From: Icenowy Zheng <icenowy@aosc.io>
> 
> Previously SPI controllers in Allwinner SoCs has a clock divider inside.
> However now the clock divider is removed and to set the transfer clock
> rate it's only needed to set the SPI module clock to the target value.
> 
> Add a quirk for this kind of SPI controllers.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
>  drivers/spi/spi-sun6i.c | 68 +++++++++++++++++++++++------------------
>  1 file changed, 38 insertions(+), 30 deletions(-)
> 
> diff --git a/drivers/spi/spi-sun6i.c b/drivers/spi/spi-sun6i.c
> index 84c525b08ad0..fc81afc3a963 100644
> --- a/drivers/spi/spi-sun6i.c
> +++ b/drivers/spi/spi-sun6i.c
> @@ -87,6 +87,7 @@
>  
>  struct sun6i_spi_cfg {
>  	unsigned long		fifo_depth;
> +	bool			has_clk_ctl;
>  };
>  
>  struct sun6i_spi {
> @@ -260,7 +261,7 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  				  struct spi_transfer *tfr)
>  {
>  	struct sun6i_spi *sspi = spi_master_get_devdata(master);
> -	unsigned int mclk_rate, div, div_cdr1, div_cdr2, timeout;
> +	unsigned int div, div_cdr1, div_cdr2, timeout;
>  	unsigned int start, end, tx_time;
>  	unsigned int trig_level;
>  	unsigned int tx_len = 0, rx_len = 0;
> @@ -350,39 +351,44 @@ static int sun6i_spi_transfer_one(struct spi_master *master,
>  
>  	sun6i_spi_write(sspi, SUN6I_TFR_CTL_REG, reg);
>  
> -	/* Ensure that we have a parent clock fast enough */
> -	mclk_rate = clk_get_rate(sspi->mclk);
> -	if (mclk_rate < (2 * tfr->speed_hz)) {
> -		clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
> -		mclk_rate = clk_get_rate(sspi->mclk);
> -	}
> +	if (sspi->cfg->has_clk_ctl) {
> +		unsigned int mclk_rate = clk_get_rate(sspi->mclk);
> +		/* Ensure that we have a parent clock fast enough */
> +		if (mclk_rate < (2 * tfr->speed_hz)) {
> +			clk_set_rate(sspi->mclk, 2 * tfr->speed_hz);
> +			mclk_rate = clk_get_rate(sspi->mclk);
> +		}
>  
> -	/*
> -	 * Setup clock divider.
> -	 *
> -	 * We have two choices there. Either we can use the clock
> -	 * divide rate 1, which is calculated thanks to this formula:
> -	 * SPI_CLK = MOD_CLK / (2 ^ cdr)
> -	 * Or we can use CDR2, which is calculated with the formula:
> -	 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
> -	 * Wether we use the former or the latter is set through the
> -	 * DRS bit.
> -	 *
> -	 * First try CDR2, and if we can't reach the expected
> -	 * frequency, fall back to CDR1.
> -	 */
> -	div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
> -	div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
> -	if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
> -		reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN6I_CLK_CTL_DRS;
> -		tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
> +		/*
> +		 * Setup clock divider.
> +		 *
> +		 * We have two choices there. Either we can use the clock
> +		 * divide rate 1, which is calculated thanks to this formula:
> +		 * SPI_CLK = MOD_CLK / (2 ^ cdr)
> +		 * Or we can use CDR2, which is calculated with the formula:
> +		 * SPI_CLK = MOD_CLK / (2 * (cdr + 1))
> +		 * Wether we use the former or the latter is set through the
> +		 * DRS bit.
> +		 *
> +		 * First try CDR2, and if we can't reach the expected
> +		 * frequency, fall back to CDR1.
> +		 */
> +		div_cdr1 = DIV_ROUND_UP(mclk_rate, tfr->speed_hz);
> +		div_cdr2 = DIV_ROUND_UP(div_cdr1, 2);
> +		if (div_cdr2 <= (SUN6I_CLK_CTL_CDR2_MASK + 1)) {
> +			reg = SUN6I_CLK_CTL_CDR2(div_cdr2 - 1) | SUN6I_CLK_CTL_DRS;
> +			tfr->effective_speed_hz = mclk_rate / (2 * div_cdr2);
> +		} else {
> +			div = min(SUN6I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
> +			reg = SUN6I_CLK_CTL_CDR1(div);
> +			tfr->effective_speed_hz = mclk_rate / (1 << div);
> +		}
> +
> +		sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
>  	} else {
> -		div = min(SUN6I_CLK_CTL_CDR1_MASK, order_base_2(div_cdr1));
> -		reg = SUN6I_CLK_CTL_CDR1(div);
> -		tfr->effective_speed_hz = mclk_rate / (1 << div);
> +		clk_set_rate(sspi->mclk, tfr->speed_hz);

clk_set_rate() may not set the exact requested rate. Should we set
tfr->effective_speed_hz based on clk_get_rate() afterward?

Regards,
Samuel

>  	}
>  
> -	sun6i_spi_write(sspi, SUN6I_CLK_CTL_REG, reg);
>  	/* Finally enable the bus - doing so before might raise SCK to HIGH */
>  	reg = sun6i_spi_read(sspi, SUN6I_GBL_CTL_REG);
>  	reg |= SUN6I_GBL_CTL_BUS_ENABLE;
> @@ -702,10 +708,12 @@ static int sun6i_spi_remove(struct platform_device *pdev)
>  
>  static const struct sun6i_spi_cfg sun6i_a31_spi_cfg = {
>  	.fifo_depth	= SUN6I_FIFO_DEPTH,
> +	.has_clk_ctl	= true,
>  };
>  
>  static const struct sun6i_spi_cfg sun8i_h3_spi_cfg = {
>  	.fifo_depth	= SUN8I_FIFO_DEPTH,
> +	.has_clk_ctl	= true,
>  };
>  
>  static const struct of_device_id sun6i_spi_match[] = {
> 

