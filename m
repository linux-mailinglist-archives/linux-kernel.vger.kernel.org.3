Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A655247CA
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351397AbiELIWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235236AbiELIWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:22:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65C860BBF;
        Thu, 12 May 2022 01:22:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzPs462kJz4xLb;
        Thu, 12 May 2022 18:22:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652343739;
        bh=oqyP/eRxWGgzdMpYZOapCZZTI3VMb9w9Q2Ll1LDMp+g=;
        h=Date:From:To:Cc:Subject:From;
        b=kNelXJ0j9LefnS7GPhRB+SHw3FnkJE76BbtSZIul/MQwTXe8OLmYMpQsiioAQAm8i
         ZtjC0f7O2oaTj4Vgubx5n6K5lkw9AdvKwKqvIe5hjGJQwWTC/7/VShJxuvExEmc9uV
         p5uxou3l+1mfqoqBoSUzfGd4aBnWQn9MzTMymYz3IniqZ6FYT++zQmGqoh4YsKbLKm
         XkMzpVcwoL08ctj12GIdBsz4r2Bm+Fel3TB2332ErUu4fev8u5NErE9YNCnVZztW2v
         JNzczg0xYvEqevHJky4X3R8Oz2b5GQHewmbliZ0bXti5TqiinXcywZX006pdYkjqxV
         N+7ohUO4+i7pw==
Date:   Thu, 12 May 2022 18:22:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: linux-next: manual merge of the mm-nonmm-stable tree with the
 userns tree
Message-ID: <20220512182215.2b7c4383@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ox+8JP5BUM2+dMsTHbi_O7h";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ox+8JP5BUM2+dMsTHbi_O7h
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm-nonmm-stable tree got a conflict in:

  include/linux/ptrace.h

between commit:

  c200e4bb44e8 ("ptrace/um: Replace PT_DTRACE with TIF_SINGLESTEP")

from the userns tree and commit:

  a9866bef5171 ("ptrace: fix wrong comment of PT_DTRACE")

from the mm-nonmm-stable tree.

I fixed it up (the former removed the line modified by the latter, so I
just removed it) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/ox+8JP5BUM2+dMsTHbi_O7h
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ8w7cACgkQAVBC80lX
0Gy9oAf+PAiz9mU/LrpUMChZQEEgwaT+FeeaL4gsx0eB3frVXHg5dzHxGgF1rFvR
E7tidJt6nHe7f+47gPagbHekZ90JpZC/NEh9DlZZd1mEXl9PR6AJv2Oyd3nX0Naw
Cjb/eHJWjCChUJHJ4sNhoopdqsOcfaf3lGUOqHTBEXocDWSaPoRgjmSrI0UFBCrJ
4hahFnv7NNp2Wj/kR08bQ18u/5Mx1EC9Xl8hP+OmHeRDEDjeQPVRewuwBcB589SR
E23jYSaC1qITJLrFHJ4xcnJA3K8x++F3jYXcCKGtU0alwm5lS41XM0C/E2RYzWhl
w5lXfcypW/Zad3TKbrf+egG8Oe2s6Q==
=lFRz
-----END PGP SIGNATURE-----

--Sig_/ox+8JP5BUM2+dMsTHbi_O7h--
