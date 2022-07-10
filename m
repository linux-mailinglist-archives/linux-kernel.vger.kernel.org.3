Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FE956D1D1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 00:47:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiGJWrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 18:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJWrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 18:47:32 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8128B14020;
        Sun, 10 Jul 2022 15:47:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lh2G65Bnxz4xD9;
        Mon, 11 Jul 2022 08:47:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657493246;
        bh=iVK3CsYEkIR1/tZ4z2hcFPWA2N48goqdU1AFq1VQr6s=;
        h=Date:From:To:Cc:Subject:From;
        b=ArCMMiUTHwU3RIdabHIBXdSOdkBluhMT21Gl2utOD3yh3yH+9NZ8XTg0RGa2r4Eni
         mPJJaok2TPOcFvjWuO6c1neQwPsesNcIn55uFp7wbieK4joKMRXwF/S6IYxAa94uWu
         7g4TLByj+11EAWehIS2KVEEWeiApFb2TrhSX60o9y+KJv7YS+tpq+L9Upl8/uGSiC5
         gnYPZGh+9H/ZtfimInbeyJKdSgbZjIu5W5E+uZmUiIzGcUPtz9W4HxaT3a/VPMJrTX
         fJX1gr9NPXm05RP4U8pUXLs2SwSS20lKLPDc5R+SsH0hFmKySRVwtwRxZj++zkYDNq
         LmPGGOcdm/1fQ==
Date:   Mon, 11 Jul 2022 08:47:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the kvms390 tree
Message-ID: <20220711084725.26b9ed99@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kpuoL_Fmf.aFdEynhKkcgxp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kpuoL_Fmf.aFdEynhKkcgxp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  a25db9e809ec ("MAINTAINERS: additional files related kvm s390 pci passthr=
ough")
  a0c4d1109d6c ("KVM: s390: add KVM_S390_ZPCI_OP to manage guest zPCI devic=
es")
  a4ae95559e77 ("vfio-pci/zdev: different maxstbl for interpreted devices")
  0a8107de8091 ("vfio-pci/zdev: add function handle to clp base capability")
  6518ebc68c72 ("vfio-pci/zdev: add open/close device hooks")
  b8d6db486fae ("KVM: s390: pci: add routines to start/stop interpretive ex=
ecution")
  d53ad189a06d ("KVM: s390: pci: provide routines for enabling/disabling in=
terrupt forwarding")
  1779cffa5bf9 ("KVM: s390: mechanism to enable guest zPCI Interpretation")
  834c4bfa5b5c ("KVM: s390: pci: enable host forwarding of Adapter Event No=
tifications")
  394f70328769 ("KVM: s390: pci: do initial setup for AEN interpretation")
  7713b9894b2a ("KVM: s390: pci: add basic kvm_zdev structure")
  b6a7066f4e9b ("vfio/pci: introduce CONFIG_VFIO_PCI_ZDEV_KVM")
  59370746253b ("s390/pci: stash dtsm and maxstbl")
  729c8d1d957a ("s390/pci: stash associated GISA designation")
  59f42dba7d24 ("s390/pci: externalize the SIC operation controls and routi=
ne")
  db29efaf10d4 ("s390/airq: allow for airq structure that uses an input vec=
tor")
  7a7bdc5f142a ("s390/airq: pass more TPI info to airq handlers")
  5857c6577bdc ("s390/sclp: detect the AISI facility")
  1e41bd8fd172 ("s390/sclp: detect the AENI facility")
  2f3a5d8de328 ("s390/sclp: detect the AISII facility")
  263007d2d10b ("s390/sclp: detect the zPCI load/store interpretation facil=
ity")

are missing a Signed-off-by from their committer.

--=20
Cheers,
Stephen Rothwell

--Sig_/kpuoL_Fmf.aFdEynhKkcgxp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLLVv0ACgkQAVBC80lX
0Gw1nAf/S8lu8VWMxwH/XHGkWkXseae0DtlMBdUuCAxG9u10EW5F7YI4/DVFSUSJ
/iwl/zAhxyllj7PTDJNPbjt4LWiHt+13jV74Kg/ccHZOJ9E1L3ufMrP4kJJ8IpLG
nn+2fvXUuNoBMuLOCIH+qtrp8LE9FEx3aqw5q2DvAuqputYpeC6b7QUBlEPPfE57
ItxpBzDU5Ao5HODmubDo11ouUeOK1TpGDD0Lzn7wCPyzeTVlSgkq4t1Mo2iIBagb
4vHeH5rxKF2hdJpRQFimE0fYtfHLaHZgOIIAfnKA/X5jENWqkWiu3bh8BFYMRpRl
dSyj1R8+gCxFRmHaYeoc0iZFWlGWsw==
=o6qp
-----END PGP SIGNATURE-----

--Sig_/kpuoL_Fmf.aFdEynhKkcgxp--
