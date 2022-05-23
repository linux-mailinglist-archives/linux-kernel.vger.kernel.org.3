Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3949953086D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 06:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbiEWEYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 00:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiEWEYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 00:24:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94486236;
        Sun, 22 May 2022 21:24:36 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L643j53gWz4xXg;
        Mon, 23 May 2022 14:24:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653279874;
        bh=hszSGSEAWYFbEEGQMO1SFV7XS8z86K6y58+ZDF+bDu0=;
        h=Date:From:To:Cc:Subject:From;
        b=dcJSr6zm3JToIwAOPBc0mCrU3K7XFQzdmKbEy7CYTfBlx2u2vXXuUwvuMObh3hFuv
         ByzKZC87h9K9qQtnXppHuay9emJYbgilNO2hubbfEK8iy9QyAcrdQpsDwoRkvoT80P
         muXV+HJBFy2p+Ni9zTz5PMKt+fZghho0fy9FqnI8yVl/+f4RGwQ+dcazMgI4YJ4vFG
         DBres6aKVr66Z1jz8rQsVIwvbLVyrVN8BSbnIYUDILXLmbTC5SslEhJPAww3bR6cvo
         Cro7+v2YAr7YzSPUTJcoG/DSnsHI5LmuB28OQiEZPYIlTTV6hM09y0NRrRELgPuiWd
         3pqwficJKYx5Q==
Date:   Mon, 23 May 2022 14:24:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: linux-next: manual merge of the tip tree with the kbuild tree
Message-ID: <20220523142431.10ff2f77@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/eB6BtpQ0AHS=obKOXHznCjx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/eB6BtpQ0AHS=obKOXHznCjx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in:

  scripts/Makefile.build

between commit:

  0212301af7bb ("kbuild: do not create *.prelink.o for Clang LTO or IBT")

from the kbuild tree and commit:

  753da4179d08 ("objtool: Remove --lto and --vmlinux in favor of --link")

from the tip tree.

I am not sure if I fixed this up correctly, please check the final result
when linux-next is released.

I fixed it up (I used the former version) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/eB6BtpQ0AHS=obKOXHznCjx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKLDH8ACgkQAVBC80lX
0GwdTAf/c6FzAJfisb6g7dTTTyHS/8MuDFYYhhSiHl9naP8p8QU+GyZMzUSFU7Ru
sYGotjAHR3V8h/zG4ogT3KN7NLTcFMdS7Iy1BE3QMNZ4YeyUOk6WcdZmnBoWFq3s
nBd7JfANZCe5clge10zqcRBKS49vrggFYqEeyBvNZn4JFxMdgRqvToOdykUegOXq
8gR/ynGFnYXjl0vkwyTmXTxaKrlJYn2U/2h1oFXbOqci9Tbme54y1UlYXM9lOWRt
0RLGXHQ0RffU7HH/PE3V99AkUaeFTQefYazE3n8lgH0wq+DbSxYoEX30C+aLL0N1
+nC4n0GG9aVs6/3JkS76RxyjkUXquw==
=sdy5
-----END PGP SIGNATURE-----

--Sig_/eB6BtpQ0AHS=obKOXHznCjx--
