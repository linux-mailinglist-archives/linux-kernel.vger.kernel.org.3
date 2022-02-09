Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CF5E4AF3EA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbiBIOSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:18:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbiBIOS2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:18:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE41DC06157B;
        Wed,  9 Feb 2022 06:18:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F689B821B2;
        Wed,  9 Feb 2022 14:18:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B8AC340ED;
        Wed,  9 Feb 2022 14:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644416308;
        bh=1MtO7MBePNHbA180B0d3mHWV4qoaflVr2s+vaUlLuqk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LriNNC73jaD88ED44JGHSTX8EOyHJPWda8DfKQNiSc0t42p29DxoZgkY9dLHrUURN
         H2I6fZ+1iDE2XnR/vglWu+eYh6LW7rybBnJWKuWEZq39cy0z8jMMt7ss42PWj1sWNi
         twDAfJCStcclo88RxyM0lKOs1zGS7viof0ecEXlQQCidRmV5asTeE5HJjkqnhavMq9
         eWMS8sA2CGKLSREVpE7D44iCFOkhpA4CN3oBGPEGA2x/rLlwZDxw3dfFAeyDctnKtn
         YwA6adixpgNvuLNtMZuNdQuYVquOE853N0oXEbiokZ6zH44BhRo9JKZcUTc6LkrcD7
         zAIKK4X2vaGpg==
Date:   Wed, 9 Feb 2022 14:18:22 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Satya Priya <quic_c_skakit@quicinc.com>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Das Srinagesh <gurus@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_jprakash@quicinc.com
Subject: Re: [PATCH V5 4/6] regulator: Add a regulator driver for the PM8008
 PMIC
Message-ID: <YgPNLq6tdj5/UpZE@sirena.org.uk>
References: <1644331940-18986-1-git-send-email-quic_c_skakit@quicinc.com>
 <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xXbvD+5GjL5lwDdj"
Content-Disposition: inline
In-Reply-To: <1644331940-18986-5-git-send-email-quic_c_skakit@quicinc.com>
X-Cookie: Disc space -- the final frontier!
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--xXbvD+5GjL5lwDdj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 08, 2022 at 08:22:18PM +0530, Satya Priya wrote:

