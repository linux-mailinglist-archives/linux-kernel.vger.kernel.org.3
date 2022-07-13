Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA057345A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235038AbiGMKeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236104AbiGMKe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:34:26 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED56BEDB61;
        Wed, 13 Jul 2022 03:34:21 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LjYrh52rWz4xZD;
        Wed, 13 Jul 2022 20:34:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657708456;
        bh=Ey1jE8nSC7Mk66Rrk+OsUh80n2ZIXqpzMWY/OJsmnM4=;
        h=Date:From:To:Cc:Subject:From;
        b=Lr3eOkAzon04P8+sEfsVemBd0ioqKwrx/1I8f1cUV+IYTY1SqqjHj34/haJScbiXn
         wqgqa2+/udEWoVMTg5Qw8I8SHHqCUDH4kHuo3uFX7joX9k+PCPDCfNGAZZSwNOLJ4u
         Vee7iCOObS/8M53ocFYykNpHuA5+WgBxe/fT6DoDEio0z7KnAceYXe9iFtIOCJnY4O
         UznFh+CXeYfP6bux5/+muFGMSD9GntuA1zMJuWl149Qs+dttQbnaRQD6s78PsHO821
         PhNXVWbjmq2jIGnzw9CLCSmQj99w8Bh7Uzeb2BALFf/7MdRRl553jvqz0jqRw+alJ4
         kAHJOekMOA+NQ==
Date:   Wed, 13 Jul 2022 20:34:09 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Borislav Petkov <bp@suse.de>, Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: linux-next: manual merge of the rust tree with Linus' tree
Message-ID: <20220713203409.559c5464@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/fNNaP+bU4aiB=S243ECecbo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/fNNaP+bU4aiB=S243ECecbo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rust tree got a conflict in:

  arch/x86/Makefile

between commit:

  f43b9876e857 ("x86/retbleed: Add fine grained Kconfig knobs")

from Linus' tree and commit:

  0ea4b9a1bece ("Kbuild: add Rust support")

from the rust tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/x86/Makefile
index 1f40dad30d50,5ac9b324751d..000000000000
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@@ -21,12 -21,8 +21,13 @@@ ifdef CONFIG_CC_IS_CLAN
  RETPOLINE_CFLAGS	:=3D -mretpoline-external-thunk
  RETPOLINE_VDSO_CFLAGS	:=3D -mretpoline
  endif
+ RETPOLINE_RUSTFLAGS	:=3D -Ctarget-feature=3D+retpoline-external-thunk
 =20
 +ifdef CONFIG_RETHUNK
 +RETHUNK_CFLAGS		:=3D -mfunction-return=3Dthunk-extern
 +RETPOLINE_CFLAGS	+=3D $(RETHUNK_CFLAGS)
 +endif
 +
  export RETPOLINE_CFLAGS
  export RETPOLINE_VDSO_CFLAGS
 =20

--Sig_/fNNaP+bU4aiB=S243ECecbo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLOn6EACgkQAVBC80lX
0GxWbggApRFxsIZ5bbLd57tMBcT91GmCHHxjQXU+QhS6MfV8XfB1CHB7x8r/FhKh
3cPu9tusxUqBJ0cxzCWaNVGn3KoxtONylfQYaSWrGFYV142d8V7T5c/MAoCBmSX/
4JTkzLFVfipaB8k0CWk6XhQCtSQA6O1xlCkG230HU7k28I6Gmd7W/+FgkpD1GG11
qcPQSu8jaoXNNiX3Zed1zcIkpp1tOXx8CEj77Wk/pfmOUsPuZZwZJNByhR5gpxaY
fVhD0RJAnzXTl5ooGd+xj1NkH9Qi+dO8CufScGdBPdS1fZmwxYx0OQcZmQzerMgj
ewtxpiZBgEafxg8KKCYYF10EXXR+Gw==
=I9eX
-----END PGP SIGNATURE-----

--Sig_/fNNaP+bU4aiB=S243ECecbo--
