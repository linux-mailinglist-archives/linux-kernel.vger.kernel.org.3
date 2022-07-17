Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7D55775D2
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 12:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbiGQK6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 06:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGQK56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 06:57:58 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB5315A02;
        Sun, 17 Jul 2022 03:57:56 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 5F9541C0003; Sun, 17 Jul 2022 12:57:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1658055475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2PiYcVoQaJRB7ipLJ+CzHZiXAP65SK93zbBFtaADAHY=;
        b=aNP+rDla8x8MVa/ZII4Q1KX24tDomXButkwpdsgzHhxyeB2Lyk0hTdcCpzAxJ7HyUEH/N/
        76CDAdOSE4aqEMZ6b8tR1Y9OrAVLCZJEPXMS5nZvlRu0T8zcJJUDcElOa9Ps+vRSMsn7R5
        O3uebTfw7bt/2fygjdjAM3Zxv+CXP1M=
Date:   Sun, 17 Jul 2022 12:57:54 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Vincent Pelletier <plr.vincent@gmail.com>,
        Bin Meng <bin.meng@windriver.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Ron Economos <w6rz@comcast.net>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen L Arnold <nerdboy@gentoo.org>,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Schwermer <sven.schwermer@disruptive-technologies.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        David Abdurachmanov <davidlt@rivosinc.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 4/4] riscv: dts: sifive unmatched: Add PWM controlled
 LEDs
Message-ID: <20220717105754.GE14285@duo.ucw.cz>
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
 <20220705210143.315151-5-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="orO6xySwJI16pVnm"
Content-Disposition: inline
In-Reply-To: <20220705210143.315151-5-emil.renner.berthing@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--orO6xySwJI16pVnm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2022-07-05 23:01:43, Emil Renner Berthing wrote:
> This adds the two PWM controlled LEDs to the HiFive Unmatched device
> tree. D12 is just a regular green diode, but D2 is an RGB diode with 3
> PWM inputs controlling the three different colours.
>=20
> Signed-off-by: Emil Renner Berthing
<emil.renner.berthing@canonical.com>

Acked-by: Pavel Machek <pavel@ucw.cz>

(This is dts change, I'd rather not take it through the LED tree).

Best regards,
							Pavel

--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--orO6xySwJI16pVnm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtPrMgAKCRAw5/Bqldv6
8vJKAKCK8iCAueRbp/sBar9NXzmMECiF6ACgp9e1BthH/ZKcWRgw97Pvc99PupI=
=0geR
-----END PGP SIGNATURE-----

--orO6xySwJI16pVnm--
