Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC14F885B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 22:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiDGUaq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 16:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbiDGUa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 16:30:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C602DCC99;
        Thu,  7 Apr 2022 13:14:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6100CCE29BF;
        Thu,  7 Apr 2022 20:14:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 401EFC385A4;
        Thu,  7 Apr 2022 20:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649362455;
        bh=WW8rVy2QPJiQmDJ/9CJJp7rEmsJBUAeYshtZ8r09Shc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SYZRJQpPQTzZtgAKcI+8tv9khBU8zZbYgKEQAAbFJEjzucAqYpRs01JaOB1/+aNf7
         mFeM2D8GuNG2QVut/TW/soCOoX2n6OD5mQQpZugj4wiPzN+UVk7d/8kWF4h9n8Mn3l
         Xf9Qdogxk3HFUCvyK7rzf8WLa6fgp4KD2+JJgtMkydDEVD+3OZxfTU+qbFP5N/4e6H
         7KEB+OGWrXm467+Em2b/siPc53aL761eoktjk1aR2k6D4Ky7A5X7Djud5UatU08R2f
         GDDhOdYyE20TrEDxyCoNKzdEo89F84iPgXft2kUsX/QxoIMIf5902OnDayo71M7DLB
         IhINbOOC/GW9w==
Date:   Thu, 7 Apr 2022 22:14:12 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Stephen Kitt <steve@sk2.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 03/10] clk: cs2000-cp: use simple i2c probe function
Message-ID: <Yk9GFB9vcWTgtGEA@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407151831.2371706-1-steve@sk2.org>
 <20220407151831.2371706-4-steve@sk2.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bbJtj6fnE7MR9usx"
Content-Disposition: inline
In-Reply-To: <20220407151831.2371706-4-steve@sk2.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bbJtj6fnE7MR9usx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 07, 2022 at 05:18:24PM +0200, Stephen Kitt wrote:
> The i2c probe function here doesn't use the id information provided in
> its second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>


--bbJtj6fnE7MR9usx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmJPRhQACgkQFA3kzBSg
KbZA9Q/+MhzyslImzTueIs+gB6FQHloAdO3nD9UUrIWnldG8Hm7wpbcBxRG1axYb
jewbwt51w1ICW1eXK7Ft6l28qBGtD0zPXeQq3NJ19tdM7MdZu9fvhUvkj3WtBmp2
BbgvMyYsAiVNeUbmDr04mPG4k1XTrEJSRLXpj8r6Yr8nFFOBHBVRC/EV1sFfXFVY
PHDWspBFJTUsKoHpM6s50J03+KNsQRCvbmdZIL13bUlv340ew7g+Cf+LfhwL+s2A
Mt/mvGX0br86Be0cIrjrUyQ8iLvFJaQV8NgeEwY3A2bxUMnySpQgeljRDP/uv/+F
xzWu9PRuvNSEq2lgvUZqqXZdcEei73ZRn1BbdWpl70n+Ib6s/BdxhCCwKxm5ZIAp
LLtv5nOgS4FfzA0B+vqWh2l44qYNuIE1FTm7db5hcodW7vNsz8+hJoEu6UBvp4F5
+HUEOaadqZ27uLsWNr3FQ2O1mSrSm69hzsWySzTlowxX92x+oo2Hkx4TC8sZZO/2
JTxjEgcuoHYPgBg29c1Ke2QNOpF44p0s7Iul8RVgcD5lgdk6aZDFaVfzvIpa46ha
ZlCAzf/SLb3l0SOgCY68EaoWJh6scQLE7pp1H0E7WI5HVOu5PjGkPc/PXasQiH/N
8WRkZqG2Qz0OGjrEdCb4ar88ta2Xrwl0ukfsYUGazcSnXtsXNXw=
=Wsn6
-----END PGP SIGNATURE-----

--bbJtj6fnE7MR9usx--
