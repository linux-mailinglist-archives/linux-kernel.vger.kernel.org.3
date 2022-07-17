Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726D657763C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 14:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232931AbiGQMot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 08:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiGQMos (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 08:44:48 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7164113CE5;
        Sun, 17 Jul 2022 05:44:47 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 29AD51C000A; Sun, 17 Jul 2022 14:44:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1658061886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yHr1snlX95yLCx8+MNxlNwwABS7Wxx3b42Uc4yfpS2c=;
        b=Nd9+JVscQH6ZQXIPFOwOa9SUpZ/KbM4fKYicsanpnVsB21SGiHhLcg2wKrhuIhPAywIe+r
        FLGYznSAuez4EVsBPL7196YzunsCKVL6yhjwURaYu4fTYqgxmDEeB+//ydVa6zPEjc4KCZ
        iIcF6Qgww441QkJOSUU3oyCrXQVE11c=
Date:   Sun, 17 Jul 2022 14:44:45 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dan Murphy <dmurphy@ti.com>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ChiaEn Wu <peterwu.pub@gmail.com>
Subject: Re: [PATCH] dt-bindings: leds: class-multicolor: reference class
 directly in multi-led node
Message-ID: <20220717124445.GL14285@duo.ucw.cz>
References: <20220624112106.111351-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Pz0BBB9QxoYXlT+x"
Content-Disposition: inline
In-Reply-To: <20220624112106.111351-1-krzysztof.kozlowski@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Pz0BBB9QxoYXlT+x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The leds/common.yaml is referenced directly in each LED node, which
> leads to people doing the same with leds/leds-class-multicolor.yaml.
> This is not correct because leds-class-multicolor.yaml defined multi-led
> property and its children.  Some schemas implemented this incorrect.
>=20
> Rework this to match same behavior common.yaml, so expect the multi-led
> node to reference the leds-class-multicolor.yaml.  Fixing allows to add
> unevaluatedProperties:false.
>=20
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks, applied.

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Pz0BBB9QxoYXlT+x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtQEPQAKCRAw5/Bqldv6
8r6BAJ9GwstFtXDawy1RB7K1TUUoyHCadwCfWRst2PJWT6CuTpsKsq4oLNnkWtg=
=4igj
-----END PGP SIGNATURE-----

--Pz0BBB9QxoYXlT+x--
