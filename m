Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64B8056A1B9
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235367AbiGGMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:03:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234790AbiGGMDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:03:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB63564F9;
        Thu,  7 Jul 2022 05:03:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ldw6l1QM9z4xDB;
        Thu,  7 Jul 2022 22:03:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657195423;
        bh=YC/2OozYTGWuIXVFqvGcKXNJFtQMKiJOfOeSbGoL3v8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gGLCNrRD3X/IqnbeA4V+qfCrmER7TsrFOnupgQEOQHzkeiDXoKKDCkU9POUatYYLP
         WpSIOUR4Yhj3nLF0tqJtp7TkFYxk7HoS3rQgNP5iaYSkRz+mfMQJ4M1/AgkrOlJEg2
         dvGs0qRBjD4RLCaBjiC+zODI6fQi8cQYEUttnz4uXfmFmre7YiL+P/wKM7nJQduNt+
         DvkJ4AEOO414rh9aml/Z+h40gqwnwBEFzAf1bH5sPtjtAoy1nEbWBPEgomhGQRPQkI
         wbFQknKEO9+VmZ+qFycokRUUkmVKStze0jBIjvxVxPi3x2IO3bcwunuLPf2KqlwfMa
         BOAXsopphNDYg==
Date:   Thu, 7 Jul 2022 22:03:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>,
        Juerg Haefliger <juerg.haefliger@canonical.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the random tree with the powerpc
 tree
Message-ID: <20220707220335.36087d5e@canb.auug.org.au>
In-Reply-To: <CAHmME9qCTZpRKrvXVDhCGTD6z15BwDFupX0Z5QwhoWCCT2w2Fw@mail.gmail.com>
References: <20220707173252.5fff21f2@canb.auug.org.au>
        <CAHmME9qCTZpRKrvXVDhCGTD6z15BwDFupX0Z5QwhoWCCT2w2Fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/RZw/=ITfff_AmIDTe9mkTMr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/RZw/=ITfff_AmIDTe9mkTMr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Jason,

On Thu, 7 Jul 2022 12:52:54 +0200 "Jason A. Donenfeld" <Jason@zx2c4.com> wr=
ote:
>
> Oh darn. Any clever tricks to prevent the merge conflict from
> happening? Or is this trivial enough that we'll let Linus deal with
> it?

Just leave it for Linus, its pretty trivial.

--=20
Cheers,
Stephen Rothwell

--Sig_/RZw/=ITfff_AmIDTe9mkTMr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLGy5cACgkQAVBC80lX
0Gxswgf+P5svBBU4WZUfNjPdqEFVlotiBELcLj9aQQOVg43ggtrYWXuMUPEZmgw3
3mhRaBpjQ9uTbNw7+rLZhDmhe/FNN5kol/KKwLS29AM2zvLRM0sexabHmSdKjsDM
tc/Z++3JKRah5n/RGNt+WQVZjDrxSQozsvhNsmQ2w8kbkWHNDXewy0+shkdDE5sL
CVAWw/XHYKWWNfBqkryf63tPy3Dlxe38Mxg7CpBFO+S32XmUnmemGRm244aYqnkW
p0B4T+QUkW2st0siclSvWnA/xTNoZdj0HrYjZgK617mlJEYuVmGu0T1n1BpjEIIq
pEeE/QK8EMkdhepSJ+zr9aP9CBQ+Mw==
=nulz
-----END PGP SIGNATURE-----

--Sig_/RZw/=ITfff_AmIDTe9mkTMr--
