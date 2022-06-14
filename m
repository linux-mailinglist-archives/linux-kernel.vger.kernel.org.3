Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCE954A78F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237369AbiFNDeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:34:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbiFNDeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:34:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB89D2F3AB;
        Mon, 13 Jun 2022 20:34:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMYvd400Fz4xYC;
        Tue, 14 Jun 2022 13:34:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655177662;
        bh=aVBDcex9xuVU47iI1YrP1wnTDjoykVLXNbXEs85vAzI=;
        h=Date:From:To:Cc:Subject:From;
        b=iuH8mfb92AxAZnH/ZoPgDfXuLlbAIER8Ekd1Y40VPhZWDujYrrzVZgfGNmwDUuOck
         ik8sdmAAy6c+zRwgjjKmgbfuZ0T3II/aapdYlDOFw4aL8LMlG0j3VSAGLEbPJavvI6
         5LxLDKix9mxUnlz0yUyk/R3MBwgS5LGON54cHClEnhZ5Q2+4D7IMdrA1NSvxOPaA7g
         GBzUhGoYw3CwMbhOamDvS43blLDkKKISSvEaTwvBfjZVbSl0XqYc9k/KqaWMun9/dz
         qVVuQEMqSrIHIt50WWgAiCHAJgZ8+BxYEEAUxJOVCE1UF8PDTYa43LonKAlO4aZXGS
         PXRp/epF7fUKQ==
Date:   Tue, 14 Jun 2022 13:34:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the btrfs tree
Message-ID: <20220614133419.5e10ba00@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/KkjETaiVYXQffIj1+s/J1yg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/KkjETaiVYXQffIj1+s/J1yg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/btrfs/disk-io.c

between commit:

  fe9b88cb7288 ("btrfs: use preallocated page for super block write")

from the btrfs tree and commit:

  020ae1ea6060 ("btrfs: Use a folio in wait_dev_supers()")

from the folio tree.

I fixed it up (I did not know how to fix this up, so I used the former -
effectively reverting the latter) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/KkjETaiVYXQffIj1+s/J1yg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKoAbsACgkQAVBC80lX
0GwLIggAosxPOEsmzhOKQD4JnaidypIVfg2pj/O20eeZaJ6QVh3Ho1jwD7LKv70u
6MyUEuFgzINKHZOL8qlSZMl6IgwF5azHKz++6xDic8fodQh7RDfvk3IefsXHxzKy
9WhI6JiwIrhOrXshNTtR2an7HUn9VkPe/17FsnE0zZT7yb65Kt0HWnbPVF5tnHtW
Gkz4NUBxTebgIHRCzHdk/klUvZt1JXn+PJnJGTCyA4zIbT8QZkNBWp/EsB3CpFUQ
KStwYkwRdZujsVrbpdis7wNb/Zll3oVoypNmFyv/qjspixRtBbp0blCraYnP/occ
wWF8vsNDuD6hnoKA74XJCcQ/LJ7dbQ==
=uPzH
-----END PGP SIGNATURE-----

--Sig_/KkjETaiVYXQffIj1+s/J1yg--