> +static int pm8008_regulator_of_parse(struct device_node *node,
> +			const struct regulator_desc *desc,
> +			struct regulator_config *config)
> +{
> +	struct pm8008_regulator *pm8008_reg =3D config->driver_data;
> +	int rc;
> +	unsigned int reg;
> +
> +	/* get slew rate */
> +	rc =3D regmap_bulk_read(pm8008_reg->regmap,
> +			LDO_STEPPER_CTL_REG(pm8008_reg->base), &reg, 1);
> +	if (rc < 0) {
> +		dev_err(pm8008_reg->dev,
> +			"%s: failed to read step rate configuration rc=3D%d\n",
> +			pm8008_reg->rdesc.name, rc);
> +		return rc;
> +	}
> +	reg &=3D STEP_RATE_MASK;
> +	pm8008_reg->step_rate =3D DEFAULT_VOLTAGE_STEPPER_RATE >> reg;
> +
> +	return 0;

This is not doing any parsing of any DT properties at all, it is just
reading a default value back from the hardware.  This shouldn't be in
the of_parse() callback, it should be done on probe() or something so
that if someone adds ACPI support or whatever there's no surprise
breakage, and so that we've got this configured even if there's no DT
bindings for the specific regulator.

> +}
> +
> +static int pm8008_regulator_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	int id =3D pdev->id % PM8008_NUM_LDOS;
> +	struct regulator_dev    *rdev;
> +	struct pm8008_regulator *pm8008_reg;
> +	struct regmap *regmap;
> +	struct regulator_config reg_config =3D {};
> +	int rc;
> +
> +	dev_dbg(dev, "DEBUG: Probing LDO%d\n", id + 1);
> +
> +	regmap =3D dev_get_regmap(dev->parent, NULL);
> +	if (!regmap) {
> +		dev_err(dev, "parent regmap is missing\n");
> +		return -EINVAL;
> +	}
> +
> +	pm8008_reg =3D devm_kzalloc(dev, sizeof(*pm8008_reg), GFP_KERNEL);
> +	if (!pm8008_reg)
> +		return -ENOMEM;
> +
> +	pm8008_reg->regmap =3D regmap;
> +	pm8008_reg->dev =3D dev;
> +	pm8008_reg->base =3D reg_data[id].base;
> +
> +	pm8008_reg->rdesc.type =3D REGULATOR_VOLTAGE;
> +	pm8008_reg->rdesc.regulators_node =3D of_match_ptr("regulators");
> +	pm8008_reg->rdesc.ops =3D &pm8008_regulator_ops;
> +	pm8008_reg->rdesc.name =3D reg_data[id].name;
> +	pm8008_reg->rdesc.supply_name =3D reg_data[id].supply_name;
> +	pm8008_reg->rdesc.of_match =3D reg_data[id].name;
> +	pm8008_reg->rdesc.of_parse_cb =3D pm8008_regulator_of_parse;
> +	pm8008_reg->rdesc.uV_step =3D VSET_STEP_UV;
> +	pm8008_reg->rdesc.min_uV =3D reg_data[id].min_uv;
> +	pm8008_reg->rdesc.n_voltages
> +		=3D ((reg_data[id].max_uv - reg_data[id].min_uv)
> +			/ pm8008_reg->rdesc.uV_step) + 1;
> +	pm8008_reg->rdesc.linear_ranges =3D reg_data[id].voltage_range;
> +	pm8008_reg->rdesc.n_linear_ranges =3D 1;
> +	pm8008_reg->rdesc.enable_reg =3D LDO_ENABLE_REG(pm8008_reg->base);
> +	pm8008_reg->rdesc.enable_mask =3D ENABLE_BIT;
> +	pm8008_reg->rdesc.min_dropout_uV =3D reg_data[id].min_dropout_uv;
> +
> +	reg_config.dev =3D dev->parent;
> +	reg_config.driver_data =3D pm8008_reg;
> +
> +	rdev =3D devm_regulator_register(dev, &pm8008_reg->rdesc, &reg_config);
> +	if (IS_ERR(rdev)) {
> +		rc =3D PTR_ERR(rdev);
> +		dev_err(dev, "%s: failed to register regulator rc=3D%d\n",
> +				reg_data[id].name, rc);
> +		return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static struct platform_driver pm8008_regulator_driver =3D {
> +	.driver	=3D {
> +		.name		=3D "qcom,pm8008-regulators",
> +	},
> +	.probe	=3D pm8008_regulator_probe,
> +};
> +
> +module_platform_driver(pm8008_regulator_driver);
> +
> +MODULE_DESCRIPTION("Qualcomm PM8008 PMIC Regulator Driver");
> +MODULE_LICENSE("GPL");
> --=20
> 2.7.4
>=20

--xXbvD+5GjL5lwDdj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIDzS0ACgkQJNaLcl1U
h9DRcAf9HPN3Mc4xD6E/TulcobefCCiQgxa/AHUX1JjIH0G6D0zCj79m5CZDoY3C
0GjR8ECghIi9en0dXhsHyacAuudBBWQOO54LVpSh0pWtfi3r9rJS11wgjCIhk7FO
+pSO7jaKR38mbNp6I1j7xha5NiDkdvzTkbyYuxAxKMT1B7n75GlV6hfcez4L+Hz6
Q8IRPfmYqa1IStIMfk77tA7CxnAA4+ynE41z276XuRhYLmm+JYpLZY3jDheEYazA
OGIYxev1JXfdIRpuwWJNdWUGhl+3ulLhI7lg6G3TjfPxaHFKDOyJ4HPtCTX/QhZr
Ucq/G4rJ4mK8UL18pjuxoacFwb7iiw==
=sAyx
-----END PGP SIGNATURE-----

--xXbvD+5GjL5lwDdj--
