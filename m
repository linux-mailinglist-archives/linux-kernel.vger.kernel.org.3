Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9887855CDA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234460AbiF1D37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:29:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiF1D34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:29:56 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41F421B;
        Mon, 27 Jun 2022 20:29:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 61ED4320097D;
        Mon, 27 Jun 2022 23:29:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 27 Jun 2022 23:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1656386992; x=
        1656473392; bh=GXdRtjVdnwILxLdtyM/xN95hYHB1ae83/NYaN89uAv8=; b=p
        SZmozpusuFw5cqSpA4LbjEkNnKgbZG9kv+G7DTLU/QwgKaxXSNGV6+Sv23j1+qU0
        3lFzGNvqVm97PJf+e1MfbWC2cwCq03ZG6R9SANqnPusxWcsgb979cJeMktuZBQV0
        QcZCCmAWBo3rTvUDd1KCjSsyHLupgrF/vFOm0g1fL57FLKRz7QZmDzQjD8jpruLv
        iee1UzDmEUGl//kVKof+EwxRIDXWx+5ktxjga8YM6ha/52hMJFb7OXQxBxonh2vI
        3refu2XTBtY65BjchXPV3ddnOYT7z6WGfQYENnkQHclDorsRATcTp1twXu9p4bPa
        8zLjmErGwf/57rFJgBkEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1656386992; x=
        1656473392; bh=GXdRtjVdnwILxLdtyM/xN95hYHB1ae83/NYaN89uAv8=; b=a
        YOuOrFSqzZd2cXPRbpdHzzeql076eT03IL90bzaLJIIxee/uJS3g2OApi2Bkr15K
        eg2h4O+DSp9GJEvfjK1qYlsLCz1scA8kaRgunIyNYLNfv2++l1L2LUzy33Eqbo1X
        gFT2ufZtJpqbQO6vYEmTMr5jzwPNA3Is5BIYzAYfsfOxMWTMXcvm1dGIJawcMRTP
        5vG97PPUAdbj2uzIg5GdH1SpDdD7DEIdqJmF0TEx2ZOBIjyIGDxu81Ql3NNWty2C
        39XbTupgNdH4fSxTe0Z9cQjTUz1s7ayHqNhtNL2R80jHv83Ja6z8TWRD3FXjJ1LF
        5qEpDx05d7CqnX5g/F6fw==
X-ME-Sender: <xms:sHW6YgjOBgHdmwEIns-ctdSBIUeE46Nm-j7TnVVAIuLhv455GPDmHg>
    <xme:sHW6YpAFV7RcMuD_dRpRqsTq7nPd6PeIfM3cVCaOsqf6Mr07fY_UyOK0OTih2dZIu
    PwqyOHYZMPk3sOKMA>
X-ME-Received: <xmr:sHW6YoEWLfBpgoMj-yF1PEhg33slSCqEK-Clqga8quitBSkwhz0jwtBW8v44Z992pnxjZlnksXr23lV1djA3dE6mSChJmUaYuqpNaOWEKijhLYKGRlGo2Vsikg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegiedgjeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpedtvefhheehgfdvkeetffeludeuudehudeuvddtveelleekvedv
    uedviefhkeeuheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:sHW6YhTnOaeM5Y74OwVlWRIdKvFIcceMRcXRV0cthlbAFx_IHVcYbg>
    <xmx:sHW6Ytwf99M4HjheAEB9jZg8A8A2wQHhhMRUIOf2TLP1wlfyqOO38A>
    <xmx:sHW6Yv7Uju4meBL2PW1Dq8nygHLT6ojtHnr4VSkzlvHFup1DUJW49A>
    <xmx:sHW6YiphFUAsJFhnNd8qkBfEuOv8RTiJGMNnVkD9HWz_V0dfO7mqIA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jun 2022 23:29:51 -0400 (EDT)
Subject: Re: [PATCH 3/6] pinctrl: sunxi: Support the 2.5V I/O bias mode
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>, Ondrej Jirman <x@xff.cz>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220626021148.56740-1-samuel@sholland.org>
 <20220626021148.56740-4-samuel@sholland.org>
 <1818958.tdWV9SEqCh@jernej-laptop>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <b1aaa895-59dd-bbb1-3dc1-9dfaa96dfdb0@sholland.org>
