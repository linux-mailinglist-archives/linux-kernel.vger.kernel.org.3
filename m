Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8C157D446
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGUThO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbiGUThK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:37:10 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB0EA3D5B6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:36:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4E2E3CE2729
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 19:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A71C3411E;
        Thu, 21 Jul 2022 19:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658432213;
        bh=6OaPjad8CpsXAI8nFwTOIOEWRf/cBjv265th+xKGvYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nmEjm9lxx24PzeOfyU7zOSG116WbulTXHfHMwKjjfMnJj57hfV52XWDqMi7ilNp/F
         fXN730jr9EKoKIyw25PIA0ZNUqP/Ls4qOliwI/CiZyxfXduydDw7/YzTSZS0qz8kzs
         +AcEI1SbselOAdiITdwH3gROf1s8mSK7gsjSvpwo5W4vYrcLE1eyQIJwbN+VzZlWm5
         bG5IJG1lL3QH0gwa2zmIgWPoX6OQHE5NZ3IWY3rsxgkyk2Tf07R8O2bQz8O/9kPWAb
         MoHmWRaEh0jZbt5uwnHLwO7kHyXfbEh4qJYY3C5ntGVa92k8BhhEN3ixWztBV2DITf
         xxP0AjSe3xvog==
Date:   Thu, 21 Jul 2022 20:36:46 +0100
From:   Mark Brown <broonie@kernel.org>
To:     syed sabakareem <Syed.SabaKareem@amd.com>
Cc:     alsa-devel@alsa-project.org, Alexander.Deucher@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        vijendar.mukunda@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Julian Braha <julianbraha@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bard Liao <bard.liao@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 5/5] ASoC: amd: enable RPL Platform acp drivers build
Message-ID: <YtmqzkUjhKDIg0d2@sirena.org.uk>
References: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
 <20220721061035.91139-5-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LCMckrGGq+4TFFQ6"
Content-Disposition: inline
In-Reply-To: <20220721061035.91139-5-Syed.SabaKareem@amd.com>
X-Cookie: Your domestic life may be harmonious.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LCMckrGGq+4TFFQ6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 11:40:02AM +0530, syed sabakareem wrote:
> From: Syed Saba Kareem <Syed.SabaKareem@amd.com>
>=20
> RPL Platform drivers can be built by selecting necessary
> kernel config option.
> The patch enables build support of the same.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/amd/acp/acp-platform.c: In function =E2=80=98i=
2s_irq_handle
r=E2=80=99:
/build/stage/linux/sound/soc/amd/acp/acp-platform.c:108:31: error: =E2=80=
=98struct acp_d
ev_data=E2=80=99 has no member named =E2=80=98stream=E2=80=99
  108 |                 stream =3D adata->stream[i];
      |                               ^~

--LCMckrGGq+4TFFQ6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZqs0ACgkQJNaLcl1U
h9B+sAf/Tzx8Dke3d/kShh/tPQ6OdU0qFsfYj5h7Z+hzW5NGEPPZpM7yYU9cXLoE
lfOcUlb/f7v8KotWgP5t39yVmEgKnAN0jIDJIyq6LH4sopnkCiaW0X4Lok8qiOYn
fbwdsWdbIvxIhGxTKDDWykpg6+u/wopxx1hmbCcru0+gImlZZp64D5C4r260jvgT
XPHXwvMjO46uo7GSmPX/NEbFKyBZgkGX8MeN3JA8WVu/rvjPxsDjlGtIY39b/8x8
wdX9dlCMqeQcgYDBvl15VGcg1UdjHkfFCM8wP4xIpOIPQr3KFQXtyZWAtBcmknqy
QZd7KK4NuOFEECRmZ5zv9cAMlGugvg==
=tJCh
-----END PGP SIGNATURE-----

--LCMckrGGq+4TFFQ6--
