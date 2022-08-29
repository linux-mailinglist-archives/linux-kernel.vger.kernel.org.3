Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8315A420D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 06:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH2EzD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 00:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiH2EzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 00:55:00 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64B83E033;
        Sun, 28 Aug 2022 21:54:58 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MGJ5T18Gkz4wgr;
        Mon, 29 Aug 2022 14:54:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661748893;
        bh=xFQ7zfJRnQWJoRz960vXmdbXNSKrViSHnR9p/nXzFB0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Obr3Qa0DgFtB8KMxZ9dNlwIc4V9R63OD+FmZ6/DR3uAXgPpXwU62Sv8EKtjIfAQ0x
         BAC/PJ511xbooNXOKw5B70sTW6tK/v/EGYUGsAHQPPH+0Lqgs2IENEhSPsk6VQU9AB
         L3zk8T4vEAtrmEpHF+VJJjdPiC2AiuLNGd/1OrdAM5BfE9UqXz42mVhbkDN1C4K7Gc
         yB/BRnB4lbN1va7Rkti4f67mfg4qyLvb9Z3bkbh5tS7IN13/S+GamJ0j+WUeCasKwH
         gJCyYtCintqC+7jujuGx52llpBWybvS0cvKM0hP2xZEGJJXDLrA36ost4JS1Jp0NzZ
         Nfjcx5sm6j+EA==
Date:   Mon, 29 Aug 2022 14:54:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the scsi-mkp tree
Message-ID: <20220829145451.388505a3@canb.auug.org.au>
In-Reply-To: <20220824115057.107e3d42@canb.auug.org.au>
References: <20220824115057.107e3d42@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/G.zbZoIa+fZo/1ILOd/r7Dn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/G.zbZoIa+fZo/1ILOd/r7Dn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 24 Aug 2022 11:50:57 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the scsi-mkp tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> In file included from include/linux/bitmap.h:9,
>                  from include/linux/cpumask.h:12,
>                  from arch/x86/include/asm/cpumask.h:5,
>                  from arch/x86/include/asm/msr.h:11,
>                  from arch/x86/include/asm/processor.h:22,
>                  from arch/x86/include/asm/cpufeature.h:5,
>                  from arch/x86/include/asm/thread_info.h:53,
>                  from include/linux/thread_info.h:60,
>                  from arch/x86/include/asm/preempt.h:7,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:55,
>                  from include/linux/wait.h:9,
>                  from include/linux/wait_bit.h:8,
>                  from include/linux/fs.h:6,
>                  from include/linux/highmem.h:5,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/blkdev.h:9,
>                  from drivers/scsi/mpi3mr/mpi3mr.h:13,
>                  from drivers/scsi/mpi3mr/mpi3mr_transport.c:10:
> drivers/scsi/mpi3mr/mpi3mr_transport.c: In function 'mpi3mr_update_mr_sas=
_port':
> include/linux/find.h:40:23: error: array subscript 'long unsigned int[0]'=
 is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Werro=
r=3Darray-bounds]
>    40 |                 val =3D *addr & GENMASK(size - 1, offset);
>       |                       ^~~~~
> drivers/scsi/mpi3mr/mpi3mr_transport.c:1610:27: note: while referencing '=
phys_to_be_added'
>  1610 |         u32 phy_mask_xor, phys_to_be_added, phys_to_be_removed;
>       |                           ^~~~~~~~~~~~~~~~
> In file included from include/linux/bitmap.h:9,
>                  from include/linux/cpumask.h:12,
>                  from arch/x86/include/asm/cpumask.h:5,
>                  from arch/x86/include/asm/msr.h:11,
>                  from arch/x86/include/asm/processor.h:22,
>                  from arch/x86/include/asm/cpufeature.h:5,
>                  from arch/x86/include/asm/thread_info.h:53,
>                  from include/linux/thread_info.h:60,
>                  from arch/x86/include/asm/preempt.h:7,
>                  from include/linux/preempt.h:78,
>                  from include/linux/spinlock.h:55,
>                  from include/linux/wait.h:9,
>                  from include/linux/wait_bit.h:8,
>                  from include/linux/fs.h:6,
>                  from include/linux/highmem.h:5,
>                  from include/linux/bvec.h:10,
>                  from include/linux/blk_types.h:10,
>                  from include/linux/blkdev.h:9,
>                  from drivers/scsi/mpi3mr/mpi3mr.h:13,
>                  from drivers/scsi/mpi3mr/mpi3mr_transport.c:10:
> include/linux/find.h:40:23: error: array subscript 'long unsigned int[0]'=
 is partly outside array bounds of 'u32[1]' {aka 'unsigned int[1]'} [-Werro=
r=3Darray-bounds]
>    40 |                 val =3D *addr & GENMASK(size - 1, offset);
>       |                       ^~~~~
> drivers/scsi/mpi3mr/mpi3mr_transport.c:1610:45: note: while referencing '=
phys_to_be_removed'
>  1610 |         u32 phy_mask_xor, phys_to_be_added, phys_to_be_removed;
>       |                                             ^~~~~~~~~~~~~~~~~~
> cc1: all warnings being treated as errors
>=20
> Caused by commit
>=20
>   434726c4b89c ("scsi: mpi3mr: Refresh SAS ports during soft reset")
>=20
> I have used the scsi-mkp tree from next-20220823 for today.

I am still seeing this failure.

--=20
Cheers,
Stephen Rothwell

--Sig_/G.zbZoIa+fZo/1ILOd/r7Dn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMMRpsACgkQAVBC80lX
0GyClwf/SzyY9E0qGYHpaxsCYUaaV5Dlnlt3PeuCCul4q5RSHzAZSCcYfDYmn8/l
A7LtSx8Exh8ygk2QoAu0HJGH/HdYW7D0GET+wzsxrnQbci5qjMmIttfxvnxLigmo
/U8W0lRMilT2LXPBqQQHr6iIkyIumIZxnLTbB/mNsyR32OsZfmyhcxkAhJ+vi9AS
psW3Mkf4aRVjmemt9eP0StAXGzLdphAlFYzn53jH6wn2jN7lalp/rk+ywhHUpCgE
DSZibETN8zF9jf/wynyk0bpLoXNzJ6fkyJa7VuMOrmlCuA52Z11PWSepQ9zvIGyu
Sf8ejxzzz7MZLTn8JWEQ/wY4uNZCmA==
=fFQu
-----END PGP SIGNATURE-----

--Sig_/G.zbZoIa+fZo/1ILOd/r7Dn--
