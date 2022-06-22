Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E18A556EF7
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376324AbiFVXVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236091AbiFVXVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:21:40 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35C0419AC;
        Wed, 22 Jun 2022 16:21:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSzsr4Vnzz4xDB;
        Thu, 23 Jun 2022 09:21:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655940096;
        bh=lgLuZj1ojYBewJrZNkD9z6NnuoB+nEmKWA6B4YvZoQQ=;
        h=Date:From:To:Cc:Subject:From;
        b=exzw9u2tnIBN/nI7BuPZ4ACTKiFkuXtLrtqEyz/yjjIIwKgY7T39QyskzC1E/bHsB
         0f/OPqu2Tefm3O6HVOcL1UuAqDUFit330ipyK0mrNsXkGGIom5MxCl8LUZObhuHKrO
         BtDKYSLy752SGtMBjkVmyOOAocQ76RjGYbWwEKbXe8dDP91VEVbA7Iv0So0ni553Yx
         1PkVW3WWED2si7GSrsa/jIMFlYBMnvnJmOguY1iHwNGSxt9UyOfVq+KUbC9xNeRe6M
         G5uyRslI//98qQK98on6xsYpW7f9VmBMUnof+vZr4bJmJC1i8kJAgpZ3rgk2hxB2gd
         bDP76++VhZYFA==
Date:   Thu, 23 Jun 2022 09:21:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the cifs tree
Message-ID: <20220623033347.55c86333@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/o6NPBi2CbqexYCeonJFXu63";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/o6NPBi2CbqexYCeonJFXu63
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  cf1f97ccd084 ("cifs: periodically query network interfaces from server")
  3864f0cfa996 ("cifs: during reconnect, update interface if necessary")
  e0a746e20c4f ("cifs: change iface_list from array to sorted linked list")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell <sfr@canb.auug.org.au>

--Sig_/o6NPBi2CbqexYCeonJFXu63
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKzo/8ACgkQAVBC80lX
0GyfoAf9GudBkq6CiSs3/PCcwop/mAHS0gVPfWPVkaycZV80wQJ3A7+/lacK9qpO
grn+5kn4nmC+Z34OtKRk/UPRX229o2opINBB+uW3EGz+hPd9+yvm0I1Fmv608vtV
QXtWGmEEJIZAjjvcY0YNCvwCImeH6VvY+g7vATIVeKSIgrhkRWYMmHLuNrJnxk+g
43uR0eMwDVOeBRyrusfwv+6EeGIukI8YrnB/NgugRaVdq3tdlDhA7XVfeHnkCvuN
OoWohM2bw6SAYxQCKwePEKh6Yh5hJLpY0LFEo+s6r866PJt9ioCP3u45jFMPFynB
C+ZrNUZKqD+JMQTViBf3nKn8ljsUKA==
=V6c9
-----END PGP SIGNATURE-----

--Sig_/o6NPBi2CbqexYCeonJFXu63--
