Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D829359175C
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237055AbiHLWcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiHLWb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:31:59 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A79FD8;
        Fri, 12 Aug 2022 15:31:58 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 01C0F32008FB;
        Fri, 12 Aug 2022 18:31:55 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 12 Aug 2022 18:31:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660343515; x=
        1660429915; bh=kgS42RQgG/tiE5VGji6aib4Oy9gURPck9Fi+x//w8eU=; b=y
        CsbGqpOkVSo0Xin2aC9GExcdGKs8UxUhKlgip+5w4IqZuVN8gWqzAP1JIB8gF2FJ
        oPg70bJH7vDXn+vjd012wOrsmGWOARsAvVBDtyX3V2cNFEt/7zApF9TtGAMsftTA
        L3rfxRfby+8Tk+M48jlZSbYMXmB90lMASMwpLl7CSIUswO4QYJhkCIvRvockDRc6
        S2ybO3xop0kRYDvwJryn4QSrOXflD8/50GVWnxaCU1BD9UefYa8DiZtOgQ1r3NOS
        c1W4K8RDz9T1HlvB1aumy8MweCVVPitq6FVjJaFU5MayKGqrdmAYNLZIUTbccSOd
        vH5BN0Slo1ch9O5cY4TLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660343515; x=
        1660429915; bh=kgS42RQgG/tiE5VGji6aib4Oy9gURPck9Fi+x//w8eU=; b=W
        j97d76GyyLi27VuagXD865UAWLlMXkhvJGZbd5+L6MdlFK6IZ3/3isSic4Y560kM
        h1KtXR3Q34AYqr6zhdudMoKZ0fi9zfOoSP4ExZqEYnVKtB9ti0W2AOkQl9YuA1Ct
        hNswG0cIbLt34mOBlrzF6SPuXDqHnOCUEnXsn0idHA3qGw947xNA2ewscuUsSSxL
        0e67OLm8DdF6O1iID7Bsn5Mj1hk3vJoDrrHgUsWWJu+RziRejF0XGEWChO2gcFwA
        EQL9umR8VzQWGGtz/3Oq/E+mfHH/9XHHTNGX6eMm3j3otdJmSHVVOSHvn9l8kjAS
        Fl+h1wBWkzZkdK3g9bKNA==
X-ME-Sender: <xms:29T2Yjronklez5rC9QvkRZ5IOh8Glmjl6-zGFC0kKSM0ACcPiC0Ftg>
    <xme:29T2YtoYu8a88cBeVQC-olIoXclrvykrolrDpbg_NnMfofnKU3cXHyXxp_74BoPmc
    BRWPUsDph9FQmpPuA>
X-ME-Received: <xmr:29T2YgPJVaKdCeHUWVbrfu8n6kpu7phn_TlyPOQEE_yPuuHWEWmu_3AmIClZNfpwZQINQzKPI5tv4DMfqgkOwER0GlFja2VOPYRNVeZ6Eo3n0VsKn_hJkZQaNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdegjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:29T2Ym60xl5IRoBqxYQ5PXJnhHq__wkrwHfbUxVbPCmrRRRaWR31YA>
    <xmx:29T2Yi5rYdZt8zaq6YlhP5IRuqPe6oCFuiYlTfwJyHVhDwo9KpzwVA>
    <xmx:29T2YuiSFAH5ArNpogzaluKq6Upk3Nk8zXSui6WctijI7Uc5PwOYBg>
    <xmx:29T2YlL8ncCii3rgdIflz_YNMAse12Ya8Q_HUx3SErmvcrsDkXVPDA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Aug 2022 18:31:54 -0400 (EDT)
Subject: Re: [PATCH 6/8] phy: allwinner: phy-sun6i-mipi-dphy: Set enable bit
 last
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <20220812075603.59375-1-samuel@sholland.org>
 <20220812075603.59375-7-samuel@sholland.org> <YvZBmZ+SfrJuAzAs@aptenodytes>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <b3a2dc61-7384-17f7-2f4f-4b6bb86bcced@sholland.org>
Date:   Fri, 12 Aug 2022 17:31:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <YvZBmZ+SfrJuAzAs@aptenodytes>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 8/12/22 7:03 AM, Paul Kocialkowski wrote:
> On Fri 12 Aug 22, 02:56, Samuel Holland wrote:
>> The A100 variant of the DPHY requires configuring the analog registers
>> before setting the global enable bit. Since this order also works on the
>> other variants, always use it, to minimize the differences between them.
> 
> Did you get a chance to actually test this with either DSI/CSI-2 hardware?

I have tested DSI output with the Clockwork DevTerm (D1 SoC) and Pine64
PinePhone (A64 SoC). I do not have any MIPI CSI hardware to test with.

> I vaguely remember that the order mattered. Do you have an idea of what the
> Allwinner BSP does too?

The Allwinner BSP makes the same change as this commit in its "lowlevel_v2x"
copy of the code, which is used for R40 and T7 (original DPHY) and A100 and D1
(updated DPHY). It does not make the change in "lowlevel_sun50iw1" (A64 SoC,
original DPHY), but I tested A64 with this change, and it works fine.

> Otherwise I could give it a try, at least with my MIPI CSI-2 setup
> that uses the driver.

This commit only changes sun6i_dphy_tx_power_on(). The code for RX is unchanged
-- in fact, it already sets SUN6I_DPHY_GCTL_REG last.

Regards,
Samuel

>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/phy/allwinner/phy-sun6i-mipi-dphy.c | 8 ++++----
>>  1 file changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
>> index 625c6e1e9990..9698d68d0db7 100644
>> --- a/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
>> +++ b/drivers/phy/allwinner/phy-sun6i-mipi-dphy.c
>> @@ -183,10 +183,6 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
>>  		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA0(3) |
>>  		     SUN6I_DPHY_TX_TIME4_HS_TX_ANA1(3));
>>  
>> -	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
>> -		     SUN6I_DPHY_GCTL_LANE_NUM(dphy->config.lanes) |
>> -		     SUN6I_DPHY_GCTL_EN);
>> -
>>  	regmap_write(dphy->regs, SUN6I_DPHY_ANA0_REG,
>>  		     SUN6I_DPHY_ANA0_REG_PWS |
>>  		     SUN6I_DPHY_ANA0_REG_DMPC |
>> @@ -244,6 +240,10 @@ static int sun6i_dphy_tx_power_on(struct sun6i_dphy *dphy)
>>  			   SUN6I_DPHY_ANA2_EN_P2S_CPU_MASK,
>>  			   SUN6I_DPHY_ANA2_EN_P2S_CPU(lanes_mask));
>>  
>> +	regmap_write(dphy->regs, SUN6I_DPHY_GCTL_REG,
>> +		     SUN6I_DPHY_GCTL_LANE_NUM(dphy->config.lanes) |
>> +		     SUN6I_DPHY_GCTL_EN);
>> +
>>  	return 0;
>>  }
>>  
>> -- 
>> 2.35.1
>>
> 

