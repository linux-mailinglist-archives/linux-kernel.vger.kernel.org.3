Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69AE3530D97
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 12:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiEWJOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbiEWJOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 05:14:05 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E467446B3B;
        Mon, 23 May 2022 02:14:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6BTk2zSqz4xXg;
        Mon, 23 May 2022 19:14:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653297242;
        bh=bAqoIMEuQquPVKkfMuxks/eKt3v5juteOw3qBcvys58=;
        h=Date:From:To:Cc:Subject:From;
        b=M4DRqq3qZTNlqaGQoFdIShgUnBPZxKxEgWUf1nYChNxef9tF0SEpH4Fwmvmb5EZ6s
         RW9zy0seuf7HoYimzNCAgb/2KaF8mka2LoI/VaVvXWBI/b88bXJHnXNjvoutm1TvpY
         Aw0aCBinpqsdgOa/Ygv2WdVmamN5Ocph9+gJEqhL6tiO69uH03l/WZPtSOzU1pYCGt
         uZVWLeplsry+V2S8uzyc1AZfY0LUpC6YCP2l6GA0mDxwhfesCDWBemOK2thqoaiSrG
         6OLuIcB5gcwK9cSvYHE2g83BILDfXy/edwVjgcbdf1sgO+lCmjo5BCxqW6QfsfhQ+c
         Lx+d29ZCx/t7w==
Date:   Mon, 23 May 2022 19:14:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: linux-next: manual merge of the bitmap tree with Linus' tree
Message-ID: <20220523191401.2fccbdd6@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8vnJZJq2krq+Nj4hTh=PJWZ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8vnJZJq2krq+Nj4hTh=PJWZ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  arch/x86/kvm/hyperv.c

between commit:

  ea8c66fe8d8f ("KVM: x86: hyper-v: fix type of valid_bank_mask")

from Linus' tree and commit:

  017a983d0ecf ("KVM: x86: hyper-v: replace bitmap_weight() with hweight64(=
)")

from the bitmap tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/8vnJZJq2krq+Nj4hTh=PJWZ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKLUFkACgkQAVBC80lX
0GxdMAf+KQJMtqsd9fpEWss5ITLmbWRZ+ui4Z3Z/jibPYF63fHneeX1hM54ZOI+b
UCYPbfOUwJbn+vCUI/mibD6xfudTW42fd+1bSJssuZLthUl0I5Lgc9bYZnJb0Oq3
KsCUH8VQD/ZaXyWmTnhOb+CMI2ed0vS+IIc6JfHfV0NN+nyqq7rLnhH5b4I8v8nD
8ku5s+Hk3oMGXxTgSPiPcNVM2JwYmnJFxEScFGCxz0Cn86TGOst0sgOnZAS4QrBJ
gB6+eQ/UCI6zOxSHCoTNlboIN2NtY4Zr82rRE/pGD03mY0OFZpgRPpfBav9nYlm0
S3NeFMH68fcUshx9wooUzpRVnshXpw==
=3Jks
-----END PGP SIGNATURE-----

--Sig_/8vnJZJq2krq+Nj4hTh=PJWZ--
