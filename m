Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5744C70F7
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 16:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237036AbiB1Pvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 10:51:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiB1Pvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 10:51:43 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2E57A9BD;
        Mon, 28 Feb 2022 07:51:03 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6lGZ03nPz4xNq;
        Tue,  1 Mar 2022 02:51:01 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646063462;
        bh=SEcc3EtNNweS8yAPQruGplcCFIv6W1ZPkpDUWmGnuyk=;
        h=Date:From:To:Cc:Subject:From;
        b=YwjdwMy9xJJU2YCRMOrwwncy6xSVI+qkBx6xdVHxk0Nck3j3x0pyWvmfFV/WFw354
         XwMY8TqRPQSG4GaRD0ka4ZMQhtC0n76Jr4mF1nTSUylehFuaOCdWvcouNIM3vvyiNu
         xFQD6LkFxtstzpDcGMEw6BlCbY9SY/cvzcskaMH+n8JbcFzNulM6d0z9u4ubQMH00k
         QkXuvTeqne2RKoV8wUmEdnufwP73WFzXqVz0QIlLkce82UPCREciEeQhtr1pApALpD
         YInxH+NqzSyQAumT9HEOAXkiUNsOpjkkdINrnuW3eluiKb+Rfq56+V01/596ZnLpKm
         lmUFvfAJAp7Jw==
Date:   Tue, 1 Mar 2022 02:51:01 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
Cc:     Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <mail@conchuod.ie>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the arm-soc tree
Message-ID: <20220301025101.7fb280fd@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KlhcJqX_EOKopP_mYV7qNUg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KlhcJqX_EOKopP_mYV7qNUg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  ed40a635b5ec ("soc: microchip: make mpfs_sys_controller_put static")

Fixes tag

  Fixes: dsafsdfd0054 ("soc: add microchip polarfire soc system controller")

has these problem(s):

  - No SHA1 recognised

Maybe you meant

Fixes: d0054a470c33 ("soc: add microchip polarfire soc system controller")

--=20
Cheers,
Stephen Rothwell

--Sig_/KlhcJqX_EOKopP_mYV7qNUg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIc72UACgkQAVBC80lX
0Gxl4Qf/aOM70Cn/uZHngAoo+fCtMvm2YZUbWYkFmVHKkNR+eyQ02q7uChnf/QYK
8QQAItSSd9VzlJHORLhAPG7lmw10DisRPTarHJwHf7Sq9iS/YvseyE6YoCuaojL5
ZaZomaVCfJxATQFWvd7cSBTS8/1gA3Q5mVyXGqGg+WAFYBqhbPNCNqX+mjUJE8+4
hihW+L+KfKX61HYrduooRJTnz/2yUMAdZwyXWsMXW5E3y11ROBeE1Itka7Efkcc5
v5AoMMzNlhfjWZb8JJFrpLkERoCBpVy6ZkzR2Gi/i20o1Qm4CdtwIO3ineTtz4gt
itapJKRSlY1Ccs7C3CA/T54sleFY6g==
=wp7P
-----END PGP SIGNATURE-----

--Sig_/KlhcJqX_EOKopP_mYV7qNUg--
