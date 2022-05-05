Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165D851BA79
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349229AbiEEIds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344233AbiEEIdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:33:44 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413C0488AC;
        Thu,  5 May 2022 01:29:58 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 0A1071C0BA6; Thu,  5 May 2022 10:29:57 +0200 (CEST)
Date:   Thu, 5 May 2022 10:29:56 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Manuel =?iso-8859-1?Q?Sch=F6nlaub?= <manuel.schoenlaub@gmail.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Filipe =?iso-8859-1?Q?La=EDns?= <lains@riseup.net>,
        jikos@kernel.org, benjamin.tissoires@redhat.com,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: logitech-hidpp: support Color LED feature (8071).
Message-ID: <20220505082956.GB14065@duo.ucw.cz>
References: <Yifr4etBFPu1a2Ct@hermes>
 <275245e8048fa124055d9ff3d10ce6562294483a.camel@riseup.net>
 <ce3adf7013ba01aad54fb65bf9c657dd9d0b7d23.camel@hadess.net>
 <YjvlQrvRS+ZKNbZ5@hermes>
 <5b842bd4f8d17e5ecb8e7972637dbe7ad50060ac.camel@hadess.net>
 <YjyX2q1IXeJQ2LGG@hermes>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <YjyX2q1IXeJQ2LGG@hermes>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ZoaI/ZTpAVc4A5k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> Yeah the SetBrightness in systemd / logind should work out of box.
>=20
> Though I just noticed something: For this to be useful, the default
> multi_intensity for each component of the multicolor LED in the kernel sh=
ould be set to
> max_brightness, effectively producing white (on RGB LEDs at least).

Agreed we should have multi_intensity set to something nonzero. Note
that max on all channels may not result in white.

> Now there are three solutions:
>=20
> 1) Naming the Logitech LEDs <device>:rgb:kbd_backlight-N even on mice
> and at some point send a patch to systemd adapting the udev rules to
> care for devices with nuemrical suffixes.
>=20
> 2) Naming the LEDs <device>:rgb:backlight-N and send a patch to systemd
> adding a new udev rule to cater for backlight LEDs in general.

If it is known to be mouse, use mouse_backlight or something like
that. Just document it so that others use same string.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnOLBAAKCRAw5/Bqldv6
8il+AJ9edp4VRLJO5Wk6Es98eUiFbkB1uQCfd9nOb4SI6MQNXEH6mcwK2y4zygM=
=kRHT
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
