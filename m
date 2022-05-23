Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5964531E7A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiEWWSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:18:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiEWWSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:18:39 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A8F3BA579;
        Mon, 23 May 2022 15:18:37 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 66D3D1C0B82; Tue, 24 May 2022 00:18:35 +0200 (CEST)
Date:   Tue, 24 May 2022 00:18:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Richard Purdie <rpurdie@rpsys.net>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220523221835.GC15554@duo.ucw.cz>
References: <20170323055435.29197-1-bjorn.andersson@linaro.org>
 <20220523163038.GA9124@duo.ucw.cz>
 <20220523220107.6wmpp2ohw63p4mjh@SoMainline.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <20220523220107.6wmpp2ohw63p4mjh@SoMainline.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-05-24 00:01:07, Marijn Suijten wrote:
> On 2022-05-23 18:30:38, Pavel Machek wrote:
> > Hi!
> >=20
> > > The Light Pulse Generator (LPG) is a PWM-block found in a wide range =
of
> > > PMICs from Qualcomm. It can operate on fixed parameters or based on a
> > > lookup-table, altering the duty cycle over time - which provides the
> > > means for e.g. hardware assisted transitions of LED brightness.
> > >=20
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> >=20
> > I'd really like to see the patch fixing the pattern interface (or
> > disabling it). I don't want to push the tree to Linus with that bug.
>=20
> (I couldn't help but be confused for a minute by this being a reply to
> the original v1 patchset from March 2017 :) )
>=20
> Does that mean there's still some time to review / pick up [1]
> (LPG enablement for PM660L)?  And even more so for [2] (fixing the use
> of a software-pattern variable in the hardware-pattern code) which
> complements Bjorn's series but hasn't been looked at ever since last
> year.

There's still time if the patches are perfect.

								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYowIOgAKCRAw5/Bqldv6
8tlOAKDDdpooBKjWIXXR4nNmzGWAZIKRhACfQ4fsUFMXbtyBNNp0GHvGW9tuWPE=
=56ty
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
