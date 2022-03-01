Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1706F4C874E
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233527AbiCAJEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiCAJEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:04:33 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588607ED99;
        Tue,  1 Mar 2022 01:03:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 16F3CB817F6;
        Tue,  1 Mar 2022 09:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1186C340EE;
        Tue,  1 Mar 2022 09:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646125429;
        bh=1c14S9dVNVF1VyP3FFe0N65e9c5Jwxgr+ehoV6e9Nh4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gD5dXXhUeEpUdK7hh/LestsugNYQB0olqAMDGA85MmxmdxSbaa8ZXOIKWM/2ZswUK
         xLf/XlReSOYTALDhEGkCR0pV6xgf7JEhKLhbjM7EKbXIALSoDeXUPTnV6Kp5bcUCAj
         Pz9UtyP8vv8NGM+AM6IM0VTUdqn2iSoDw9OYSpBi+B52N4oDlTHdYAzBvDS0b+mjKp
         Xd+5CA9Tugg4uwvHbkVQGI4iS4yFkYZb2cRkbPGwSZ1HOdjxyr/WRRvMuKUwgWri48
         TVoO6bSS5lESM/u0uNGB/qSpd/iWw67aaIm9iqO04J6Quh83P17qIcnpFKP9V2Z4I6
         dzEq5egneiLXQ==
Date:   Tue, 1 Mar 2022 17:03:45 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, matthias.bgg@gmail.com,
        trevor.wu@mediatek.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>
Subject: Re: [PATCH 2/2] ASoC: mediatek: mt8192: support rt1015p_rt5682s
Message-ID: <Yh3hcQpLngg8Pnd4@google.com>
References: <20220301072924.24814-1-jiaxin.yu@mediatek.com>
 <20220301072924.24814-3-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220301072924.24814-3-jiaxin.yu@mediatek.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2022 at 03:29:24PM +0800, Jiaxin Yu wrote:
> From: Jiaxin Yu <jiaxin.yu@mediatek.corp-partner.google.com>

The environment didn't configure properly so that the header showed up.
See [1].

[1]: https://git-scm.com/docs/git-send-email#Documentation/git-send-email.txt---fromltaddressgt

> diff --git a/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c b/sound/soc/mediatek/mt8192/mt8192-mt6359-rt1015-rt5682.c
[...]
> +static struct snd_soc_card mt8192_mt6359_rt1015p_rt5682s_card = {
> +	.name = "mt8192_mt6359_rt1015p_rt5682s",
> +	.owner = THIS_MODULE,
> +	.dai_link = mt8192_mt6359_dai_links,
> +	.num_links = ARRAY_SIZE(mt8192_mt6359_dai_links),
> +	.controls = mt8192_mt6359_rt1015p_rt5682_controls,
> +	.num_controls = ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_controls),
> +	.dapm_widgets = mt8192_mt6359_rt1015p_rt5682_widgets,
> +	.num_dapm_widgets = ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_widgets),
> +	.dapm_routes = mt8192_mt6359_rt1015p_rt5682_routes,
> +	.num_dapm_routes = ARRAY_SIZE(mt8192_mt6359_rt1015p_rt5682_routes),
> +};

Are the two cards only different from names
(mt8192_mt6359_rt1015p_rt5682_card vs. mt8192_mt6359_rt1015p_rt5682s_card)?

> @@ -1150,6 +1177,52 @@ static int mt8192_mt6359_dev_probe(struct platform_device *pdev)
>  				dai_link->num_platforms =
>  					ARRAY_SIZE(i2s3_rt1015p_platforms);
>  			}
> +		} else if (strcmp(dai_link->name, "I2S8") == 0) {
> +			if (card == &mt8192_mt6359_rt1015_rt5682_card ||
> +			    card == &mt8192_mt6359_rt1015p_rt5682_card) {
> +				dai_link->cpus = i2s8_rt5682_cpus;
> +				dai_link->num_cpus =
> +					ARRAY_SIZE(i2s8_rt5682_cpus);
> +				dai_link->codecs = i2s8_rt5682_codecs;
> +				dai_link->num_codecs =
> +					ARRAY_SIZE(i2s8_rt5682_codecs);
> +				dai_link->platforms = i2s8_rt5682_platforms;
> +				dai_link->num_platforms =
> +					ARRAY_SIZE(i2s8_rt5682_platforms);
> +			} else if (card == &mt8192_mt6359_rt1015p_rt5682s_card) {
> +				dai_link->cpus = i2s8_rt5682s_cpus;
> +				dai_link->num_cpus =
> +					ARRAY_SIZE(i2s8_rt5682s_cpus);
> +				dai_link->codecs = i2s8_rt5682s_codecs;
> +				dai_link->num_codecs =
> +					ARRAY_SIZE(i2s8_rt5682s_codecs);
> +				dai_link->platforms = i2s8_rt5682s_platforms;
> +				dai_link->num_platforms =
> +					ARRAY_SIZE(i2s8_rt5682s_platforms);
> +			}
> +		} else if (strcmp(dai_link->name, "I2S9") == 0) {
> +			if (card == &mt8192_mt6359_rt1015_rt5682_card ||
> +			    card == &mt8192_mt6359_rt1015p_rt5682_card) {
> +				dai_link->cpus = i2s9_rt5682_cpus;
> +				dai_link->num_cpus =
> +					ARRAY_SIZE(i2s9_rt5682_cpus);
> +				dai_link->codecs = i2s9_rt5682_codecs;
> +				dai_link->num_codecs =
> +					ARRAY_SIZE(i2s9_rt5682_codecs);
> +				dai_link->platforms = i2s9_rt5682_platforms;
> +				dai_link->num_platforms =
> +					ARRAY_SIZE(i2s9_rt5682_platforms);
> +			} else if (card == &mt8192_mt6359_rt1015p_rt5682s_card) {
> +				dai_link->cpus = i2s9_rt5682s_cpus;
> +				dai_link->num_cpus =
> +					ARRAY_SIZE(i2s9_rt5682s_cpus);
> +				dai_link->codecs = i2s9_rt5682s_codecs;
> +				dai_link->num_codecs =
> +					ARRAY_SIZE(i2s9_rt5682s_codecs);
> +				dai_link->platforms = i2s9_rt5682s_platforms;
> +				dai_link->num_platforms =
> +					ARRAY_SIZE(i2s9_rt5682s_platforms);
> +			}

After seeing the code, I am starting to wonder if the reuse is overkill.  If
they (RT5682 vs. RT5682S) only have some minor differences, probably it could
reuse more by:

SND_SOC_DAILINK_DEFS(i2s8, ...
SND_SOC_DAILINK_DEFS(i2s9, ...

...

if (card == &mt8192_mt6359_rt1015p_rt5682s_card) {
        i2s8_codecs.name = RT5682S_DEV0_NAME;
        i2s8_codecs.dai_name = RT5682S_CODEC_DAI;
        ...
}

Or even uses of_device_is_compatible() if it would like to reuse the struct
snd_soc_card.
