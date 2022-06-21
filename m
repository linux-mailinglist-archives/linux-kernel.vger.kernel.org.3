Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61CDF553AC4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 21:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354133AbiFUTsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 15:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353438AbiFUTsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 15:48:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCA065A6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 12:48:24 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3jr3-0004Tn-Ml; Tue, 21 Jun 2022 21:48:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3jqu-001tMQ-OO; Tue, 21 Jun 2022 21:47:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o3jqv-000Gjf-G8; Tue, 21 Jun 2022 21:47:57 +0200
Date:   Tue, 21 Jun 2022 21:47:57 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Jiang Jian <jiangjian@cdjrlc.com>
Cc:     tsbogend@alpha.franken.de, srinivas.kandagatla@linaro.org,
        rafael@kernel.org, sudeep.holla@arm.com,
        alexandre.belloni@bootlin.com, xkernel.wang@foxmail.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: sgi-ip22: Remove duplicate 'of' in two places.
Message-ID: <20220621194757.ay4z6bbwev7ibggs@pengutronix.de>
References: <20220621162114.23723-1-jiangjian@cdjrlc.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s4a723nibkbfrw2k"
Content-Disposition: inline
In-Reply-To: <20220621162114.23723-1-jiangjian@cdjrlc.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s4a723nibkbfrw2k
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The Subject speaks about two places, there is only one change here
however?

On Wed, Jun 22, 2022 at 12:21:14AM +0800, Jiang Jian wrote:
> file: ./arch/mips/sgi-ip22/ip22-gio.c
> line: 44
>   * @ids: array of of device match structures to search in
> changed to
>   * @ids: array of device match structures to search in

I know writing a sensible commit log is hard, but this is really very
useless. This is a plain repetition of the diff below.

Additionally I'm not sure the patch is right. The comment speaks about
of (=3D open firmware) devices. So if you want to improve here, maybe make
it read

+ * @match: array gio_device_id structures to search in

But please double check this is indeed sensible; I didn't.

(But yes, @ids is wrong, the parameter is named match.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--s4a723nibkbfrw2k
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKyIGoACgkQwfwUeK3K
7AmWRAf9GbhbYFWPzdOQIDbXFeD1he67uvEGsTTtcwrsgq8b1KGkXdzVvxLwlm2p
qUSDzZ3aS+jP/ScaLCkO3FRo/LfliAPKI6a26M/SeZf2F0jnNUjqcbDyQ7kjFbx2
eJ4dzoG7VBWe5GZfRxwzCjUKSVqUENqyCX85tMpo8cA0Jvv1lQcJSWz+kvrHUaiI
00cEWRsCOFCJPFRgUbu9yUQpKr+Hc6s9ahlTq4G+Ato63IeYtPV8wcqfD8gg7BuX
So6/w0bOfN8LCfUZ2pAHBC7ssoTPRgjcpjIL9hxGwWKk3Xr1qjkMJcn+xKdbTTCx
OitQ5aizcuZxM9yeP6uAwzFLFGygMg==
=jxEL
-----END PGP SIGNATURE-----

--s4a723nibkbfrw2k--
