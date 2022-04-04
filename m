Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0194F0DB6
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 05:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376999AbiDDD2W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 23:28:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiDDD2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 23:28:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8646B37BFA;
        Sun,  3 Apr 2022 20:26:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KWx5917SPz4xLQ;
        Mon,  4 Apr 2022 13:26:21 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649042782;
        bh=QJELPXIz7CnQ3n8+N1qPomwELwcrEeipiKroGgbrHJM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pAylQI/Y6xjaI5qFjN7h/9+6KTTUmoxz/wmKOA9XqQc/GgvuRA66FV79UXETHOkea
         00rzATPx+t1C4cLznTDTJAU7hpC20X1rTU2vLf/Y7uXjPoY3njZ2q8WcNwsEHqOYIR
         YdgfHWSQUoCRT6cSfnTNmuwXafb+P4QtawxU1cnla5EorMmCd2shzZfsart1ChrgaQ
         +7jjsIm9GMpF+2PmsJOZnlt5sPD0BWj6NTIAke9Q4VU0jvS9qaG7kFpCn+SMvw675p
         WWEaXfItmh2sgYjbmLsT4IO56XsxMj2rxI8Y9OnWlFlRQlw2fgTosG3K4VXdjFLgM2
         wC0JONZccif+A==
Date:   Mon, 4 Apr 2022 13:26:20 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220404132620.5766f151@canb.auug.org.au>
In-Reply-To: <20220315133249.146b8bac@canb.auug.org.au>
References: <20211217144004.0c00fabc@canb.auug.org.au>
        <20220122105806.3b710900@canb.auug.org.au>
        <20220315133249.146b8bac@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/OZfOJDMjcJM.iH/pAUG_WB5";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/OZfOJDMjcJM.iH/pAUG_WB5
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 15 Mar 2022 13:32:49 +1100 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> I gained these new ones after merging today's tip tree:
>=20
> arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_2block_xor_avx5=
12vl() falls through to next function chacha_8block_xor_avx512vl()
> arch/x86/crypto/chacha-x86_64.o: warning: objtool: chacha_4block_xor_avx5=
12vl() falls through to next function chacha_8block_xor_avx512vl()
> arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx(=
) falls through to next function poly1305_blocks_x86_64()
> arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_emit_avx() =
falls through to next function poly1305_emit_x86_64()
> arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx2=
() falls through to next function poly1305_blocks_x86_64()
> arch/x86/crypto/poly1305-x86_64.o: warning: objtool: poly1305_blocks_avx5=
12() falls through to next function poly1305_blocks_x86_64()

All we have left are the poly1305_ ones.  They are in Linus' tree now.
--=20
Cheers,
Stephen Rothwell

--Sig_/OZfOJDMjcJM.iH/pAUG_WB5
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJKZVwACgkQAVBC80lX
0Gw1uAf+MFAFqi6qB7zNWk483BQCeT4jfHvcpHVy7ahHsbXnpAAxLxRkKQ+muFuk
qQNih4ERF6q3lP2bWEf04BGdKIQVM+QZx5WVJphjael25d4aAhKuAxFF26pdrbxs
I3tJPVNrMUkzVgD/ergXycTxonmvp3OIO5njpq8ZPcDa1ydQwknQRgKAsjVhTA//
kBT+Onu5F3AtAEnzR+431CYqixFEErxSA/ZKsweWCi/sE7vCWcx0qlRaPkiWAkmy
NMX5rErfjjt1Yejfci8FNeEBXT46Kyzd4OT1byfJziNPar9N1SF61Ez7AL2pTVdV
6j23chWG32A1OBzt4Qzb11jdayoGrg==
=4+Mt
-----END PGP SIGNATURE-----

--Sig_/OZfOJDMjcJM.iH/pAUG_WB5--
