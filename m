Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A1F545345
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 19:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345072AbiFIRpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 13:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344498AbiFIRpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 13:45:38 -0400
X-Greylist: delayed 166901 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 09 Jun 2022 10:45:36 PDT
Received: from 8.mo584.mail-out.ovh.net (8.mo584.mail-out.ovh.net [188.165.33.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832BE2A1D4B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 10:45:33 -0700 (PDT)
Received: from player714.ha.ovh.net (unknown [10.108.20.161])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id C37CE251D3
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:45:31 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player714.ha.ovh.net (Postfix) with ESMTPSA id CA8942B5D8553;
        Thu,  9 Jun 2022 17:45:18 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-107S0019894c42d-17cc-460a-bd58-8972ad9d0d06,
                    FB82ABC7E83112E23A0D9558C7043BAE976A9334) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
Date:   Thu, 9 Jun 2022 19:45:11 +0200
From:   Stephen Kitt <steve@sk2.org>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        linux-fbdev@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Helge Deller <deller@gmx.de>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] fbdev: atmel_lcdfb: Rework backlight status updates
Message-ID: <20220609194511.4e0bc3e6@heffalump.sk2.org>
In-Reply-To: <YqIuUYUXzxeSgZ/o@ravnborg.org>
References: <20220608205623.2106113-1-steve@sk2.org>
        <20220609095412.fccofr2e2kpzhw4t@maple.lan>
        <YqIuUYUXzxeSgZ/o@ravnborg.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EP0pO67BNhj61Y43uRPbrz_";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Ovh-Tracer-Id: 3583457929091712646
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtledgudduvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhfogggtsehgtderreertdejnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeiheevvdeugeejffefteffvefhieegjeevhfekjeejvdelgfefkeehhfdufffhjeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejudegrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekge
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EP0pO67BNhj61Y43uRPbrz_
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sam, Daniel,

On Thu, 9 Jun 2022 19:30:57 +0200, Sam Ravnborg <sam@ravnborg.org> wrote:
> thanks for taking care of all these backlight simplifications - this
> really helps to make the code simpler and more readable.

You=E2=80=99re welcome! I noticed fb_blank was deprecated and near enough u=
nused, and
started digging...

> On Thu, Jun 09, 2022 at 10:54:12AM +0100, Daniel Thompson wrote:
> > On Wed, Jun 08, 2022 at 10:56:23PM +0200, Stephen Kitt wrote: =20
> > > Instead of checking the state of various backlight_properties fields
> > > against the memorised state in atmel_lcdfb_info.bl_power,
> > > atmel_bl_update_status() should retrieve the desired state using
> > > backlight_get_brightness (which takes into account the power state,
> > > blanking etc.). This means the explicit checks using props.fb_blank
> > > and props.power can be dropped.
> > >=20
> > > Then brightness can only be negative if the backlight is on but
> > > props.brightness is negative, so the test before reading the
> > > brightness value from the hardware can be simplified to
> > > (brightness < 0). =20
> >=20
> > props.brightness should always be in the interval 0..max_brightness.
> >=20
> > This is enforced by the main backlight code (and APIs to set the
> > brightness use unsigned values). Thus props.brightness could only be
> > negative is the driver explicitly sets a negative value as some kind of
> > placeholder (which this driver does not do).
> >=20
> > I don't think there is any need to keep this logic. =20
>=20
> Daniel is right - please drop the "if (brightness < 0)" logic.
> I have looked a bit on the datasheet in my attempt to do a drm version
> of this driver - something that I am yet to succeed and the backlight
> core avoid any negative values.

Thanks for the reviews!

I=E2=80=99ve prepared a v2 without the (brightness < 0) logic, I=E2=80=99m =
about to submit
it.

Regards,

Stephen

--Sig_/EP0pO67BNhj61Y43uRPbrz_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEnPVX/hPLkMoq7x0ggNMC9Yhtg5wFAmKiMacACgkQgNMC9Yht
g5wQqA/+MORCtyNvu5ifk0jvdn5LxEz8JNduQREG75KZo5vuDLlEtsc+PmZtFJxL
uIDoVjfAwRpEkg0kw5JV7hIRg2XwkvioUC/7pTueOFQQyRvnS5gwP0NEQkPBvYyy
cQ5njUzoFibUOTWg1DDNwjuKk5x5KfCeVwTt2EVNnWQg3n+5v9c8DnZZAnNn39PU
ufwwmd9ZZ7NzEieSqtTqv1rd+YfBkQ9jE1Fk9cB143fWGMtQYbs0YXPCPsE7rclD
g+xN73lzFUDtQyHebSEiMwVu9n1OHuR9ZBXI87TjT/f7gNBFzlYzc7jDzg4RWLt7
We0YQs1pDQTFzYjgdMLrKoSNU35ZFuSge2RhZz0/Rm0cYY1CbSpLxIW2d3LDumNM
hFqRo5wIYPlZK5NW6HvTv1OeGFb7J7TI5r7zdbBtLXtnrHXK6TJ+OYp/wqldPKRx
tShQcSBb0mPXzCjhEFzM4Hovb9/JkBL0BLRlXztbsnoYPGRgebsaq9GisNEJiXjZ
ro/4Na1NzKfPijkWS9VXH9vpE5w3Xo7P7qJ43QnipRB00/Cfqup4IXPlAeoc2Z0O
r6WzrI8Ue4umFico2lazistZ1qNIgiDfRcQQRK/Brsui6U0J3WJNn+I6PS2yRiN4
TxoRbATKZXeUgX5rf4LMP/bOTxk62XRTfDfaL4qWmaJ6miTugxI=
=w0I1
-----END PGP SIGNATURE-----

--Sig_/EP0pO67BNhj61Y43uRPbrz_--
