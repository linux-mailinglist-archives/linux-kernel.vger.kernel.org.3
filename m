Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B36B58FADD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 12:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiHKKrj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 06:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234645AbiHKKrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 06:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DEB52716D;
        Thu, 11 Aug 2022 03:47:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0CD7260ED3;
        Thu, 11 Aug 2022 10:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C06AC433D6;
        Thu, 11 Aug 2022 10:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660214854;
        bh=4WoU4PzTqSWaKAiYjQxMqeztaU+Fg5MuY24q8LVMV78=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aYoM1/Vt15qtgK7KyhfqAX4/Yb0rFlmcFB7dAw2aNMEox9rqxt8EMfPlcNJ0QpfcH
         dHCDd0nEpUcjZabJF8Uwqd9dlTZnOAP4gyk5yPEihH6/EAj16MJIeG0p2jt112fxk2
         RO/U8rFO2bu0lYH3Wpunc8Tt14++HrUbamVXLNYTjsvYq+aaLGXHAybzQwT5SJdIe/
         fRAieTTLS/igvRrWJkjW3k65trDPyWj0axh73bKuh1TZGvD6YRy/SWjg18wHTRmY/T
         fj7kShu035g5kp6Iy3VczUU7KQA/uqYST4dv0KTTMasskriY/QpBAsm16GjTJXlSoN
         Tki++/bIG+qFg==
Date:   Thu, 11 Aug 2022 12:47:27 +0200
From:   Wolfram Sang <wsa@kernel.org>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: rectify entry for RISC-V/MICROCHIP
 POLARFIRE SOC SUPPORT
Message-ID: <YvTePwvp5AigV0Ax@shikoro>
Mail-Followup-To: Wolfram Sang <wsa@kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        linux-riscv@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220811070506.12252-1-lukas.bulwahn@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/Fg/PWpkMsj86wcD"
Content-Disposition: inline
In-Reply-To: <20220811070506.12252-1-lukas.bulwahn@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/Fg/PWpkMsj86wcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 11, 2022 at 09:05:06AM +0200, Lukas Bulwahn wrote:
> Commit 3cbd67384677 ("MAINTAINERS: add the Polarfire SoC's i2c driver")
> adds the file entry for drivers/i2c/busses/i2c-microchip-core.c, but the
> file is actually named drivers/i2c/busses/i2c-microchip-corei2c.c.
>=20
> Repair this file reference in RISC-V/MICROCHIP POLARFIRE SOC SUPPORT.
>=20
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Acked-by: Wolfram Sang <wsa@kernel.org>


--/Fg/PWpkMsj86wcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmL03jsACgkQFA3kzBSg
Kbb9ug//XvIqb1Vway8MBwrhbNGpzOqOcN4Q2c8JUiZ3oNXlBHxMTik8nRbX+JTq
fpafbNe7CRZ1SUyIgKcz/bmagZj3dNS+3oeE9vBOi2fWBGb8xMGhTzNQib6Z+q8m
N6NfsX7y5t7Z/IracHQhhTrVAd8nKRbNnQd9BqQhnGgR/ZJTX6QFzeoF6byhaa3c
wX+SH46dADmYghkFdPRtNx72TlQElL1raj7Lqb7u9tlGF3NgbVQISjjPYbepx8u3
LfRMAYanVCXMZO1tUOfXo2yZakquAl5S//Xmfx4nvpO7IU/hcF6LUVjxtGNPoDdQ
M+n6ctoCtpZkblt/TyExfP7ijZ+cx6bPGsu0fnbiB9KoeU4BcXvPmCHvY8N9B320
6hRucRjlYEHA6M1Cr7OCL7jikLlJtts3qnJoKO6bB3bfADUID4/KekJfeDB9NqYj
oWTeKhF8Ekudd7v4W2+QK/QHuDHlTAW4rJuSp0Tk+6QqAFy9W8x55hHIAqu+8gr3
Jzfb+3Gd+CDT2eXEaPPTBPV3WqX/pSyH9IGfUPSOaQgjVKmLfsda02ZvmBrWoI+b
v9rSEma+xmrtiupifePbvgQcwM9k6WdxG0WblT0fwnKgZSXOya9/cZTUpy79D/ml
f9ZkG9s5+t80w0F6KKRQ82z4s5soiVy4nlAtvbLOLx1Q2YfWAb0=
=edpy
-----END PGP SIGNATURE-----

--/Fg/PWpkMsj86wcD--
