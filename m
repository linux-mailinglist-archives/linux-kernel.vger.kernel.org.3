Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8901651334B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 14:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345968AbiD1MF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 08:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiD1MFY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 08:05:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DBBADD60;
        Thu, 28 Apr 2022 05:02:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A45DAB82BA0;
        Thu, 28 Apr 2022 12:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92278C385A0;
        Thu, 28 Apr 2022 12:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651147327;
        bh=z/rcuQ6bVDZnTEpAnS4QlRzB5Yc+lFfj8TR9qyt755Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=si2hzBVdSNFEBs1SgfQe/IMiNDmiaAebPForIezTbJrYcMWx8DUqOFoD3nbKycvFX
         xJVX5eLCianPJHhpZCYyFuJrVdU3zLaVbnFQPLbJtjFrBJBBdHfISwgbSy4weuFDqV
         Yzs1wECbO0Yq+9bvY8V0fhs7z5JbOGPOi6+LhNskOT0L/e8tsXxhMW2tfs3jrsqIDD
         D1ASAm2ReV+JfUbpHHro8c1ZQsD5gBO2zgDQEaqYx9hdphw4k2kLUPM1X35rIGujjq
         3XSOQc2obb2oK11OPs4V/dN6JrLsvw4Lp4m8MpZb2BoLKeRd07bUOsR4MJa66X3GkQ
         bvEvwzh+J+81A==
Date:   Thu, 28 Apr 2022 13:02:01 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [v4 13/18] ASoC: mediatek: mt8186: add platform driver
Message-ID: <YmqCORqp6nYuQJZf@sirena.org.uk>
References: <20220428093355.16172-1-jiaxin.yu@mediatek.com>
 <20220428093355.16172-14-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jdU3xo2gQbe9oqCP"
Content-Disposition: inline
In-Reply-To: <20220428093355.16172-14-jiaxin.yu@mediatek.com>
X-Cookie: Bedfellows make strange politicians.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jdU3xo2gQbe9oqCP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 28, 2022 at 05:33:50PM +0800, Jiaxin Yu wrote:
> Add mt8186 platform and affiliated driver.
>=20
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> ---
>  sound/soc/mediatek/Kconfig                    |   44 +
>  sound/soc/mediatek/Makefile                   |    1 +
>  sound/soc/mediatek/mt8186/Makefile            |   22 +
>  sound/soc/mediatek/mt8186/mt8186-afe-common.h |  235 ++
>  .../soc/mediatek/mt8186/mt8186-afe-control.c  |  261 ++
>  sound/soc/mediatek/mt8186/mt8186-afe-pcm.c    | 3005 +++++++++++++++++
>  .../mediatek/mt8186/mt8186-interconnection.h  |   69 +
>  .../soc/mediatek/mt8186/mt8186-misc-control.c |  294 ++
>  .../mediatek/mt8186/mt8186-mt6366-common.c    |   59 +
>  .../mediatek/mt8186/mt8186-mt6366-common.h    |   17 +
>  sound/soc/mediatek/mt8186/mt8186-reg.h        | 2913 ++++++++++++++++
>  11 files changed, 6920 insertions(+)

This looks mostly good though it is enormous so I might've missed some
things.  The patch series is already very large but it might still be
worth splitting this up a bit more, perhaps split the code and data
tables/register definitions into separate patches?

A few relatively minor issues with the controls.

> +/* this order must match reg bit amp_div_ch1/2 */
> +static const char * const mt8186_sgen_amp_str[] =3D {
> +	"1/128", "1/64", "1/32", "1/16", "1/8", "1/4", "1/2", "1" };
> +static const char * const mt8186_sgen_mute_str[] =3D {
> +	"Off", "On"
> +};

On/off controls should be normal Switch controls not enums so userspace
can display things sensibly.

> +static int mt8186_sgen_set(struct snd_kcontrol *kcontrol,
> +			   struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt =3D snd_soc_kcontrol_component(kcontrol=
);
> +	struct mtk_base_afe *afe =3D snd_soc_component_get_drvdata(cmpnt);
> +	struct mt8186_afe_private *afe_priv =3D afe->platform_priv;
> +	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
> +	int mode;
> +	int mode_idx;
> +
> +	if (ucontrol->value.enumerated.item[0] >=3D e->items)
> +		return -EINVAL;

=2E..

> +				   0x3f << INNER_LOOP_BACK_MODE_SFT);
> +	}
> +
> +	afe_priv->sgen_mode =3D mode;
> +
> +	return 0;
> +}

This should return 1 if the value is different from the previous value
so event generation works, please run mixer-test against a system using
the driver to help spot issues like this.  The same issue applies to at
least some of the other custom controls.

> +static int mt8186_sgen_mute_set(struct snd_kcontrol *kcontrol,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *cmpnt =3D snd_soc_kcontrol_component(kcontrol=
);
> +	struct mtk_base_afe *afe =3D snd_soc_component_get_drvdata(cmpnt);
> +	struct soc_enum *e =3D (struct soc_enum *)kcontrol->private_value;
> +	int mute;
> +
> +	if (ucontrol->value.enumerated.item[0] >=3D e->items)
> +		return -EINVAL;
> +
> +	mute =3D ucontrol->value.integer.value[0];
> +
> +	dev_dbg(afe->dev, "%s(), kcontrol name %s, mute %d\n",
> +		__func__, kcontrol->id.name, mute);
> +
> +	if (strcmp(kcontrol->id.name, SGEN_MUTE_CH1_KCONTROL_NAME) =3D=3D 0) {
> +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +				   MUTE_SW_CH1_MASK_SFT,
> +				   mute << MUTE_SW_CH1_SFT);
> +	} else {
> +		regmap_update_bits(afe->regmap, AFE_SINEGEN_CON0,
> +				   MUTE_SW_CH2_MASK_SFT,
> +				   mute << MUTE_SW_CH2_SFT);
> +	}
> +
> +	return 0;
> +}

I can't tell why some of these are done with custom code rather than
using a normal SOC_SINGLE()?

--jdU3xo2gQbe9oqCP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJqgjgACgkQJNaLcl1U
h9AdWgf/f48ddKYw5UEk9XqJetzu+AKnHMJdiGhcXVL8VJHS8NjNHgAIEkf7OtdR
IViyQ7xxZBoVqVIdFG6R9agx3aFmdzL4xB1pujeQBINZxBU9AUsNZYVYvoPcOCVE
1mTboTs+xpDB6w2l8wWS5LSep9LWUHZbNCVhjuauariDNPMIE1PtIsLdwrbFFn98
TfLbVeGSNsabtkj1gp8Uy+7vMz8EyhsCZ+vVYLTbY9+vrFtMkKHo9kmNn/AfFSQE
w4q2Jl2ktlwuhsQ3PYl+436ODLdrmUtBoV6RjRUn30TbpnGW2Z5qtR8+eMUR5PzZ
nmzRcM5BGt4HvdA3tf5kTA6VLsD2Dw==
=uhVL
-----END PGP SIGNATURE-----

--jdU3xo2gQbe9oqCP--
