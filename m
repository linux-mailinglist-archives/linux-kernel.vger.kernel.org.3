Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E341753C0A8
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 00:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239570AbiFBWMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 18:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbiFBWMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 18:12:49 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218D21FCDB;
        Thu,  2 Jun 2022 15:12:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LDgHZ1Tmxz4xXg;
        Fri,  3 Jun 2022 08:12:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1654207962;
        bh=ve61wgSuXEc6WPnIRJgC9ELhgl1i/D1lrVDNLVYUKjY=;
        h=Date:From:To:Cc:Subject:From;
        b=vEJL08WRJiZlnom5QB+PQslzLJlBorZIw374e4gw8P/8IGMHDYMJwqFNk8n5r4UoU
         VU2w4rroS2tselmtvnHRG0hwrsR/6YhYtiK6PXzzquGy6A0+xdbzjtQprNlhzCflNa
         shdpXoI0DqZnANrib8ZD/RIGTbpeafkTykVFqFF6G+pgpM7eXn+Ufa59u9ZZ0qDLRl
         cFxoRvI5yqiANje2vpLNm2zrHKlI91vOtzQ+x5qFujDzSa92Tpm30DpaFuxeQgijok
         V1iQwOTFSASfFWIAGXmLftgD8w+DTYKukPHe8GDtIKRO3yL24ayNyE5Mzv8X05Ocsq
         SCyq6gFLHRY4Q==
Date:   Fri, 3 Jun 2022 08:12:40 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Steven Whitehouse <swhiteho@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     Andreas Gruenbacher <agruenba@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the gfs2 tree
Message-ID: <20220603081240.3d2b99af@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ltvi4GXKjRGZ3A2bSDihkiz";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ltvi4GXKjRGZ3A2bSDihkiz
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  c70bac321715 ("gfs2: Remove redundant NULL check before kfree")

is missing a Signed-off-by from its committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/Ltvi4GXKjRGZ3A2bSDihkiz
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKZNdgACgkQAVBC80lX
0GwBzQf/ZqYvnAeiI2SZqa/EFo/fQePhN1myTEuQ6lHZk1yiPO0YCMCg8YIYbx1h
Th1V+s2812nw+wtbfNlVlQMxD/MDMUJEN4U4RSc45cRS1ew9AUEXpVK+8pHFoqgK
k5kuzRbvgVOH/oqqoNKDPh3wQENzW9GDJY64Tf86e+66urx/K/ubwyBvJvkuYJab
fp9A1JIKSrnRwWvMFf7qIZluj35t9/csxAwNkgKD7pKTmNsRLi6oIvB/092LNChd
ufLNt3yZkFzDMUVdzOooW5/LF6Yc/ySgsSB0uToc+xm3aIt3J4ZvM61peaZozf2W
vMREg4CthcRexRoA1oJnT9Ik15ZM6Q==
=xP+Y
-----END PGP SIGNATURE-----

--Sig_/Ltvi4GXKjRGZ3A2bSDihkiz--
