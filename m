Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311E84EA53E
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:34:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiC2CgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiC2CgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:36:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ECC52467C7;
        Mon, 28 Mar 2022 19:34:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KSDCn56CLz4xXh;
        Tue, 29 Mar 2022 13:34:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648521255;
        bh=nbfcybE20PpnRiD+elMc1rwomlbOKhyQj34+YxgHgQ0=;
        h=Date:From:To:Cc:Subject:From;
        b=lLF7+1Ru6Zg376PQT9F5F6M15x/kUGy8UHKNwOlEdBpGj7T9gATsOrpVBnjv5AwfQ
         mZWh3CLRp71f2AnWF8J47VQio8naX6DMePMGvX0sSjQKc7NUr9mgg6ih5mD3qXiPH2
         /BncON483axkpbv2CcJoRibKQtI2y7rLxkQbRAomRvV1HAdrYz8H2bEifq8sxSO4Fr
         /bi0DactlX6z0BwUJ3bYyESLFwi5Kay4vSXJJWeHyMeBQQWkERANSS4huDZTOeskzg
         6MLDVMIbnzpImVfBkuvHzx/wOjd5+9UFEGyLch4ej9MgiuPOvyqap1Y3x6F4OO+JL9
         fTxnm2WGHBUIQ==
Date:   Tue, 29 Mar 2022 13:34:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul@pwsan.com>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Atish Patra <atishp@atishpatra.org>,
        Atish Patra <atishp@rivosinc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the risc-v tree
Message-ID: <20220329133412.591d6882@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8G2sDaC9zXpc4k/_1JT_B1g";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8G2sDaC9zXpc4k/_1JT_B1g
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the risc-v tree, today's linux-next build (htmldocs)
produced this warning:

Documentation/riscv/index.rst:5: WARNING: toctree contains reference to non=
existing document 'riscv/pmu'

Introduced by commit

  23b1f18326ec ("Documentation: riscv: Remove the old documentation")

This is actually in Linus' tree.  Sorry I missed it when it was
introduced.

--=20
Cheers,
Stephen Rothwell

--Sig_/8G2sDaC9zXpc4k/_1JT_B1g
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJCcCQACgkQAVBC80lX
0GzV6wf7Bm+/GSMpAMN8LfAjONy+dBEu/yUNm3OPRpVq2YaxB3jTdtaJVqkULbxf
9KpMkecPhg3ZLbe/Lmygfbk0+w+7WScENT2Oi7ObIg4wrnb/eRLOGy8gOFxFFX91
tby07NJ9RxQ69IVoudRAStKzEx5Ib2Br/+hnyQmbmj/06Jutr1jaXyJVnftMalBb
4qL+y57Gq2KUekrkfz5pyCCpDHtp/HUIfeQAP89mC5ssNZpZc9iNnCiyuA0cdGVx
md8fIszpMBOMdsPavEolxQlZrGiXBmJRJqeMAwOq0BRTSOV9B+j7Z4yQvgbPzbFL
xD734ZUI7fR42ZZL9NVjgQkwz70X/Q==
=fbDA
-----END PGP SIGNATURE-----

--Sig_/8G2sDaC9zXpc4k/_1JT_B1g--
