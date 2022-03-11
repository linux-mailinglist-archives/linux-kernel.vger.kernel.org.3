Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0684D6765
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350677AbiCKRSS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350669AbiCKRSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:18:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C0F1C65C8;
        Fri, 11 Mar 2022 09:17:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6FE5B82854;
        Fri, 11 Mar 2022 17:17:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3049DC340F4;
        Fri, 11 Mar 2022 17:17:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647019023;
        bh=443SiYGJGUDaMgpUN+vix0hHpSMSvx4CLDcgACriZt0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uu5+tGzYAjUd7aKyPyz734orEl9bVHujIe/+7Bo9jR0kAOE27Kl2UJRQk8Ld24pRF
         ej8rmZOZzlHI58r1gyCGmlRH10ITP6M+gIZN0yujTAg9GcdP0C/dYsqN3g8+cPTASs
         rJKnGVycgSVxaV2JJMjDiaO24qZlvQ2vxkJNVWRDyay6u+0zr1fRS3/FAsaUmNEE1w
         7a9ynvFrgKpHqDsZidhlTtEhSMSWybAjMaoCoHLQeTcFPi6wUMEV2HdOpU9JufGlt6
         d5p2LR0Mk1UdCanpOlclbk1qSbGMDwZXysxKCKDTrVxanATa9xTFslNthHcHs6wcDZ
         h8/o//sAF+VWw==
Date:   Fri, 11 Mar 2022 17:16:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Alifer Moraes <alifer.m@variscite.com>
Cc:     linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, eran.m@variscite.com,
        festevam@gmail.com, lgirdwood@gmail.com,
        linuxppc-dev@lists.ozlabs.org, nicoleotsuka@gmail.com,
        patches@opensource.cirrus.com, perex@perex.cz,
        pierluigi.p@variscite.com, robh+dt@kernel.org,
        shengjiu.wang@gmail.com, tiwai@suse.com, Xiubo.Lee@gmail.com
Subject: Re: [PATCH 1/4] ASoC: fsl-asoc-card: add WM8904 support
Message-ID: <YiuECMoS3S54dfeF@sirena.org.uk>
References: <20220307141041.27538-1-alifer.m@variscite.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b8SEATCHD1iXnOvu"
Content-Disposition: inline
In-Reply-To: <20220307141041.27538-1-alifer.m@variscite.com>
X-Cookie: PIZZA!!
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--b8SEATCHD1iXnOvu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 07, 2022 at 11:10:38AM -0300, Alifer Moraes wrote:
> From: Pierluigi Passaro <pierluigi.p@variscite.com>
>=20
> The codec WM8904 can use internal FLL as PLL source.
> Whenever the PLL source is not an external MCLK, this source
> must be setup during hw_params callback otherwise the BCLK
> could be wrongly evaluated.
> The SND_SOC_BIAS_PREPARE event is raised after the hw_params
> callback, so there is no need to set again PLL and SYSCLK and
> actually there's no need at all the set_bias_level function.
> Also, when esai is used, a dedicated snd_soc_dai_set_tdm_slot

> Signed-off by: Alifer Moraes <alifer.m@variscite.com>
>=20
> Signed-off-by: Pierluigi Passaro <pierluigi.p@variscite.com>

When you're sending a mail your signoff should come at the end of the
chain of signoffs - see submitting-patches.rst for details.

This breaks an arm64 defconfig build:

/mnt/kernel/sound/soc/fsl/fsl-asoc-card.c: In function 'fsl_asoc_card_hw_fr=
ee':
/mnt/kernel/sound/soc/fsl/fsl-asoc-card.c:265:37: error: 'struct snd_soc_pc=
m_runtime' has no member named 'cpu_dai'
  265 |   ret =3D snd_soc_dai_set_tdm_slot(rtd->cpu_dai, 0, 0, 2,
      |                                     ^~
/mnt/kernel/sound/soc/fsl/fsl-asoc-card.c:266:35: error: 'params' undeclare=
d (first use in this function); did you mean 'parameq'?
  266 |             params_physical_width(params));
      |                                   ^~~~~~
      |                                   parameq
/mnt/kernel/sound/soc/fsl/fsl-asoc-card.c:266:35: note: each undeclared ide=
ntifier is reported only once for each function it appears in


--b8SEATCHD1iXnOvu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmIrhAcACgkQJNaLcl1U
h9CnVgf/Wr9SUVAFGV9OWF89sPv7dvpJRJTpALOk5PGWPIvkKsyMl54WVqeNMbb5
aRfcFiNedP7SPyS9WJlGAt7MOa3mSG9qaFM1EkPJhLcQ5Bx1MGOEmAPt+lIuXTMz
janQOk3NRv6wUBzS+RtQET2qCcjHkhLXJl24gvWoEQUX/qChPB3+Es3UBOkbIHWC
Zxx/O6wQZVPqsYzoqUoDQAXlXrIrvYSwEsJXFNptivsOxr/ZkmZQWEIZ12FsnRQF
wW1RquHMD1cr2Fx4CC9Yq8i9lgzJWFzd+k3+74c70kiHQXUJpXwdHVfIjZAvaAjk
Shq9tKOFh/8wv7exJK4Dd+n/1PZPkg==
=UvIJ
-----END PGP SIGNATURE-----

--b8SEATCHD1iXnOvu--
