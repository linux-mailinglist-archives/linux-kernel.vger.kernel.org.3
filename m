Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3105D51F516
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbiEIHGC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:06:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235368AbiEIG41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:56:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875A5158974;
        Sun,  8 May 2022 23:52:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxX0F71kyz4xPw;
        Mon,  9 May 2022 16:51:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652079118;
        bh=W/+d4S9tcfXn8+PhKprWis+tDtcLApvdpUzHqCxGIkw=;
        h=Date:From:To:Cc:Subject:From;
        b=OBPIHa+/LXjGqFB3N7cSLTajCsWVLbRzdNunPFlIRWwkHhzH3n7eIpAsjttfSPOlN
         otA0SMUs8a3IDuTXbvP32GBeBXGtLntVit0gXsRQzh43KF1YdQW+uPGrMc6PDaGRUj
         Mi48MFqhk/4vrxxS6lj1dTgnooRZU+6PRCX8paBtk2ONwj97yMBxeEP5K/XB+8U7vq
         YaWDyUGidLB+KYBKFXLA4mKrOkUGV4LcznsbFeOnHYKnlCmeRwYV8R3+CT39LiEMgU
         R2mEqfOFRKrQHprxdqwdTVQCajiO1ahjZqQ+y0seJo1b368/qB9A6fsb9d95SmIqdw
         SPFLjBqHLPyHQ==
Date:   Mon, 9 May 2022 16:51:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the userns tree with the asm-generic
 tree
Message-ID: <20220509165157.0cb6505f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nM08NTFadHSvRcx+YSMBgO.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nM08NTFadHSvRcx+YSMBgO.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the userns tree got a conflict in:

  arch/h8300/kernel/process.c

between commit:

  1c4b5ecb7ea1 ("remove the h8300 architecture")

from the asm-generic tree and commits:

  c5febea0956f ("fork: Pass struct kernel_clone_args into copy_thread")
  5bd2e97c868a ("fork: Generalize PF_IO_WORKER handling")

from the userns tree.

I fixed it up (I just removed the file) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/nM08NTFadHSvRcx+YSMBgO.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ4ug0ACgkQAVBC80lX
0GwHdAf/XUpQ50Oj3C7ksmHd/nVHtJdcTJ6zxu8oTCnPYjVozYEXA922pG0Q/IOc
J9INi9iLhibQKIxsm7NYUH37TEYekiQZBIxh+1pSv/Ft1Bo010BPmOPQ+2y4CChl
lKEP3+5enGRcsqtMe0sSYWkC1lxgmLPk3PNCzlZRS4PjBjWPZieOjbf8j2T6jnUp
pPkMSplvvmIR1PAxF5gUhO8nCRibM465vaaY/DrM8gVsfguT+7OX5IVbx3lMKFDS
rTyXMFQdcw9cuUGCpC/LyyefmKTDwFvtQJCwSASdiGMBgm39rcWVtq2rbpxebUre
kL692hMlhTWOx75qpOiaHAOpNWxqRg==
=3MwO
-----END PGP SIGNATURE-----

--Sig_/nM08NTFadHSvRcx+YSMBgO.--
