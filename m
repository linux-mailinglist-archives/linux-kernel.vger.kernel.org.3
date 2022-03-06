Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1227D4CED9D
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:15:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233386AbiCFUP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:15:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiCFUP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:15:56 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA449F10;
        Sun,  6 Mar 2022 12:14:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBXrG5M6qz4xsk;
        Mon,  7 Mar 2022 07:14:54 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646597695;
        bh=ZELYOeR+h1ZLQGtay/Jsd6ULBdk9wfcSTGD/Vxdigno=;
        h=Date:From:To:Cc:Subject:From;
        b=oLi0X0vEwpJaQtSC6Womn4sm51hr1M+Xzh95Wx/FVgYW8KZAVVO6+Oymy6xOBH92l
         4a3t+ukcqS7xy+5hW6K/BUmlPjUJQBInNrpyMjWtb9yMFHuclUNmTSCT3vwb0y4Umt
         5gqC/z3z8YBWoFFa6QHKyFNiBKjDxRL9FSR45lJcLgy0qsKhSC5GQZnNZEn/jcMuia
         dEl3H7hmjX5s87s5MJkMxg5l5P8yLACFZgE+qJtmCuNecBR64JEAs237mobDm28xEQ
         VXwpPJaK+imsa6iRNCw+PAi6fnZNhmyL+OhBmLWuFOHoZeArsKlt/zIrUx6R8Ck9Xp
         R8R5MJlurjvYg==
Date:   Mon, 7 Mar 2022 07:14:50 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Nicolas Ferre <nicolas.ferre@atmel.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the at91 tree
Message-ID: <20220307071450.3074a015@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kM8/5fP8sXQZT_YtXvb8x7O";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kM8/5fP8sXQZT_YtXvb8x7O
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  d355edef55ee ("soc: microchip: make mpfs_sys_controller_put static")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/kM8/5fP8sXQZT_YtXvb8x7O
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlFjoACgkQAVBC80lX
0GzVkwf/dLXyWMh4swzsLePGrsviq7UNIdAhV9Mcd90b3RYkJ66Fhyb6f/pal/qs
/cXDD5ltnpdIFGlXxIhqhN+LMlDEqVWgfA+XhGqWEignwidK37v9fXqKhn2+oq56
TMEz6DgnVCKXiDYq0InJlPhe9r4WlETDnMoBbcfDEwcdFTPdIKf14KEL5+UfDvx5
QviMcUK5gGqviuPS54JNnD0hIpn0reSaxK5VLguUWY6LPoJr81JrG+84l/9ZLaSv
WaXsWxQViJgkEeMiiD8oQjO9SJ/fHhh7XcGGbzWtYrioFmv+HPLbALtpYStwvhPl
FVX9BbN2YMtDVHwngUE5Vw0RBBQXVA==
=ieaR
-----END PGP SIGNATURE-----

--Sig_/kM8/5fP8sXQZT_YtXvb8x7O--
