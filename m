Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32B5A5B239A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 18:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiIHQ1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 12:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbiIHQ1q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 12:27:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEA3F9104;
        Thu,  8 Sep 2022 09:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2DFA261D96;
        Thu,  8 Sep 2022 16:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A56EC433D6;
        Thu,  8 Sep 2022 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662654463;
        bh=Brgz3oNaf9WODk9ERmXiAM/uo6+QdfAka7ySSGUv6Bk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N2QiBrhNoe9X5SGsrx6CgAzwFJCtc1vNOEMo/7ynYGkzV4Q5NpGvCKXzv0QhaDFX9
         9AZsTKy7MDeFbKnuWo+pgsEODlM5KYAVD1M9I7AlZ10OcP68F3msGuwzlhB53lW8dG
         2I6GQb2ErRqQ8wHq94GwD4pmR5hjEptfOYAjxeC58RON6KwGm01FJ4mzXjAcTv4tWF
         KeM6gKyI1gu99WYdFHjEuUMMOb3Z23R+6LREVs+UEw7y6k4j6cAQDQOc0OyyNBjwtJ
         L5FdJUc0ct6OQqkGjuiwOUEEEdieJHnpg3dE4NGOHqKtMAYM9gyiX6G4UNdreJgpbS
         YQRBfrZ1zvtng==
Date:   Thu, 8 Sep 2022 17:27:36 +0100
From:   Mark Brown <broonie@kernel.org>
To:     luca.ceresoli@bootlin.com
Cc:     alsa-devel@alsa-project.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH 7/8] ASoC: codecs: Add RK3308 internal audio codec driver
Message-ID: <YxoX+G5OFVDTX7s3@sirena.org.uk>
References: <20220907142124.2532620-1-luca.ceresoli@bootlin.com>
 <20220907142124.2532620-8-luca.ceresoli@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eH9xiUGEV4YR/RR8"
Content-Disposition: inline
In-Reply-To: <20220907142124.2532620-8-luca.ceresoli@bootlin.com>
X-Cookie: Metermaids eat their young.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eH9xiUGEV4YR/RR8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 07, 2022 at 04:21:23PM +0200, luca.ceresoli@bootlin.com wrote:

> +static const char *offon_text[2] = {
> +	[0] = "Off",
> +	[1] = "On",
> +};

Simple on/off controls should be normal switches, not enums.

> +/* ALC AGC Switch */
> +static const struct soc_enum rk3308_agc_enum_array[] = {
> +	SOC_ENUM_SINGLE(0, 0, ARRAY_SIZE(offon_text), offon_text),
> +	SOC_ENUM_SINGLE(0, 1, ARRAY_SIZE(offon_text), offon_text),

Do not index into arrays of enums with magic numbers, this is hard to
read and maintain.  Use named variables for the enums like other drivers
do.

> +static void rk3308_codec_update_zerocross(struct rk3308_codec_priv *rk3308)
> +{
> +	unsigned int agc_on, value;
> +	int grp;
> +
> +	/* 14: enable zero-cross detection if AGC enabled, else AGC won't work */
> +	for (grp = 0; grp < rk3308->used_adc_grps; grp++) {

If you're going to force zero cross on then you need to generate an
event on the zero cross control so that UIs get updated, however it
might be a bit more idiomatic to either just leave zero cross always on
and not offer user control or return an error if the user tries to
enable AGC without zero cross (or tries to disable zero cross without
AGC).  Given that there's very few use cases for disabling zero cross
with actual audio usage it may be best to just force it on and worry
about offering control for those other use cases later if someone
actually needs that, it's probably more trouble than it's worth to
handle.

> +static int rk3308_codec_agc_put(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
> +

> +	}
> +
> +	rk3308_codec_update_zerocross(rk3308);
> +
> +	return 0;
> +}

_put() operations need to return 1 if the value changed, please run the
mixer-test selftest on a system with your driver0 - it'll catch issues
like this for you.

> +	if (any_micbias_enabled) {
> +		regmap_update_bits(rk3308->regmap, RK3308_ADC_ANA_CON07(0),
> +				   RK3308_ADC_LEVEL_RANGE_MICBIAS_MSK,
> +				   rk3308->micbias_avdd_mult);
> +
> +		/* Wait until the VCMH keep stable */
> +		msleep(20);	/* estimated value */
> +
> +		regmap_set_bits(rk3308->regmap, RK3308_ADC_ANA_CON08(0),
> +				RK3308_ADC_MICBIAS_CURRENT_EN);
> +	}

This should probably be modelled as a SUPPLY widget for the micbiases
rather than open coding.

> +static int rk3308_codec_micbias_put(struct snd_kcontrol *kcontrol,
> +				    struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);

There should be no reason to offer userspace control over micbiases,
they should be modelled as supply widgets like with other drivers.  If
there's some system specific reason for offering control then the
machine driver can handle it.

> +static int rk3308_codec_hpout_l_get_tlv(struct snd_kcontrol *kcontrol,
> +					struct snd_ctl_elem_value *ucontrol)
> +{
> +	return snd_soc_get_volsw_range(kcontrol, ucontrol);
> +}

Just use the generic function directly, no need for this wrapper.

> +static int rk3308_codec_hpout_r_put_tlv(struct snd_kcontrol *kcontrol,
> +					struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
> +	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
> +	unsigned int dgain = ucontrol->value.integer.value[0];
> +
> +	rk3308->hpout_r_dgain = dgain;
> +
> +	return snd_soc_put_volsw_range(kcontrol, ucontrol);
> +}

Just model the headphone output as a stereo control.

> +	 * There are 8 ADCs and use the same SCLK and LRCK internal for master
> +	 * mode, We need to make sure that they are in effect at the same time,
> +	 * otherwise they will cause the abnormal clocks.
> +	 */
> +	if (is_master)
> +		regmap_clear_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_DIG_WORK);
> +
> +	for (grp = 0; grp < ADC_LR_GROUP_MAX; grp++) {
> +		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON01(grp),
> +				   RK3308_ADC_I2S_LRC_POL_REVERSAL |
> +				   RK3308_ADC_I2S_MODE_MSK,
> +				   adc_aif1);
> +		regmap_update_bits(rk3308->regmap, RK3308_ADC_DIG_CON02(grp),
> +				   RK3308_ADC_IO_MODE_MASTER |
> +				   RK3308_ADC_MODE_MASTER |
> +				   RK3308_ADC_I2S_BIT_CLK_POL_REVERSAL,
> +				   adc_aif2);
> +	}
> +
> +	/* Hold ADC Digital registers end at master mode */
> +	if (is_master)
> +		regmap_set_bits(rk3308->regmap, RK3308_GLB_CON, RK3308_ADC_DIG_WORK);

