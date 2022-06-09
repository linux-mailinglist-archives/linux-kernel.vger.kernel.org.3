Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8F5454BA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 21:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239690AbiFITOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 15:14:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiFITOQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 15:14:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F3A0FF5A0;
        Thu,  9 Jun 2022 12:14:14 -0700 (PDT)
Received: from mercury (unknown [185.209.196.172])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B84B660174E;
        Thu,  9 Jun 2022 20:14:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1654802053;
        bh=dJm39X+aqRwTdCncqny3+Gv7KAPlsa1o8rIl8p8OWI8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RPJKyUP8SglbgECHdtiq1tfymLSA+aIjIAWAm4kAQSca9ny0+h7bFi2GhWRveDtE1
         qtswUfiZ5YCL4unUm2PvNTw9HGXM7N618S+8kYsmATxuNlzE7zL293KSiwOhNWXHyl
         cPyo0HBHeQBwJyEEPiH8iGK9WIQdDzmUqt4Xd0A8OXWz000YUH7uk3aohaDt5/riOM
         6rMcYuMtzSEPoYFoUb1E+a8Yy7ik2ZymRFLwHO7xfnxNeRyx58d8qSJ+6x27DvOd3f
         VMtJx6wu3iuWZMLLpiUXI4Cl0xPaN/eVAMmne6vTmQfPEKv610sn1VieHbQATbE0ZS
         kJNfXck21ZQiw==
Received: by mercury (Postfix, from userid 1000)
        id 3702210605B9; Thu,  9 Jun 2022 21:14:11 +0200 (CEST)
Date:   Thu, 9 Jun 2022 21:14:11 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Miaoqian Lin <linmq006@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power/reset: arm-versatile: Fix refcount leak in
 versatile_reboot_probe
Message-ID: <20220609191411.uel3lw4yc7r6u5cs@mercury.elektranox.org>
References: <20220523141009.52965-1-linmq006@gmail.com>
 <CACRpkdb+-urzSHCuug0qa=oytNuyBZyFafBBJ+1D8Yatks7Qew@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="wgupwjg7po6kxsxy"
Content-Disposition: inline
In-Reply-To: <CACRpkdb+-urzSHCuug0qa=oytNuyBZyFafBBJ+1D8Yatks7Qew@mail.gmail.com>
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wgupwjg7po6kxsxy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 24, 2022 at 09:25:48AM +0200, Linus Walleij wrote:
> On Mon, May 23, 2022 at 4:10 PM Miaoqian Lin <linmq006@gmail.com> wrote:
>=20
> > of_find_matching_node_and_match() returns a node pointer with refcount
> > incremented, we should use of_node_put() on it when not need anymore.
> > Add missing of_node_put() to avoid refcount leak.
> >
> > Fixes: 0e545f57b708 ("power: reset: driver for the Versatile syscon reb=
oot")
> > Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
>=20
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks, queued to power-supply's fixes branch.

-- Sebastian

--wgupwjg7po6kxsxy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmKiRoIACgkQ2O7X88g7
+pocZA//ezqI9t2xFRre5PyuVHYMrEPPr5II+PmdBp1vPRAKOGpDB/vBi5TNHeaG
C730YWTy53g4yz6GRdLDY2yM7JykAiPqUEfGvLj+CVQYhpLvvTQyRtUaOmsy4qJK
sb0Z2YWNVX9jk20/h9fx0nJ+ZNKBYWqzyVRWZTb88bxdTu+Q220kqggm3kDGeEDS
rtOtRBsxeL47xXOt4lSt2iEGeZBDu8NV5+k+2uKVpzDSqNmLit1vJogRI1wkLJvc
vA2WHpD700ljQDyEfqovDqR9Tcz4fs8Cw17BPuGe71qEuSHyCaCWnzjKV6DqwT6b
IbIU1pbznOoDuBWOMNTMmlIjvxZHPnkjFyaxrwVsAChc+JACLR2LHFNt5wclrMXY
wnH4hW7lRsdqZUOR0TRA8NLGEh149rwZrcB0zSXtfNH7+YN1faDlA+FXXB1F16p5
Y2pm9vhLNZq24iD/9R+0H3uBjyJfByCYQ14qrPlZOXSOw4EfzPXdUwinveprZWmH
ISeul5kKgrkcK0813co/Oar6SGovQn6Bc9etZPCGohj/rEXsCYWpGU5pTaW93My+
RhjlbBdoBpVXj3SxV7Gc/jfHG1jA2XuyCTv9uH+M88fNwDHWfwk9DBX4qd50Dcyz
OxUzOehMs2dTgMoYRFBAoyMR8NBTMTluuclO1RuBSjVTccji3wI=
=u8eP
-----END PGP SIGNATURE-----

--wgupwjg7po6kxsxy--
