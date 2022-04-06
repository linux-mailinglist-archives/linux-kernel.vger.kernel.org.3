Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D754F64FC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 18:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237298AbiDFQVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 12:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237478AbiDFQVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 12:21:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236A01CFF82;
        Tue,  5 Apr 2022 19:45:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KY84c40gZz4xXv;
        Wed,  6 Apr 2022 12:45:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649213106;
        bh=1+sqTb0wM2qZfgwqUDRrCmRK6iregCrgSZT9Fz4WIpY=;
        h=Date:From:To:Cc:Subject:From;
        b=nx6MQaIXz9w7QZh9oAn32NiPKAKDRlblu6g/ms217t8xbnyMpiEzd+XdHgha8DLuE
         5ucOKKt1oGy2TWe7Y9nHKypGd/RRweDE1gevZ14IHRWDyuNz7S3XhQX3QLR1VOUwc5
         ENCHYmshfv87L2rqL7KTGmF1joEo8C4+rNUW5OXtWWY392qLdGLcOaUk8VmHCq2cCt
         /x7U7j+BfloOTHUrHn8c9Wfo02ZWPV3+j1CQZtcmRK0Xyt2j4JMvACzZrQ6DzouNIb
         npIORKWC0pbzSe7MgOPv3g1h/mhWOGwbYQLqesHHm4JcDtZtREeFhisQum11l+mNxq
         qp0a5R2v9oqZQ==
Date:   Wed, 6 Apr 2022 12:45:03 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: linux-next: manual merge of the rcu tree with the tip tree
Message-ID: <20220406124503.25e8ed68@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/js5uG5LcJijHlYphM5dKCDW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/js5uG5LcJijHlYphM5dKCDW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got conflicts in:

  kernel/sched/core.c
  include/linux/sched.h

between commit:

  cfe43f478b79 ("preempt/dynamic: Introduce preemption model accessors")

from the tip tree and commit:

  42e3e3c6a774 ("EXP preempt/dynamic: Introduce preempt mode accessors")

from the rcu tree.

Well, this is just a pain.  Paul, please don't put expierimental things
in you linuc-nect included branch.  I have dropped the rcu tree today.

The rules I use for the linux-next tree are:

"You will need to ensure that the patches/commits in your tree/series have
been:
     * submitted under GPL v2 (or later) and include the Contributor's
        Signed-off-by,
     * posted to the relevant mailing list,
     * reviewed by you (or another maintainer of your subsystem tree),
     * successfully unit tested, and=20
     * destined for the current or next Linux merge window.

Basically, this should be just what you would send to Linus (or ask him
to fetch).  It is allowed to be rebased if you deem it necessary."

--=20
Cheers,
Stephen Rothwell=20
sfr@canb.auug.org.au

--=20
Cheers,
Stephen Rothwell

--Sig_/js5uG5LcJijHlYphM5dKCDW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJM/q8ACgkQAVBC80lX
0Gxivgf+OuWWEyB8TtgNsIXnwXz6OpNaQiaTzj04k5qrP+a5xlFfVWrhh43GS8BR
eqv0fVdli4tiZTpqqdKFVc3+t4H9cs1jIKmCxK61p/E0u5xx/eqPL0K6/bgtdWmV
yK2w5HvrbxKA3eMt4M5or7Ehv+9HfyK2VlsrAVDVaGukXeqiAMkBVbD5p++o2zh4
EWxuFsXwH3xf/nOPC45XNFfamrxAQguKMYZlhtyMKbYEXG9CrPg8BVtcxxNuBDca
SOCjb2fadtXxnXYvORErWWxK0XEi91n6mEPOyVg2F7Il0M5dCwQgu7SUu6NBMjBr
OgqGuRxoYxsmt3TPxfmfniu5FmCbKA==
=QCxQ
-----END PGP SIGNATURE-----

--Sig_/js5uG5LcJijHlYphM5dKCDW--