This looks like it might glitch other active streams, you should
probably have a check to see if the configuration is actually being
changed and skip updates entirely if not.

> +static int rk3308_mute_stream(struct snd_soc_dai *dai, int mute, int stream)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
> +
> +	if (stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		int dgain;
> +
> +		if (mute) {
> +			for (dgain = 0x2; dgain <= 0x7; dgain++) {
> +				/*
> +				 * Keep the max -> min digital CIC interpolation
> +				 * filter gain step by step.
> +				 *
> +				 * loud: 0x2; whisper: 0x7
> +				 */
> +				regmap_update_bits(rk3308->regmap,
> +						   RK3308_DAC_DIG_CON04,
> +						   RK3308_DAC_CIC_IF_GAIN_MSK,
> +						   dgain);
> +				usleep_range(200, 300);  /* estimated value */
> +			}

I'm not clear why a volume ramp is required here?  Generally when the
mute operation happens there's no audio running so we'd just be ramping
up the noise floor, it's for masking glitches from the controller.

> +static int rk3308_codec_digital_fadein(struct rk3308_codec_priv *rk3308)
> +{
> +	unsigned int dgain, dgain_ref;
> +
> +	if (rk3308->hpout_l_dgain != rk3308->hpout_r_dgain) {
> +		pr_warn("HPOUT l_dgain: 0x%x != r_dgain: 0x%x\n",
> +			rk3308->hpout_l_dgain, rk3308->hpout_r_dgain);
> +		dgain_ref = min(rk3308->hpout_l_dgain, rk3308->hpout_r_dgain);
> +	} else {
> +		dgain_ref = rk3308->hpout_l_dgain;
> +	}

Does the device actively need this for masking some issue with clean
startup or is this just a nice to have?  It should be easy enough to
handle asymmatric volumes, you can just ramp by one step at once and
just stop ramping on whichever channel needs fewer steps whenever it
hits target.

If there's some other reason the gains absolutely must be identical just
offer a mono control.

> +	/*
> +	 * We'd better change the gain of the left and right channels
> +	 * at the same time to avoid different listening
> +	 */

Looks like it is working around a power up issue so it's fine to have
this.

> +static int rk3308_codec_dac_enable(struct rk3308_codec_priv *rk3308)
> +{

This looks way, way too open coded - you should be implementing a DAPM
graph for the device and splitting things up.

> +	/*
> +	 * 1. Set the ACODEC_DAC_ANA_CON0[0] to 0x1, to enable the current
> +	 * source of DAC
> +	 */
> +	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON00,
> +			RK3308_DAC_CURRENT_EN);
> +
> +	usleep_range(20, 40);

This should be a DAC widget.

> +
> +	/*
> +	 * 2. Set the ACODEC_DAC_ANA_CON1[6] and ACODEC_DAC_ANA_CON1[2] to 0x1,
> +	 * to enable the reference voltage buffer
> +	 */
> +	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON01,
> +			RK3308_DAC_BUF_REF_L_EN |
> +			RK3308_DAC_BUF_REF_R_EN);
> +
> +	/* Waiting the stable reference voltage */
> +	mdelay(1);

This should be a supply.

> +	/* Step 03 */
> +	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON01,
> +			   RK3308_DAC_HPOUT_POP_SOUND_L_MSK |
> +			   RK3308_DAC_HPOUT_POP_SOUND_R_MSK,
> +			   RK3308_DAC_HPOUT_POP_SOUND_L_WORK |
> +			   RK3308_DAC_HPOUT_POP_SOUND_R_WORK);
> +
> +	usleep_range(20, 40);
> +

You can probably push preparatory work like this into a fake supply
widget, wm8994 has some stuff like that.

> +	/* Step 05 */
> +	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
> +			RK3308_DAC_L_HPMIX_EN |
> +			RK3308_DAC_R_HPMIX_EN);
> +
> +	/* Waiting the stable HPMIX */
> +	mdelay(1);
> +
> +	/* Step 06. Reset HPMIX and recover HPMIX gains */
> +	regmap_clear_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
> +			  RK3308_DAC_L_HPMIX_WORK |
> +			  RK3308_DAC_R_HPMIX_WORK);
> +	usleep_range(50, 100);
> +	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
> +			RK3308_DAC_L_HPMIX_WORK |
> +			RK3308_DAC_R_HPMIX_WORK);
> +
> +	usleep_range(20, 40);

