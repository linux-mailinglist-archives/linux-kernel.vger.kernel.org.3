Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10FCA4A329A
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 00:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351484AbiA2XXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 18:23:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238951AbiA2XXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 18:23:10 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79062C061714;
        Sat, 29 Jan 2022 15:23:09 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JmVjz37dQz4xcN;
        Sun, 30 Jan 2022 10:23:03 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643498583;
        bh=SxN/2ugBVfaI/4+xVgJJ0hH3WGsgXTSrK65pT/q6KR4=;
        h=Date:From:To:Cc:Subject:From;
        b=nw0OUYt3Sd7aXz2WdhtT7vlWfFlXg0q7XSQz60afOAcsrjyvDQLiiY93Sk6ffUv1h
         r8bPC1fPvmyV871Qq3Fu+C3NhHr9U7qZeqo5ZoQhF1Tm6W3QgKTJaVxNjUx/FKFo/s
         B6jAtzeVUbFjp0sVHTkbJO9ZC1TrM5Tzt0vBHNpYXLCNry0ViX8xlI5AZVu1FNJpQY
         QkOtpWMK9byGL17vAndOO0M1t+UZ+7Z/f7JDJa0fKR0FYvmJqhICICNueTtEnCySPR
         66qsSGZv+HPVEeKXH8WSpHaViWOzu9QQsXpFIB8T3Keg4/z3/ySNscXkKWErDJtY2O
         JG311EEQ/xj+A==
Date:   Sun, 30 Jan 2022 10:23:02 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the rockchip tree
Message-ID: <20220130102302.698a7551@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/xQXFxOSoM50oyK0_sAbP=9A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/xQXFxOSoM50oyK0_sAbP=9A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  8c318aaa2000 ("arm64: dts: rockchip: fix Quartz64-A ddr regulator voltage=
")

Fixes tag

  Fixes: b33a22a1e7c4 ("arm64: dts: rockchip: add basic dts for Pine64

has these problem(s):

  - Subject has leading but no trailing parentheses
  - Subject has leading but no trailing quotes

Please do not split Fixes tags over more than one line.  Also, keep all
the commit message tags together at the end of the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/xQXFxOSoM50oyK0_sAbP=9A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmH1zFYACgkQAVBC80lX
0GxrAgf/Skh0jQzGNH27+MEUw8u0Am48iG0txW+52GLJq0S4ARNlKGr0IwYefbOd
5A2B6kZB8dyUjcOUD7mcy6aq3VMY5iLrL2HEf54RSD8ldNY+egjeIDDbut8l+kDs
ZMTcfCMq70zsTUafibt5pbR5p4U9dSxJx8NZ1UJRiKHrX89FC0pyhFQHIFTC4UXj
g/VO/7vlpoDw4SoPUhLuOLkMVO1u4frpZSHAH4dthb1U5LBahW7CzYDlrjcKxx9e
WRbeOTqip110+DqbIjeGJprbYcEgETB34DgOA+0EQah4T7tGdjR2YGFukElsQ25r
dWD+fPcKQX7g4gzEqPkbiyh0zpsZ4w==
=WQzr
-----END PGP SIGNATURE-----

--Sig_/xQXFxOSoM50oyK0_sAbP=9A--
