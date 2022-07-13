Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1BDE573F8E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237186AbiGMWW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237330AbiGMWW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:22:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87D44B0CB;
        Wed, 13 Jul 2022 15:22:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LjsZL3m35z4xht;
        Thu, 14 Jul 2022 08:22:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657750970;
        bh=sTDT4efZZFvdO3HO4lJfD2IL6jQFUScKXQkGERxX3HU=;
        h=Date:From:To:Cc:Subject:From;
        b=NZW7XE3HAKQBKYWb8mZ26JM8c9DlYHJhKLtDQ8mVqmc8/RXyR9oGHvL8zq2Van64y
         rONMBBiQ3s5z7XP5MggzK6jrCnlegn+X+Ee2Bh8rvmQOla1zCTB5YUCXLoRvkB9/R7
         b8t/KQ7FocY8bSpyDR+Dkb0Jf8XDbhoOX0FNi5nhFhfqM8TaN1zfQwAbZV6mZBAMdS
         c9TQulSO5U2LHc5dYgKuHGFcEcio9uhafvbQlaHtF40vk155dSbvXQkx1rTBZd1FSp
         6Kv5v7Ew089gVTrsP4RdGXjHmaw2QUyXs4ccTH2UdwVT8+J5HU8pQcoEs8P4BX6wUj
         7zkJ81+sIHdmw==
Date:   Thu, 14 Jul 2022 08:22:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the amdgpu tree
Message-ID: <20220714082227.4bec9b7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/XMboeF8XRcOHzwE7Z=IhWYc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/XMboeF8XRcOHzwE7Z=IhWYc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  246cefb8637a ("drm/amdgpu: Check BO's requested pinning domains against i=
ts preferred_domains")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/XMboeF8XRcOHzwE7Z=IhWYc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLPRaMACgkQAVBC80lX
0Gz94wgAn7emTyj3htF9fA9kDeEkC3EHfWTmS/wdDantUBMK4Dlw1d45xk6kW9O9
LkRDXoutHMJkcH6qRcvFpzf8EQapR7kFtVqBS3NLPnxc+MnL6kW2DBLnGJRnYTMK
Vq+73of90Z6vkikI3FsI/223vAHE1WnJMJ6DH1cz/biCDNnDKt241R5z8bE0EDuF
2B0NsyzAsH0s7rjgwhPDyJpd+kGc3IjxtHb4nPjNkGwMRHfKcTs6XVwRYi/kdmT0
pvsIc2+29JxJ4TRkHpj+oP1MnVt56aWPFAirHg0CvAtxqSN5/pd1kEtMShPMVxUy
5vYSJXATepA60ane3AMPc4ob95CVmg==
=vmMC
-----END PGP SIGNATURE-----

--Sig_/XMboeF8XRcOHzwE7Z=IhWYc--
