Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7239C5A401D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 00:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229542AbiH1W55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 18:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiH1W5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 18:57:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DBA22497C;
        Sun, 28 Aug 2022 15:57:52 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MG89Q0nXwz4xDB;
        Mon, 29 Aug 2022 08:57:45 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661727467;
        bh=Yqo8XRJXmrZ78DGccIiqAtUBDk2Wkswb2Q63M32n5EU=;
        h=Date:From:To:Cc:Subject:From;
        b=jtN3I0NChKbLAcov4XASmzL7eG9qnsjRo3P777ZOVqX8xxT4yN27sJH06Ha9MTgQL
         hsNcx2tOxUyPMI6/9nprUPKWr29IqoORisrdAl9q14WmJPVoVJQYLtwJMt0zE8SWij
         BLiZML7cDQg3b9xDbMOGzcgp78oF8ioeoxhsX0WNV6iXqak3AD8l22F4vrInB3X4vj
         UHm3w5JBL7PgCaQEYSSF4cVobZNB5ZurbwQqrq0fYgx8aCrL4R6lsc6lXLgPYWCOAK
         G9YfqYXMsd2WwkrsW01I3g2leqf1mlzouWjAbPQYiMbmj/tikn+ulXWUqV5EvjvMA7
         fsJaBE0Tyfk1Q==
Date:   Mon, 29 Aug 2022 08:57:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20220829085730.142da032@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/EDWs8V67X9A1mMFOOGLjJQT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/EDWs8V67X9A1mMFOOGLjJQT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  6bc72375dd93 ("perf: Add system error and not in transaction branch types=
")

is missing a Signed-off-by from its author.

--=20
Cheers,
Stephen Rothwell

--Sig_/EDWs8V67X9A1mMFOOGLjJQT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmML8toACgkQAVBC80lX
0GzUwAgAhe5V5isNZiywJseAON4f5QffYj9GJCMPUwpRBe215J9On1SJHAJHBaHW
6VIOeKEHHdKCkYk4WdTafRO/BCPN50YJKGLInoTl2WoudhrzB9vHiehoGllxUN2H
aurwOp0c150JQRhif+q+r0kLN8WSk28F/UCsGq+11PyPplfSGECVYAUzGTg4VaGy
ML0nkry7ApfCosbspTrmsiiiyxYW++SlbwzLmhAnBWL5HtVDD11v7izR084GdrsX
6gE6UOUWuXwBB5OHj/sJup+H9xRrv0cZ9oY0uHmjLZOsGDxBojokrorN0YVNtV0f
2A8zw1emIzkQQUC3v6kk1BLgH2rn2A==
=SvqJ
-----END PGP SIGNATURE-----

--Sig_/EDWs8V67X9A1mMFOOGLjJQT--
