Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAEC8520D1A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 06:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236587AbiEJFAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 01:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236526AbiEJFAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 01:00:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B600823BE5;
        Mon,  9 May 2022 21:56:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ky5NF6Ybjz4xXk;
        Tue, 10 May 2022 14:56:13 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652158574;
        bh=qG3DB09m459rI56ayuEPdkMRjaBaaeI4AO1yvaGMTy8=;
        h=Date:From:To:Cc:Subject:From;
        b=DfPUxM8QqPs/p7MobusM98vDXgFOtdsq4MTyz/VBJ+3q95DTnnDs4TGuf+Ih/YsXi
         vKXUPWE5/C1dUkQILiLF03+M0/uRS/jpERWVb3mqwdg/d24N8f/MAStpSVknYkmyT8
         4c4JZFAMDxHRI/1zGtuZdBXOaYy2d+KgNXKvRqnPPsh8ZYLt+eTXc/jH8vaMPpuj0T
         BT/IM5ROc3i/Piujhiru/ekZmwUe961DU8tR2DJt7yRxiFYvud+DtSSaLiun1ADqA7
         EiVsIDZJ2YW0yXksevwUv6NKiy9T9w60gQ4GDJJQpi65CrEI3mhOCTPqN5pA6MuGEA
         rWFq1iJIcENDw==
Date:   Tue, 10 May 2022 14:56:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Moritz Fischer <mdf@kernel.org>, Xu Yilun <yilun.xu@intel.com>,
        Wu Hao <hao.wu@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Signed-off-by missing for commit in the fpga tree
Message-ID: <20220510145612.502d7930@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+jvf86HSuBp76xGkDLDvM8K";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+jvf86HSuBp76xGkDLDvM8K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Commits

  7269868818a4 ("fpga: fpga-region: fix kernel-doc formatting issues")
  d73ef1ed7300 ("fpga: Use tab instead of space indentation")
  154970f89f06 ("fpga: fpga-mgr: fix kernel-doc warnings")
  d0749c3c95fc ("fpga: fix for coding style issues")

are missing a Signed-off-by from their committer.

(A danger of rebasing omeone else's commits ..)

--=20
Cheers,
Stephen Rothwell

--Sig_/+jvf86HSuBp76xGkDLDvM8K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ58GwACgkQAVBC80lX
0Gw7tAf6A9FwI/OZvIFNmEC3bdePWR5ewDzYCipCxSlyjPXqzwvgtUqp4xGAWC9+
SH3vIyyKCZm72HCYyB0sUxwS5oXJ8N/gZBQwHRn3IZvV5U0pWt7jXOdvhcoRsQAf
4R0cT3tSsdmGPSLqJ7/KYsadsLnOuB5Bs79nCuQHq7uIum4U3l9z2WLa8lirrHky
knUKZXNAurDgrr6nhGbsQr+/LEPsIZeNYKyMto0Uvsky1sveu/1o5x8d/FNF9qrk
xGk32LRF3XBhm9Qb1rp3SJV/sYCY4S8DgLGwcN+rQv4RoMGqhSgxB/wwUQPFrW6q
VcrAsrna5XpNcwBr5dWSMNY2r4DBrg==
=nApB
-----END PGP SIGNATURE-----

--Sig_/+jvf86HSuBp76xGkDLDvM8K--
