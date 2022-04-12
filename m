Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3159B4FEA56
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbiDLXrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiDLXq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:46:57 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B04D28997
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 16:34:45 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id B39695C01B6;
        Tue, 12 Apr 2022 19:34:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 12 Apr 2022 19:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1649806482; x=
        1649892882; bh=QN2NQNsZfvFG2wo53SzY7h+0Bmcu+2M8n+ZKjAkfluo=; b=s
        YO3mdiqI5d2aP0InJSt+zDFq9jkFBfL4qdov3QmDAIzXd9Ku/cO1cC6cYT5VS0/t
        wMn3VYlv1HUBK/YxyeODOKPFVc2U5vwcTThviHS9zzqSHZjDJct8nYBcDeOqBHo4
        RYgx+TVk5vVBOPSroCnfPHC9TGpvFtF0VqLrD4pY0u3ILvZNDubnlyI6JTS+7ky8
        FlGSxRK87skKcwA5nKnQyrBZMSWxJVSlVk9zs7eEz8QK/ziD6uTkeFCsoTkAcPB9
        NXb4KkU3mWaCUXzsKUDBtDZNgcilYiIlNmu3M1nbrEQPiiqBx8Il0+SS8NFjN6v6
        Rh1XyhpKY+2Wu+kdJkNEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1649806482; x=1649892882; bh=QN2NQNsZfvFG2
        wo53SzY7h+0Bmcu+2M8n+ZKjAkfluo=; b=jhgfc8UPS3l2HYaz10gZ81RLfKvvT
        T3jeHTnm3NW6cnVQpPkARc8bapLOD/PWGz7JcSR8PKnHAdzDnqvlUXdgKphMRnby
        oH/9N8JPdOxvxOOtTx3jkKkFgGFrHo4/MeMwnddG5hOSN4paaFNevOSFMm1W5Z0R
        mynVu93GUPhRozYAPMX6pGd0W0tSQTPwZBeSYTQuAPzJS1/+QmP5TKQt2ThV6+f4
        XeQMKIgZHJWrxuS7aa4rP2hEOpJ9OCGa/3ufKXF00dAxo4lRULFyoAieYBvPm2t7
        /MEnGI7wujdX5FCg3jhFglfMqPkksY9QraobhA8iqj86gNUgOQ2nGMveg==
X-ME-Sender: <xms:kQxWYvGptXzuUo2Ca3AwNuZskaZASP2yGhn_AlHGnPX5gr5trvujhA>
    <xme:kQxWYsX9KUAm5VSvt5IZPVd4_SqFDUsSa1Si99MAZJaUDnVyaOlnBh_OYCx7oaD9Y
    n1ZP_F99sydlYkcdw>
X-ME-Received: <xmr:kQxWYhJj3MrlW17_1nh8wU4rj7M-cPUyCE7Vcx8KIoLVEauoUa8z_ZW7kN82WSQyvmDw7oaYLwDK5IxL0BBybB4NF_Glx0fcH1aJ0ugSoqcrgt237YySV12Oug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudekledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepgfevffetleehffejueekvdekvdeitdehveegfeekheeuieeiueet
    uefgtedtgeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:kQxWYtHGU5bFOJLsDIGhChTe6jJU-PMiBTFCNW5Um1IdZie8OWmbDg>
    <xmx:kQxWYlUxOwkxLB7BKJ-ilxWX2HclY8FItGzvjPl-5tu0_U73fZBo7g>
    <xmx:kQxWYoP7yM23qiCJd2c1n3Z6x8x4A2drHhlK3AkxfaPbOuSaRDINzA>
    <xmx:kgxWYho0khb_5Rivlu6O89JI2rlNux89XLGtSsAsLiMpT0vFteEMNA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Apr 2022 19:34:41 -0400 (EDT)
Subject: Re: [PATCH 3/6] drm/sun4i: sun8i-hdmi-phy: Used device-managed
 clocks/resets
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
References: <20220412043512.49364-1-samuel@sholland.org>
 <20220412043512.49364-4-samuel@sholland.org>
 <20220412132325.bq2c3g2fskckfgpz@houat>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <4b3b2515-d180-fee4-6095-c2e197a3f195@sholland.org>
