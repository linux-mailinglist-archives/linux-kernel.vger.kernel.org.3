Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A199A57D7E7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 03:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiGVBD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 21:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiGVBDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 21:03:24 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866CC95C3A;
        Thu, 21 Jul 2022 18:03:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lprls1FZhz4xG6;
        Fri, 22 Jul 2022 11:03:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658451801;
        bh=/GRiuf7ykwnNRqHpIxEfCgtG4dEKDB3In+svl1cP9hw=;
        h=Date:From:To:Cc:Subject:From;
        b=BMW+D6yHW9qX7V1m9dxrpfFOu/EIrAKVTprEL6lPVPEd6qBLZVrwgbwh+fDgPRywL
         kAVnXrEts7867vY6wrWU7oIBOYP9Ti2VPU9jwXl9rfNgcKDW1l3k2hwNad1CXIsITT
         OyliphKvB28PdOXkPhorxEoe9lNEakV8EFKxU09LQnpo6FlmX9im8AJZHi0bH3akvg
         Wo+hvN+AwBBw/nHhCJ8uyFHJUbA1Q8Toy3CZ8NQlS1ii5/kSZEUtX48o+rUx8MMK37
         zFJSHGxUS5S6CsxpHwo011m3tar8AtfzkalvgqcOyRpIaDgR2+euryteD5rnMyEQKF
         U2a0wAfUcOIaw==
Date:   Fri, 22 Jul 2022 11:03:16 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Ioannis Angelakopoulos <iangelak@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the btrfs tree
Message-ID: <20220722110316.346f1982@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Gko6WDuEIwI48fbHmg3TGtT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Gko6WDuEIwI48fbHmg3TGtT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the btrfs tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

fs/btrfs/free-space-cache.c: In function 'load_free_space_cache':
fs/btrfs/free-space-cache.c:929:31: warning: variable 'mapping' set but not=
 used [-Wunused-but-set-variable]
  929 |         struct address_space *mapping;
      |                               ^~~~~~~

Introduced by commit

  22d85ab1af7d ("btrfs: Change the lockdep class of struct inode's invalida=
te_lock")

--=20
Cheers,
Stephen Rothwell

--Sig_/Gko6WDuEIwI48fbHmg3TGtT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLZ91QACgkQAVBC80lX
0GzXgAf+OtlbNcGt1OPQcL2PCJnqCmf3nbiEn2x+tGvIB7fTziI4rdLiQLucrYA/
j4GjxFeP92XhmS56ycN3zfDBN9nB3qlxudrfkJzJfcXVtuArz2MprYXtWJ6XELWL
HeUIGXzullO2RoSu9HXP1yPSa3VhBl29XgU2aJQhWQ98Lmptrr6bxFp/jsYDyjZA
S2nlG39cul8dI0LPJ2kzft1cl1FFDtNPRk86oyZxLeYLee5yx/Mr4WTGnanu/xuW
PvumqcH0GNDJAGAokGEIBrYMTWzIbU+5e+Do9mhz4Udcu4cl+UQgxXkNmN9nRSDn
3LC2N/vU8IsqmvtyVxMUy3MskDm3OQ==
=QIaS
-----END PGP SIGNATURE-----

--Sig_/Gko6WDuEIwI48fbHmg3TGtT--
