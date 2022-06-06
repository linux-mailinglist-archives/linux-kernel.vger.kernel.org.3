Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 979B153EA85
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241352AbiFFQIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241219AbiFFQIp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:08:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC8C19FA4;
        Mon,  6 Jun 2022 09:08:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC40BB81A87;
        Mon,  6 Jun 2022 16:08:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B34DC385A9;
        Mon,  6 Jun 2022 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654531721;
        bh=VcnSGVYbTblm760SjoQqgE9wkQ5/rRfgycH6HwRHJBc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=V+beBwDxRnKh4QQe2VqHO65haLEa4SFcYqmwQ5ha8+WUYCaxluVJVO3WScGsMh7p/
         yCfF9SVghYkLIH6xbuY7EblAx0+pw2kCeFY+U8r5aYiYId7tg1gWkBet3TOBYGLIQT
         PcGrSh8CCrUG5ygkR02Frlr2vLWxWu4elm2N6km6BG/SAlnAB2hA9vt/LQe6X0dQsB
         l9+KnyRf/Tk2tZ0WgxX6uJlruPDsrpmtYtQVC3nbp0WKqm9tlPjhyXCBWfx3JGBLic
         6DN4asOH0MIrEIiwReQNoKx9++AZ6UztiGOM76QW95uzWgz6z9uoC1ZFVsS5+hc9Y0
         yB6c3lFfV6NaA==
Date:   Mon, 6 Jun 2022 17:08:35 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jiaxin Yu <jiaxin.yu@mediatek.com>
Cc:     robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        aaronyu@google.com, matthias.bgg@gmail.com, trevor.wu@mediatek.com,
        tzungbi@google.com, julianbraha@gmail.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v5 19/20] ASoC: mediatek: mt8186: add machine driver with
 mt6366, rt1019 and rt5682s
Message-ID: <Yp4mg3ObzfQJ3FgP@sirena.org.uk>
References: <20220523132858.22166-1-jiaxin.yu@mediatek.com>
 <20220523132858.22166-20-jiaxin.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="9rL9qmwu0rrfH0q3"
Content-Disposition: inline
In-Reply-To: <20220523132858.22166-20-jiaxin.yu@mediatek.com>
X-Cookie: Zeus gave Leda the bird.
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9rL9qmwu0rrfH0q3
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 23, 2022 at 09:28:57PM +0800, Jiaxin Yu wrote:
> Add support for mt8186 board with mt6366, rt1019 and rt5682s.
>=20
> Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>

This breaks an x86 allmodconfig build:

/build/stage/linux/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.=
c: In function =E2=80=98mt8186_da7219_init=E2=80=99:
/build/stage/linux/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.=
c:58:15: error: too many arguments to function =E2=80=98snd_soc_card_jack_n=
ew=E2=80=99
   58 |         ret =3D snd_soc_card_jack_new(rtd->card, "Headset Jack",
      |               ^~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/include/sound/soc.h:1362,
                 from /build/stage/linux/sound/soc/mediatek/mt8186/mt8186-m=
t6366-da7219-max98357.c:15:
/build/stage/linux/include/sound/soc-card.h:18:5: note: declared here
   18 | int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id=
, int type,
      |     ^~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.=
c: In function =E2=80=98mt8186_mt6366_da7219_max98357_hdmi_init=E2=80=99:
/build/stage/linux/sound/soc/mediatek/mt8186/mt8186-mt6366-da7219-max98357.=
c:161:15: error: too many arguments to function =E2=80=98snd_soc_card_jack_=
new=E2=80=99
  161 |         ret =3D snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_J=
ACK_LINEOUT,
      |               ^~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/include/sound/soc.h:1362,
                 from /build/stage/linux/sound/soc/mediatek/mt8186/mt8186-m=
t6366-da7219-max98357.c:15:
/build/stage/linux/include/sound/soc-card.h:18:5: note: declared here
   18 | int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id=
, int type,
      |     ^~~~~~~~~~~~~~~~~~~~~
make[5]: *** [/build/stage/linux/scripts/Makefile.build:249: sound/soc/medi=
atek/mt8186/mt8186-mt6366-da7219-max98357.o] Error 1
/build/stage/linux/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c=
: In function =E2=80=98mt8186_rt5682s_init=E2=80=99:
/build/stage/linux/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c=
:61:15: error: too many arguments to function =E2=80=98snd_soc_card_jack_ne=
w=E2=80=99
   61 |         ret =3D snd_soc_card_jack_new(rtd->card, "Headset Jack",
      |               ^~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/include/sound/soc.h:1362,
                 from /build/stage/linux/sound/soc/mediatek/mt8186/mt8186-m=
t6366-rt1019-rt5682s.c:17:
/build/stage/linux/include/sound/soc-card.h:18:5: note: declared here
   18 | int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id=
, int type,
      |     ^~~~~~~~~~~~~~~~~~~~~
/build/stage/linux/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c=
: In function =E2=80=98mt8186_mt6366_rt1019_rt5682s_hdmi_init=E2=80=99:
/build/stage/linux/sound/soc/mediatek/mt8186/mt8186-mt6366-rt1019-rt5682s.c=
:137:15: error: too many arguments to function =E2=80=98snd_soc_card_jack_n=
ew=E2=80=99
  137 |         ret =3D snd_soc_card_jack_new(rtd->card, "HDMI Jack", SND_J=
ACK_LINEOUT,
      |               ^~~~~~~~~~~~~~~~~~~~~
In file included from /build/stage/linux/include/sound/soc.h:1362,
                 from /build/stage/linux/sound/soc/mediatek/mt8186/mt8186-m=
t6366-rt1019-rt5682s.c:17:
/build/stage/linux/include/sound/soc-card.h:18:5: note: declared here
   18 | int snd_soc_card_jack_new(struct snd_soc_card *card, const char *id=
, int type,
      |     ^~~~~~~~~~~~~~~~~~~~~
make[5]: *** [/build/stage/linux/scripts/Makefile.build:249: sound/soc/medi=
atek/mt8186/mt8186-mt6366-rt1019-rt5682s.o] Error 1

--9rL9qmwu0rrfH0q3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmKeJoIACgkQJNaLcl1U
h9CFwgf9G5LGVON0H/dhjgLQ816wyvWWAsYE0+WxJJpawHUSAJG6kzTYC82FZhmg
sKZTDn6T5jUPGtP/wzWpE+EzcUyUds+Uo6QzoZ4rqzYCEid76p5sksmT5oGdmn8R
HaQSkTKIWF6OprneORmZda8SBV+UcpqScD8irzR1x5V/ZAxo7BRqfOw3ZiTcz8Ru
RgJf+UcRdUoECGjsxBl0yA4BLMfk6Bt8SDPr/KG5J4mkdFxzRwZCz68nyWdt0CFE
FDU1KIBy/P0Oy5eyMdw1n+gT63rWT2swrBcjfanH+HML8cj4Yo63Fl7wMxA1C+WN
ZB/b3z4o7yvK/wM7PbzvknzAm0536w==
=91r5
-----END PGP SIGNATURE-----

--9rL9qmwu0rrfH0q3--
