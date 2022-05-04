Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3917151983A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbiEDHds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343741AbiEDHdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:33:46 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B9D23168;
        Wed,  4 May 2022 00:30:11 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 2E7E01C0B82; Wed,  4 May 2022 09:30:10 +0200 (CEST)
Date:   Wed, 4 May 2022 09:30:09 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Lee Jones <lee.jones@linaro.org>,
        Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v14 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220504073009.GC8204@duo.ucw.cz>
References: <20220303214300.59468-1-bjorn.andersson@linaro.org>
 <20220303214300.59468-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <20220303214300.59468-2-bjorn.andersson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> +/sys/class/leds/<led>/hw_pattern
> +--------------------------------
> +
> +Specify a hardware pattern for a Qualcomm LPG LED.
> +
> +The pattern is a series of brightness and hold-time pairs, with the hold=
-time
> +expressed in milliseconds. The hold time is a property of the pattern an=
d must
> +therefor be identical for each element in the pattern (except for the pa=
uses
> +described below).

therefore?

> +Simple pattern::
> +
> +    "255 500 0 500"
> +
> +        ^
> +        |
> +    255 +----+    +----+
> +        |    |    |    |      ...
> +      0 |    +----+    +----
> +        +---------------------->
> +        0    5   10   15     time (100ms)
> +
> +The LPG supports specifying a longer hold-time for the first and last el=
ement
> +in the pattern, the so called "low pause" and "high pause".

Please see
Documentation/devicetree/bindings/leds/leds-trigger-pattern.txt . This
should really be compatible.

Can I get either patch to disable pattern infrastructure for now or to
get it compatible?

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnIrgQAKCRAw5/Bqldv6
8rLMAJ0VtBNxB/xvCl2JcOP0LCU18d1nfgCfdpUxi4Hu4njyY6v5UbF8MNrW4p8=
=qHV3
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
