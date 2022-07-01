Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923EA5636C2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 17:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbiGAPQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 11:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiGAPQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 11:16:15 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB6A73057F;
        Fri,  1 Jul 2022 08:16:14 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 549FB3200684;
        Fri,  1 Jul 2022 11:16:11 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Jul 2022 11:16:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656688570; x=
        1656774970; bh=Tqwsov16Tb0O3xmHbTi4I+HfDNbMkRJRXqdUjVyems0=; b=f
        IR3s4uS4yWZciAfs+E8sv1lP4+d4xh9McJaAh+lLsBBivpn4rTbX4iIe3lb9Jnv4
        pfaUQPUMPss2tykJLQlt1OL4DF2c64giwSjAHzhb0Wmw4v09Kprw3Fgeic5/tiA7
        Sg7ZN9QVaau7+pZYx0bHqG/aORhLS3XIl6AXBvZ8+NGs5aXl4VDseDZaPZj72ybe
        G5HHazVhkg5Ev7WyPOkFn/lDYH+yDi/j014Kup4kjOLG0AkmVI6Rid1Y6t3i0+wM
        PhXBM/NUcXPdgdUEmFC41D8QSh9b1HiiqEoVXWjrD1gg3m0oSxMNnhhlfrJO+K9K
        AOg7iowiiRYEzQTRjmJCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656688570; x=
        1656774970; bh=Tqwsov16Tb0O3xmHbTi4I+HfDNbMkRJRXqdUjVyems0=; b=e
        +Hdle0aD9T5q2Zxi+2LOdnfPs+A2JW2Owdfw1YtAZeD/8sJghUqhOM8eEmgKM21X
        UQBDjK+I4xVJUUatNYt/MxTFONARP/lROXkldTXoV97sl6WDOl6uA2sYqiNuGzj2
        57K/JMwf4k1P3kkYLDFrKPq3WNf3LgQPNXc0pcEiKqzlCR7nPZuyw6gxnCWNBNDS
        wQ7+j6QNiVN7TJtKuFkzCx6Luf6X/5/qEjh4dTtlG1NtSu1L9ROgA2CU8RpAA9YS
        +X6zA+RpAzhiPgnao/Q9Zf2a8ytHVlj/DwQrKmR4KTafONBd/xo2+03RP9+GdBGo
        /xaFLFnnyBV0lbesMLlAg==
X-ME-Sender: <xms:uQ-_Yuxb0GQMRCVEJJqp2RMZJk1ZedtGxiRbprHZfQLLCOz7ZkhiOw>
    <xme:uQ-_YqRH08y6riR4f4Xji7XlN3emQmWe2QEoCeHP0JbLpvdLS9cOjCx0XXM3_bsjw
    0HiVSIxN1cwRxKhcA>
X-ME-Received: <xmr:uQ-_YgUx40LlBe6syWCBJHSz9acW7DQOROdgHAbxhiINJT_DtrWrZL-3sJh3O9LGITtvYScm5_Y-XLvD-pNegcmI0zkMphe5TyLaMGO9D6SdCxl4M368RWU1Jg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudehfedgkeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpefftdevkedvgeekueeutefgteffieelvedukeeuhfehledvhfei
    tdehudfhudehhfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:uQ-_YkjJRWT8TPe9MP3hVekmyrt2oqD5kWCEG0eNuyxe03Z3SBI-0w>
    <xmx:uQ-_YgAoMZ-uLUf8naXGiZfDwfFNGmsoXM9OmjdpSz0jcXAD6TnCTA>
    <xmx:uQ-_YlKkxFLALD803MggfrKfXtcSSezkc8FKpUyRNor2v30eguH-uw>
    <xmx:ug-_YpJv9AA1oHVjBlqdhJrv1b4xiOOu64EsUc5YsPzr2wQopcJQcQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Jul 2022 11:16:08 -0400 (EDT)
