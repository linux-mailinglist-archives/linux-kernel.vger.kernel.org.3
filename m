Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C294E8B13
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 01:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236687AbiC0Xet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 19:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiC0Xes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 19:34:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B915E0A2;
        Sun, 27 Mar 2022 16:33:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KRXFG0wzRz4xNm;
        Mon, 28 Mar 2022 10:33:06 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648423986;
        bh=M45XB28xn1/Bfs1hY9Y7+mO4qS8oFV3iu8erEC4NRrQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uD2kHHFOLwv0rF/dZHQ4eFU4hP3pCeCRLnP8J+DyiFrU/Zqp4r2nylkn/LdYPo/9Y
         W9ofIO7msOyC0WMQ2THEbk1Nzu5YZpgPW/0GOXzoabj4OfGEKD8NV9JyQfUJIDPe6M
         ydgu8vqbnZdArq5QCP6Uez0JF9i2zftZHgK59016uIJtkN1/B7eFmafyjruv6XRaNw
         JDBpjQio+yzcR8DKWdCpCiwfyZJEPkjqw0c6KKS9omcIkdU1hTiuAiNIVjHCKpa3W+
         MSNdzy6UXZVjrZ8bZ75EpQazjQ7mb2d37bWgXBFAEhPSlSFFGYXWsfaxcjL9zNn5Py
         0VR9HF6+2EzOQ==
Date:   Mon, 28 Mar 2022 10:33:05 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure in Linus' tree
Message-ID: <20220328103305.3fa42f9a@canb.auug.org.au>
In-Reply-To: <CAHk-=whGmZrYZ=YdcjeJbpviUTShj0NOiG2q-3d1-RJtz6vBPQ@mail.gmail.com>
References: <20220328090111.26f8980f@canb.auug.org.au>
        <CAHk-=whGmZrYZ=YdcjeJbpviUTShj0NOiG2q-3d1-RJtz6vBPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p376M4UlT+aL0d52XU_L2Rq";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p376M4UlT+aL0d52XU_L2Rq
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Linus,

On Sun, 27 Mar 2022 15:23:24 -0700 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> Will apply that patch asap.

Thanks

--=20
Cheers,
Stephen Rothwell

--Sig_/p376M4UlT+aL0d52XU_L2Rq
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJA9DEACgkQAVBC80lX
0GxZ+QgAoPtxju6+mSyCVBHtCXujWtF8Zw/IfpgGl2yzFD4wOT/Ox3SHHnle9EOu
d4d6hDWTKcRRDLT99nH75jc/V72TSFcXERBpOLM57FkUi8fCJzC7J2R6MNo+d4l8
o7EB5Uer8fz2n23Scda0AcUQsHZQc89T+fGL+OVXyUBPsjmgQcUtwyTivCiKUMoJ
80U+Az/RmlGxSvmt+XuLrhy/dF1AViIMhcgpVvBtUNw6MbPeBei94xgkrXUJ0niw
wMCTZ9Eww9z5qufTe7SCdkKwHIdHZP2A0MINvmAwDnfi6j73MbrHmvB2pBQpV0lf
K1jyT9aTQ63MpUT72pq8ZOdJt9m7NQ==
=rum5
-----END PGP SIGNATURE-----

--Sig_/p376M4UlT+aL0d52XU_L2Rq--
