Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7DE56344A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiGANYJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiGANYI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:24:08 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C896D65D55
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 06:24:07 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7Gcp-0005xu-GZ; Fri, 01 Jul 2022 15:23:59 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7Gck-003nLS-PU; Fri, 01 Jul 2022 15:23:58 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o7Gcn-002KQZ-5J; Fri, 01 Jul 2022 15:23:57 +0200
Date:   Fri, 1 Jul 2022 15:23:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Fabien Parent <fparent@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pwm@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: dts: mediatek: mt8195: add pwm node
Message-ID: <20220701132344.vy2w3tx5glmrgbya@pengutronix.de>
References: <20220531114544.144785-1-fparent@baylibre.com>
 <20220531114544.144785-2-fparent@baylibre.com>
 <20220701072500.3rgvscnulhjmjhb6@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xui4lo5jobfysqwp"
Content-Disposition: inline
In-Reply-To: <20220701072500.3rgvscnulhjmjhb6@pengutronix.de>
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


--xui4lo5jobfysqwp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Fri, Jul 01, 2022 at 09:25:00AM +0200, Uwe Kleine-K=F6nig wrote:
> I wonder why will pick up this patch? Will patch 1 then go the same

I think my question is clear, but in case it's not: s/why/who/

> path, or is that one supposed to go via the pwm tree?

Best regards
Uwe



--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--xui4lo5jobfysqwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK+9V0ACgkQwfwUeK3K
7AlSrgf+P7HokPzYJcLz1i8OVvZtt/3C3sXTf3NXmiSxxegT3LP71x71/BIkYjoV
2PoXvxeAVv2/messCMQ6vP79SXVkQ1fTNQLrEcX7YHJyxT19K+0G0RTn82vf8SfJ
oxv2ADzLB6qziR02eFBIRGQiZ5ypOgK4AONG8mXQLtVPM7VzSJ79NUOrC4NsznLZ
T35JrwhDtVOAVWA7zZNwTAI2f8hPPOQFf6fvpmlklLq/JD11yQ5NU400UpY+z26b
SjrXLF2srqXdMFPOBkTy9xFjs6GtQc6fxbDgEVLNrXUMs4HvjxhTex0bmFvMh6ss
AFCi6yLd+CiVxnW2mTnhD9k3QAbFKA==
=+UjS
-----END PGP SIGNATURE-----

--xui4lo5jobfysqwp--
