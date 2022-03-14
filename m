Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 903664D799C
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 04:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235935AbiCNDS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 23:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiCNDRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 23:17:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D9015A31;
        Sun, 13 Mar 2022 20:16:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4E40260F0A;
        Mon, 14 Mar 2022 03:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C70CC340E9;
        Mon, 14 Mar 2022 03:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647227801;
        bh=pqkDNAeAEYNvG49k/Hx0tByN0ecvsp2DdmQ6if+3LdA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K6stHjXByT/LIIEPIIN7gV5+ue1kVhi02UDo/UKc/m29vF0fX3xut4Yg4viAqkjQ6
         1xe5srH6/IkKVbXiIHrX2MrjP8vuOu03F5X+2fbduJUhQ7Fnk1h9me4H3aqfbCngOp
         dxsGOek5ppdJBELp7JOkg0DA8kH+UwxOsJ9fdy27kGaHlG8nEHE8jQIV+W4X8tUxOg
         azJ/56yD5EYylptV+CI2SzgAZhq4poAfP/p1mNf5P3Vk5pqFwi56V3pfdYEm4pX+aN
         Y1vEaMqAca9yOZE7ajA25CxUIDKZDeJH6MVkyab2wvikK3vpXfRqig5ckIY6hTAcJj
         fR4pOtOJOq5Qw==
Date:   Mon, 14 Mar 2022 11:16:36 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, aaronyu@google.com,
        matthias.bgg@gmail.com, trevor.wu@mediatek.com, linmq006@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [v4 2/2] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Message-ID: <Yi6zlIvA6t+yEbza@google.com>
References: <20220311162213.6942-1-jiaxin.yu@mediatek.com>
 <20220311162213.6942-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311162213.6942-3-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 12:22:13AM +0800, Jiaxin Yu wrote:
> Supports machines with rt1015p and rt5682s. Uses new proposed compatible
> string "mt8192_mt6359_rt1015p_rt5682s". Using define to simplifies card
> name and compatible name, and uses the snd_soc_of_get_dai_link_codecs()
> to complete the configuration of dai_link's codecs.

Rephrase the paragraph and consider to use imperative mood as [1] suggests.

[1]: https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

The patch includes multiple changes.  Could you further separate it into:
1. Refactor for I2S3 DAI links for original amps.
2. Refactor for I2S8 and I2S9 DAI links for original headset codec RT5682.
3. Support mt8192_mt6359_rt1015p_rt5682s for RT5682S.

> Reported-by: kernel test robot <lkp@intel.com>

The tag can be dropped as "Supports machines with rt1015p and rt5682s" is not
an idea from the bot.  Put it in change logs if you would like it to be a
record.

> +static int mt8192_mt6359_card_set_be_link(struct snd_soc_card *card,
> +					  struct snd_soc_dai_link *link,
> +					  struct device_node *node,
> +					  char *link_name)
> +{
> +	int ret;
> +
> +	if (node && strcmp(link->name, link_name) == 0) {
> +		ret = snd_soc_of_get_dai_link_codecs(card->dev, node, link);
> +		if (ret < 0) {
> +			dev_err(card->dev, "get dai link codecs fail\n");

How about using dev_err_probe()?  As the callers also report errors if
mt8192_mt6359_card_set_be_link() fails, the log can be dropped.

>  static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
>  {
>  	struct snd_soc_card *card;
> -	struct device_node *platform_node, *hdmi_codec;
> +	struct device_node *platform_node, *hdmi_codec, *headset_codec, *speaker_codec;
>  	int ret, i;
>  	struct snd_soc_dai_link *dai_link;
>  	struct mt8192_mt6359_priv *priv;
> +	struct device *dev;
[...]
> +	dev = &pdev->dev;

I don't think it could help too much unless it was struggling for code
columns.  Please consider to drop the variable or you should s/&pdev->dev/dev/g
for the function.

> +	speaker_codec = of_get_child_by_name(dev->of_node, "mediatek,speaker-codec");
> +	if (!speaker_codec) {
> +		ret = -EINVAL;
> +		dev_err_probe(dev, ret, "Property 'speaker_codec' missing or invalid\n");
> +		goto err_speaker_codec;
> +	}
> +
> +	headset_codec = of_get_child_by_name(dev->of_node, "mediatek,headset-codec");
> +	if (!headset_codec) {
> +		ret = -EINVAL;
> +		dev_err_probe(dev, ret, "Property 'headset_codec' missing or invalid\n");
> +		goto err_headset_codec;
> +	}

Are these new DT bindings?  They are not in
Documentation/devicetree/bindings/sound/mt8192-mt6359-rt1015-rt5682.yaml.

> +		ret = mt8192_mt6359_card_set_be_link(card, dai_link, speaker_codec, "I2S3");
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret, "%s set speaker_codec fail\n",

As mentioned above, I don't think `dev` could help too much.  However, to be
consistent, either drop the `dev` variable or use `dev` here.

> +		ret = mt8192_mt6359_card_set_be_link(card, dai_link, headset_codec, "I2S8");
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
> +				      dai_link->name);

Ditto.

> +		ret = mt8192_mt6359_card_set_be_link(card, dai_link, headset_codec, "I2S9");
> +		if (ret) {
> +			dev_err_probe(&pdev->dev, ret, "%s set headset_codec fail\n",
> +				      dai_link->name);

Ditto.

>  	ret = mt8192_afe_gpio_init(&pdev->dev);
>  	if (ret) {
> -		dev_err(&pdev->dev, "init gpio error %d\n", ret);
> -		goto put_hdmi_codec;
> +		dev_err_probe(&pdev->dev, ret, "%s init gpio error\n", __func__);

Ditto.

>  	ret = devm_snd_soc_register_card(&pdev->dev, card);
> -
> -put_hdmi_codec:
> +	if (ret)
> +		dev_err_probe(&pdev->dev, ret,

Ditto.

> +err_probe:
> +	of_node_put(headset_codec);
> +err_headset_codec:
> +	of_node_put(speaker_codec);
> +err_speaker_codec:
>  	of_node_put(hdmi_codec);
> -put_platform_node:
> +err_hdmi_codec:
>  	of_node_put(platform_node);
> +err_platform_node:
> +

The new line can be dropped.