These are mixers.

> +	if (rk3308->dac_output == DAC_LINEOUT ||
> +	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
> +		/* Step 07 */
> +		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON04,
> +				RK3308_DAC_L_LINEOUT_EN |
> +				RK3308_DAC_R_LINEOUT_EN);
> +
> +		usleep_range(20, 40);
> +	}
> +
> +	if (rk3308->dac_output == DAC_HPOUT ||
> +	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
> +		/* Step 08 */
> +		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON03,
> +				RK3308_DAC_L_HPOUT_EN |
> +				RK3308_DAC_R_HPOUT_EN);
> +
> +		usleep_range(20, 40);
> +
> +		/* Step 09 */
> +		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON03,
> +				RK3308_DAC_L_HPOUT_WORK |
> +				RK3308_DAC_R_HPOUT_WORK);
> +
> +		usleep_range(20, 40);
> +	}
> +
> +	if (rk3308->codec_ver == ACODEC_VERSION_B) {
> +		/* Step 10 */
> +		regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON15,
> +				   RK3308_DAC_LINEOUT_POP_SOUND_L_MSK |
> +				   RK3308_DAC_LINEOUT_POP_SOUND_R_MSK,
> +				   RK3308_DAC_L_SEL_LINEOUT_FROM_INTERNAL |
> +				   RK3308_DAC_R_SEL_LINEOUT_FROM_INTERNAL);
> +
> +		usleep_range(20, 40);
> +	}
> +
> +	/* Step 11 */
> +	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
> +			RK3308_DAC_L_REF_EN | RK3308_DAC_R_REF_EN);
> +
> +	usleep_range(20, 40);
> +
> +	/* Step 12 */
> +	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
> +			RK3308_DAC_L_CLK_EN | RK3308_DAC_R_CLK_EN);
> +
> +	usleep_range(20, 40);
> +
> +	/* Step 13 */
> +	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
> +			RK3308_DAC_L_DAC_EN | RK3308_DAC_R_DAC_EN);
> +
> +	usleep_range(20, 40);
> +
> +	/* Step 14 */
> +	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON02,
> +			RK3308_DAC_L_DAC_WORK | RK3308_DAC_R_DAC_WORK);
> +
> +	usleep_range(20, 40);
> +
> +	/* Step 15 */
> +	regmap_update_bits(rk3308->regmap, RK3308_DAC_ANA_CON12,
> +			   RK3308_DAC_L_HPMIX_SEL_MSK |
> +			   RK3308_DAC_R_HPMIX_SEL_MSK,
> +			   RK3308_DAC_L_HPMIX_I2S |
> +			   RK3308_DAC_R_HPMIX_I2S);
> +
> +	usleep_range(20, 40);
> +
> +	/* Step 16 */
> +	regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON13,
> +			RK3308_DAC_L_HPMIX_UNMUTE | RK3308_DAC_R_HPMIX_UNMUTE);
> +
> +	usleep_range(20, 40);
> +
> +	/* Step 17: Put configuration HPMIX Gain */
> +
> +	if (rk3308->dac_output == DAC_HPOUT ||
> +	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
> +		/* Step 18 */
> +		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON03,
> +				RK3308_DAC_L_HPOUT_UNMUTE | RK3308_DAC_R_HPOUT_UNMUTE);
> +
> +		usleep_range(20, 40);
> +	}

