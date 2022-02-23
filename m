Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083524C0AC0
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 04:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237710AbiBWD5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 22:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231979AbiBWD5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 22:57:36 -0500
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65FC4CD6F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 19:57:09 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 197C658016D;
        Tue, 22 Feb 2022 22:57:09 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 22 Feb 2022 22:57:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; bh=rGS7E0Tr6KX60A
        jswUG+WsXZIUdtEZ7uVok6SjY+3Nc=; b=TiiHLuliwP595agUDFcm1CnON1egtr
        7WPWXMS8Y7w+7U38nTBsEEfVVZV+CnfOeO5EhSlKUws45RDuTI/Ztxcm85Kwzn4U
        PzMDO9CGNuUlz/JCcnl0kJVqZPWiwEWJTVZvDPHddgQHVxK9y5GoT3MPvCCr0O+4
        YNxZEsde0InUtXOs9HvbaOCat5ShEpIT2E74zaOIDuobsHYtbzo5TJlHnOSlFTJA
        Jz5ZHA3T2+hbUHKF3efrZg1enQIqxhrh+00HvcJeVcXAl4E7k/ehmMjXBaX8BYQN
        sEQiOU1kMVmjA8wSo+p+2diBc5rcgmCe5Iq3WtTo4mInx5JE1lNPk35Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=rGS7E0Tr6KX60AjswUG+WsXZIUdtEZ7uVok6SjY+3
        Nc=; b=dvCHztbM1x4e66FQBgeGRSyGIzStNuiQ60hU8fjHwl0xbmLQcwpE+zOuN
        Hqtg4cgYHp/2sEe6FfqIbVlZNF3XWk3NBWa7QZ5lL34kTpySxmmhkFoPqDBzrGUx
        eFVUeFrdwh0K2Es5gleGJtgZzMisiR9HbeZIM1HCqta5M8SJpMqKW3o/K8Y9kodi
        +lqriAeqel6qhphC6z0oIPlu4k8fVSNnYH4CDiBetMFXU18dE8LJJnQ73/X/8Gg/
        WHzQqC/5a2EK8qUC3dcYIGDAwUrf7EbKUM7hlVz0510+X9ugt9vFwRgUciMRhXD7
        slZx0ADCnxhgL0YXE35Y3dQtt/Cvg==
X-ME-Sender: <xms:lLAVYuj7WD6xQvxNjK22n8ltQidbxsNUWmAKoFM-40XBDbXfUgbcMA>
    <xme:lLAVYvDNCzApkSu89cXDlH_THFKPond84grVXph-9u6yKjSgDE4N-Puyz7ja-bmfu
    wzZZ346yKmHjzXFNQ>
X-ME-Received: <xmr:lLAVYmGnrAD2w3V3ajMXo-XYCcbPFLpHif7shclhn77I34rH1UZRxs3ZDYuxGG94NsFnFWSx-Q31MvEdmc6C9p9A2_9bgKYpV_XQ-MFn0crguhpUjjYcM-zzeg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrkeelgdeigecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgveffteelheffjeeukedvkedviedtheevgeefkeehueeiieeuteeu
    gfettdeggeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:lLAVYnTWMxgcyXjJasaHVrEKHKPW5Wdpgd_vrUlM3aRciXfvgVjiYA>
    <xmx:lLAVYrxL8mfQi-jRHv7Nd6wFv8rlZy78KviRIEvH4ZFCwrnd3n7Gag>
    <xmx:lLAVYl7Da0z0Etu5zc966BhPRY6GivZxaTAy5d9MCZn5FQr65lJ1ZA>
    <xmx:lbAVYp5pEURhaTNDhNnBJU7wehG9wBx-ljjBeiPEi4VoYyuN2Gt27w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 22 Feb 2022 22:57:07 -0500 (EST)
Subject: Re: [PATCH v10 14/18] phy: sun4i-usb: Introduce port2 SIDDQ quirk
To:     Andre Przywara <andre.przywara@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Ondrej Jirman <megous@megous.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, linux-phy@lists.infradead.org
References: <20220211122643.1343315-1-andre.przywara@arm.com>
 <20220211122643.1343315-15-andre.przywara@arm.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <14105ae3-4314-3463-8b07-ccd6106cf681@sholland.org>
