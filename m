Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B260257B713
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbiGTNMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236361AbiGTNMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:12:41 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3827C5A46E;
        Wed, 20 Jul 2022 06:12:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lnx2F2KxSz4xG2;
        Wed, 20 Jul 2022 23:12:36 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658322757;
        bh=UgcaYd52fK9rxL9lClImIpu0JM8bSZKpwP4533wob6s=;
        h=Date:From:To:Cc:Subject:From;
        b=K3efgTV4RjUXtVxV7I4HTb0JpRvWfmRWMgF0o+JnWa7WMw2vSjP93oshdj/zaRuSS
         pFQxvNIv6nmWKR4oFOg25Obdf3v2WVVAgE2igNQVent7WiSrR4nhhQ0IZYtnBJ5ASO
         Z5kuiKfZ/eplAUlj+1xBuxeYvS7mP76hTQdNugiJ2kPV3d9jjUS1lT0y/T8HD7p2lX
         EPF3gHnsSDARV0qMVv3sHX3qbweVahDMiwOotUWdfoQNKhNxpz7R9xX86urhMx68ja
         ruT4AKeCBXO6gOewUR6wIo9DeKTS8m3+U2Oj4owlD/G/i7HiOmfmuEmxrvvcma1Pt6
         LCkF2+J/G0eSg==
Date:   Wed, 20 Jul 2022 23:12:34 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the arm64 tree
Message-ID: <20220720231234.71813cff@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ePAZfnM7yWnX5H8yTzoEVOz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ePAZfnM7yWnX5H8yTzoEVOz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c2cbc16df707 ("arm64: fix KASAN_INLINE")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/ePAZfnM7yWnX5H8yTzoEVOz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLX/0MACgkQAVBC80lX
0Gw8kQf6A66uQc3ZoA6SuxypHAOXTon6FX+dozBhtqu32o3kfB9NzPJBjX4viVN8
MuWcGEpsmwGwKXr7ETEqEf3dM0xRpDG4Xk04K0blERmRZe9xtVg5X1K9DrhwgLgC
qCBu1TNKsbEi9wpwg86wGE+2iJylOnMTKqyGkQU/Nb0HtCbxd0geu0Q3VRZPMl+q
DG9pwG6Wg4Ux5YHzOge6YguiwsaZ0Gauiiqj3yHROZVJiKQ4elOSnKDrhP6zGWiP
cljWI0IlLsV+bttc0hWeyvdTrWjSTtqbdwRN6PB3gCM18p/j8slCmu//1xS0Ep3v
sTQfgH5J/BIFlHmryEC83k+d0YML0w==
=C0Fk
-----END PGP SIGNATURE-----

--Sig_/ePAZfnM7yWnX5H8yTzoEVOz--
