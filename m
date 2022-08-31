Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3125A75AF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 07:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiHaFZL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 01:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiHaFZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 01:25:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A93B32ECA;
        Tue, 30 Aug 2022 22:25:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MHXgL5SJ3z4xG6;
        Wed, 31 Aug 2022 15:25:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661923503;
        bh=rToXtjYtY3zb/Sys09il3li6xaGHac7/vbOjAjgOJkw=;
        h=Date:From:To:Cc:Subject:From;
        b=R0mSNm9m/ivGDg6uE8L0flgFfpixYVEKh7NqTIDTITC8h4WpsXkkEr6xQcNr8eTj5
         +v0qBLX9/ArOx/WxnJ1aveKmFxtAW36GNvRhBQ5R9cYWFjccGVhBbs9DLhWlnQsS0W
         XtK3jIgi/R81H8qd3EKdfAmbGWTChx2a3tU/T0KEGiitqWoDVDtTo9/k266GU/Q9iZ
         8HUuY5oPyNonUlshYEoqtEtexl25KKsf54sfJK0J83cDot1+nJ2iNaWtYMHOJCXf9D
         m+PnTYLPd7LLOdwCtgYXUbyWPGotonQQuSymbVUyEKvlb6l9vzaDBF1RtATqGTM/bc
         n/seAagJxh9Yg==
Date:   Wed, 31 Aug 2022 15:24:58 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the usb.current tree
Message-ID: <20220831152458.56059e42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/u_I3KNqHV3X0xtfMcb=NP0y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/u_I3KNqHV3X0xtfMcb=NP0y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the usb.current tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/driver-api/usb/usb:176: /home/sfr/next/next/drivers/usb/core/=
hub.c:6040: WARNING: Unknown target name: "pre".

Introduced by commit

  9c6d778800b9 ("USB: core: Prevent nested device-reset calls")

--=20
Cheers,
Stephen Rothwell

--Sig_/u_I3KNqHV3X0xtfMcb=NP0y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMO8KsACgkQAVBC80lX
0GyZYwf+KZoSHBCRC0VQz/SnzM1X8SVIIRcHrwTbc4U1NjNwoWTOijROY6P8fDPP
1xhIieBuFbsh1kA2/zB17Gd1EO3x0haemF1bCXsfISqGBPyci4jdh0lnblFenOJy
+O/vHsXFQRrLXeLYmHfQVOYNcz2qZ8cXIU5piNGzYCH2VCdqcTOfDOgCWHgbxS5m
Jt1wPqAhBt4k2NGMG31QHtRvUqdxuYaHDQaCv3nois9cI18T/g8JUzlhvrfFmmLu
INcYg+mUh04L11DSggG9oHABldgDu2Im9kIEcScaN/R6Ko/EYpHW0xITJ4vGqwIA
uPT0OecelugxkUnbhImbuYXy24c9jw==
=YCdR
-----END PGP SIGNATURE-----

--Sig_/u_I3KNqHV3X0xtfMcb=NP0y--
