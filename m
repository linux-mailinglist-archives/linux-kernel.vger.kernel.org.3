Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 640A5519811
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:24:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345243AbiEDH2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiEDH2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:28:13 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633F617045;
        Wed,  4 May 2022 00:24:38 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 901C91C0B82; Wed,  4 May 2022 09:24:36 +0200 (CEST)
Date:   Wed, 4 May 2022 09:24:35 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v14 1/2] dt-bindings: leds: Add Qualcomm Light Pulse
 Generator binding
Message-ID: <20220504072435.GB8204@duo.ucw.cz>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
In-Reply-To: <20220303214300.59468-1-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This adds the binding document describing the three hardware blocks
> related to the Light Pulse Generator found in a wide range of Qualcomm
> PMICs.

Sorry for the delays. I have collected tested/review tags and push the
result to:

To gitolite.kernel.org:pub/scm/linux/kernel/git/pavel/linux-leds.git
   312310928417..24e2d05d1b68  for-next -> for-next

I'll need to check pattern usage in the driver, and there are some
small fixes needed as evidenced in the reviews.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--gatW/ieO32f1wygP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnIqMwAKCRAw5/Bqldv6
8n7RAJ9oOCOR3ISZxwaIRR8H6om+IUUYdgCbB10QXZkS8Dp7LlyK3cTk9omfaOk=
=o9iF
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
