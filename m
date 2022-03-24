Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB3E44E6B58
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 00:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356657AbiCXXvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 19:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357728AbiCXXuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 19:50:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777953B3F3;
        Thu, 24 Mar 2022 16:48:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KPhkL6C9qz4xYc;
        Fri, 25 Mar 2022 10:48:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648165707;
        bh=FGaYydygHo7aD6IpnCFLKUSu/ytyGYSSz5y0DpV5kbs=;
        h=Date:From:To:Cc:Subject:From;
        b=sYhUKU5P3uUcxw62vZz3WiQ6LhwgcOUpCVBVMTjprX5tdxSC3k1c1YTppgurYS4As
         KliivHZ76pqwnXwkvEy+EfGMOhNZzhzk2n/sT2EojDv6kTXguYmrTmJrJidbMxrGH8
         tSkyVDGVQknMnbijC12mCAT8RB+TFKsl/+td1Y8pW936Kz+2HdTwcefLUYyjPRUO3u
         gFmy8/A665Ao4+SXObtfhmD6mJt3hRkSgsoO3wp935UmZUPUwhDbBabS1b0XG+SJMy
         UJxqGb3Vx06diP9n32wu6byaZY2JnbffbJcmvYCwKKEqBhLct/JkCCf03gd+4z1OKM
         CpIA568lDHV5w==
Date:   Fri, 25 Mar 2022 10:48:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the btrfs tree with the btrfs-fixes
 tree
Message-ID: <20220325104825.72c2e97c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Wqj0wr/92CqfDAhZhsLf_3_";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Wqj0wr/92CqfDAhZhsLf_3_
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the btrfs tree got a conflict in:

  fs/btrfs/zoned.c

between commits:

  0b9e66762aa0 ("btrfs: zoned: traverse devices under chunk_mutex in btrfs_=
can_activate_zone")
  62ed0bf7315b ("btrfs: zoned: remove left over ASSERT checking for single =
profile")

from the btrfs-fixes tree and commits:

  71f3883a5968 ("btrfs: zoned: use RCU list in btrfs_can_activate_zone")
  7d5e73a6ef6c ("btrfs: zoned: remove left over ASSERT checking for single =
profile")

from the btrfs tree.

I fixed it up (I just (arbitrarily) chose the former version) and can
carry the fix as necessary. This is now fixed as far as linux-next is
concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/Wqj0wr/92CqfDAhZhsLf_3_
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI9A0kACgkQAVBC80lX
0Gyk4Af8CC8j8BwCE6j/OGuApn7BDyr3k9wzHkfohLwaZK2X2H6IF0MRn6lIciZi
je5GgFVU3MBkGZvpc8WmBDcP4NqZtyhm+F+6mzF2Gz6s4Gex7Fj8nK+4+JIxbLHa
XlpOZE9RVlROTs9oYeI/Bfa4ry4tN0iXv3TpqAzvBSSLjunjiGb148VhGiNKYfKs
1q+mB5NjDD3pG5hAVKxJrxq2bLN5nlXa0Shh4Rz051rtadUb9S3f4yPxH6ww+AxH
DxMnQQCWcJVcnrMckEb+sa5azyutMKWcVM0gqXZ2mVfbdrr80UKG37A0pGJCMaaE
nfTfYC6d6GC6Zs7OE7Cu6NqHn/bWHQ==
=VkAI
-----END PGP SIGNATURE-----

--Sig_/Wqj0wr/92CqfDAhZhsLf_3_--
