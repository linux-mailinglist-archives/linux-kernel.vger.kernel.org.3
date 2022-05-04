Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159E051ACBD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 20:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350247AbiEDS2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 14:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237899AbiEDS2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 14:28:16 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DEE44D61B;
        Wed,  4 May 2022 10:56:48 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 606581C0BA5; Wed,  4 May 2022 19:56:47 +0200 (CEST)
Date:   Wed, 4 May 2022 19:56:47 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: leds-mt6360: Drop redundant
 'unevaluateProperties'
Message-ID: <20220504175647.GE8725@duo.ucw.cz>
References: <20220426133508.1849580-1-robh@kernel.org>
 <YmmLldJcJ2tOOCO7@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2hMgfIw2X+zgXrFs"
Content-Disposition: inline
In-Reply-To: <YmmLldJcJ2tOOCO7@robh.at.kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2hMgfIw2X+zgXrFs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 2022-04-27 13:29:41, Rob Herring wrote:
> On Tue, 26 Apr 2022 08:35:08 -0500, Rob Herring wrote:
> > The binding has both 'unevaluateProperties: false' and
> > 'additionalProperties: false' which is redundant. 'additionalProperties'
> > is the stricter of the two, so drop 'unevaluateProperties'.
> >=20
> > Fixes: e05cab34e417 ("dt-bindings: leds: Add bindings for MT6360 LED")
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/leds/leds-mt6360.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> >=20
>=20
> Applied

Thank you!
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--2hMgfIw2X+zgXrFs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYnK+XwAKCRAw5/Bqldv6
8uKUAJ4mu8CeqxEjsLFjOzdUAjXUoBBgEQCgpeK3/QYfQACi2vQAk8BrArf+WJU=
=SuN2
-----END PGP SIGNATURE-----

--2hMgfIw2X+zgXrFs--
