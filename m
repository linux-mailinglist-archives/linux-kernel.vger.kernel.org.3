Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB76D565F99
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 01:14:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiGDXOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 19:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiGDXOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 19:14:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142CA2BE4;
        Mon,  4 Jul 2022 16:14:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LcM7b4dcFz4xMW;
        Tue,  5 Jul 2022 09:14:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1656976444;
        bh=gGAy9HKPmq6/KevfTSABt8eUjrOxgMipgIQUBB1dcaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=S9y4UWVJaLAxVUq52BpcaEUakpbO/FXhfhyrlNjgTxLq8ZqW5p4HTa8t9DfJS7nEj
         2igx91RxX8RABh34N2Rv9RjrOJ58FihX31MuGgAFuQce+UPUTmBDFGsEJxtyBZbxC+
         WCx6IPo8Mtt4/QSCrdnHnq2jlkKVtRsqaN8Ofkjey67CmIMYNUvQHdIlUtZINZ+0RV
         rK+uw+4QUkWoZYc3/vWCgsFhnhDleCGrnkz4XQrGQ4N8IyJm5qEFs75K1UUqBheGGF
         jSrKCMrWHIeI80MlYhtuGMWLuAdUJK/ZGuXe+c0X9yiVWVVXQcQuihjNYj8ZfmVdoi
         U4tj8/8EWfkTQ==
Date:   Tue, 5 Jul 2022 09:13:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     John Johansen <john.johansen@canonical.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Subject: Re: linux-next: manual merge of the kunit-next tree with the
 apparmor tree
Message-ID: <20220705091352.15150c7f@canb.auug.org.au>
In-Reply-To: <20220405125540.2135d81d@canb.auug.org.au>
References: <20220405125540.2135d81d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/r9u35FtCzJJEvCNUmSpZDPE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/r9u35FtCzJJEvCNUmSpZDPE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Tue, 5 Apr 2022 12:55:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> Today's linux-next merge of the kunit-next tree got a conflict in:
>=20
>   security/apparmor/policy_unpack_test.c
>=20
> between commit:
>=20
>   d86d1652ab13 ("apparmor: test: Remove some casts which are no-longer re=
quired")
>=20
> from the apparmor tree and commit:
>=20
>   5f91bd9f1e7a ("apparmor: test: Use NULL macros")
>=20
> from the kunit-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>=20
>=20
> diff --cc security/apparmor/policy_unpack_test.c
> index 399dce3781aa,5c18d2f19862..000000000000
> --- a/security/apparmor/policy_unpack_test.c
> +++ b/security/apparmor/policy_unpack_test.c
> @@@ -408,8 -408,8 +408,8 @@@ static void policy_unpack_test_unpack_u
>  =20
>   	size =3D unpack_u16_chunk(puf->e, &chunk);
>  =20
>  -	KUNIT_EXPECT_EQ(test, size, (size_t)0);
>  +	KUNIT_EXPECT_EQ(test, size, 0);
> - 	KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
> + 	KUNIT_EXPECT_NULL(test, chunk);
>   	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
>   }
>  =20
> @@@ -430,8 -430,8 +430,8 @@@ static void policy_unpack_test_unpack_u
>  =20
>   	size =3D unpack_u16_chunk(puf->e, &chunk);
>  =20
>  -	KUNIT_EXPECT_EQ(test, size, (size_t)0);
>  +	KUNIT_EXPECT_EQ(test, size, 0);
> - 	KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
> + 	KUNIT_EXPECT_NULL(test, chunk);
>   	KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET=
);
>   }
>  =20

This is now a conflict between the apparmor tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/r9u35FtCzJJEvCNUmSpZDPE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLDdDAACgkQAVBC80lX
0GzbrQf/VcMxgYzo/wSPHsfNd/FLzRzhvareF0a/zzjPH5A+EowGTL6iUFClFxgS
QCsBZ/p8UhYVQjlDOL5s6Plemt3+FUxxntpgQEx7hSfkiXaErhmzLYxFCn9BMkyc
La4GyM8g0crlvZu+bUne7on3sTM3nJPtCzC1qgnFVAkyedQLUqSp+HL4YM61Ehjo
DqGVmV1Y6aqgbdgWDlRY1O7u3S1KZikEc5H3AQGqTHjnNnJr1qTxUYlob3KltjxE
LODVgXZpYFR2MIuKSjue2Tsab301gYjWzi2X+CzHqw5gAoQ4fuoXOF9VzntMcRYd
wgOAXNvE5QyfBQGmFkYU2yj46lK4MQ==
=Kw/g
-----END PGP SIGNATURE-----

--Sig_/r9u35FtCzJJEvCNUmSpZDPE--
