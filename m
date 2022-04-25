Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16C3750EB8C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbiDYWYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343680AbiDYWKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:10:13 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B891D33F;
        Mon, 25 Apr 2022 15:07:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnJyg3zk0z4xLb;
        Tue, 26 Apr 2022 08:07:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650924427;
        bh=8W/XQMfl13oPVMn3H/dXL2UEr59p5Ucby+ot8qSJ6hw=;
        h=Date:From:To:Cc:Subject:From;
        b=YrpMu9SJ0cRmhOgd8zLvq/5BYbf0jtO5z6XZ4hhR2PTrJOrcmRlUOUy2giPQgCt+p
         OgCiQW3dpYFFgR4ahDwtMuAfLrsLD6h6I4wW64UN4qvz2lsmZFuBGxkVz1C3Yl4qlw
         S6KuDZzMBQEvmaaFMQKyvR9nJfqX4uIGs5O5Pr6QxyvMioJlEY+MZAcfcXlaZIHaZt
         QQbd1JRWN6Ub0/WfsVodpWGFaqWhkAfmHBHmyWrNb9ubeUTiajgD/oeGv5z6hLlgcr
         OBVshZmLUWdwx8XJXABrcNOYYX6xy+ZEMQvDp3SY3al2P33YBxalon1AhXu5L+/cOH
         yD2JSB9e9e9uA==
Date:   Tue, 26 Apr 2022 08:07:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mediatek tree
Message-ID: <20220426080706.26c6816b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MyGZ3Dh2DsRjcdKT49YsKkP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MyGZ3Dh2DsRjcdKT49YsKkP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  775ef8aaa66e ("arm64: dts: mediatek: align thermal zone node names with d=
tschema")
  c8b8db1a173d ("arm64: dts: mediatek: align operating-points table name wi=
th dtschema")
  c01d9aa630b8 ("arm64: dts: mediatek: mt8183: align Google CROS EC PWM nod=
e name with dtschema")
  75a3c81bc634 ("arm64: dts: hisilicon: align 'freq-table-hz' with dtschema=
 in UFS")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/MyGZ3Dh2DsRjcdKT49YsKkP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnG4oACgkQAVBC80lX
0GyHnwf5AVVusdviDPGwJRcrItMi1tSpgB44cQeOTxF3OrEsMycpZA/jJnBfDcu2
4l4WEjUYtjBK9gP8t/mEie3d8lH3Twm4q2zx60cio/JN+VJ56m1Mqp9RgFNimhB5
VEZxoEneg47vxmMqSXkAEit0Rm350GK1NSG0TZZqOaLNyMmhbHvlz213ObgIJAhb
SXXtcxr4fnedP/htogeBJpU6VItHQHLWxhTTS+EA/HK51TmC8GumaSbXiMiMc+LH
kdnrNRN2auSfCvoK02U6wmL9sjJcTmnoYkE0CBgvF+zdue+XLhs2Xwfz2WoQX399
M9zJkBOC6KuPaZFiRanlPSeAq+u0pg==
=IAHA
-----END PGP SIGNATURE-----

--Sig_/MyGZ3Dh2DsRjcdKT49YsKkP--
