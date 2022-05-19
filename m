Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7411652E037
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245638AbiESXCO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiESXCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:02:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAC524F3C;
        Thu, 19 May 2022 16:02:11 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L45336NB3z4xD9;
        Fri, 20 May 2022 09:02:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653001328;
        bh=rBUXIaYvBaLHaORqdPDKoBqIalDVISEvroC7wciMFRs=;
        h=Date:From:To:Cc:Subject:From;
        b=DXvGdvxIJGIjqOTTbAb4jqH7yOm6OeRsQWHIOdCZuP1yY09QBvbivWGBVSbCH7ySg
         gTiydclLD1HGBOe7clVnvzLtKlj5YoVs+phHpkBmKt+gEYyYt6fsP4kfmlspaxElxH
         M5o/PBjcBX7r8R7ohfhsYTyGrlmLyumnAPjiRQSBRbusYddjyOgs6IIu077TSyuOk8
         f+WbWyqo051NSmvT1gfYlTJ3IXfFpIsmDlACMaFw3hjg77Yyc8mq/YiqMv1R0qirgu
         3IzPgoejKCWSvwAkL2H3DeL/X48Sg8oMKz/ESIRwJOiLtyHFtzyr4VeghRJSIO8k40
         v9T+iUYAEMJ8A==
Date:   Fri, 20 May 2022 09:02:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20220520090206.2cf07c2d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/maXGSWe_ezXCDx0N01I=6ek";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/maXGSWe_ezXCDx0N01I=6ek
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  42d2607d91c4 ("PM / devfreq: passive: Return non-error when not-supported=
 event is required")

Fixes tag

  Fixes: ce9a0d88d97a ("PM / devfreq: Add cpu based scaling support to pass=
ive governor")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: a03dacb0316f ("PM / devfreq: Add cpu based scaling support to passiv=
e governor")

--=20
Cheers,
Stephen Rothwell

--Sig_/maXGSWe_ezXCDx0N01I=6ek
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKGzG4ACgkQAVBC80lX
0Gz4QAgAjzUIAzBDkMMxjT/ImwQZKyITOhl91INMf6vym+ZCv5Zzwv809YHekjOr
MJuc7zqVLibb+9Y/NP3w9olqVsWzhMDaObpv+1WWTey4jMw1VjKpHsL7+Ems0Kfm
u3wE1z6SUB/vt5XRQ8enMCNJMrf4uHsorZ6GH5DpvJRllHRcjD9gll/a/Hotxk0o
XEZJJyynsgEr9LhBE1HJQfpez1c3mrDiTb5Ik4wAKtKLmlMFUdSY4LfIrsvODGn5
QHVb+/qMKK54FcJA+YKFuoCmO9K0uh5aV3uoUGUTURoArQwZjAwEfIeVpfmiJ069
EOiE+/TJJ3lFkqVpBmNEFbQee6YGTw==
=SKjy
-----END PGP SIGNATURE-----

--Sig_/maXGSWe_ezXCDx0N01I=6ek--
