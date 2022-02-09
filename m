Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E97E4AEA1B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 07:16:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbiBIGIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 01:08:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236250AbiBIGCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 01:02:44 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA26C05CB91;
        Tue,  8 Feb 2022 22:02:47 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jtq6Z1tFnz4xNn;
        Wed,  9 Feb 2022 17:02:46 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644386566;
        bh=uxaaXvYIbtI4aegsfPOJtjkeOl5w2tl8Onh1/52Y3UI=;
        h=Date:From:To:Cc:Subject:From;
        b=JEmOY3f+PrmaLgzaoS1/h+UOwuEST3BWLFkg1C/eIduLraEwupOlF8Z78skyLXBqi
         0qcVkrLvAy8CV+H2wpxD9TazffJZWfw2JZUMR4PKLSsNR/YZ3Q0l24alaBO1H1Qxby
         r0BjOKN1hk0JdtXSBhzl7ZRW1EA9JvZowJVOKHju84DPOctP1WFc9/EDE5mgfym1dy
         abQ7eRygw5WRMAWOl0MSPeuorV8CgiEZRkb7wsKioFiXNQ4n5LPdsXJP6Wukqy0D5h
         lYblKlwJTZjsTs+35KRiYQ3K+FEtmbXXmw3DpF/T0/N2aZuJqd6XIIIZM75TRVL54Y
         9Wz2QoP+ijAFA==
Date:   Wed, 9 Feb 2022 17:02:45 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Hugh Dickins <hughd@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warnings after merge of the akpm-current tree
Message-ID: <20220209170245.08968c92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Dee7nPj8oXldzM=GQLhF+HP";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Dee7nPj8oXldzM=GQLhF+HP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (htmldocs)
produced these warnings:

include/linux/mm_types.h:272: warning: Function parameter or member '__fill=
er' not described in 'folio'
include/linux/mm_types.h:272: warning: Function parameter or member 'mlock_=
count' not described in 'folio'

Introduced by commit

  60a5c5ab0ba7 ("mm/munlock: maintain page->mlock_count while unevictable")

--=20
Cheers,
Stephen Rothwell

--Sig_/Dee7nPj8oXldzM=GQLhF+HP
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIDWQUACgkQAVBC80lX
0GxZZwf+IR40bxk5vxRy0bIafrZM+6L2eLLu1dGAl/UVhLcl65gzfePgODjI48rW
JckKDQm8dKo9AynZkEVcrmMydEguGNNYtlYq2Of+WTuCKBfRaw+hXugzp25bI+e2
4zBTPMInFJ4brUWzzKwc1CIxRMA73PfETZYX0X+M4zU77DP/tmHiR/8STWk3CyRX
11vpm0vNTxRefEs52xJolPdy/Wf2BwC8ueGfzyyRcFWRToU7XRTvHgf5ZkyFuSzK
A34dwxzhD4KYbpZAbGQ6UjQ1yxWKucN4BxLQiRb570ASow5IwLlLMxtr/11/LGhp
9SRRHPEUjTJdUdNnf7iGu31I+H5IzA==
=gLy4
-----END PGP SIGNATURE-----

--Sig_/Dee7nPj8oXldzM=GQLhF+HP--
