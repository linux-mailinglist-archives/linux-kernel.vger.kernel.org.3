Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3664CEDA2
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Mar 2022 21:18:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbiCFUTH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Mar 2022 15:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiCFUTF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Mar 2022 15:19:05 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E64513DF2;
        Sun,  6 Mar 2022 12:18:12 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KBXw31WD5z4xvS;
        Mon,  7 Mar 2022 07:18:11 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646597891;
        bh=ae2v1IHr5aZ4cMtrLs47tDGL85Nws2DWMSxkrLHVRv8=;
        h=Date:From:To:Cc:Subject:From;
        b=f1/Y/Qu2BPIsszJxD9PxUqoDKZ42DrwB/BTyg8hTfPwPuobLuDcOcR4vEIj5eLSvg
         hqYWhlfBA5n3+KPqXp6RsH2QURckd535ooz90FqUJCTokGLkl5V/Cmg+QpWo8eWrgW
         pzSGQIym93FvL5GuBCZITkuRwUDXrwSHIrVa7MY3MLBAlXQqFUNhYTyudUisaERCHb
         foGLqG/tG04px4tDf+OtSuGj0CJ4Hn70gwTN0xz1mAnXzk20Gh+z2suWh3KUZqVMGQ
         woQ5DLPhZQxXaEHf513ket0DRcniLPr/aJmCUpp8wHR67PR7ad/46ITUUPJoeK3Pve
         wz1Wcs6TG8AEQ==
Date:   Mon, 7 Mar 2022 07:18:10 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the fscache tree
Message-ID: <20220307071810.42cff3b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/N_NjM5MklAPQeb5.nl4seKm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/N_NjM5MklAPQeb5.nl4seKm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  2cdefea9850a ("netfs: Add a procfile to list in-progress requests")

is missing a Signed-off-by from its author and committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/N_NjM5MklAPQeb5.nl4seKm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIlFwIACgkQAVBC80lX
0GwGzAf9HIe4kGjBsUE9Sp3drJ4BdVEsjz0/T+TIsJA/zdTYQ6NbrE8gwL9YqZij
uWEuAcFLry7hL1ybpwYg3PX2hSULY4ePZk3ckqSwo0+bHjaSTcNMXKUj7aqvXqI5
v+0zktw9x0s6R22H3Dlj8dmOj1i55RYoUS/42dKuR36tNFJFX/d5NMKbrMdwyfiO
PVMM52mugKbL3rt1QX5QKMO6hj9uYoesBO3jsQy8Hpw0MOszTTZqkebSkQQBaNyF
yEbzG9p2wYHKJsvkv/D/VLr0YkTNJyRivPFVURTEZAwP2Mjo7qmmY0Vk6fiMbsv9
Q1QZ1oBI6TlqMkJ5wz7dv3WtEW15VQ==
=vnw3
-----END PGP SIGNATURE-----

--Sig_/N_NjM5MklAPQeb5.nl4seKm--
