Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4B557F12C
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 21:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235585AbiGWT1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 15:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiGWT1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 15:27:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61FE1056F;
        Sat, 23 Jul 2022 12:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3476C60EE7;
        Sat, 23 Jul 2022 19:27:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7A7DC341C0;
        Sat, 23 Jul 2022 19:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658604452;
        bh=ZbgxQl+rg3lKvC7krfve+T2jrFIJNpWda+6LzKO5bVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jYfTItcNNWxzBrd2FdZDyCAXbhBbBfRu6EzxX5X+STOAA/Y/i0EoAlW9TYLCmUhp5
         j92DwmQLLnTL+z9beMk2cPqFaFWxw96Buz/TlW12WDm2X1c8xFEVhUqkLhA/hJ97qF
         Sthq4TF8XMIIJrw99MSMgs2FYhcRhEAOa88kw+tufLbCE7Wvo6cWt/hG+F2ZH2jMeq
         WAWi0Vhr4OgaV8diwe6XHa5F6gjUl5UebPE9nHjKzc6dAhfKafMiSUSDcMI5BGn31F
         SHSB1SGr+T248fdxtS2BoLvAe1iW99KEgwswGV2wKRa7hSR5yQk7BEqQbt4JxdfvM6
         onT5zTynAQeIw==
Date:   Sat, 23 Jul 2022 20:27:28 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Mike Yang <reimu@sudomaker.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Zhou Yanjie <zhouyanjie@wanyeetech.com>,
        tudor.ambarus@microchip.com, p.yadav@ti.com, michael@walle.cc,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mtd@lists.infradead.org, linux-spi@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, aidanmacdonald.0x0@gmail.com,
        tmn505@gmail.com, paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        jinghui.liu@ingenic.com, sernia.zhou@foxmail.com
Subject: Re: [PATCH 2/3] dt-bindings: SPI: Add Ingenic SFC bindings.
Message-ID: <YtxLoPOykLDTzTn9@sirena.org.uk>
References: <1658508510-15400-1-git-send-email-zhouyanjie@wanyeetech.com>
 <1658508510-15400-3-git-send-email-zhouyanjie@wanyeetech.com>
 <487a93c4-3301-aefd-abba-aabf4cb8ec90@linaro.org>
 <37062a5d-9da3-fbaf-89bd-776f32be36d9@wanyeetech.com>
 <d1a0dd15-3621-14e9-b931-417cefaab017@linaro.org>
 <b5505a46-ce76-d0aa-009e-81d9ba16e1d5@sudomaker.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TbMQOSOuune2YTJx"
Content-Disposition: inline
In-Reply-To: <b5505a46-ce76-d0aa-009e-81d9ba16e1d5@sudomaker.com>
X-Cookie: Necessity is a mother.
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--TbMQOSOuune2YTJx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Jul 24, 2022 at 02:47:14AM +0800, Mike Yang wrote:
> On 7/24/22 01:43, Krzysztof Kozlowski wrote:
> > On 23/07/2022 18:50, Zhou Yanjie wrote:

> >> No offense, does it really need to be named that way?
> >> I can't seem to find documentation with instructions on this :(

...

> > All bindings are to follow this rule, so I don't understand why you
> > think it is an exception for you?

> Zhou didn't ask you to make an exception. They have a valid
> point and they're asking why.

> You may want to avoid further incidents of this kind by stop
> being bossy and actually writing a guideline of naming these
> .yaml files and publish it somewhere online.

Yeah, I do have to say that I was also completely unaware that
there was any enforced convention here.

--TbMQOSOuune2YTJx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmLcS6AACgkQJNaLcl1U
h9B16Af+OB537q2iAFHtuzDZyT8beLFm5e80sPm2/JK6DK39SDS56/LU25TuqiQo
JICSdChsFLOntnTc+3yLvssDYmtu+9niHfjBbG3zbA4IU7n2tH5zC8ks0BZnHG1y
Ca58/ofXK99lB5wPUVB7eH9ccEVPfQ03/Ezb7gD435htmmn4ZBV3idkJkhezOxG/
kgEJDtu7iJiaMNViADXs2AHGyCrAcgRSJKAtWByb1e8Cguh+CpuLKR6kzbs+IDGp
fnCzAS4YOJmZGAO0P7mc4789Bxy3+v4s2mJSaZWRD2UGIZllBcoLxyWDtgAKIGB0
FNxFe0cCP1mEKNoLaxf1rLh4gwlkZQ==
=bYHr
-----END PGP SIGNATURE-----

--TbMQOSOuune2YTJx--
