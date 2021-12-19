Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F249B47A16D
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 17:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbhLSQtJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 11:49:09 -0500
Received: from jabberwock.ucw.cz ([46.255.230.98]:36502 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbhLSQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 11:49:08 -0500
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 7FDB01C0B76; Sun, 19 Dec 2021 17:49:06 +0100 (CET)
Date:   Sun, 19 Dec 2021 17:49:03 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Henning Schild <henning.schild@siemens.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Srikanth Krishnakar <skrishnakar@gmail.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Mark Gross <mgross@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Enrico Weigelt <lkml@metux.net>
Subject: Re: [PATCH v5 2/4] leds: simatic-ipc-leds: add new driver for
 Siemens Industial PCs
Message-ID: <20211219164903.GB28481@duo.ucw.cz>
References: <20211213120502.20661-1-henning.schild@siemens.com>
 <20211213120502.20661-3-henning.schild@siemens.com>
 <20211215201800.GA28336@duo.ucw.cz>
 <61983e62-bc3d-a711-c197-7436a2e33531@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Content-Disposition: inline
In-Reply-To: <61983e62-bc3d-a711-c197-7436a2e33531@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2021-12-15 21:53:56, Hans de Goede wrote:
> Hi,
>=20
> On 12/15/21 21:18, Pavel Machek wrote:
> > On Mon 2021-12-13 13:05:00, Henning Schild wrote:
> >> This driver adds initial support for several devices from Siemens. It =
is
> >> based on a platform driver introduced in an earlier commit.
> >>
> >> One of the supported machines has GPIO connected LEDs, here we poke GP=
IO
> >> memory directly because pinctrl does not come up.
> >>
> >> Signed-off-by: Henning Schild <henning.schild@siemens.com>
> >=20
> > Acked-by: Pavel Machek <pavel@ucw.cz>
>=20
> I see that this patch #includes linux/platform_data/x86/simatic-ipc-base.h
> which gets added by patch 1/4.
>=20
> Pavel, can I take this patch upstream through the pdx86 tree (with you Ack
> added)? Or shall I prepare an immutable branch with patch 1 for you to
> merge ?

Yes, you can.


> >> +
> >> +static struct simatic_ipc_led simatic_ipc_leds_io[] =3D {
> >> +	{1 << 15, "green:" LED_FUNCTION_STATUS "-1" },
> >> +	{1 << 7,  "yellow:" LED_FUNCTION_STATUS "-1" },
> >> +	{1 << 14, "red:" LED_FUNCTION_STATUS "-2" },
> >> +	{1 << 6,  "yellow:" LED_FUNCTION_STATUS "-2" },
> >> +	{1 << 13, "red:" LED_FUNCTION_STATUS "-3" },
> >> +	{1 << 5,  "yellow:" LED_FUNCTION_STATUS "-3" },
> >> +	{ }
> >> +};

But I'd still like better naming than red:status-2.
								Pavel
--=20
http://www.livejournal.com/~pavelmachek

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYb9ifwAKCRAw5/Bqldv6
8uHWAKCgQYszzwybvqBi37R/5FoZwIsNnACdF3E0kvypS03RTx/lJKhUyQrq0yg=
=pLhL
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
