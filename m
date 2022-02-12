Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2474D4B3486
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 12:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234380AbiBLLZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 06:25:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiBLLZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 06:25:42 -0500
X-Greylist: delayed 92 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Feb 2022 03:25:39 PST
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4245826562;
        Sat, 12 Feb 2022 03:25:39 -0800 (PST)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id E28801C0B80; Sat, 12 Feb 2022 12:25:37 +0100 (CET)
Date:   Sat, 12 Feb 2022 12:25:36 +0100
From:   Pavel Machek <pavel@ucw.cz>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH v2 0/3] regulator/mfd: dt-bindings: maxim,max77802:
 convert to dtschema
Message-ID: <20220212112536.GB20866@duo.ucw.cz>
References: <20220111175430.224421-1-krzysztof.kozlowski@canonical.com>
 <f0a9e656-cf18-f212-b701-a1c9d10c4a59@canonical.com>
 <YgDoG8Xlhq5L3Bii@google.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
In-Reply-To: <YgDoG8Xlhq5L3Bii@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > Dear Lee,
> >=20
> > This patchset was reviewed and there are no outstanding issues. Could
> > you pick up entire set via MFD tree?
>=20
> Nothing from LED or Regulator?

I took 3/3 separately, as suggested.

Best regards,
								Pavel

--=20
http://www.livejournal.com/~pavelmachek

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYgeZMAAKCRAw5/Bqldv6
8oy2AJ9cSaFdxoaoiv60dYQ5ubQK+1vE8ACgrgDOFd06FGAIeeyDOMZ3ok9YyY0=
=/ZGh
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--
