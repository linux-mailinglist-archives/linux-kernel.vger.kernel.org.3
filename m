Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B722546BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 19:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347082AbiFJRrm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 13:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349720AbiFJRrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 13:47:40 -0400
Received: from 3.mo560.mail-out.ovh.net (3.mo560.mail-out.ovh.net [46.105.58.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8863256B05
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 10:47:38 -0700 (PDT)
Received: from player760.ha.ovh.net (unknown [10.109.146.131])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id A528524A4E
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 17:47:36 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player760.ha.ovh.net (Postfix) with ESMTPSA id 4E6CB2B728F28;
        Fri, 10 Jun 2022 17:47:27 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G00515216049-9e93-4894-aa40-e1df9efa6a35,
                    3EA6D779A65D7DCBA15D92F127CD72011C01B2E3) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Fri, 10 Jun 2022 19:47:20 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/3] drm/panel: panel-dsi-cm: Use backlight helpers
Message-ID: <20220610194720.485cf7be@heffalump.sk2.org>
In-Reply-To: <20220609215236.ojxw6l2vkf652hgu@mercury.elektranox.org>
References: <20220607182026.1121992-1-steve@sk2.org>
        <20220607182026.1121992-3-steve@sk2.org>
        <20220609215236.ojxw6l2vkf652hgu@mercury.elektranox.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Fiv/6RAB4w3meaj/_BS+ruP";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 9491336218715915910
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedrudduuddgudduhecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeiheevvdeugeejffefteffvefhieegjeevhfekjeejvdelgfefkeehhfdufffhjeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejiedtrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Fiv/6RAB4w3meaj/_BS+ruP
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

On Thu, 9 Jun 2022 23:52:36 +0200, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
> On Tue, Jun 07, 2022 at 08:20:25PM +0200, Stephen Kitt wrote:
> > diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c
> > b/drivers/gpu/drm/panel/panel-dsi-cm.c index b58cb064975f..aa36dc6cedd3
> > 100644 --- a/drivers/gpu/drm/panel/panel-dsi-cm.c
> > +++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
> > @@ -86,16 +86,10 @@ static void dsicm_bl_power(struct panel_drv_data
> > *ddata, bool enable) return;
> > =20
> >  	if (enable) {
> > -		backlight->props.fb_blank =3D FB_BLANK_UNBLANK;
> > -		backlight->props.state =3D ~(BL_CORE_FBBLANK |
> > BL_CORE_SUSPENDED);
> > -		backlight->props.power =3D FB_BLANK_UNBLANK;
> > +		backlight_enable(backlight);
> >  	} else {
> > -		backlight->props.fb_blank =3D FB_BLANK_NORMAL;
> > -		backlight->props.power =3D FB_BLANK_POWERDOWN;
> > -		backlight->props.state |=3D BL_CORE_FBBLANK |
> > BL_CORE_SUSPENDED;
> > +		backlight_disable(backlight);
> >  	} =20
>=20
> The brackets can be removed now. Otherwise:

>=20
> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>

Thanks, I=E2=80=99ll wait a little more to see if there are any other revie=
ws of the
patches and then push a v2 with that fix.

Regards,

Stephen

--Sig_/Fiv/6RAB4w3meaj/_BS+ruP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmKjg6gACgkQgNMC9Yht
g5zfSw//WI01jNuYSP0lMjDjiVPi3dZknMK/1vgV6zHCgisK5W9RahwyjRdg9hWW
veSzZA4xLOVHS1WpSEcsQWSRCTAoi22tZ/IhGVFTW9hpWkKUzndtuebMzQ5LuEwq
gP/c6sU3O5qP2tjMyUwDs8zAEugZl6hlcZGtkYdZUk50gUsP2ajEJ2XjblIkikEn
JskElLBZSpvBS06TzHphA7DZZW1B/GjkucvmM6vOVklRtkxbCYck7E2PCM1uPe6x
8U7pacTwdvzdf0j255cSxb6xehc1wTDKCelVrp9VcXyI1PiZb6nzW4+xSE/JF+iZ
Kyrrw8Iuom5Zwr0SlPszmdk8HiKpj+DLRugmH0fHksHAxb09L77zSZZ3krUefXrF
2A7g0AAXxy7OEZtCJyLHPiSL3Q9EHQ3FtzLH+3xddratrbdzjnbq+kPA37GqfWTk
qNo0zrCK4o2E2GFAzZf08Hg6FT5o/4LnYPZikTfmOiOYyBR5FGW2nl2AyoH3WdZC
EfzICSO2fB0i3miIcpTOH+YRJU5G0Ih1acm8FK/1x8A/GSPG/wY0juQMS9Zzkq3Q
FlsH13MKT+fqlTDwf2wl8hF5ESklSJ90CTKITJTxZiWHLkKeKIZ2l8ll5o4qg4jt
O5Rj0KaoPq+pkrIwj0Y//PlpPOd8d/X4pYuct2ujiPXp7pkaHLM=
=9bxl
-----END PGP SIGNATURE-----

--Sig_/Fiv/6RAB4w3meaj/_BS+ruP--
