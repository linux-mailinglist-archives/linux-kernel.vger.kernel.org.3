Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2865ADBFA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 01:51:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiIEXvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 19:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiIEXvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 19:51:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF0137F8C;
        Mon,  5 Sep 2022 16:50:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MM4z45GYgz4x1d;
        Tue,  6 Sep 2022 09:50:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662421857;
        bh=iKkMD8pLUppKo4CrYvVP5qZqGbMH0rIbl8/NNluHiu8=;
        h=Date:From:To:Cc:Subject:From;
        b=b2BeSDAi5r8XkUi/rG2xNHPQwidEYL6gLMoAutSNMQjMYY8YKsAwJjrT1tJgNWSzY
         DxZLhuDXHTDbt1aJ5TuV1skdcqxsRU+7jY/M4xmnY1EeEr0MKqIG5OcGx44WIk93JU
         6UZsOTymngfLYCRS47529pkhMv11nFjdNNlKl4IKi8c95y12AWVmnS8SMmXT1Bwpxh
         V19w9NsrlV3bl8MhhVvnTn3IiV0MASivLmwNrGADMJJiRc9F9vlOPV+SO5O71LsKUn
         EaYkORNOiI1DaWeMpMgLYx2uIguUVdgusdzir3O3EigUdL4w2UKIrCg/OhpJxtu8SB
         YmuytE2YSMtIg==
Date:   Tue, 6 Sep 2022 09:50:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Josef Bacik <josef@toxicpanda.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the btrfs tree with the btrfs-fixes
 tree
Message-ID: <20220906095055.498d90ea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+ZW8GY.DYKoImP.5RiOqcl+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+ZW8GY.DYKoImP.5RiOqcl+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/zoned.c

between commit:

  6ca64ac27631 ("btrfs: zoned: fix mounting with conventional zones")

from the btrfs-fixes tree and commit:

  e5182af66852 ("btrfs: convert block group bit field to use bit helpers")

from the btrfs tree.

I fixed it up (the former removed some of the code modified by the latter)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/+ZW8GY.DYKoImP.5RiOqcl+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMWi18ACgkQAVBC80lX
0GyPBQf/fLS3R4N6ZMGkwDopaIPWD/0WInzWomaCfw5phpI0LaIG6Ke8aSPo+Sxk
A8B32PFUbzKrRztMdcNjppChwD+tIHHYhOxF7P8BpQKBIGfm0lyJttsVmWZ4fVRi
sAS/Wm+gsWzaM67bQoDxwmE9dGEt1/cKDtS/OONzUil+T/SdftYTrOEN80p35aTg
OAvcJpVgdqKug2y9sIthx0JmGKpgoSb9+h64taSFY3LlaWCeuVHR3suifxRarKbA
9vZ13z9J7n1R+YForP/Ec21u6LKReSN8l++POS+a1hqO5qy3lDAW5KxXFzL1S1MB
SBh9wtEkrel45wpOJCQGZ4KNWmpjiA==
=X7dK
-----END PGP SIGNATURE-----

--Sig_/+ZW8GY.DYKoImP.5RiOqcl+--
