Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE02950EC09
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 00:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiDYW2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 18:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343666AbiDYWEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 18:04:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA75C2AED;
        Mon, 25 Apr 2022 15:01:05 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnJqg1kSNz4xXg;
        Tue, 26 Apr 2022 08:01:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650924064;
        bh=dgnFnh2YS/OljHj75zTIC3khtGaTUqgjpX5MlFKzM4Q=;
        h=Date:From:To:Cc:Subject:From;
        b=nBrOzIE/jnw2fYnZHezA76Go/OuTmo0B5vnyRcV5ESPlZaiMNvqht9xniXg3qSq5h
         GwuETu2D7zZwpsZo2N9k2nrV7JpA9IWjLKtz7Jqe0EcufcJORFlu3Lv1LHX6mWJFG0
         rcWBCI92sPk2+vN2lJfE6R2oYiqME/fo4TVIiT3KmT5R6YvjMsM7wPwiuUmk0FJ8V+
         MNrCCW2wd57tn4O9l7MyTp4ktjmEtDjZYKmLJ4RHpUF9zhff1ay9NPZEJon8V+QaaC
         Ah1cUNGPLd6ZVyHbQiUhV5/cxRALe3NA/C2YDZn4tierXxtyOYkZg7ubCnLS6BZEkw
         kSf5/d0EEC2NA==
Date:   Tue, 26 Apr 2022 08:01:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the risc-v-fixes tree
Message-ID: <20220426080102.7263b1ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4W=bcibjLyqA/AB+tXQ81R8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4W=bcibjLyqA/AB+tXQ81R8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  760d10a5b792 ("RISC-V: configs: Configs that had RPMSG_CHAR now get RPMSG=
_CTRL")

Fixes tag

  Fixes: 617d32938d1b ("rpmsg: Move the rpmsg control device from rpmsg_cha=
r to rpmsg_ctrl", 2022-01-24)

has these problem(s):

  - Subject has leading but no trailing quotes
  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Please do not add the date field, it doesn't add anything.

--=20
Cheers,
Stephen Rothwell

--Sig_/4W=bcibjLyqA/AB+tXQ81R8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnGh4ACgkQAVBC80lX
0GzZBwf+NwiZvKB/2XcuIYCSy15T4iTXkawUORbcQ7+NjS6oJrC9KdUsxh9K1/uc
1NMzV69oPG7e/K5OAcLFa7kiXKdBBYm+fPjEuRNnAMzwbB5zefRyX487Qmdb1oZu
IGv6WAKNQVZSmXopDp2fQgL8LIDV+JWL/5YipZ06vLPRnGtAcUGDUKfX8UjX9FIU
9iuRYh4u0wMxYXiz5ATPpKIs4Ff6AXxOzCPyMd/zN1TdFdSlwsx+jmSQnGIW4EKx
XKavL5xNId3m5cAQJ0ISdsdXA0dzprCSPjubWtEYyqnUHhpBaLfBtZHv1+JYm7EH
vXwHWTTCVSd/Ayd2bzZI7tse6GRS3g==
=KGrS
-----END PGP SIGNATURE-----

--Sig_/4W=bcibjLyqA/AB+tXQ81R8--
