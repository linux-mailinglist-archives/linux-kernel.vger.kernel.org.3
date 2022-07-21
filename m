Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFCA57D6CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 00:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbiGUWVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 18:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233866AbiGUWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 18:21:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D5495C18
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 15:21:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB0F961DB0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 22:21:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D09CC341CE;
        Thu, 21 Jul 2022 22:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658442078;
        bh=WhB1PD1kMyLRf+42xJ1wMh8BKbH3xsmCONTEx0+eMh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BEZ+jC0rJiVM+zeUWTx6V2ftRHpCjVGuE2uRsAyTcxM5rv/coRx4w90PZ8fReg8tg
         blGghO+x7ozDoMwI15kEx5/XuOSO6k2ta02eqRqazL3PVazjiJLjKWytT6yYBjg5J+
         YUlxbybDmg7HJH3qJlLOMcTIE2JPLVCbqk0fbmUDiOjVGks+zTK1OUhIhuNr6f1S5P
         P9TV03QOzXRoHybEa4TJqop8MuQ3WifqEM5VkjcsPi131EdS8FV/7b1XpaymqvUy6I
         LTYzlF8sIOHkfnDj1Nw4N/PyI8HpZAgjidS+k06pNZkcuKxO0MiwoaL2Owkw3ut7bx
         8UuEpfVNBQZag==
Date:   Thu, 21 Jul 2022 23:21:11 +0100
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
Message-ID: <YtnRV4qQoUkLN552@sirena.org.uk>
References: <20220721061035.91139-1-Syed.SabaKareem@amd.com>
 <20220721061035.91139-5-Syed.SabaKareem@amd.com>
 <YtmqzkUjhKDIg0d2@sirena.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="oOv3QA6AufJZt5bU"
Content-Disposition: inline
In-Reply-To: <YtmqzkUjhKDIg0d2@sirena.org.uk>
X-Cookie: Do not pick the flowers.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oOv3QA6AufJZt5bU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 21, 2022 at 08:36:53PM +0100, Mark Brown wrote:
> On Thu, Jul 21, 2022 at 11:40:02AM +0530, syed sabakareem wrote:
> > From: Syed Saba Kareem <Syed.SabaKareem@amd.com>
> >=20
> > RPL Platform drivers can be built by selecting necessary
> > kernel config option.
> > The patch enables build support of the same.
>=20
> This breaks an x86 allmodconfig build:
>=20
> /build/stage/linux/sound/soc/amd/acp/acp-platform.c: In function =E2=80=
=98i2s_irq_handle
> r=E2=80=99:
> /build/stage/linux/sound/soc/amd/acp/acp-platform.c:108:31: error: =E2=80=
=98struct acp_d
> ev_data=E2=80=99 has no member named =E2=80=98stream=E2=80=99
>   108 |                 stream =3D adata->stream[i];
>       |                               ^~

Sorry, this was actually a different commit earlier in the branch
triggering this.

--oOv3QA6AufJZt5bU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLZ0VYACgkQJNaLcl1U
h9C4qwf+LvXEf1DhkBwwKhCvfZyKKK9YVzwpry417epDVJnvaorf84Y6FyGJjm6D
x++atMwrYkY8N6Ro0ls3a8jmHBlozUs8m0uJ9Hlo7k81zANGPzZ5Pyb6VDrdVM/r
js1NVEvqRu3inNtQQjLu5UjcXISHBUjOWzMVSEfCQ5K2cDklTaItFviXX7ZtA9Fj
KkE+cmaj5EOk1y5h0MRBITwfeFYcgAm7pviqPzKpXi+h8n2ycutgCjdRztB5C33Q
bjN0YODYLtm5EinD8u2h+mWk9VmDDmY/t8SrpJ4PE126FsKL2icNoo7sazfHyIiY
rmdtIVCRSeF7t7Ynvdc1Gf4Z0aYPLA==
=ujmp
-----END PGP SIGNATURE-----

--oOv3QA6AufJZt5bU--
