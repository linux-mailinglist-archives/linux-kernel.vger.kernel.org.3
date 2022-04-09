Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5EA44FA516
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:26:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239164AbiDIFZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiDIFZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:25:49 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF08126544;
        Fri,  8 Apr 2022 22:23:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kb3S41h1Zz4xR1;
        Sat,  9 Apr 2022 15:23:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649481814;
        bh=XobdU+KeJLZu1qvT7Shd/7p/QSg0qDaTgRMNjR5XoMU=;
        h=Date:From:To:Cc:Subject:From;
        b=KRRiTcTE/7nWNj5+DEE4q1Jk2rwZkKwnhePa5KtDgsonSbB1uiUgJhPc23Qwxx+6A
         s8kv1MA1KbCOiIO3Ovf8rAW0p1cIHLVHhJzXUQ6EL8ZTYtCYwJBr8gQfkOwXcWz8km
         VDbjEdz68UAtA1GoI8sTZEmy0rug5Oao/fo6v31MK2iYGIXktgvJyz/eqK4oP5XVCv
         2ddX//Eaiax1Nys555nud/3Uf400gwDOyLDWQVGdZuaoncJ8dLPa7qTwSIzKf0T3Ob
         Pm4jqZ66WH3CVnQTjh2aA/dHu9d/v14yEXbresCEoPZyO8m+zgUhhYJYmBxhbRuit6
         vTFTr52uQp+nw==
Date:   Sat, 9 Apr 2022 15:23:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Reto Buerki <reet@codelabs.ch>,
        Adrian-Ken Rueegsegger <ken@codelabs.ch>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the tip tree
Message-ID: <20220409152330.6dad275f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+G/Ml90U_EcHFfMG+TGy7mX";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+G/Ml90U_EcHFfMG+TGy7mX
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  59b18a1e65b7 ("x86/msi: Fix msi message data shadow struct")

Fixes tag

  Fixes: 6285aa50736 ("x86/msi: Provide msi message shadow structs")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/+G/Ml90U_EcHFfMG+TGy7mX
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJRGFIACgkQAVBC80lX
0Gw0mQf9EiXvxWlXgxNd8AlgARzntrVtoKuMclUuX5kLfsJ4dGLKqqaAQB5I59o3
ORDmIP3Lu68t6sF+qrdU6Hgyg/kDwc7bR3UpeXn/d/F2bF0UgTKs6I2OsVUu48Xb
M+M7B8MFP/cIy+U+xEhDQ9gJuNeDbG6bV2jyPh4RMr5C7trTuct/WJegKdWo7wiB
oOj9zyXkTbJa+JVDhBA5Mk4SmsTrp2Wdo1urUtwCx8RBuFjjABjHzhAZ1PvlH5bW
REqqSv2iOUtUfF2d2aouEY2QldoMXff8DlK5kzPV0zUX7G8MiMyf2tX9kGyE43y3
fjzDL008p07H4J+9VfKL/+dH6W1+vw==
=Wi0U
-----END PGP SIGNATURE-----

--Sig_/+G/Ml90U_EcHFfMG+TGy7mX--