Date:   Tue, 22 Feb 2022 21:57:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220211122643.1343315-15-andre.przywara@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/11/22 6:26 AM, Andre Przywara wrote:
> At least the Allwinner H616 SoC requires a weird quirk to make most
> USB PHYs work: Only port2 works out of the box, but all other ports
> need some help from this port2 to work correctly: The CLK_BUS_PHY2 and
> RST_USB_PHY2 clock and reset need to be enabled, and the SIDDQ bit in
> the PMU PHY control register needs to be cleared. For this register to
> be accessible, CLK_BUS_ECHI2 needs to be ungated. Don't ask ....
> 
> Instead of disguising this as some generic feature, do exactly that
> in our PHY init:
> If the quirk bit is set, and we initialise a PHY other than PHY2, ungate
> this one special clock, and clear the SIDDQ bit. We can pull in the
> other required clocks via the DT.
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> ---
>  drivers/phy/allwinner/phy-sun4i-usb.c | 59 +++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/phy/allwinner/phy-sun4i-usb.c b/drivers/phy/allwinner/phy-sun4i-usb.c
> index 126ef74d013c..316ef5fca831 100644
> --- a/drivers/phy/allwinner/phy-sun4i-usb.c
> +++ b/drivers/phy/allwinner/phy-sun4i-usb.c
> @@ -120,6 +120,7 @@ struct sun4i_usb_phy_cfg {
>  	u8 phyctl_offset;
>  	bool dedicated_clocks;
>  	bool phy0_dual_route;
> +	bool needs_phy2_siddq;
>  	int missing_phys;
>  };
>  
> @@ -289,6 +290,50 @@ static int sun4i_usb_phy_init(struct phy *_phy)
>  		return ret;
>  	}
>  
> +	/* Some PHYs on some SoCs need the help of PHY2 to work. */
> +	if (data->cfg->needs_phy2_siddq && phy->index != 2) {
> +		struct sun4i_usb_phy *phy2 = &data->phys[2];
> +
> +		ret = clk_prepare_enable(phy2->clk);
> +		if (ret) {
> +			reset_control_assert(phy->reset);
> +			clk_disable_unprepare(phy->clk2);
> +			clk_disable_unprepare(phy->clk);
> +			return ret;
> +		}
> +
> +		ret = reset_control_deassert(phy2->reset);
> +		if (ret) {
> +			clk_disable_unprepare(phy2->clk);
> +			reset_control_assert(phy->reset);
> +			clk_disable_unprepare(phy->clk2);
> +			clk_disable_unprepare(phy->clk);
> +			return ret;
> +		}
> +
> +		/*
> +		 * This extra clock is just needed to access the
> +		 * REG_HCI_PHY_CTL PMU register for PHY2.
> +		 */
> +		ret = clk_prepare_enable(phy2->clk2);
> +		if (ret) {
> +			reset_control_assert(phy2->reset);
> +			clk_disable_unprepare(phy2->clk);
> +			reset_control_assert(phy->reset);
> +			clk_disable_unprepare(phy->clk2);
> +			clk_disable_unprepare(phy->clk);

This is quite a lot of duplication. Please consider using goto for the error path.

> +			return ret;
> +		}
> +
> +		if (phy2->pmu && data->cfg->hci_phy_ctl_clear) {
> +			val = readl(phy2->pmu + REG_HCI_PHY_CTL);
> +			val &= ~data->cfg->hci_phy_ctl_clear;
> +			writel(val, phy2->pmu + REG_HCI_PHY_CTL);
> +		}
> +
> +		clk_disable_unprepare(phy->clk2);
> +	}
> +
>  	if (phy->pmu && data->cfg->hci_phy_ctl_clear) {
>  		val = readl(phy->pmu + REG_HCI_PHY_CTL);
>  		val &= ~data->cfg->hci_phy_ctl_clear;
> @@ -354,6 +399,13 @@ static int sun4i_usb_phy_exit(struct phy *_phy)
>  		data->phy0_init = false;
>  	}
>  
> +	if (data->cfg->needs_phy2_siddq && phy->index != 2) {
> +		struct sun4i_usb_phy *phy2 = &data->phys[2];
> +
> +		clk_disable_unprepare(phy2->clk);
> +		reset_control_assert(phy2->reset);
> +	}
> +
>  	sun4i_usb_phy_passby(phy, 0);
>  	reset_control_assert(phy->reset);
>  	clk_disable_unprepare(phy->clk2);
> @@ -785,6 +837,13 @@ static int sun4i_usb_phy_probe(struct platform_device *pdev)
>  				dev_err(dev, "failed to get clock %s\n", name);
>  				return PTR_ERR(phy->clk2);
>  			}
> +		} else {
> +			snprintf(name, sizeof(name), "pmu%d_clk", i);
> +			phy->clk2 = devm_clk_get_optional(dev, name);

This clock is not documented anywhere in the binding.

Regards,
Samuel

> +			if (IS_ERR(phy->clk2)) {
> +				dev_err(dev, "failed to get clock %s\n", name);
> +				return PTR_ERR(phy->clk2);
> +			}
>  		}
>  
>  		snprintf(name, sizeof(name), "usb%d_reset", i);
> 

