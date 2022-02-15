Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6364B63DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 08:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234660AbiBOHA5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 02:00:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234656AbiBOHAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:00:55 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC1E3E5CF;
        Mon, 14 Feb 2022 23:00:45 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JyX6h3K1Tz4y3h;
        Tue, 15 Feb 2022 18:00:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644908444;
        bh=AKJ/dR8BPfe6zq3W9O6Z+o/jn7dK96AB9mxFSSRU4HA=;
        h=Date:From:To:Cc:Subject:From;
        b=SWjxyyTK4+kYBlGJPNC2zWDZPNBUjbwPwFPPXknAGl+YjFmgJwhSgZf1iu0iaaUkl
         6OTVoNe2l4rU7mg08xG1xxKoJe/xRA0QUCGJMv/DZzDhZiQ7Ww+R9Pg3unv6JE7yKm
         tPv/TPYBROC+uc05zQwCCyCeOuTalyuu7vJm6tZFItavb9baN6c9WVO7ZnSMkX6T4h
         SabAW3PzIe+RFwQDrVLiU/Mmk2lTFn1YMS7z8TzNqTiALDEELrRowV7IHFWNwzd4CD
         bBmkWm1t9BaiU7+8AvuL6+zrJGqoDM+Lt/kUlA5dtIH/x3pi0q7vRhsubbRyRpPNw6
         732jAC/7wYpXA==
Date:   Tue, 15 Feb 2022 18:00:43 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the akpm-current tree with the folio
 tree
Message-ID: <20220215180043.23879691@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BI=LnLnJ8yUvPft7vj4C.Ge";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BI=LnLnJ8yUvPft7vj4C.Ge
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got conflicts in:

  include/linux/mm.h
  include/linux/rmap.h
  mm/gup.c
  mm/huge_memory.c
  mm/internal.h
  mm/memory-failure.c
  mm/migrate.c
  mm/mlock.c
  mm/rmap.c
  mm/vmscan.c

There is no way I can figure out in a reasonable time (or at all
probably) the resolution needed here.  You guys need to get together
and figure out how the folio tree changes are going to progress to
Linus' tree.

I have gone back and used the folio tree from next-20220204 again for
today.
--=20
Cheers,
Stephen Rothwell

--Sig_/BI=LnLnJ8yUvPft7vj4C.Ge
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmILT5sACgkQAVBC80lX
0Gyp5wf/fMeORNi36rHxWmLeunsKRuit6JyGjHNRjAIofAG0Zvob7Cc0/8OgO9QK
qg3Z4oRm+Lsg0qQSje53QMrQN6BnDePfYsmYKhMx36NlCsaWaehCZ/iE/chMv6sW
z1Yhj46hWR6N1mu2ISoil7GJmfGaRevxeIRy0wXBWt7kWC0/LAacax5HHDAQbbvV
guPZA7jPzNzXRwptsVSkLBJBxFdeaaQL7DRpF7z+udoEKrglql932lOV9nuvk6fv
5e7HOFGsq5mXYAosPT8sgIjAibOYzpVnGIqlHTzf2VYRmJamTTpNwdtaVB0+IbmQ
P2Dux7b224zIzyXNz2npWnhkLRqVGA==
=0iaa
-----END PGP SIGNATURE-----

--Sig_/BI=LnLnJ8yUvPft7vj4C.Ge--
