Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6610D5775DB
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 13:02:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiGQLCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 07:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbiGQLCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 07:02:52 -0400
Received: from jabberwock.ucw.cz (jabberwock.ucw.cz [46.255.230.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557421704D;
        Sun, 17 Jul 2022 04:02:51 -0700 (PDT)
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id CFBCF1C000A; Sun, 17 Jul 2022 13:02:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ucw.cz; s=gen1;
        t=1658055769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5+3U4BoqIseximINTkRtUt+Nxs6zfcLxjIl2czwey7I=;
        b=GWJTe8AEpO/14QNQQ1reCbJkDMgrVCxC8B/z18B7dYm8mHjT/aSUP2jOg6eT/eXVqfwyvO
        kjHQTAuIw3/9dJdN3TDblzyc+DCwzXdnf32vwVsCNsKeR9X5MFUWADxCabQqgOdCtiTLUY
        E47SHyApcktL1zW45A0XD/fgcYgfvik=
Date:   Sun, 17 Jul 2022 13:02:49 +0200
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
Subject: Re: [PATCH v1 0/4] Add HiFive Unmatched LEDs
Message-ID: <20220717110249.GF14285@duo.ucw.cz>
References: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Mjqg7Yu+0hL22rav"
Content-Disposition: inline
In-Reply-To: <20220705210143.315151-1-emil.renner.berthing@canonical.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Mjqg7Yu+0hL22rav
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> This series adds support for the two LEDs on the HiFive Unmatched
> RISC-V board.
>=20
> Emil Renner Berthing (4):
>   leds: pwm-multicolor: Don't show -EPROBE_DEFER as errors
>   dt-bindings: leds: pwm-multicolor: Add active-low property
>   leds: pwm-multicolor: Support active-low LEDs

Thank you, applied. Not taking the dts change

Best regards,
							Pavel
--=20
People of Russia, stop Putin before his war on Ukraine escalates.

--Mjqg7Yu+0hL22rav
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQRPfPO7r0eAhk010v0w5/Bqldv68gUCYtPsWQAKCRAw5/Bqldv6
8gq0AJwIckPJm2yDxtGdkNcSELHvsLEndQCgh55aqv0nUOUw476HCy+Z7iSfGt0=
=PdXv
-----END PGP SIGNATURE-----

--Mjqg7Yu+0hL22rav--
