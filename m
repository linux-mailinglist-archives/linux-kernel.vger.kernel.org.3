Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0302359CB27
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 23:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238401AbiHVVxy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 17:53:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238399AbiHVVxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 17:53:44 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70AA610FC5;
        Mon, 22 Aug 2022 14:53:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MBR242Zh3z4xL5;
        Tue, 23 Aug 2022 07:53:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661205212;
        bh=IUO8s84JYOd3ji+LftyiD4hTBeIG245bOnUef2tdzNQ=;
        h=Date:From:To:Cc:Subject:From;
        b=cWH5s7npLSTjIQNcu8Lf0KtRdx8uekt4KJD5D8kz67YeYvygvKZXGbw/zf8FAkzeP
         na+Q4uj0yqUeqQrlvG5gxZrfM405kUS/odhrAvFmQg2xxX320JigK68mTB/rp5fI7+
         TOf0dD+nx9h5R2NTyQrjMLb6xXujKNBBMJ7Iy684I3AUXZoaX0ltIZWVAxUoyhTqt9
         gFkxU0p1x6EpxsK/vsLBd+uk/EVoG5YWjXvcbG/HadG23w67IY+WtZXOW1Sl4JTUjx
         hkO90tJUbafLA8rcUQRIRkQgQmz6xsYo28HeRRYTXWVIWvE3Kf9V3xHuHeYOGkzTu0
         B4YrDsz8E0hIA==
Date:   Tue, 23 Aug 2022 07:53:14 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "=?UTF-8?B?Sm/Do28=?= H. Spies" <jhlspies@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pinctrl tree
Message-ID: <20220823075314.63d0a03c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/7FK91ThomnWS5sQagZdh7tQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/7FK91ThomnWS5sQagZdh7tQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  2648ede07315 ("pinctrl: rockchip: Enhance support for IRQ_TYPE_EDGE_BOTH")

Fixes tag

  Fixes: 936ee26 ("gpio/rockchip: add driver for rockchip gpio")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/7FK91ThomnWS5sQagZdh7tQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMD+soACgkQAVBC80lX
0GyvYQf+IHcXvQEK1N9U0FT4kOxb57eJE7VNcpJkVGLdbInCyc2hBLApiCJLLhCZ
xXQmOnvrPCtOfsIJWKY9Cad99YuvpvwbMcst2Ywmq6Uv0hXFrqq6oZgPatLVhfkN
34RpU4Hcp4wj1y+d9Wa61jol6KmDpeiZp1cOGXvWvEmdJZ+fca6AZgzcjywCLGZt
ldQtGkLBTZBFXHmY0/XrogSOLJt8bHHD8FDy85utSg9pXd62sF+q4RjJJhIYatoe
JQ202WMfJrjhAHrvXV88NZQTCXeRWxTsXOH4aqQt2uh6FyfS0QrGDFdN9xNk2Qtv
yjGUkuIcvJRCZpE5vJevs88IJdR8ZA==
=RiQo
-----END PGP SIGNATURE-----

--Sig_/7FK91ThomnWS5sQagZdh7tQ--
