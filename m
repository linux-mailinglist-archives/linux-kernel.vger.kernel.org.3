Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B870E50085F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 10:29:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiDNIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbiDNIbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 04:31:45 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3228E0D;
        Thu, 14 Apr 2022 01:29:20 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 6349D1C0B88; Thu, 14 Apr 2022 10:29:17 +0200 (CEST)
Date:   Thu, 14 Apr 2022 10:29:16 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Velumani T <velumani.t@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        patrick@stwcx.xyz
Subject: Re: Multi-color LED framework
Message-ID: <20220414082916.GA6514@amd>
References: <CAEHFT+o-wv=5AUrzwYDR5t4fA4vDJW8QY2SCpteNYrq6nYB2ZQ@mail.gmail.com>
 <CAEHFT+rq_Pn9Y+38ZBptCDpEUUtKL5RYGUh2gmySXtjQefLG8g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline
In-Reply-To: <CAEHFT+rq_Pn9Y+38ZBptCDpEUUtKL5RYGUh2gmySXtjQefLG8g@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> I have a question about the multi-color LED driver, Is the multicolor
> driver implementation specific to the RGB color integration?
>=20
> If yes, is there a way I can use static color LEDs with this driver
> framework making changes to have this as enhancement?
>=20
> In my case we have blue and yellow color static LEDs connected in
> GPIO, I need to choose the color from the application and the LED
> shall glow based on the application configuration.

Why sending the mail twice?

Multicolor framework should be able to work with that, but if LEDs are
just on/off it may be a bit of overkill.

Best regards,

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAmJX21wACgkQMOfwapXb+vLmwQCfZ0oM+UVmf1tVipxuEz2yEkvg
nB4AoL1uA5u/yvx7H0J7MjmR5rkPLh8+
=w1M+
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