Date:   Mon, 27 Jun 2022 22:29:51 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1818958.tdWV9SEqCh@jernej-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 3:43 PM, Jernej Škrabec wrote:
> Dne nedelja, 26. junij 2022 ob 04:11:44 CEST je Samuel Holland napisal(a):
>> H616 and newer SoCs feature a 2.5V I/O bias mode in addition to the
>> 1.8V and 3.3V modes. This mode is entered by selecting the 3.3V level
>> and disabling the "withstand function".
>>
>> H616 supports this capability on its main PIO only. A100 supports this
>> capability on both its PIO and R-PIO.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c |  1 +
>>  drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c   |  2 +-
>>  drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c   |  2 +-
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.c         | 10 ++++++++++
>>  drivers/pinctrl/sunxi/pinctrl-sunxi.h         |  7 +++++++
>>  5 files changed, 20 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
>> b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c index
>> 21054fcacd34..afc1f5df7545 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100-r.c
>> @@ -82,6 +82,7 @@ static const struct sunxi_pinctrl_desc a100_r_pinctrl_data
>> = { .npins = ARRAY_SIZE(a100_r_pins),
>>  	.pin_base = PL_BASE,
>>  	.irq_banks = 1,
>> +	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_CTL,
>>  };
>>
>>  static int a100_r_pinctrl_probe(struct platform_device *pdev)
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
>> b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c index
>> e69f6da40dc0..f682e0e4244d 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-a100.c
>> @@ -684,7 +684,7 @@ static const struct sunxi_pinctrl_desc a100_pinctrl_data
>> = { .npins = ARRAY_SIZE(a100_pins),
>>  	.irq_banks = 7,
>>  	.irq_bank_map = a100_irq_bank_map,
>> -	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
>> +	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_CTL,
>>  };
>>
>>  static int a100_pinctrl_probe(struct platform_device *pdev)
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
>> b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c index
>> 152b71226a80..d6ca720ee8d8 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sun50i-h616.c
>> @@ -525,7 +525,7 @@ static const struct sunxi_pinctrl_desc h616_pinctrl_data
>> = { .irq_banks = ARRAY_SIZE(h616_irq_bank_map),
>>  	.irq_bank_map = h616_irq_bank_map,
>>  	.irq_read_needs_mux = true,
>> -	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_SEL,
>> +	.io_bias_cfg_variant = BIAS_VOLTAGE_PIO_POW_MODE_CTL,
>>  };
>>
>>  static int h616_pinctrl_probe(struct platform_device *pdev)
>> diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> b/drivers/pinctrl/sunxi/pinctrl-sunxi.c index 3c5e71359ca8..eb3d595f816a
>> 100644
>> --- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> +++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
>> @@ -662,6 +662,16 @@ static int sunxi_pinctrl_set_io_bias_cfg(struct
>> sunxi_pinctrl *pctl, reg &= ~IO_BIAS_MASK;
>>  		writel(reg | val, pctl->membase + 
> sunxi_grp_config_reg(pin));
>>  		return 0;
>> +	case BIAS_VOLTAGE_PIO_POW_MODE_CTL:
>> +		val = uV > 1800000 && uV <= 2500000 ? BIT(bank) : 0;
>> +
>> +		raw_spin_lock_irqsave(&pctl->lock, flags);
>> +		reg = readl(pctl->membase + PIO_POW_MOD_CTL_REG);
>> +		reg &= ~BIT(bank);
>> +		writel(reg | val, pctl->membase + PIO_POW_MOD_CTL_REG);
>> +		raw_spin_unlock_irqrestore(&pctl->lock, flags);
>> +
>> +		fallthrough;
> 
> Would this set bit 12 as needed? According to documentation, it's a bit 
> special case, since it covers VCC-IO, port F and port H, at least according to 
> documentation. I guess BIAS_VOLTAGE_PIO_POW_MODE_SEL has same issue.

Right, it seems we would need some mask to tell us which ports are affected by
bit 12, and which have their own setting. The current code is unlikely to cause
any issue, though, because in practice VCC-IO is always 3.3 V.

Regards,
Samuel
