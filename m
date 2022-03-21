Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41374E1E9E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 02:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239189AbiCUBXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 21:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbiCUBXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 21:23:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A4370F44;
        Sun, 20 Mar 2022 18:22:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KMH0V4zXSz4xNq;
        Mon, 21 Mar 2022 12:22:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647825739;
        bh=H0stCziyVDLD3DINOQhpsqwLktWFysFx9RKi2uMqjMM=;
        h=Date:From:To:Cc:Subject:From;
        b=ixjRL5bHHhUOM2LtKIul2Vmk5uz2xGPnNbvHJO+DtWT82tBoXYtPBONt4IZ5qxXi0
         4LRqLSwAwFyxsS632zcACB24w3wouMu7Ky0RxU89TrxxCRUvPNugDKhY9jrwNrS9qj
         9UWOmrper4uvYW3zWOYjICt2BHvsH3/CB2xDGH94ElPjzmzQxDcEkWXcieEa0R9GUT
         /Dkx1MlhV0j+d2N+HeHRiDmhTGlom6+LVT54zSHJR3tQWXrhN6Z8tLEaflvh6DuB5i
         GuzoIB82MfM7njLcxk3+V4joy3kgB68nZxfAiHciVmtjl1D7sH+T35rskCp9WOEpwA
         oQhnlxIPnux7g==
Date:   Mon, 21 Mar 2022 12:22:17 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Chaitanya Kulkarni <kch@nvidia.com>,
        Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20220321122217.6bc6b678@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SX6L_ANRHgWuEhVHmfXR_N9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SX6L_ANRHgWuEhVHmfXR_N9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  drivers/nvme/target/configfs.c

between commit:

  0c48645a7f39 ("nvmet: revert "nvmet: make discovery NQN configurable"")

from Linus' tree and commit:

  73d77c53ff34 ("nvmet: don't fold lines")

from the block tree.

I fixed it up (The former removed some code that was updated by the
latter) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/SX6L_ANRHgWuEhVHmfXR_N9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmI300kACgkQAVBC80lX
0Gzw/gf/RFoEhrecQK7WRo0s4gLGi+RPKvOj7eJn9tsNuEBZSlnJMbQqJAWsDPNY
XqWZnZfvZdpDAMwwYbBL005WTulWR/l0J3uuFGRlAO9kDQVxqMzdKDrrjjXELtig
unNaxljGImtppa+HXam4yteUXvhoarhtdlrQamr54u9ljCq2nR+Xv8P0rmMXptmd
E/cVuIF3E8pSuzdvPRrVxqKM37G2RQ6M9G6mM69HvZ0n+BD70cH561v110MNRh26
JRJpkDa5rXIydZcSpr0+Pfm6dC7wYzcU4Mgny+XJYM8JYd/WTs38bvm8vmLlVI3L
WQ9ubqRVjM1vQJOv2woZmxIGFW0+MQ==
=eQE4
-----END PGP SIGNATURE-----

--Sig_/SX6L_ANRHgWuEhVHmfXR_N9--