Subject: Re: [PATCH 6/6] pinctrl: sunxi: Add driver for Allwinner D1/D1s
To:     Heiko Stuebner <heiko@sntech.de>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220626021148.56740-1-samuel@sholland.org>
 <20220626021148.56740-7-samuel@sholland.org> <17090319.JCcGWNJJiE@phil>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <e6d2d4e8-b385-11d6-4d41-454542735269@sholland.org>
Date:   Fri, 1 Jul 2022 10:16:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <17090319.JCcGWNJJiE@phil>
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

Hi Heiko,

On 7/1/22 8:13 AM, Heiko Stuebner wrote:
> Am Sonntag, 26. Juni 2022, 04:11:47 CEST schrieb Samuel Holland:
>> These SoCs contain a pinctrl with a new register layout. Use the variant
>> parameter to set the right register offsets. This pinctrl also increases
>> the number of functions per pin from 8 to 16, taking advantage of all 4
>> bits in the mux config field (so far, only functions 0-8 and 14-15 are
>> used). This increases the maximum possible number of functions.
>>
>> D1s is a low pin count version of the D1 SoC, with some pins omitted.
>> The remaining pins have the same function assignments as D1.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> On a D1-Nezha
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> Reviewed-by: Heiko Stuebner <heiko@sntech.de>
> 
> with one remark below

Thanks for reviewing the series.

>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> index ec7daaa5666b..350044d4c1b5 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -1297,11 +1297,11 @@ static int sunxi_pinctrl_build_state(struct platform_device *pdev)
>>  
>>  	/*
>>  	 * Find an upper bound for the maximum number of functions: in
>> -	 * the worst case we have gpio_in, gpio_out, irq and up to four
>> +	 * the worst case we have gpio_in, gpio_out, irq and up to seven
>>  	 * special functions per pin, plus one entry for the sentinel.
>>  	 * We'll reallocate that later anyway.
>>  	 */
>> -	pctl->functions = kcalloc(4 * pctl->ngroups + 4,
>> +	pctl->functions = kcalloc(7 * pctl->ngroups + 4,
>>  				  sizeof(*pctl->functions),
>>  				  GFP_KERNEL);
>>  	if (!pctl->functions)
>> @@ -1494,9 +1494,15 @@ int sunxi_pinctrl_init_with_variant(struct platform_device *pdev,
>>  	pctl->dev = &pdev->dev;
>>  	pctl->desc = desc;
>>  	pctl->variant = variant;
>> -	pctl->bank_mem_size = BANK_MEM_SIZE;
>> -	pctl->pull_regs_offset = PULL_REGS_OFFSET;
>> -	pctl->dlevel_field_width = DLEVEL_FIELD_WIDTH;
>> +	if (pctl->variant >= PINCTRL_SUN20I_D1) {
>> +		pctl->bank_mem_size = D1_BANK_MEM_SIZE;
>> +		pctl->pull_regs_offset = D1_PULL_REGS_OFFSET;
>> +		pctl->dlevel_field_width = D1_DLEVEL_FIELD_WIDTH;
>> +	} else {
>> +		pctl->bank_mem_size = BANK_MEM_SIZE;
>> +		pctl->pull_regs_offset = PULL_REGS_OFFSET;
>> +		pctl->dlevel_field_width = DLEVEL_FIELD_WIDTH;
>> +	}
> 
> this is likely ok for _one_ variant (so for now this should be ok) but
> will get ugly when there are more of them.
> 
> So in the long term it might make sense to pass these values in from
> the soc-specific driver maybe?

Yes, in the long term. It took 10 years before the first layout change, so I do
not expect another layout change any time soon.

For now, I did not want to deal with the overhead of passing in the offsets
individually, nor coming up with a name for each layout to look up the offsets
from a table. (The BSP calls the variants "SUNXI_PCTL_HW_TYPE_0" and
"SUNXI_PCTL_HW_TYPE_1", which is... not descriptive.)

Regards,
Samuel
