Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600AE59526B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 08:17:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbiHPGRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 02:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbiHPGQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 02:16:31 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681C416ADFF;
        Mon, 15 Aug 2022 17:05:45 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 7ED123200909;
        Mon, 15 Aug 2022 20:05:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Aug 2022 20:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1660608314; x=
        1660694714; bh=NsPJS2VIJEDBob5v9WBpSZ/01bhARsMi65w3+LrtJ7c=; b=t
        g5Jw+cUS2y8EQnJ/ig8RfpAT8DDcn3Q/13XNUEvhvegwnpi5dLzKZ07GedI2DAiq
        HO+D5oDbFM5iTfVNV8X7ymx7gTijIkq0AlGq8RFZgH9SNi0LNPZAyNKJBwM2KpkD
        kVP4Zi40VWCftd/AadON+848nrsT2spgxI5HN4T5xm+7B7H5BIYB3A2CfFhzEOkI
        HfCqxjGXzD9Zmyn3+X1LYjfSWU7qvIQoiS+jknyXAal6bEHBSD7BFppJ2cJiC42i
        xjiyZUF38xzGvj8qEeB56W3PdUDN+S/lyfnL/AY48Bd0hmWmJ/EvLe0S1r7Bv27i
        R+Frh5/Ct7QOLvQsEVaKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1660608314; x=
        1660694714; bh=NsPJS2VIJEDBob5v9WBpSZ/01bhARsMi65w3+LrtJ7c=; b=r
        7IiiLlqA9uVxQqCHZ/G/KSFxhGNUJ2tPQRnfwRXG+prY2UDrnI934O1oGoxT7ZcP
        Qu6QXBKA0kBNrL9HMPYLGZxViGjzdi8E2aCq13tqqsi4LjbZaIykL8FUwVNoOw4r
        PF5F0RVJRA+KS35q6OtB0BR5x5thYzaOpbMkAyKFNsIH/W7Z2urxvOjeMHc/GWX7
        YghY9T7ix2iOSDtjra7wPjrqVVAkpvxr14lYpGJ6tlabKpsYmdCVcOpWgaLXLm5G
        U2BRS6PLrvYKGuKq1nnCIUufjmgiqzt45lruIWBjUAJVrYr37mMXDAgs5WPNo4XG
        SEqiUmyhmlVDEYQ+ExAaQ==
X-ME-Sender: <xms:Od_6YkUbWm-dcNWuhZJJGkvpSXLSHHjBR5UmhtbCGhkUsbjdF66aYw>
    <xme:Od_6Yom2b5_C-br4WNBa5m1dASvMrlABc8IEgY2IOlvl8g_fl4etAqMlPdqKZrf7y
    0pg3YvtCXIs3DuYkw>
X-ME-Received: <xmr:Od_6YoYmPExpjjjCKsjMh5c58zPBoVYpmEPFv3pRDgzQMa_V13YpRIG2Pei-u5WSiuW7YQa7VEskZ7d6Vy1mGKkSp0FDq4ehg8gX7VK-j-qzr9HaA2O0IeSvaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdehfedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvvehfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghm
    uhgvlhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenuc
    ggtffrrghtthgvrhhnpeeikeeugfefudffveeuvddujeeiveeuudeigedttdevueehfeeh
    lefgheetteffveenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucevlhhushhtvg
    hrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhl
    lhgrnhgurdhorhhg
X-ME-Proxy: <xmx:Od_6YjU3pHysx06WGYPHgfwQgSYjRC697mLSs2_Dg5zjNVVHiXsDeg>
    <xmx:Od_6YunjpLISR8qivZ3ZXIZDUWEV5JufHRjmOIxfmJ9JscGDyccAkQ>
    <xmx:Od_6Yof8qt73MhzEP16oIK_LTSx4-HppujVdXZTBbxPxac0Hfd4EUw>
    <xmx:Ot_6Ygc_JSsm8nJM6JkaBmuWrUsIlQeM7wFNMxncAAPtnzvMKH4e8g>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Aug 2022 20:05:12 -0400 (EDT)
