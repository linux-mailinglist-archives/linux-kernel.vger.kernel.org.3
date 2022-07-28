Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9400583C82
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 12:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236306AbiG1Ktw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 06:49:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbiG1Ktv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 06:49:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37F955F9B;
        Thu, 28 Jul 2022 03:49:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B88C16199C;
        Thu, 28 Jul 2022 10:49:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABB2EC433C1;
        Thu, 28 Jul 2022 10:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659005388;
        bh=c/xTkxRbWD4FTJsS0u1tXoSZ7j2nlmXNxawdaZwg6Ms=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EuPBj5QbHdjkGUBWJJ6hQ+NZfpW65W+gjBZYMO5dwZGGQmnfViFK4YTJ0ScPf/18u
         grSS/ZSb2vZQfDw35zgn3xdME5hLtn2SXwjhpNZnm36TtD97k7iaQhyeUcRumDc4Oe
         YrJnFmvdtXlqPgx5sNI42r8uwYwKwT5af83+42LxTjuub/W9cUChEZGTVm/vg6vpWv
         E0DEOhLq3ZK6X6Dy6bgNn5nnZISii6PY+wEiqjvYL7x98SeebmzUY/xbgDxUYapiCJ
         Vi9I+7pBEPxKgCoc+jdEfKe0x6a0qlPoPVvTk/LkBIUGr8O0OV1xBnbSSBwLBgS1z9
         8r583cZ1J1MuQ==
Date:   Thu, 28 Jul 2022 11:49:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        robh+dt@kernel.org, quic_plai@quicinc.com, bgoswami@quicinc.com,
        perex@perex.cz, tiwai@suse.com, srinivas.kandagatla@linaro.org,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] ASoC: qcom: SC7280: Add support for external DMIC bias
 supply
Message-ID: <YuJpxSuPBB++pl/o@sirena.org.uk>
References: <1658992233-28372-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="19Amlz8gj2K5TooV"
Content-Disposition: inline
In-Reply-To: <1658992233-28372-1-git-send-email-quic_srivasam@quicinc.com>
X-Cookie: People respond to people who respond.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--19Amlz8gj2K5TooV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 28, 2022 at 12:40:33PM +0530, Srinivasa Rao Mandadapu wrote:

> +static int sc7280_dmic_micbias(struct snd_soc_dapm_widget *w,

> +				struct snd_kcontrol *kcontrol, int event)
> +{
> +	struct snd_soc_card *card = w->dapm->card;
> +	struct sc7280_snd_data *data = snd_soc_card_get_drvdata(card);
> +	int ret = 0;
> +

This is open coding SND_SOC_DAPM_REGULATOR_SUPPLY() isn't it?

--19Amlz8gj2K5TooV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLiacQACgkQJNaLcl1U
h9C81gf9Ga+tG1jtopYoO2vybAFTSEv9+weEyQYVfWYlV/dr54/mFfs5thvXdkQy
C4ZHp1P2Pvc0Zz21fKPITIZ/oUJvMHAFsUN1OvD5QDn9tXyn3QTYjnQvxuKYC9iF
QuwAqQClFBn+VdUNev78ZC8alwfezPpz3RfFVHg6gO22v9w+tsOe6YPeZYU915is
0jI/vXl4PYcb7PYgYp7k0Uyr7wdU8Ju6z9HqRC2KRhwasNRZjndt6XRfGF2QpybG
VOQtO49CDUOLxdDtNfC+hu25oeI4Hi+1WVVpHxmKtzLHlraQkbRf9C94jSyS75qa
4h/gpJnIHzoUwOmrWzLg3ZS8L/vGyA==
=k9u9
-----END PGP SIGNATURE-----

--19Amlz8gj2K5TooV--
