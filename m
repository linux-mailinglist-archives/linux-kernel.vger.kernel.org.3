Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F8C4B28CB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347757AbiBKPLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:11:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232068AbiBKPLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:11:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E99304;
        Fri, 11 Feb 2022 07:11:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42A8F61FAE;
        Fri, 11 Feb 2022 15:11:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71801C340E9;
        Fri, 11 Feb 2022 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644592260;
        bh=yJSk4L5HsItHxMJcn7RPlOgarRlO8VBIH+WmTOcXLOg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VEjL6R0ZUonlqNIwyPEtl0VSA6V/hI22RLzZDd+F6g1Cq+8+bQ5L9Qmirb0BqBdQO
         WAvvR81ULKp2sF0fIkQYe1Nf89uIkVTBZ1bA2yTOcP7CXJx03FC867IMwhFzDy0jaV
         l5uqea3U58VGTj8dXgFw5oVk71WbZpN+nXKNUhzKv2aC6Q5jv7qC+O9nqOon2kbHSb
         M7/Iyp0VQlewoMLx5W27UQSc9abaEpkYM1cCCaAk4hdbQJbgOTyzxV0pKu3gIDtAXh
         Edc3Pf30q0NK1nJisNoEYs9bhzdHXVSDc3N26fZKTlAjRA2WvHTTnBwn3ovnqWsIru
         K8X6vWgc0LNwA==
Date:   Fri, 11 Feb 2022 15:10:54 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     lgirdwood@gmail.com, tiwai@suse.com, robh+dt@kernel.org,
        matthias.bgg@gmail.com, perex@perex.cz, p.zabel@pengutronix.de,
        geert+renesas@glider.be, trevor.wu@mediatek.com,
        tzungbi@google.com, zhangqilong3@huawei.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/15] ASoC: mediatek: mt8186: support adda in platform
 driver
Message-ID: <YgZ8fnvd4/Mxm3wp@sirena.org.uk>
References: <20220211103818.8266-1-jiaxin.yu@mediatek.com>
 <20220211103818.8266-4-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jQ99B0YRXDijfpGR"
Content-Disposition: inline
In-Reply-To: <20220211103818.8266-4-jiaxin.yu@mediatek.com>
X-Cookie: do {
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jQ99B0YRXDijfpGR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 11, 2022 at 06:38:06PM +0800, Jiaxin Yu wrote:

This looks pretty good, there's some issues below but they're all very
minor, mostly stylistic things rather than anything substantial.

> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + *  MediaTek ALSA SoC Audio DAI ADDA Control
> + *
> + *  Copyright (c) 2022 MediaTek Inc.
> + *  Author: Jiaxin Yu <jiaxin.yu@mediatek.com>
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +static int mtk_adda_ul_event(struct snd_soc_dapm_widget *w,
> +			     struct snd_kcontrol *kcontrol,
> +			     int event)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_dapm_to_component(w->dapm);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	int mtkaif_dmic = afe_priv->mtkaif_dmic;
> +
> +	dev_info(afe->dev, "%s(), name %s, event 0x%x, mtkaif_dmic %d\n",
> +		 __func__, w->name, event, mtkaif_dmic);

This should be dev_dbg() at most, otherwise the logs will get very noisy
(but note that there are trace points in the core which cover this).
There's a bunch of other dev_info() calls like this on DAPM events.

> +		if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2_CLK_P2)
> +			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x38);
> +		else if (afe_priv->mtkaif_protocol == MTKAIF_PROTOCOL_2)
> +			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x30);
> +		else
> +			regmap_write(afe->regmap, AFE_AUD_PAD_TOP, 0x30);

This could be more clearly written as a switch statement.

> +			if (strcmp(w->name, "ADDA_MTKAIF_CFG") == 0) {
> +				if (afe_priv->mtkaif_chosen_phase[0] < 0 &&
> +				    afe_priv->mtkaif_chosen_phase[1] < 0) {
> +					dev_info(afe->dev,
> +						 "%s(), calib fail mtkaif_chosen_phase[0/1]:%d/%d\n",
> +						 __func__,

Should this be a dev_err() given that the calibration failed?

> +/* mtkaif dmic */
> +static const char * const mt8186_adda_off_on_str[] = {
> +	"Off", "On"
> +};
> +
> +static const struct soc_enum mt8186_adda_enum[] = {
> +	SOC_ENUM_SINGLE_EXT(ARRAY_SIZE(mt8186_adda_off_on_str),
> +			    mt8186_adda_off_on_str),
> +};

This is a simple on/off control so should be a standard numeric control
with a name ending in Switch to help UIs handle it properly.

> +static int mt8186_adda_dmic_set(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt = snd_soc_kcontrol_component(kcontrol);
> +	struct mtk_base_afe *afe = snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv = afe->platform_priv;
> +	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
> +	int dmic_on;
> +
> +	if (ucontrol->value.enumerated.item[0] >= e->items)
> +		return -EINVAL;
> +
> +	dmic_on = ucontrol->value.integer.value[0];
> +
> +	dev_info(afe->dev, "%s(), kcontrol name %s, dmic_on %d\n",
> +		 __func__, kcontrol->id.name, dmic_on);
> +
> +	afe_priv->mtkaif_dmic = dmic_on;
> +	return 0;

This should return 1 if the value changed so an event is generated for
userspace.  You might want to run the mixer-test kselftest (ideally the
version that's in -next as there were a few bits added very recently),
it should detect issues like this.

--jQ99B0YRXDijfpGR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIGfH0ACgkQJNaLcl1U
h9DHegf9FFOH5x7aOO8tIrLCjfLZFtOCnSo3V7OkQ8PJX+03uK3Ix78EZtr4fty8
+Kp/3NwD98U0ZtN8thMfTOozGdzcfWUFiKGiBLFN0lFXt6h4whktuTB+OJfhmwy1
mbmVi46mEJphnEyVhY6cS8b/AXeZ8usoZb3h/3meT8/nHKfP3ihQZKeBntk1y4Eh
Fj/mJtQIOA/ck+U6bMyaXaSZ8kYsBlpNin/MI+dPNxk50W2WSZJIFNe+PIMeGiuT
41F/eRkbYtv+nCmVmmdBuw3YLNUzSXLNYzttDYlofXvnz3mbraXvhny8qJ0ZA3X7
fBlHVaOI7kH11JdpDxFVoftYhH2YQg==
=N7WM
-----END PGP SIGNATURE-----

--jQ99B0YRXDijfpGR--
