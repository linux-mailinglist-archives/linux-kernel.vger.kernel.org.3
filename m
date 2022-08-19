Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FFA35996C1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347436AbiHSIIZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:08:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347437AbiHSIIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:08:21 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14EB2E60;
        Fri, 19 Aug 2022 01:08:16 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 8D7231C0003; Fri, 19 Aug 2022 10:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1660896494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xnSnA3nWQpeYFNh72VNZw+Q8gHM4SwkhWnnSyXt/Sc0=;
        b=Os9MDjMZIhMPCG6eHYJnIhp2tVtKBoBo/loS2RHhNlWhlZ7HJvVddLtXh1Gsn3P4xzRULL
        7iO69sJ9iO8RHN+ipCpUCFWSyzfVLTnHEo3inLjYbFXCy2MWO1x74EOA322uWWFCVtQg1S
        V0cNt4QkYeky/L+T93sH7G55+I/FwvQ=
Date:   Fri, 19 Aug 2022 10:08:14 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: leds: register-bit-led: Add active-low
 property
Message-ID: <20220819080814.GA6653@duo.ucw.cz>
References: <20220818172528.23062-1-pali@kernel.org>
 <f635d5a7-6817-cd62-e395-63e346775716@linaro.org>
 <20220819065620.wvmy3kigvvbwo4bo@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
In-Reply-To: <20220819065620.wvmy3kigvvbwo4bo@pali>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Although the question is - where is the user of it?
>=20
> I was planning to send updated powerpc DTS files with these
> register-bit-led definitions after accepting dt bindings.

We need device tree people to ack them, first. But a note saying "this
is for Turris Omnia router" would be welcome.

Best regards,
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYv9E7gAKCRAw5/Bqldv6
8o0PAKCH/a2TQLl6OrbyEbn5+4OVf4zdowCeNgABuJMFG5XPiEuEhUm5UfLC100=
=sFpc
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
