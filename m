Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894F65926E9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 01:08:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbiHNXIf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 19:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHNXIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 19:08:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F60CB1FE;
        Sun, 14 Aug 2022 16:08:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M5Y4B0fBRz4x1G;
        Mon, 15 Aug 2022 09:08:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660518510;
        bh=Oyz83mtuuG52OS165AXQn0ZnNd5GcGQA+FkNBjyXstM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XQI88QAPudFhKI+cmgAyWtOVvU+4TmriMDmTtUYKDqRy/WhtZCP5zC+ScnnVKdo6J
         I0iXJxRi+EXzBH2OAFuuWM28WEj5GAabe0rNAtyxA+730VBkOLOl284JEn8Vz9BDaZ
         g8uVKauQRLYIemgXoIeKiUQZWEd7xM775IaTWIPhlnp7Ci/NRXc889+R71ZbpMu6l/
         ZeqVXXFY9ZnX6fo8vwNhAD+qcQzM22rnfiOb305UzIjRHBrsTmNc2mSYJnedqqpXyZ
         ekP82OCOnvd6QI88g4joun6Y3h0Bmp9HDf1Vp9RnzK2IsjMlf2eG4jQGagq8WAGj2I
         0ofl0pnJkA+YA==
Date:   Mon, 15 Aug 2022 09:08:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     broonie@kernel.org, Adam Bratschi-Kaye <ark.email@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Antonio Terceiro <antonio.terceiro@linaro.org>,
        =?UTF-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Boris-Chengbiao Zhou <bobo1239@web.de>,
        Daniel Xu <dxu@dxuuu.xyz>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        David Gow <davidgow@google.com>,
        Douglas Su <d0u9.su@outlook.com>, Finn Behrens <me@kloenk.de>,
        Gary Guo <gary@garyguo.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Miguel Cano <macanroj@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Tiago Lam <tiagolam@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>
Subject: Re: linux-next: manual merge of the rust tree with the kbuild tree
Message-ID: <20220815090824.340d44bb@canb.auug.org.au>
In-Reply-To: <20220802233844.2613013-1-broonie@kernel.org>
References: <20220802233844.2613013-1-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/JEMC6Aj/fh_YdWBJhKc5r7G";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/JEMC6Aj/fh_YdWBJhKc5r7G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed,  3 Aug 2022 00:38:44 +0100 broonie@kernel.org wrote:
>
> Today's linux-next merge of the rust tree got a conflict in:
>=20
>   Makefile
>=20
> between commit:
>=20
>   a6036a41bffba ("kbuild: drop support for CONFIG_CC_OPTIMIZE_FOR_PERFORM=
ANCE_O3")
>=20
> from the kbuild tree and commit:
>=20
>   fe24902ba8765 ("Kbuild: add Rust support")
>=20
> from the rust tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
> diff --cc Makefile
> index 60a7e3e8b4787,cd1d545f316bc..0000000000000
> --- a/Makefile
> +++ b/Makefile
> @@@ -758,10 -819,20 +822,17 @@@ KBUILD_CFLAGS	+=3D $(call cc-disable-warn
>  =20
>   ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE
>   KBUILD_CFLAGS +=3D -O2
> + KBUILD_RUSTFLAGS +=3D -Copt-level=3D2
>  -else ifdef CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE_O3
>  -KBUILD_CFLAGS +=3D -O3
>  -KBUILD_RUSTFLAGS +=3D -Copt-level=3D3
>   else ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
>   KBUILD_CFLAGS +=3D -Os
> + KBUILD_RUSTFLAGS +=3D -Copt-level=3Ds
>   endif
>  =20
> + # Always set `debug-assertions` and `overflow-checks` because their def=
ault
> + # depends on `opt-level` and `debug-assertions`, respectively.
> + KBUILD_RUSTFLAGS +=3D -Cdebug-assertions=3D$(if $(CONFIG_RUST_DEBUG_ASS=
ERTIONS),y,n)
> + KBUILD_RUSTFLAGS +=3D -Coverflow-checks=3D$(if $(CONFIG_RUST_OVERFLOW_C=
HECKS),y,n)
> +=20
>   # Tell gcc to never replace conditional load with a non-conditional one
>   ifdef CONFIG_CC_IS_GCC
>   # gcc-10 renamed --param=3Dallow-store-data-races=3D0 to
> @@@ -1098,7 -1178,7 +1178,8 @@@ export MODULES_NSDEPS :=3D $(extmod_prefi
>   ifeq ($(KBUILD_EXTMOD),)
>   core-y			+=3D kernel/ certs/ mm/ fs/ ipc/ security/ crypto/
>   core-$(CONFIG_BLOCK)	+=3D block/
>  +core-$(CONFIG_IO_URING)	+=3D io_uring/
> + core-$(CONFIG_RUST)	+=3D rust/
>  =20
>   vmlinux-dirs	:=3D $(patsubst %/,%,$(filter %/, \
>   		     $(core-y) $(core-m) $(drivers-y) $(drivers-m) \

This is now a conflict between the rust tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/JEMC6Aj/fh_YdWBJhKc5r7G
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL5gGgACgkQAVBC80lX
0GwSzQf/YPRCFxeF8VLi7d28SuVfithkyRx7IgBILJuqQWq7LmrApvkMgyOlK/j0
5OTuL/1jdIV4vp5yxcI0Ui+WoDmEwAmOpzDizByiJOWxEhEZ6EMkOrMlPwkmWdGm
2tOGZtvtDHKxWDUyrjva7Xbm+vLIQffuTJXb3SSuL0TP1enNODiK1d3edOemCPgJ
EhQwsa/wTYuIvLGNKbBprQPQLTVpIVGFju703jJwIhQT5GeomH/OFIbcUQJrmdNP
wcPF/PiEXNU3+VBssECfOYFthAxERxJjgd9+vkqdiOknG88khiVrAsQxQkyw8XOT
UVxx9k/GQiHv1SGaT8Kxc4peNtbafA==
=M+SV
-----END PGP SIGNATURE-----

--Sig_/JEMC6Aj/fh_YdWBJhKc5r7G--
