Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F6EC585C32
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 23:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiG3VAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 17:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232279AbiG3VAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 17:00:31 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B865110FEA;
        Sat, 30 Jul 2022 14:00:30 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 84FC51C0001; Sat, 30 Jul 2022 23:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1659214829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ucSCYgK+GmsYscsfSPeCmlSx8seUtYHo8kNxn/rdyec=;
        b=VnowGBcPVNzioXBTILWPf1RwBfQ6aIj1WpHUMIdciaUc0mo4w3vGiQ9ihf5CGx+9AKHOnf
        TNLr/74GjFfBPo+WDed325sBUOtKfkwd3E6iH3pg9IOruCXkdOKYJ3nDcWGMpKo2w1UDwM
        +T4x9ZXRvtmj/XMFSq4XlIkONpt2Hr4=
Date:   Sat, 30 Jul 2022 23:00:29 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, linux-leds@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: leds: pwm-multicolor: document
 max-brigthness
Message-ID: <20220730210029.GC23307@duo.ucw.cz>
References: <20220719074542.24581-1-krzysztof.kozlowski@linaro.org>
 <20220719232614.GA2034561-robh@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <20220719232614.GA2034561-robh@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-07-19 17:26:14, Rob Herring wrote:
> On Tue, 19 Jul 2022 09:45:42 +0200, Krzysztof Kozlowski wrote:
> > The Multicolor PWM LED uses max-brigthness property (in the example and
> > in the driver), so document it to fixi dt_binding_check warning like:
> >=20
> >   leds/leds-pwm-multicolor.example.dtb:
> >     led-controller: multi-led: Unevaluated properties are not allowed (=
'max-brightness' was unexpected)
> >=20
> > Reported-by: Rob Herring <robh@kernel.org>
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  .../devicetree/bindings/leds/leds-pwm-multicolor.yaml       | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >=20
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>

Thank you, applied.
								Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYuWb7QAKCRAw5/Bqldv6
8lQOAKCbz10ruXYIIOdXbryLrqwVQ/EXHwCaArUFtrYKBGelWJS0EQxfYL9Nbbk=
=cZYo
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
