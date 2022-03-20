Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F294E1E06
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 22:48:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245410AbiCTVt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 17:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235433AbiCTVtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 17:49:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E904344E4;
        Sun, 20 Mar 2022 14:48:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMBFg5dwzz4xNq;
        Mon, 21 Mar 2022 08:48:23 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647812903;
        bh=HoPeXE78L27hjnpG3H5ey77XtOD5evIdjLZRv91A+1c=;
        h=Date:From:To:Subject:From;
        b=gFgJ7ms2DGk8ueVlsyOTypXAdJvujq94KHPbWMIY0hHtVUSkMNUHr0a95qc/q5OeA
         L7R2RjP0RAsu2cZbjNhLQchBjICzTbARx9CDiICFRzAXWI82H20/7Vk7Ctr1w2kKOM
         UocYgxNew38H02S1w4w7hajKhpoGsiuI7rokweI8b+g9FzdWvEadbvmNV0qmjxhGUu
         kYZhJrTCpaMn2bUR/eDHuQ1ViK8XMcwGU5Q+D/5EZTeZ/nl/q9cl/H16vWskaMJSPT
         r7/E3BK0KZ79qFfw3AIBPmYKmEJzSsehaoosJbKqDH4eXrc5/mAslPwyUFZDOLewYB
         ks/gWfg87HRyQ==
Date:   Mon, 21 Mar 2022 08:48:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: the merge window is open
Message-ID: <20220321084823.6911700b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Q2YO=GGGLlaNaZ6EN3k3Wk/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Q2YO=GGGLlaNaZ6EN3k3Wk/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Please do not add any v5.19 material to your linux-next included trees
until after the merge window closes i.e. after v5.18-rc1 has been
released.

--=20
Cheers,
Stephen Rothwell

--Sig_/Q2YO=GGGLlaNaZ6EN3k3Wk/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI3oScACgkQAVBC80lX
0GwXfQf+JMYj7z3e41/HMwUpf3xuCDgEhhKJ25uX0ePXQNZ1DLyOKcJFZ65XPYcE
7hRH7pu8xp875fXrMcfruSjin/hCqApcdVkQMBN8dNzlqSxQboYY7WK3n8psE79l
TDTuUm9dqS6ppZLIOuV5jD+eFCKe6ZHgSaK3mSUhNYS2M/f+kXjnWcSPhLJfat8z
Gk9olm9udDBGgOnzUsXw0Lf3YmVLuZoevoEV3g3DzjSImRnzJNEFDyF3v7KoPD/o
gGv7MKofGtKGuSnJyo65xccECmmIleYQ4HidpDKJxGfx1KA7RLVMeYN3ywAA24xs
N76oM8o6Rki0OzprHR7oJACNpobQMg==
=Z0/p
-----END PGP SIGNATURE-----

--Sig_/Q2YO=GGGLlaNaZ6EN3k3Wk/--
