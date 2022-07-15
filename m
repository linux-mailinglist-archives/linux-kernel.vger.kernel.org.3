Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7F36576122
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232655AbiGOMG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiGOMGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:06:52 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D2585D6E;
        Fri, 15 Jul 2022 05:06:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lkqpc4nYwz4xZD;
        Fri, 15 Jul 2022 22:06:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657886808;
        bh=jEVwLH1s7Ccu9gK0ZkWxMS+cXWp4/CJxWlH8w+ZXKME=;
        h=Date:From:To:Cc:Subject:From;
        b=JFM3wPwKQaXREyxMcoz64VVSrBEKToPyc0pBO6+Ve9FixjAkIXQ9Ebkyw9R95njff
         6wIIgD49BwB8CB/+0q99bfKLb9HJPmEn/ZLehqGnOpP5djN6KZfv/bmKtJFjMIqARj
         ff2NenZo/tWWI8YgYwMuUrbuZIJRLYeP2fT4v6hDyHnvtlSiQ70OvLdGx6PXpZJiRr
         AU1l6kRyQqeCW750znSCMMmnmu3wfNkfmtCer1uglb19joQUTiYDHOg4SSpVO7YgI1
         FQmcOVrBHxq9CZ+HwB3curNKlqEqnNjyGCgiwsN9dD5woa9RlUfK/nvR+JUCcILT5z
         i2EZQXGWJXSdA==
Date:   Fri, 15 Jul 2022 22:06:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the block tree
Message-ID: <20220715220647.4b47e62c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/2QWu8C9K7WxNYji_yGPzB5R";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/2QWu8C9K7WxNYji_yGPzB5R
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the block tree, today's linux-next build (htmldocs)
produced this warning:

kernel/trace/blktrace.c:1884: warning: Function parameter or member 'opf' n=
ot described in 'blk_fill_rwbs'
kernel/trace/blktrace.c:1884: warning: Excess function parameter 'op' descr=
iption in 'blk_fill_rwbs'

Introduced by commit

  919dbca8670d ("blktrace: Use the new blk_opf_t type")

--=20
Cheers,
Stephen Rothwell

--Sig_/2QWu8C9K7WxNYji_yGPzB5R
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLRWFcACgkQAVBC80lX
0GygVQgAkw9l9UVqacrNJeqt04R9LQDULo/OToKfU9k6X1SzFKbALFisVasdtQyK
wg1TfYg8fDdZiypgiHhLCeIZ4WguPbLgBEdQ6JSYT2+4X+1xrzz7FWRJNaF8vPfg
t5fseArvGUdnDiaKiTiQhnTXkg/5WQGYxFpeus955grQltDbdMCrj66rd/0+9K8c
T2vRN3Z8krk9xVWya40FpaCqi4FXD9LJsfwSk9webxfU7neBgY0AjdeUwJ6oBTnw
3mNsAX830Iv21FAfrsjulFs8bR6Koh0zvLl9lvnzZPNDtMA8PWOlPDdEsLve8gly
URbR0hXJ7qaSqX5Q2G8R5DiXpZl3Kg==
=GVNT
-----END PGP SIGNATURE-----

--Sig_/2QWu8C9K7WxNYji_yGPzB5R--
