Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B2F4FEAF1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 01:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbiDLX3J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 19:29:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiDLX0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 19:26:46 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD08A88A1;
        Tue, 12 Apr 2022 15:36:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KdJ7Z0tPbz4xLQ;
        Wed, 13 Apr 2022 07:02:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649797322;
        bh=r2XCP+C01lmUpMxczGDkvBp+3Q3NgFqgOAMSr2km3yw=;
        h=Date:From:To:Cc:Subject:From;
        b=g7Y6uxdIG7NSlD1cN8Au0Suewd1eXzOVebr/NeAg7JIkiL5twMadZ7IwGCxsNMzkW
         Ml++oqdZb67s7kOm3uhOX7kr8V/2bzB8gdOgHQMN4ZqLGZ4DMsjcJJZk1sH+l+Y/vM
         1b16XSuXEvxKpC/kwNWPxqgIJD6IXgJFGlmHUXtaEtBMl9hNmlmCGp8XEtApO/0YUc
         fMQ7Tba7Eiyu7QvugcWQg8C9dI1boOwSFsUEN82V0t0Wu/ur1/HB/lk9+R07WSogrl
         6Qs9wX0ExacpJovoTVYLQM5yOoVCUIiz32aBVojz6nu80pnYonhY6R5StNtyraUFjq
         WpvJ/1Bo/IJxA==
Date:   Wed, 13 Apr 2022 07:02:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Tony Lindgren <tony@atomide.com>
Cc:     "H. Nikolaus Schaller" <hns@goldelico.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the omap-fixes tree
Message-ID: <20220413070201.248a9b11@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/p830KfUM=nX+TE28sd0D0e.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/p830KfUM=nX+TE28sd0D0e.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  9be24a73de12 ("ARM: dts: Fix mmc order for omap3-gta04")

Fixes tag

  Fixes: commit a1ebdb374199 ("ARM: dts: Fix swapped mmc order for omap3")

has these problem(s):

  - leading word 'commit' unexpected

--=20
Cheers,
Stephen Rothwell

--Sig_/p830KfUM=nX+TE28sd0D0e.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJV6MkACgkQAVBC80lX
0GzbmggAlC8IVnuZUEfb4mhk3oTqmchFNv53GiCQA5dk9OMYbiTBjxvpSoCyvF1L
llv0dlBSPraHTxZ3HSPQciLO/we/Ujv8l6d4eDrcVzyFewqoDgqmhyapu/GgTReK
RVRRm8vdl66HQX0KYduJjRNgJTP6TFitQgWKnQ1pLTWX+nJhSgfV5dUDUsIFgMWA
ysiPhUzURtD+hLJ9pQhayFG0OX1k8zSBc3Cm1GAJtiOz3x39ctbFFLHpZz+FlFZH
s1mWtCC/lkRzV57H+oBokvRJbcA1d1nLoWiW+6DtjPf7PbW7UETg8HDkcXGT74He
Kf7DwjSEUA0d1rT79dYHJ5xN4QIXlg==
=xZbo
-----END PGP SIGNATURE-----

--Sig_/p830KfUM=nX+TE28sd0D0e.--