These are all output drivers.

> +
> +	if (rk3308->dac_output == DAC_LINEOUT ||
> +	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
> +		/* Step 19 */
> +		regmap_set_bits(rk3308->regmap, RK3308_DAC_ANA_CON04,
> +				RK3308_DAC_L_LINEOUT_UNMUTE | RK3308_DAC_R_LINEOUT_UNMUTE);
> +		usleep_range(20, 40);
> +	}
> +
> +	/* Step 20, put configuration HPOUT gain control */
> +	/* Step 21, put configuration LINEOUT gain control */
> +
> +	if (rk3308->dac_output == DAC_HPOUT ||
> +	    rk3308->dac_output == DAC_LINEOUT_HPOUT) {
> +		/* Just for HPOUT */
> +		rk3308_codec_digital_fadein(rk3308);
> +	}

Use a _POST widget for this.

> +static int rk3308_codec_power_on(struct rk3308_codec_priv *rk3308)
> +{
> +	unsigned int v;
> +

> +static int rk3308_codec_power_off(struct rk3308_codec_priv *rk3308)
> +{
> +	unsigned int v;

This would normally be in set_bias_level() or a DAPM supply, probably
set_bias_level() as there's a few moderate delays.

> +static int rk3308_hw_params(struct snd_pcm_substream *substream,
> +			    struct snd_pcm_hw_params *params,
> +			    struct snd_soc_dai *dai)
> +{
> +	struct snd_soc_component *component = dai->component;
> +	struct rk3308_codec_priv *rk3308 = snd_soc_component_get_drvdata(component);
> +	int ret;
> +
> +	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +		/* DAC only supports 2 channels */
> +		rk3308_codec_dac_mclk_enable(rk3308);
> +		rk3308_codec_dac_enable(rk3308);
> +		rk3308_codec_dac_dig_config(rk3308, params);
> +	} else {
> +		rk3308_codec_micbias_apply(rk3308);
> +		rk3308_codec_adc_mclk_enable(rk3308);
> +		ret = rk3308_codec_update_adc_grps(rk3308, params);
> +		if (ret < 0)
> +			return ret;
> +
> +		rk3308_codec_open_capture(rk3308);
> +		rk3308_codec_agc_dig_config(rk3308, params);
> +		rk3308_codec_adc_dig_config(rk3308, params);
> +	}

Note that hw_params() can be called repeatedly before actually starting
the audio, you shouldn't be doing any refcounted operations.  There is
an open operation or again lots of this looks like powerup stuff which
could be moved to DAPM.

> +static int rk3308_codec_default_gains(struct rk3308_codec_priv *rk3308)
> +{

Use the hardware defaults, don't open code settings for things like
gains.  Your settings may not be appropriate for other systems.

> +static int rk3308_codec_prepare(struct rk3308_codec_priv *rk3308)
> +{
> +	/* Clear registers for ADC and DAC */
> +	rk3308_codec_dac_disable(rk3308);
> +	rk3308_codec_adc_ana_disable(rk3308, ADC_LR_GROUP_MAX);
> +	rk3308_codec_default_gains(rk3308);
> +	rk3308_codec_llp_down(rk3308);
> +	rk3308_codec_controls_prepare(rk3308);

This applies to settings in general, the exceptions are generally things
like zero cross where it's so overwhelmingly clear what makes sense and
the setting is more of a chicken bit than actually useful.

--eH9xiUGEV4YR/RR8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmMaF/gACgkQJNaLcl1U
h9B5IAf+LmB6bFmeJ6R5PyfGoY49FbSjHrQjrH9ZRmVAokg3IV0jBMMCdhNa7ZdY
1eED3xMUYfGIVA3sKQumIIBq/7KIbDBxvSZr7hcjwW4KcqufpjvHnc1/fe3MApWx
RAgyZ8vFKeVAGpMcOt1oqRH9XDoQBNDxLUfmA5AFKg0burG3iGqMvmCpQE+wEq1i
X81I2kPZcDO3EYPWBJpLmFKC8Ate6RaVsAsxmZeTAofOTCgi++hRnq5Xftim3ozv
4F/WajEi5cT6Qtwnq6HifYNmEgpIKDU3nPNbjWDlADLIqheoD5/Ik2zAaYcR0INv
Nssiv1AY/+R/z4fsrB0epBYZTW+NVA==
=6HfO
-----END PGP SIGNATURE-----

--eH9xiUGEV4YR/RR8--
