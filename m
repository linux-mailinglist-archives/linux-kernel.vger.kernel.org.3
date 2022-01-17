Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3215491156
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 22:34:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243284AbiAQVdl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 16:33:41 -0500
Received: from gandalf.ozlabs.org ([150.107.74.76]:32773 "EHLO
        gandalf.ozlabs.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbiAQVdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 16:33:39 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jd4sF2Cbrz4y3l;
        Tue, 18 Jan 2022 08:33:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1642455218;
        bh=dxyMmoCI2iamV+K5AOg8Gxn3QgQLQ9oGvW3JSc/Fx/Y=;
        h=Date:From:To:Cc:Subject:From;
        b=u3QTJzyYj9f74EpGWPVpTu1GEeXkSxremR6bzTXJuVgry5a1urXilru4wmR4sW9IK
         cRBjbvl0M2ochO5Ahw2vCu53y/g9I7DrHiR86w98bnPlI8lDQF3lfxSJivAPJHqWEN
         +I/hww9POMm6ZwamLRawSBzoQUURBjs+IJFQHDiI9tIOq+3euyfGcHeZ5gESP9xa1b
         MCP5DblbwuUF5M7R92wxNkh8exOP5oSsfI0dS47P4cy6ryE0T4kyqgOUP6BsGsJLz8
         CUrfEcOnHHjNAZuDS+5V1R5d/ctXSLmTkKVIkYBHKxLnefU1oZv+w/JihTkbH/hoAI
         sDUGh82cydI+A==
Date:   Tue, 18 Jan 2022 08:33:36 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Helge Deller <deller@gmx.de>
Cc:     "Z. Liu" <liuzx@knownsec.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the fbdev tree
Message-ID: <20220118083336.25b0bcd6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OgB5UjU7QKeZxbB2dVsuSr4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OgB5UjU7QKeZxbB2dVsuSr4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  a274f635669a ("matroxfb: set maxvram of vbG200eW to the same as vbG200 to=
 avoid black screen")

Fixes tag

  Fixes: 1be60bd66d54 ("matroxfb: add Matrox MGA-G200eW board support")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 11be60bd66d5 ("matroxfb: add Matrox MGA-G200eW board support")

--=20
Cheers,
Stephen Rothwell

--Sig_/OgB5UjU7QKeZxbB2dVsuSr4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHl4LAACgkQAVBC80lX
0Gzt+Af9HvSu9x9USKClaQ/r0/8O96HYqfasU+oCQyTHOilRYZ7IsbQEtNynS2w6
NVRFBc2w1Wz06EYV3Xfq7I0vnsYHMKRvwy4mfJlU28L9DIkoJyyNiytKucFMRNWM
VaXl5eS/7lqV3rD+4NBi48SDIcAgRhsngz4SI5E//oF2iU2KCdFZ5ttx8XjhZpFU
1Swm1JT3onNgcNQATH/G/lyAQVTbsmXxozaB3I3q8JRxaYbbyJ8xkO9oA+8/DDgI
dGJcdsr+xXsRUSyrdSlZO8SZN8yGckPTYphTC2fp+uPBeFU6vDPdPY9tY4uxFvEJ
7D9DankQyNznj7ewXeiXvt6Q+lNbrQ==
=7RIH
-----END PGP SIGNATURE-----

--Sig_/OgB5UjU7QKeZxbB2dVsuSr4--
