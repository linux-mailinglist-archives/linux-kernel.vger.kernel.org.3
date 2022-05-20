Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DCD52EC6E
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 14:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346098AbiETMmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 08:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349600AbiETMm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 08:42:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B4A16647D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 05:41:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47BA760F84
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 12:41:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1601DC385A9;
        Fri, 20 May 2022 12:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653050516;
        bh=YTSPkgizOL4W7LCBZDtItpCzMG0NI7atPraoBzO31lE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Bs9TH57JxrUxnFTqhxwoioJG4z9M8pwS8Oe3EmUEQerc2sYvLs1JNdvDtYJJ5+IDz
         qV0QYbgsN/VLqxq9JPwed6ss1Zk4D3hM/G1BxaHK7IS3BhGYbi4GCGcr3C3QriAzUF
         vG0Qvkx7aB5Pfnrw491KrbxiS3+IA0NLy07QRjz2vZUcwvVVJZUWydIPo5CdQ/WiCd
         FqPrUCOJ5G5F42fqq+7hB2coKDXB4PpVbJIZzYUD8XkluuPmIUtOVu65Zr2429LzSY
         7NWuMW/VLaekuh6CGLiuERrvR+JrD5I1948xhUm+N7z50AG5fBLY+yjlkj0V1i8OpS
         eW+f8GIomXBkA==
Date:   Fri, 20 May 2022 13:41:49 +0100
From:   Mark Brown <broonie@kernel.org>
To:     V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>
Cc:     alsa-devel@alsa-project.org, Vijendar.Mukunda@amd.com,
        Basavaraj.Hiregoudar@amd.com, Sunil-kumar.Dommati@amd.com,
        ajitkumar.pandey@amd.com, Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Akihiko Odaki <akihiko.odaki@gmail.com>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Bard Liao <bard.liao@intel.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] ASoC: amd: acp: Add support for nau8825 and
 max98360 card
Message-ID: <YoeMjUJjOzDTOtbM@sirena.org.uk>
References: <20220519055522.1613813-1-Vsujithkumar.Reddy@amd.com>
 <20220519055522.1613813-2-Vsujithkumar.Reddy@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="T2P481YcpmerEUHv"
Content-Disposition: inline
In-Reply-To: <20220519055522.1613813-2-Vsujithkumar.Reddy@amd.com>
X-Cookie: Driver does not carry cash.
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--T2P481YcpmerEUHv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 19, 2022 at 11:25:21AM +0530, V sujith kumar Reddy wrote:
> We have new platform with nau8825 as a primary codec and max98360 as an
> amp codec. Add machine struct to register sof audio based sound card
> on such Chrome machine.

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/amd/acp/acp-mach-common.c: In function =E2=80=
=98acp_card_nau8825_init=E2=80=99:
/build/stage/linux/sound/soc/amd/acp/acp-mach-common.c:479:15: error: too m=
any arguments to function =E2=80=98snd_soc_card_jack_new=E2=80=99
  479 |         ret =3D snd_soc_card_jack_new(card, "Headset Jack",
      |               ^~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/include/sound/soc.h:1362,
                 from /build/stage/linux/sound/soc/amd/acp/acp-mach-common.=
c:20:
/build/stage/linux/include/sound/soc-card.h:18:5: note: declared here
   18 | int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id=
, int type,
      |     ^~~~~~~~~~~~~~~~~~~~~
make[5]: *** [/build/stage/linux/scripts/Makefile.build:288: sound/soc/amd/=
acp/acp-mach-common.o] Error 1
make[5]: Target '__build' not remade because of errors.
make[4]: *** [/build/stage/linux/scripts/Makefile.build:550: sound/soc/amd/=
acp] Error 2
make[4]: Target '__build' not remade because of errors.
make[3]: *** [/build/stage/linux/scripts/Makefile.build:550: sound/soc/amd]=
 Error 2
make[3]: Target '__build' not remade because of errors.
make[2]: *** [/build/stage/linux/scripts/Makefile.build:550: sound/soc] Err=
or 2
make[2]: Target '__build' not remade because of errors.
make[1]: *** [/build/stage/linux/Makefile:1834: sound] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:219: __sub-make] Error 2
make: Target '__all' not remade because of errors.
make --silent --keep-going --jobs=3D14 O=3D/tmp/build-work INSTALL_MOD_STRI=
P=3D1 INSTALL_MOD_PATH=3D/tmp/build-work/modinstall ARCH=3Dx86_64 CROSS_COM=
PILE=3Dx86_64-linux-gnu- modules_install
sed: can't read modules.order: No such file or directory
make[1]: *** [/build/stage/linux/Makefile:1467: __modinst_pre] Error 2
make[1]: Target 'modules_install' not remade because of errors.
make: *** [Makefile:219: __sub-make] Error 2
make: Target 'modules_install' not remade because of errors.

--T2P481YcpmerEUHv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKHjIwACgkQJNaLcl1U
h9DS7Af+NaA0kEk6Pz/LFvpVhZ8s9UWwsne4neS/3i1TgAbX+/D/grVXyXB+bgl6
b2ETIdiJSDR/eYGPfYKOZSooH6O1luCEuNMnH3uTUS5eFX37PaWXGTw7/cOIsLIy
TV1L0jMYwVeKx1yfqbevmq04KE82PAgVSmo1BAUcmwt+sQpsLI34PQBmEEj1zzLd
nYY1wMWkQnRV7LUqfwCR+XgAC40OMoPB4sO7rPfuUDQdrG3mc3/3bllkkWJ0Nala
VkfKxZVkU+WapPyE9JB2tc/u4FVlzJJtX/k23KypZT9WDKb4BQd8qWOxIYVr9sNI
JsIeFJUA0I9kN81ATYMfqowtTyOSjQ==
=jmOi
-----END PGP SIGNATURE-----

--T2P481YcpmerEUHv--
