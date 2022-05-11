Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A745232A7
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241978AbiEKMHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242150AbiEKMGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:06:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FE837003
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:06:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7FCBD61A27
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:06:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3443CC34112;
        Wed, 11 May 2022 12:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652270771;
        bh=j+SZT1/756FCJSOH/SWqGVaW5SakBqAL99hxm7pxi3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=envSBHOjKbIr0rKczLGiBRqfDL78Sma3TLybp44DVJuTLIaZYtNApvReFU9U06O9v
         3xWNB92V4Auz9luxglol+DuNCsdzS/4IOAZzhsH4r7K/1qhf8Da9UxH4nnYbqnx3bi
         X7XtwTiOUgYAA2K0EfrMcIvP5trUSMbRD62bOPrG9C3gvdZ15dVNLAWZUDSwX9DIo9
         InXC0vmpN5eU4chLnavg+yxST5A7ekd4hW1gs68udySrsn6i3HvTh/KkAHBITw1JZ/
         F582nQUqMy0xXryp2aDLcd3uwHcA9Yro9GicbHNlMk0bIyoLfhdYzels8U8SX5q47X
         JteycUYF4C4OA==
Date:   Wed, 11 May 2022 13:06:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        ryan.lee.analog@gmail.com, ricardw@axis.com, steve@sk2.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next 1/2] ASoC: max98396: Fix build error for implicit
 function declaration
Message-ID: <YnumrRUSkVCPONdl@sirena.org.uk>
References: <20220511012348.94288-1-tanghui20@huawei.com>
 <20220511012348.94288-2-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3Eq9i/WIkpo74bQR"
Content-Disposition: inline
In-Reply-To: <20220511012348.94288-2-tanghui20@huawei.com>
X-Cookie: Look ere ye leap.
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3Eq9i/WIkpo74bQR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 11, 2022 at 09:23:47AM +0800, Hui Tang wrote:

>                          devm_regulator_get_optional
> sound/soc/codecs/max98396.c:1556:23: error: =E2=80=98GPIOD_OUT_HIGH=E2=80=
=99 undeclared (first use in this function); did you mean =E2=80=98GPIOF_IN=
IT_HIGH=E2=80=99?
>               "reset", GPIOD_OUT_HIGH);
>                        ^~~~~~~~~~~~~~
>                        GPIOF_INIT_HIGH
> sound/soc/codecs/max98396.c:1556:23: note: each undeclared identifier is =
reported only once for each function it appears in
> sound/soc/codecs/max98396.c:1565:3: error: implicit declaration of functi=
on =E2=80=98gpiod_set_value_cansleep=E2=80=99; did you mean =E2=80=98gpio_s=
et_value_cansleep=E2=80=99? [-Werror=3Dimplicit-function-declaration]
>    gpiod_set_value_cansleep(max98396->reset_gpio, 0);
>    ^~~~~~~~~~~~~~~~~~~~~~~~
>    gpio_set_value_cansleep
> cc1: all warnings being treated as errors
>=20
> Add depend on GPIOLIB for 'config SND_SOC_MAX98396'

No, these issues are missing headers not dependencies.  In general
gpiolib stubs out so drivers can optionally use GPIO functionality.

--3Eq9i/WIkpo74bQR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmJ7pqwACgkQJNaLcl1U
h9B0kgf8CXSZlR2n9HkIGn6ZvtvMYK62TBjP2DAICSADC+/7mIu2RtE2eQSLbIUJ
xaxEvMealU9daTphvXFlWHhVlVQow897uyOrsuAmaNdbx7hi1PhJyr1vs89iS+uY
Ss5lPUjN8OsdyweQkaQWO91ug+mSb3q3X3Qr0KBaCqMSgVXA7cUoEtHrFkWKn8qQ
QRJoTxHmC7Xed5N0zEhE7d7quXBLgiGL9FZfKoQpJQ2IBDTB486XblaUhl2TVXDu
sP4c1FHQvKT3qnDg0eLyvu8st/jPGe+pAjpKLh9rzvY36UFBrOu9bwzti1L/oZXW
VJ24AXxfw3iFzrOkEF42aVToPho6hQ==
=SyXL
-----END PGP SIGNATURE-----

--3Eq9i/WIkpo74bQR--