Date:   Tue, 12 Apr 2022 18:34:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20220412132325.bq2c3g2fskckfgpz@houat>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/22 8:23 AM, Maxime Ripard wrote:
> Hi,
> 
> On Mon, Apr 11, 2022 at 11:35:08PM -0500, Samuel Holland wrote:
>> Now that the HDMI PHY is using a platform driver, it can use device-
>> managed resources. Use these, as well as the dev_err_probe helper, to
>> simplify the probe function and get rid of the remove function.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>>
>>  drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c | 100 ++++++++-----------------
>>  1 file changed, 30 insertions(+), 70 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
>> index 1effa30bfe62..1351e633d485 100644
>> --- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
>> +++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
>> @@ -673,10 +673,8 @@ int sun8i_hdmi_phy_get(struct sun8i_dw_hdmi *hdmi, struct device_node *node)
>>  static int sun8i_hdmi_phy_probe(struct platform_device *pdev)
>>  {
>>  	struct device *dev = &pdev->dev;
>> -	struct device_node *node = dev->of_node;
>>  	struct sun8i_hdmi_phy *phy;
>>  	void __iomem *regs;
>> -	int ret;
>>  
>>  	phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
>>  	if (!phy)
>> @@ -686,88 +684,50 @@ static int sun8i_hdmi_phy_probe(struct platform_device *pdev)
>>  	phy->dev = dev;
>>  
>>  	regs = devm_platform_ioremap_resource(pdev, 0);
>> -	if (IS_ERR(regs)) {
>> -		dev_err(dev, "Couldn't map the HDMI PHY registers\n");
>> -		return PTR_ERR(regs);
>> -	}
>> +	if (IS_ERR(regs))
>> +		return dev_err_probe(dev, PTR_ERR(regs),
>> +				     "Couldn't map the HDMI PHY registers\n");
>>  
>>  	phy->regs = devm_regmap_init_mmio(dev, regs,
>>  					  &sun8i_hdmi_phy_regmap_config);
>> -	if (IS_ERR(phy->regs)) {
>> -		dev_err(dev, "Couldn't create the HDMI PHY regmap\n");
>> -		return PTR_ERR(phy->regs);
>> -	}
>> +	if (IS_ERR(phy->regs))
>> +		return dev_err_probe(dev, PTR_ERR(phy->regs),
>> +				     "Couldn't create the HDMI PHY regmap\n");
>>  
>> -	phy->clk_bus = of_clk_get_by_name(node, "bus");
>> -	if (IS_ERR(phy->clk_bus)) {
>> -		dev_err(dev, "Could not get bus clock\n");
>> -		return PTR_ERR(phy->clk_bus);
>> -	}
>> -
>> -	phy->clk_mod = of_clk_get_by_name(node, "mod");
>> -	if (IS_ERR(phy->clk_mod)) {
>> -		dev_err(dev, "Could not get mod clock\n");
>> -		ret = PTR_ERR(phy->clk_mod);
>> -		goto err_put_clk_bus;
>> -	}
>> +	phy->clk_bus = devm_clk_get(dev, "bus");
>> +	if (IS_ERR(phy->clk_bus))
>> +		return dev_err_probe(dev, PTR_ERR(phy->clk_bus),
>> +				     "Could not get bus clock\n");
>>  
>> -	if (phy->variant->has_phy_clk) {
>> -		phy->clk_pll0 = of_clk_get_by_name(node, "pll-0");
>> -		if (IS_ERR(phy->clk_pll0)) {
>> -			dev_err(dev, "Could not get pll-0 clock\n");
>> -			ret = PTR_ERR(phy->clk_pll0);
>> -			goto err_put_clk_mod;
>> -		}
>> -
>> -		if (phy->variant->has_second_pll) {
>> -			phy->clk_pll1 = of_clk_get_by_name(node, "pll-1");
>> -			if (IS_ERR(phy->clk_pll1)) {
>> -				dev_err(dev, "Could not get pll-1 clock\n");
>> -				ret = PTR_ERR(phy->clk_pll1);
>> -				goto err_put_clk_pll0;
>> -			}
>> -		}
>> -	}
>> +	phy->clk_mod = devm_clk_get(dev, "mod");
>> +	if (IS_ERR(phy->clk_mod))
>> +		return dev_err_probe(dev, PTR_ERR(phy->clk_mod),
>> +				     "Could not get mod clock\n");
>>  
>> -	phy->rst_phy = of_reset_control_get_shared(node, "phy");
>> -	if (IS_ERR(phy->rst_phy)) {
>> -		dev_err(dev, "Could not get phy reset control\n");
>> -		ret = PTR_ERR(phy->rst_phy);
>> -		goto err_put_clk_pll1;
>> -	}
>> +	if (phy->variant->has_phy_clk)
>> +		phy->clk_pll0 = devm_clk_get(dev, "pll-0");
>> +	if (IS_ERR(phy->clk_pll0))
>> +		return dev_err_probe(dev, PTR_ERR(phy->clk_pll0),
>> +				     "Could not get pll-0 clock\n");
>> +
>> +	if (phy->variant->has_second_pll)
>> +		phy->clk_pll1 = devm_clk_get(dev, "pll-1");
>> +	if (IS_ERR(phy->clk_pll1))
>> +		return dev_err_probe(dev, PTR_ERR(phy->clk_pll1),
>> +				     "Could not get pll-1 clock\n");
>> +
>> +	phy->rst_phy = devm_reset_control_get_shared(dev, "phy");
>> +	if (IS_ERR(phy->rst_phy))
>> +		return dev_err_probe(dev, PTR_ERR(phy->rst_phy),
>> +				     "Could not get phy reset control\n");
> 
> I find the old construct clearer with the imbricated blocks.

I'm not sure what you mean here. Are you suggesting braces around the
dev_err_probe statements? Or do you want me to put the error handling for
variant-specific resources inside the variant checks? Please clarify.

Regards,
Samuel
