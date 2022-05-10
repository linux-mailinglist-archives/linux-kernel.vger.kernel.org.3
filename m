Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E8252268A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 23:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiEJV6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 17:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiEJV6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 17:58:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED5511D2FDD;
        Tue, 10 May 2022 14:58:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyX3L045Kz4xXS;
        Wed, 11 May 2022 07:58:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652219886;
        bh=6GChWQrA2iMjHjKTPa0QrKD3wmIGoLXgJXZQcqrj+JQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Ow/ThKkMhO+wEJqLx0LHEwLhUfGdGbpjxm3IqUmjfh3yOfWvbd+XVaowok88r4kjU
         YIU+Q/4suM8PwKVb/+/wZdGIFjZl40Go3rGyJJZYuRKFi5OYmQNh0jqzMlbhoZqAl2
         W3UG5jnQBAaNESCV750kCVOmBTzwqIsxiylrPGlhMdTEkuMlRkOyD1pjc9cxoVuNVY
         43O+NRT6qSsnadlzkGIvfa2vM1BAUsnJ8HpA6OxMWrC3nyDs3C7UJDHj7aHZShAtqW
         zdTe0BLF5Z9w1CxmPpORr63pz01MJ/YfiioNG/6byEMfQSnpwsrCdJiy4p6OXab65k
         LzFe75VQanJNw==
Date:   Wed, 11 May 2022 07:58:04 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tty tree
Message-ID: <20220511075804.79c5b697@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jU6m7ogx1_4gQHK63ts_lyz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jU6m7ogx1_4gQHK63ts_lyz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty tree, yesterday's linux-next build (htmldocs) produced
these warnings:

Documentation/tty/device_drivers/oxsemi-tornado.rst:41: WARNING: Inline int=
erpreted text or phrase reference start-string without end-string.
Documentation/tty/device_drivers/oxsemi-tornado.rst:86: WARNING: Inline int=
erpreted text or phrase reference start-string without end-string.
Documentation/tty/device_drivers/oxsemi-tornado.rst:96: WARNING: Block quot=
e ends without a blank line; unexpected unindent.
Documentation/tty/device_drivers/oxsemi-tornado.rst:100: WARNING: Inline in=
terpreted text or phrase reference start-string without end-string.
Documentation/tty/device_drivers/oxsemi-tornado.rst:100: WARNING: Inline in=
terpreted text or phrase reference start-string without end-string.
Documentation/tty/device_drivers/oxsemi-tornado.rst:100: WARNING: Inline in=
terpreted text or phrase reference start-string without end-string.
Documentation/tty/device_drivers/oxsemi-tornado.rst:100: WARNING: Inline in=
terpreted text or phrase reference start-string without end-string.
Documentation/tty/device_drivers/oxsemi-tornado.rst:100: WARNING: Inline in=
terpreted text or phrase reference start-string without end-string.

Introduced by commit

  366f6c955d4d ("serial: 8250: Add proper clock handling for OxSemi PCIe de=
vices")

--=20
Cheers,
Stephen Rothwell

--Sig_/jU6m7ogx1_4gQHK63ts_lyz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ63+wACgkQAVBC80lX
0Gyc7QgAlzmDDJdKLu7k57f0+LwZYw0N2GfL7lc8thUGzQSXhnoNu5z4qjIWsI/A
7QmQDPx0V2TO72oxDMzkW6k2tEScB6T6qRNGsKSONlrGJ0AQ5h2NFNH7VSKhm17p
rfCb+xWLwIMNZhpd/yJ87OSL5wC+YDBe506ixBn/r5xuugaCKZhV0sB1y+3iz/jM
/bz52VPKzTt1BUB44SeP++o+wysj8oV31snrzLusNBnEEoLrhh0+eWara+1cPJ5T
uldy7QdZQzDwN6tXGQPTiyG1YeMzbG5FXFXcP8DMdyxyoKAr52R0E8SuHAk63v0d
kLEJGlIjFTNh5GQt6wHRhw52z//dvg==
=fp4Z
-----END PGP SIGNATURE-----

--Sig_/jU6m7ogx1_4gQHK63ts_lyz--
