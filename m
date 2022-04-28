Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0B42512D3F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 09:44:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245665AbiD1HrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245494AbiD1HrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 03:47:20 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7D49D05D;
        Thu, 28 Apr 2022 00:44:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KpngN6jzpz4xNl;
        Thu, 28 Apr 2022 17:44:00 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651131842;
        bh=amNapjCLjURLE0UVrVvkvdsxtrh346rHjxYHltNNEeY=;
        h=Date:From:To:Cc:Subject:From;
        b=ZLcRj0w8WNV3FzPMqwSXsHgKIYpt6MkiHWqaSkxfEGMUcxeO5/J/ByOxobTk/9OQ+
         jzLO2wcPEnCItilFVAXbBDXJOppJLS6lhs0ACRKGL2r3zO2ZScRpx8Vn1ebL8lR1PK
         6eO3XfXYR2xPyfrQzW3JLKvorfUwhkXTwo0BEQGmwn0CNgTL69oECFqqz+OiuU+bSE
         Zj1dsBIN30lm3rDzl40ZtpucWURxl1zTDXvLHcAhccfdF7z8yoE3BNK+vaZPwR2UGc
         bPF46cN0VLyhO80Wqn1tv+qYD75bQjlr9tZkRj3nP0gxWVNv13x5ZtjrppcePSeFP0
         ewZo0Docus5TA==
Date:   Thu, 28 Apr 2022 17:44:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20220428174400.5b1a4b9b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Yr0Yq6fdL165bm17a.+CqnV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yr0Yq6fdL165bm17a.+CqnV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (htmldocs) produced
this warning:

Documentation/vm/page_owner.rst:176: WARNING: Literal block expected; none =
found.

Introduced by commit

  0613ea580918 ("tools/vm/page_owner_sort.c: support sorting blocks by mult=
iple keys")

or commit

  0996cc55c8e3 ("Merge branch 'linus' into mm-stable")

--=20
Cheers,
Stephen Rothwell

--Sig_/Yr0Yq6fdL165bm17a.+CqnV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJqRcAACgkQAVBC80lX
0Gz3igf8DaXC/bODXD1VTuoT5LAOy3dQGZ77BKhm+XPXUoiN1UQdA+UG+ReVfKKF
YcbTk72SRVnROfKGgPYUtcxQEuqIz92f632P1a+J2XbDHQZCRkKDUU+5ngMUaDu1
3jft1cywCaugeMRP8aMRZrmcp5Y4JfU6LM+nWmJTkQur+ot4sIstHpVlDOvwXpgJ
lFEu9Gdy4TJXebYGnmpBZRtZdfuSiz+eiLHbbk6GUqGlXfRLhamhRdqOiGLXr4ix
iNTduWnMkZkJlcnWHSSYsRvjXCGxvlzfQXq7qBLmg1b6vwtOEKGlvtrmtxXrhRuh
l2ukDUtnlS9Rt3SZsPqMHq2ftfCHVg==
=z3+1
-----END PGP SIGNATURE-----

--Sig_/Yr0Yq6fdL165bm17a.+CqnV--
