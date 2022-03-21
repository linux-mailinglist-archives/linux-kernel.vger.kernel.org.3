Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17CE4E1F3A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 04:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344280AbiCUDE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 23:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbiCUDE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 23:04:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C8753B66;
        Sun, 20 Mar 2022 20:03:29 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMKFD037hz4xXV;
        Mon, 21 Mar 2022 14:03:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647831808;
        bh=br0z9NnXGCy1ONvQ0NncqSLcsoe37vqwTOZ0/CseSWY=;
        h=Date:From:To:Cc:Subject:From;
        b=aPEBavwX5zap3rg8cwb5bH4sOruoMRdfuHZ9XYnZLJSJzbMUgGg+oj5JqmQhOHT9M
         sSUkNXTt6ycWH2RfwxQjpOjpoBPGgJIoN2qF7vOhK0KZiH+1OpGBu1JJeCpIndgxUD
         RR0d38kZco82NFQGMp/R7QJdXMEPFLR7J2jbDiz9ksam9QYH4TOYr4SUF2V4d0HOeG
         ZFPUYck/2UW2F6CKUcB2ZfKSEWRMqNajM/psPxZia5hzV8+EoyPy0cUM5Y1YwE8mD6
         ++CKfgfDSKUwGGWqIaPFXQ1J/09jLH1RRL2aYWmaOIiagQWgi8Z93OTa6osVhMVzm3
         uuq8vDL8VObIQ==
Date:   Mon, 21 Mar 2022 14:03:27 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the tip tree
Message-ID: <20220321140327.777f9554@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/cppcYrp6myv2JRW1dwxasD2";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/cppcYrp6myv2JRW1dwxasD2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tip tree, today's linux-next build (x864 allmodconfig)
produced these new warnings:

vmlinux.o: warning: objtool: arch_rethook_prepare()+0x55: relocation to !EN=
DBR: arch_rethook_trampoline+0x0
vmlinux.o: warning: objtool: arch_rethook_trampoline_callback()+0x3e: reloc=
ation to !ENDBR: arch_rethook_trampoline+0x0
vmlinux.o: warning: objtool: unwind_next_frame()+0x93e: relocation to !ENDB=
R: arch_rethook_trampoline+0x0
vmlinux.o: warning: objtool: unwind_next_frame()+0x5f2: relocation to !ENDB=
R: arch_rethook_trampoline+0x0
vmlinux.o: warning: objtool: unwind_next_frame()+0x4a7: relocation to !ENDB=
R: arch_rethook_trampoline+0x0
vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x81: relocation to =
!ENDBR: arch_rethook_trampoline+0x0
vmlinux.o: warning: objtool: __rethook_find_ret_addr()+0x90: relocation to =
!ENDBR: arch_rethook_trampoline+0x0
vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x8c: relocation =
to !ENDBR: arch_rethook_trampoline+0x0
vmlinux.o: warning: objtool: rethook_trampoline_handler()+0x9b: relocation =
to !ENDBR: arch_rethook_trampoline+0x0

[ Note I was already getting these:
arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_2block_xor_avx512=
vl() falls through to next function chacha_8block_xor_avx512vl()
arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_4block_xor_avx512=
vl() falls through to next function chacha_8block_xor_avx512vl()
arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx() =
falls through to next function poly1305_blocks_x86_64()
arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_emit_avx() fa=
lls through to next function poly1305_emit_x86_64()
arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx2()=
 falls through to next function poly1305_blocks_x86_64()
]

I have no idea what has caused this ...

--=20
Cheers,
Stephen Rothwell

--Sig_/cppcYrp6myv2JRW1dwxasD2
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI36v8ACgkQAVBC80lX
0GwhPQf+LHeHHDKPYEGcEn1NY2XYBWdREedwXgRyvX5AGsSIbK7QJc53oA3fR92M
muMOJtHZG6KqkIsbb/gJkFlwNSv5+IO/DInCcf3K8+Il76o5x9fLaC+YidpMnnFr
+JJDrl3ZeylYMk2sqT2or9rPfoTnKcB7/83pcjpjVlUosnliDBPmZV5Jp8k11I92
BvG1CmUyGcKFHHhTqgpXlYBLgt/xKPToaQ/Jo4LAraLXpIwPeFR9eAFFKamFM17z
d6YgcfBKFrUWKBY/gM8oq5XikPlTsgrVlDdjfR7XxPJ7gjE4CP3vi/S4lsSfCtrR
GP0OGbAOEM+gOXNrEXJ+8CTPQxU0Ww==
=HvKn
-----END PGP SIGNATURE-----

--Sig_/cppcYrp6myv2JRW1dwxasD2--
