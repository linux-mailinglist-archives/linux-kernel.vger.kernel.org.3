Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E4355C37A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233536AbiF0It3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiF0It1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:49:27 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C8326F1;
        Mon, 27 Jun 2022 01:49:26 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 9C5CF1C0B8F; Mon, 27 Jun 2022 10:49:24 +0200 (CEST)
Date:   Mon, 27 Jun 2022 10:49:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jean-Jacques Hiblot <jjhiblot@traphandler.com>, krzk+dt@kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] leds: Add driver for the TLC5925 LED controller
Message-ID: <20220627084909.GA15970@duo.ucw.cz>
References: <20220609162734.1462625-1-jjhiblot@traphandler.com>
 <20220609162734.1462625-3-jjhiblot@traphandler.com>
 <CAHp75Veurvhxi0Pg1Sjxav+3XpDTVOdan8WFFmZmdhJbZJiCaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <CAHp75Veurvhxi0Pg1Sjxav+3XpDTVOdan8WFFmZmdhJbZJiCaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu 2022-06-09 18:57:24, Andy Shevchenko wrote:
> On Thu, Jun 9, 2022 at 6:30 PM Jean-Jacques Hiblot
> <jjhiblot@traphandler.com> wrote:
> >
> > The TLC5925 is a 16-channels constant-current LED sink driver.
> > It is controlled via SPI but doesn't offer a register-based interface.
> > Instead it contains a shift register and latches that convert the
> > serial input into a parallel output.
>=20
> Can you add Datasheet: tag here with the corresponding URL? Rationale
> is to get a link to the datasheet by just browsing Git log without
> browsing the source code, which will benefit via Web UIs.

If you want to add datasheet url, add it as a comment to the source,
not to the git log.

Thanks,
							Pavel
						=09
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYrlvBQAKCRAw5/Bqldv6
8lMjAJ9QpuvQP9tiG3G3LO7oImmcxCl19ACeMx/G70Fqwya3O7MADn4ofhcKyhc=
=n4C4
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
