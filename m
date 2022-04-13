Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1841F4FEE6F
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 07:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232381AbiDMFRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 01:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiDMFRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 01:17:37 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF224F47D;
        Tue, 12 Apr 2022 22:15:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KdW4g0cXxz4xNp;
        Wed, 13 Apr 2022 15:15:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649826915;
        bh=MJI2fvsqvA9AcqaZGQX/nWxrCq8mpakwYuiN3F16N38=;
        h=Date:From:To:Cc:Subject:From;
        b=aOhLdYA33e4fYIAULVFU3kMY9Qil0vVCsC7PujqgYw9cyBZWRLI+z7Y3t1KsMTghF
         o+BnCLEV6dckcSIde7ZkD2Tg5uVj3PRB4kwhXNn9xRFRF0HZkWckp53n74tE5kXAkp
         0MfcVRAW3oYBrxZNK4eLLZo2kZ0+6GjMvldAtLG6eVCq8JdUPXdWYHVF0TWHwD4sqZ
         f4NgAEnIthn0BaFch5yl0FwCCffJPMfGXQq0ZUu1d6EcGPobBF5jjc54S9V4gEiuYM
         pFVKFtT3mSqGlLGGcGsD8/j4KqhP28aFRPjo3rENQCYB8EuAmPVQtEP7jI/2ZdDMhr
         6VqdQ50faXMCw==
Date:   Wed, 13 Apr 2022 15:15:13 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Yu Zhao <yuzhao@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the akpm-current tree
Message-ID: <20220413151513.5a0d7a7e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_//kAm4UCa8YTpBahUwuBLnat";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_//kAm4UCa8YTpBahUwuBLnat
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the akpm-current tree, today's linux-next build (i386
defconfig) produced this warning:

WARNING: unmet direct dependencies detected for ARCH_HAS_NONLEAF_PMD_YOUNG
  Depends on [n]: PGTABLE_LEVELS [=3D2]>2
  Selected by [y]:
  - X86 [=3Dy]

WARNING: unmet direct dependencies detected for ARCH_HAS_NONLEAF_PMD_YOUNG
  Depends on [n]: PGTABLE_LEVELS [=3D2]>2
  Selected by [y]:
  - X86 [=3Dy]

WARNING: unmet direct dependencies detected for ARCH_HAS_NONLEAF_PMD_YOUNG
  Depends on [n]: PGTABLE_LEVELS [=3D2]>2
  Selected by [y]:
  - X86 [=3Dy]

WARNING: unmet direct dependencies detected for ARCH_HAS_NONLEAF_PMD_YOUNG
  Depends on [n]: PGTABLE_LEVELS [=3D2]>2
  Selected by [y]:
  - X86 [=3Dy]

WARNING: unmet direct dependencies detected for ARCH_HAS_NONLEAF_PMD_YOUNG
  Depends on [n]: PGTABLE_LEVELS [=3D2]>2
  Selected by [y]:
  - X86 [=3Dy]

Introduced by commit

  7613417c58a8 ("mm: x86: add CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG")

--=20
Cheers,
Stephen Rothwell

--Sig_//kAm4UCa8YTpBahUwuBLnat
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJWXGEACgkQAVBC80lX
0GzQ5Qf8DpsmpmwYiIcPI74eKPrL0N3AtDN/ovvirYJ3/lzZ8y6H42ewJYT50zWJ
LOuKg9wMs9v5ID3byiDHAKyRLeaUiL38tlNk5Rrd3MfaUVxqHVz2zZ/g/hwBD0uB
F6MFGnVCaH+/WPuI7TnO8QFeGFU0DLOLmCDrt6JySnZi3kb2vbkBvIPEaHlg0QYl
gjN0uR9EcdE0d6GSphyvmX/oWrsSTCyU/N3Pe2ML7/QFdx8UQkLZ7LQ5Pl/1IBxq
oHHxzy3ozRhRp4VU85iG2MkkgRjBWGYZSHcMTEJXHm4KLBJgsXCfHAzAjPmVqrqt
fOUuayh8eskm4bG7l/qVRfh/6WQGmg==
=ztRJ
-----END PGP SIGNATURE-----

--Sig_//kAm4UCa8YTpBahUwuBLnat--
