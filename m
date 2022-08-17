Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5108597937
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242065AbiHQVqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:46:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242045AbiHQVqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:46:40 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A306AB063;
        Wed, 17 Aug 2022 14:46:37 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M7M6H726Xz4x3w;
        Thu, 18 Aug 2022 07:46:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660772792;
        bh=u/F2KPLWFmyNWZkM3jhYdD+8B08Z2J7Qu4O6UZvmGN4=;
        h=Date:From:To:Cc:Subject:From;
        b=oGyDiC0F2NNKGJ3YvqxYD5qZsZ8w+Pstsz4NRxIwE1+pCWnHnYvlzsIHKBqZTstiS
         LlHGc+V5JQzE3tv3gAlVdEJiUSwHSq/QmJz06d2dVvzU7YyTEBZZ/Yzi2emQGJT5/1
         Cj9I7DaGR+FxPxXUc5tx7xIXmJkAtxO5ALYEbWXsXo4Hhhd2y/6AWgcJxO/xKeVqud
         sFapHDbaLe3N3y9rP5jaYXin8aLPagyFeWBd5A4mqVfTCdo11kStXy2pS2uYUQxtWG
         D03pBwR1lh/DY4eK3+mKsdBz6RLWSGKx8xXBQkigCWCc68YQXICoz3Irx0TTzsfNqw
         570VBHIKq0/AA==
Date:   Thu, 18 Aug 2022 07:46:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the mm-hotfixes
 tree
Message-ID: <20220818074615.55c693a1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A.O7fhxODIkBkKT6q1ZMtok";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A.O7fhxODIkBkKT6q1ZMtok
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commit

  71443ad8d694 ("ocfs2: fix freeing uninitialized resource on ocfs2_dlm_shu=
tdown")

is missing a Signed-off-by from its author.

This is just another case of the author being rewritten by the ocfs2
mailing list.

--=20
Cheers,
Stephen Rothwell

--Sig_/A.O7fhxODIkBkKT6q1ZMtok
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL9YacACgkQAVBC80lX
0GxbaAf/SzFPdPuAPK525Hi9g8wCxbScFFIJZXoLFk+wkzVZE7G9VRQa9LbofEe5
YHEu4qLksbCu10Bs+qANAzum/jLWV+xgUGY4qyplDvqyvjfdC+IzUDGaY6gPcviv
GjE6jf17qEiQqKtsL9S57COgiyuHwn//ovrbxNuK1/aNBUTKk8oDHIpj0MfYp5Y7
ubvT1r+LVKWOdN49Gh6sVzxfbt2u2kXOGNO1psW/Z4Zide3mABZ1rdPfBDZTd4dU
P+8zeMLS/nQyOZbuosoWQnkTuIcccJZjN6Y6FtncsZwUX2U2+Mse1K6LD5oRlSKa
6ngKlzwlctTx3INompCeb59AeR8EiA==
=Qbvo
-----END PGP SIGNATURE-----

--Sig_/A.O7fhxODIkBkKT6q1ZMtok--
