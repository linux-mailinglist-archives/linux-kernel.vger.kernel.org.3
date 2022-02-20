Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5141E4BCB47
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 01:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240426AbiBTARx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 19:17:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbiBTARv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 19:17:51 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9D6E96;
        Sat, 19 Feb 2022 16:17:30 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K1Qx31JFrz4xbG;
        Sun, 20 Feb 2022 11:17:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645316248;
        bh=DCXYiK3nnRpaNjPDnxUCWkEWrolEOinAfGFiJac7/jg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SiYZYlBvghxP2XFEnEg2J4k1mdpO3pELPyH8qbcvRSYfMRXayN9Aa5hDEMEJl7nXh
         0MNlIaCi9nuutVIYZNVBS0QLbiwU9ePpGnFS3B7R5/EVIdjy0yDXTJVXSVtF+sLeGF
         pgGna5j4xnNtQvreqSLVf/Icc4EskGaVH8fqioCDCBFKtQEHgxq6RG99v5ranl/S71
         0ALiwtTDdeUdUu00KdbEnSaAC63/tGpeJe6jQ2aJBF8qB0Cqt7vLwdkvjDmAFo+jcS
         xzVczOntU6ZlfSmGy3EiJWexZTsfMBt2eqrQ3/ox1SERN2y2vy4VgdobvH49GrAFMV
         gg9/lJPArbcZQ==
Date:   Sun, 20 Feb 2022 11:17:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm@kvack.org,
        William Kucharski <william.kucharski@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Alex Sierra <alex.sierra@amd.com>,
        Christoph Hellwig <hch@lst.de>,
        Hugh Dickins <hughd@google.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: linux-next: manual merge of the akpm-current tree with the
 folio tree
Message-ID: <20220220111725.411507e9@canb.auug.org.au>
In-Reply-To: <Yg6778VW5JX512GL@casper.infradead.org>
References: <20220215180043.23879691@canb.auug.org.au>
        <YgumpQrC+cuYe91H@casper.infradead.org>
        <20220216172109.72fd0a38@canb.auug.org.au>
        <Yg1hf0iHdKcjnq6l@casper.infradead.org>
        <20220217163026.5e48ccb1@canb.auug.org.au>
        <20220216215124.169c42a52e31575cedc4dea5@linux-foundation.org>
        <20220217173810.0addd3ed@canb.auug.org.au>
        <Yg6778VW5JX512GL@casper.infradead.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/28TS1CVtYg20v70uYpRoY.A";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/28TS1CVtYg20v70uYpRoY.A
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Matthew,

On Thu, 17 Feb 2022 21:19:43 +0000 Matthew Wilcox <willy@infradead.org> wro=
te:
>
> I assume you mean that you'll do one last pull and release a
> next-20220218, rather than saying that the next release will be
> next-20220229?

Suprise! No :-) I started vacation on Friday morning (18-27the Feb *inclusi=
ve*).

> I have pushed out f82e2137bc1e to infradead/for-next.  xfstests currently
> running.  It includes:

I have refetched your tree into the stuff I will leave for Mark.

--=20
Cheers,
Stephen Rothwell

--Sig_/28TS1CVtYg20v70uYpRoY.A
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIRiJUACgkQAVBC80lX
0GzHvQgAhMO/d5xEnCKuA4I6yLxSrJVXXWiNnk4vTuy7xl5TNuiRg5axPqOoCQU+
mNGAidmjosx7nhGYEGaXt2J7Nok1AAEgT9QYmgZD5tbrxPi/yuBflB46pEwAJ3OT
hLKR+dIf606T7Mq3LGgfl9pWzM7tDuIrcunAflQBR0UT1q2dRsXT6okAl+sHWRmC
9uM3IshfD+jrhEn0IDlC60/bYK2hAe1bL2H9Q+I5crPaqgmk7tRdUzZHU7zCFlKv
SHsPr9tNrwHnHzFzUUCGqqaD9eab4fY+tV6CRZNK0pySo11SktweDio2r2EwCACz
23Y9w1ixkMqWJzMmtFdbL5yIpYSfWQ==
=isKl
-----END PGP SIGNATURE-----

--Sig_/28TS1CVtYg20v70uYpRoY.A--
