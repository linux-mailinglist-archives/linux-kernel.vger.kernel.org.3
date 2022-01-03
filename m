Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5947483851
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 22:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiACVZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 16:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiACVZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 16:25:53 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89A8C061761;
        Mon,  3 Jan 2022 13:25:52 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JSTLl19kQz4xZ1;
        Tue,  4 Jan 2022 08:25:50 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1641245151;
        bh=HL/DLPLpEN5gN/mSaxQtI751bOk6ZooOuNzousR9s3Q=;
        h=Date:From:To:Cc:Subject:From;
        b=g8dWzx8v+EhKqlz9DTSzP3tgY/aTkVmVoesTHrwaTe/H3L7sbK4RcV+0nZkFP1jxJ
         +2qXOL11m+khjWhKOqiDs/XAAU9pXCl8K00iyeckMZbHGERKWLMHaSVHqQAxUMguGZ
         hkNqwUFvp9ZGkZS6wYJbCSMizvethneCnxsNDs1xF7U4eTzq7xoGbYphfBK9oP1w/V
         fsZN+Ol3Foiv9z6WNblR+XGc2jg61syyB65m/IbbU9CAsB4yQtviVa920GgC7TXuVo
         xPL3u8HOWqeeC7gxiKEh96iWcdYQrCmlg0vu/Rpada5Vym9a/pggayY8xLZyGfZi5w
         +HUAds0F3PKzg==
Date:   Tue, 4 Jan 2022 08:25:49 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Geliang Tang <geliang.tang@suse.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the block tree
Message-ID: <20220104082549.2b1f7bce@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/e3xAwjXMaHm7J8dd4KWKl2b";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/e3xAwjXMaHm7J8dd4KWKl2b
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  3a605e32a7f8 ("nvme: drop unused variable ctrl in nvme_setup_cmd")

Fixes tag

  Fixes: 292ddf67bbd5 ("nvme: increment request genctr on completion")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: e4fdb2b167ed ("nvme: increment request genctr on completion")

--=20
Cheers,
Stephen Rothwell

--Sig_/e3xAwjXMaHm7J8dd4KWKl2b
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHTad4ACgkQAVBC80lX
0GzgvQf+JYdd1e9v2PhRkfs1Sp++bQLoDL/nLM91KpyohSbvluEYqkdDCRMuLwYK
lJJFqgbXq85Gzl8sD7/tImqM1VI9yDoTIGQpdxytIZdWWIoPsTJj/oxDDavfJ1/6
h003YUL4zPwxWd3IE/DMlyLLWEuQIyHm6tcjh3zovokAD4tMpsCzTT5hH9Ds/RyU
EHa601E3nmJ8wzEvbtpChFozpxwYsMYFhgbBlo2tYBDlFNJCkZG+Ub4ft4HEwy5L
o2NlhMqYs64hwjIjeBrxGsUzwDWvp/+kjxGaQgYe0wSXf3ITXYhCglzrIiU42xXC
5hDVvV6GEVlNpUpalAs7CXP1k1ZLXg==
=jAqh
-----END PGP SIGNATURE-----

--Sig_/e3xAwjXMaHm7J8dd4KWKl2b--
