Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2659E4E498B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 00:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238744AbiCVXMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 19:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235216AbiCVXMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 19:12:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C12C55E77D;
        Tue, 22 Mar 2022 16:11:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KNS0L0xxrz4xPv;
        Wed, 23 Mar 2022 10:11:14 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647990674;
        bh=SKiE5f0/Rlq6TatzPPOaTLpSSUfpNd+aBF9Lwqd3Wxc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YD2AFpl+HTCeT2v/pAmYJb57NG9nifW3tZvzVWd3KzbMELsgafecqRqU4gx6YAzxf
         neru+5NPsgpB0xooxfm5Gv+zOIzXSkjM5IZokMuXxghOhNlTxiABjIt05YzpACkb5x
         4LmXkn5McD5gii3yvZ0UMS1c75Qd8E3VLmDg7JFTXLk76idIOb8YBQdyWG4qpweK1i
         54+M30tzACYWE+/THTEjtwcrUs9Q3be8E9sAm1E1KSJzXas+VhM3WFSw6jSBg1+MbC
         4GGpPEQBjeOrzgZ+QHbpTNVg3ay8niVVTEU6Bl5FZV+2Au4iXJjS5Emg4ftVhO4zpZ
         +lC2XDcZbhMgQ==
Date:   Wed, 23 Mar 2022 10:11:13 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the tip tree
Message-ID: <20220323101113.1baac8a3@canb.auug.org.au>
In-Reply-To: <20220322215252.GU8939@worktop.programming.kicks-ass.net>
References: <20220322145108.2878ed64@canb.auug.org.au>
        <20220322215252.GU8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/wNfwU3ae+nICKJRKk=3l6.6";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/wNfwU3ae+nICKJRKk=3l6.6
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On Tue, 22 Mar 2022 22:52:52 +0100 Peter Zijlstra <peterz@infradead.org> wr=
ote:
>
> On Tue, Mar 22, 2022 at 02:51:08PM +1100, Stephen Rothwell wrote:
> >=20
> > After merging the tip tree, today's linux-next build (x86_64 allmodconf=
ig)
> > produced these warnings:
> >=20
> > WARNING: modpost: EXPORT symbol "device_match_devt" [vmlinux] version .=
..
> > Is "device_match_devt" prototyped in <asm/asm-prototypes.h>?
> >=20
> > I get thousands like this :-(
> >=20
> > I don't know what has done this, but there is a new Kbuild and modpost
> > change:
> >=20
> >   2f35e67f621f ("kbuild: Fixup the IBT kbuild changes") =20
>=20
> It was; I rebased that commit and asked Boris to regen tip so you should
> have it fixed for the next round.

Excellent thanks (I just picked up the new tip tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/wNfwU3ae+nICKJRKk=3l6.6
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI6V5EACgkQAVBC80lX
0GyYxAf/bTmLw5KE6+1PwsQn4MRbEqgb6On6EXye0bxwRywmTeWi0uFO+pmK6507
9Of81uFfR7uRmJXHxK47fbKjPP4hbQ9iSryPomD29U8n9NH0K/X9FHytcMWzNy64
aa0bJHbxyuGlD75ZjxFvEeosI5wso/I/qN5c/D0+9sChmh9xHTOmp269m2hwJ2bU
LMprFeGKh1EcOXvIItz9rhIvn84drCIT9q1NOpPcB+nAQVsbvQ+GFp0hg6UqfNK/
6ikjGBwUn6cTlsvWgcaojW5qFImWI1Q21f2PpYHjWbv56N6loVn5cxd2Lu6anbkn
qeaqtEEBp2hfNHgSXZWheebg6daBrw==
=rWK9
-----END PGP SIGNATURE-----

--Sig_/wNfwU3ae+nICKJRKk=3l6.6--