Subject: Re: [PATCH v2 05/10] soc: sunxi: sram: Fix probe function ordering
 issues
To:     =?UTF-8?Q?Heiko_St=c3=bcbner?= <heiko@sntech.de>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20220815041248.53268-1-samuel@sholland.org>
 <20220815041248.53268-6-samuel@sholland.org> <6807552.18pcnM708K@diego>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <1a35fbd8-201a-1391-64de-da2b89f3db3f@sholland.org>
Date:   Mon, 15 Aug 2022 19:05:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <6807552.18pcnM708K@diego>
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

On 8/15/22 9:06 AM, Heiko Stübner wrote:
> Am Montag, 15. August 2022, 06:12:42 CEST schrieb Samuel Holland:
>> Errors from debugfs are intended to be non-fatal, and should not prevent
>> the driver from probing.
>>
>> Since debugfs file creation is treated as infallible, move it below the
>> parts of the probe function that can fail. This prevents an error
>> elsewhere in the probe function from causing the file to leak. Do the
>> same for the call to of_platform_populate().
>>
>> Finally, checkpatch suggests an octal literal for the file permissions.
>>
>> Fixes: 4af34b572a85 ("drivers: soc: sunxi: Introduce SoC driver to map SRAMs")
>> Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on A64")
>> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> Tested-by: Heiko Stuebner <heiko@sntech.de>
> 
> but one thing below
> 
>> ---
>>
>> (no changes since v1)
>>
>>  drivers/soc/sunxi/sunxi_sram.c | 13 +++++--------
>>  1 file changed, 5 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/soc/sunxi/sunxi_sram.c b/drivers/soc/sunxi/sunxi_sram.c
>> index a858a37fcdd4..52d07bed7664 100644
>> --- a/drivers/soc/sunxi/sunxi_sram.c
>> +++ b/drivers/soc/sunxi/sunxi_sram.c
>> @@ -332,9 +332,9 @@ static struct regmap_config sunxi_sram_emac_clock_regmap = {
>>  
>>  static int __init sunxi_sram_probe(struct platform_device *pdev)
>>  {
>> -	struct dentry *d;
>>  	struct regmap *emac_clock;
>>  	const struct sunxi_sramc_variant *variant;
>> +	struct device *dev = &pdev->dev;
>>  
>>  	sram_dev = &pdev->dev;
>>  
>> @@ -346,13 +346,6 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
>>  	if (IS_ERR(base))
>>  		return PTR_ERR(base);
>>  
>> -	of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
>> -
>> -	d = debugfs_create_file("sram", S_IRUGO, NULL, NULL,
>> -				&sunxi_sram_fops);
>> -	if (!d)
>> -		return -ENOMEM;
>> -
>>  	if (variant->num_emac_clocks > 0) {
>>  		emac_clock = devm_regmap_init_mmio(&pdev->dev, base,
>>  						   &sunxi_sram_emac_clock_regmap);
>> @@ -361,6 +354,10 @@ static int __init sunxi_sram_probe(struct platform_device *pdev)
>>  			return PTR_ERR(emac_clock);
>>  	}
>>  
>> +	of_platform_populate(dev->of_node, NULL, NULL, dev);
> 
> hmm, of_platform_populate() can actually fail [0] it just looks a bit like
> sunxi driver seem to ignore that by {chance, design?} [1] .
> 
> So I guess this might want to have handling for probably unlikely
> possible errors instead?

Strictly speaking, neither this driver nor the DE2 bus driver depend on any of
the child nodes having a platform device present or a driver attached. So
failing to populate the child devices should not necessarily prevent this driver
from probing. Possibly it deserves a dev_warn(), but...

I don't think of_platform_populate() can actually fail when passed a valid node.
of_platform_bus_create() calls itself recursively, but otherwise always returns 0.

Regards,
Samuel

> Heiko
> 
> [0] https://elixir.bootlin.com/linux/latest/source/drivers/of/platform.c#L463
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/bus/sun50i-de2.c#L22
>> +
>> +	debugfs_create_file("sram", 0444, NULL, NULL, &sunxi_sram_fops);
>> +
>>  	return 0;
>>  }
