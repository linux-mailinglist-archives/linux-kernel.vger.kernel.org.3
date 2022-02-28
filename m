Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4504C6029
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 01:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiB1Als (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 19:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbiB1Alq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 19:41:46 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 853BF473AA;
        Sun, 27 Feb 2022 16:41:08 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4K6M4g0Y9Fz4xcZ;
        Mon, 28 Feb 2022 11:41:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1646008867;
        bh=HOAJ9qPlMjptQSC2BsGTJtw1VsKubJwHriHUkUCjiEs=;
        h=Date:From:To:Cc:Subject:From;
        b=NXMwO1W5Yax+UfLz3wtMydC6inkWnTFwJjkClwA6GWMCoz+BAcrwrK2JDLrCWwrBg
         ABHP+mT1YL6C6GxLTVk4vpCIfiDu57kAcLtzRnDg8nqcK7UotAipCKQ/RB9l7IyOXU
         SRsBX3yq2P3/7yHPcQiJMKs9AXmXwTvHxUtkvhD+pI3A4nAfwanZ1lK0hYKvMEVITp
         DNHMRZh6X8YOgj1tua+L/Tr7Mab/lE6AbeFYoKboYVqPQE5XQjvwA7FJ/ljuqkkjwf
         c5aQif/twfXIM4jG3BUgQis9J4SZ3+ITKwpziQ6PvpwxuY4myTG8wt3JmS49nnBMsa
         AtjW3cYVoha/g==
Date:   Mon, 28 Feb 2022 11:41:06 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yoshinori Sato <ysato@users.sourceforge.jp>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the h8300 tree with the asm-generic
 tree
Message-ID: <20220228114018.30fda009@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/meU1R+857vEcOhoJHrK1JM/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/meU1R+857vEcOhoJHrK1JM/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the h8300 tree got a conflict in:

  arch/h8300/mm/memory.c

between commit:

  967747bbc084 ("uaccess: remove CONFIG_SET_FS")

from the asm-generic tree and commit:

  81dd24966885 ("h8300: remove memory.c")

from the h8300 tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/meU1R+857vEcOhoJHrK1JM/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIcGiIACgkQAVBC80lX
0GwVJAf/UfVxLQSDHeBb8csgX4LlJ7Z2sw2ThNBbGNhYRtL48r4K/oEgq8hysKM+
BqNdqYQem4hJ4YHaRIkChqNNoO56y/yMv7vszYrWIpmdMWZOKTbdA7Vhvgti27io
DK66/1mKfeYFTsSum4Hhd/YxRYdF4Xg+5w9HLPJhJ6xBn+4ne8IC0pG0vbhJ2/VE
X2QBN0LT7l6rCwz/b7gstGOhsPd23CLZr6qNuzI6cUwtoqbY0ZyCSirZTlwCezSR
JMnwldzfn45KFUPBN5d62zOR4T4JNaDxuhYqRkCht3Iax9VXy0TDi7uLfrzmu6Qp
IcfNxZmKDRJUwBRcV5xJd4ZCrnsBFQ==
=piGt
-----END PGP SIGNATURE-----

--Sig_/meU1R+857vEcOhoJHrK1JM/--
