Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8304E47C0
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:49:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234385AbiCVUux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229827AbiCVUuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:50:51 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1321A2715D;
        Tue, 22 Mar 2022 13:49:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KNNrX08V3z4xYc;
        Wed, 23 Mar 2022 07:49:15 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647982156;
        bh=3nS1/X02do19nDNCnja3PIkKtB54dsHaWd0f2e239Kg=;
        h=Date:From:To:Cc:Subject:From;
        b=Gml/U+069J7fr2ZlL8h7/Kj0buItIPk7TJtdLKda7ZOW687dqAOlrEDxIhDnozWvs
         qB1elNkkQla+6i6kCVVRbb/ZxPLpvUmu5HkluwSawUUuEDgzXGNzL3f5AaPrmsLiNJ
         ticS+59yH56iE9vuP4Hs51oyrNnggj3mk35D4RP/fuRUdwtk+3V9/ffET/+PhOMAAo
         RkM09XNWkhekqB3u66UWz3vU6+dnRAalRyErM/SlYx/SOFjD9QqE63PlgK81sWYnUj
         rNILNzYXVfSugnd4H6HkxYM3rf8PWNZfPH1QKMRZ2jbqPpkwdG8SBJT4C3noMBvjos
         A2UotVMmVAPkQ==
Date:   Wed, 23 Mar 2022 07:49:15 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Keith Busch <kbusch@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20220323074915.7cfb312d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nvTsGfHJO+UG13Pil3T1Xm+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nvTsGfHJO+UG13Pil3T1Xm+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c30cf83999ad ("crytpo: fix crc64 testmgr digest byte order")

Fixes tag

  Fixes: commit f3813f4b287e4 ("crypto: add rocksoft 64b crc guard tag fram=
ework")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/nvTsGfHJO+UG13Pil3T1Xm+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI6NksACgkQAVBC80lX
0GyTHAf/VhXnIhGf11KBU5bZ6m6PL1HZcNvcI5ZV8xGdYXkMWhQ+WABfFzJDlwHW
6S9BZ6QOXzFTzzc/LI74mlEpRjZKJO9gd64C36oTyhHusKLHmaIxdAvhlPwyqbdI
zCUFVRd+nqJQeCRetVojsJ8uiC7piQeASH94xuu8b2H039OEVFXVB60qtSXBPdSr
5HOY76UhVUYK5+XI8JvBFdQLOhfshLSSF85Aq6l0xTqG4653ekrBv11gAOH9EUU/
5B5NJl6QR63QttVjTkzP0Yq+o5Ww/lSNf9Brwz7PuhdocOzd791+1D2KURtDMANm
l5ehOnIeG0CioRE6nHqkWm2A82mN2Q==
=nrtQ
-----END PGP SIGNATURE-----

--Sig_/nvTsGfHJO+UG13Pil3T1Xm+--
