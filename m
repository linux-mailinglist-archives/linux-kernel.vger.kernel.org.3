Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BE652158E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241690AbiEJMjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241848AbiEJMjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:39:36 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E9A02B1640;
        Tue, 10 May 2022 05:35:34 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyHZC5WCjz4xbN;
        Tue, 10 May 2022 22:35:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652186132;
        bh=MLWzkWE0Q+XzgwkdnYJywkMBFuvMtuO7i/ibU6SGfDo=;
        h=Date:From:To:Cc:Subject:From;
        b=VfHL2M6dK1qr2xB7cfAHy6zIG40UaooA2Nr4BQ0zRCE0fsXdkis0XiST1KqaH1AFv
         VCA1osVkxA8/Sp90FDIwDZPYuRIfg0VPovqHoYzRS1wrnRQdeR5ABtks+LAKFRlQB2
         BGIJ7qhBmjNVNJZTiWnFKlUkJweE6KLz536Hr6ZET7NjiPtn0v9rRZLBXVUQw5uwgI
         pWLyog8f/42bnA3inytUYppBdWdKCPdGyQZLpMknTHvzwnQKotsCqWrPn2g/Rj0aKo
         wtiFnFlASvSdBkvMFQE7MQjaG4QuU+qYcLKxcb5Se6PA+8W9S/4pCSCYk6HiUctc4H
         SeHflxOUaGlSw==
Date:   Tue, 10 May 2022 22:35:30 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Chengming Zhou <zhouchengming@bytedance.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the akpm tree with the mm-hotfixes tree
Message-ID: <20220510223530.67d9a27f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aVcrujEU3rvicBxN0Eaj.x3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aVcrujEU3rvicBxN0Eaj.x3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm tree got a conflict in:

  tools/testing/selftests/vm/Makefile

between commit:

  e33ebf536f3e ("selftests: vm: Makefile: rename TARGETS to VMTARGETS")

from the mm-hotfixes tree and patch:

  "kselftest/vm: override TARGETS from arguments"

from the akpm tree.

I fixed it up the obvious way and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/aVcrujEU3rvicBxN0Eaj.x3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ6XBIACgkQAVBC80lX
0GzvEQgAnc3P1NsJcmx90FSEyN4Bt9kdiHCK64Mrb0Q/Pw3sRdGglvI02hnvQ0mM
fnPUuyo8yzLpUiq7T47xL4/Hsb1uQUfej4gTOnnq9rPvpOCAa9zr3UpkelKp6x96
OYzD5hTBQNo1r8qZX/NxZkHFLRjtr4QNGHgvD4dAOt4ALpi9P4WkjF2gnnIAxw7N
x8pJDMcqQkdkLIUtSYR2gDVXmR9uQZ8ec35xTrVa4TxCnhTjvU8s7xUXHpYzs7b6
dVY/nsDgJotLPHqb8K6UNr5GNrRekybSXdXkVXADzDlz6dH1cWVLq/hQfrXTyU3E
9ldmn+8Kx7SL8pBYOhhO/bYpeywFcg==
=7Ooe
-----END PGP SIGNATURE-----

--Sig_/aVcrujEU3rvicBxN0Eaj.x3--
