Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6D00567A05
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiGEWQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiGEWQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:16:16 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7001815719;
        Tue,  5 Jul 2022 15:16:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LcxpN51RMz4xMW;
        Wed,  6 Jul 2022 08:16:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657059373;
        bh=XZxqfOoJqyHaxb2ijCfs64RrqwV15vWJl3ot42lwO5E=;
        h=Date:From:To:Cc:Subject:From;
        b=N+xo3zw7pGFNp+nvr1Z/pozu+e3LelshytKYgYTeyorSrkFiACdSWNWOWJndMB6V2
         4Y1HhdLpIGlbDhwKvIhhuBV1AinBA+yKDK9NXrboqPF2vKRuWq/daI5deJqXnZKsrS
         tutQhSx6mVMB/Pz27YHLbopzgnIL0xEJ0IIeWS1Rrgzuc36h42LuYnJA+6qnYpFPae
         ScQPybuyJTuMWHHdEfvGrNltRkufP0KwPWQ+pKt6Acu5T6bFmMNVLvAbPZO4/2Pgrz
         2aEaw60ZLwcDPw5WLv/73Xi8QsSUxJrdhGaPD3pwP4K/i63s357L3D7gSLougpeDko
         TpJiOADHZjBIQ==
Date:   Wed, 6 Jul 2022 08:11:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Jianqun Xu <jay.xu@rock-chips.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gpio-brgl tree
Message-ID: <20220706081108.347e3ffb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/zntH_Oz1rarvsF4xbamw6=m";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/zntH_Oz1rarvsF4xbamw6=m
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  1fde565c5593 ("gpio: rockchip: add support for rk3588")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/zntH_Oz1rarvsF4xbamw6=m
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLEtvwACgkQAVBC80lX
0Gx1tggAgiZ5+gU2UnMUw71gMV1jHv7yjIL6Xa8Azfz9WzDFs3FqDywwhgpnEV/B
rAQIHyDL/PzBmerKjKG/6E7soWavxUoHNfpBeje+Iis+8zqAHxTohY9ZzDC1Ut39
31hQw+CxGxsf8ZrHW6l92TNHcJTWE0NzNaEffgYOc2fVPKsIoXcA0x2DSJGzzF+T
d+EfCUYcjLVTSw2R1uvb7wLuUKNtEeq1dS7DYjGDRFi6LsODAE1Q2Ex0ciZ2J5id
lK2JOsfNZRnP1l4hKnoQXu/owIxCl05phxWb0l7lVnxP01o2qJFX2imozdUaUaSw
Kkq0EIgdufRegLRA2aLsHXEe84DoNQ==
=3yeE
-----END PGP SIGNATURE-----

--Sig_/zntH_Oz1rarvsF4xbamw6=m--
