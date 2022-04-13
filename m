Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92E3500147
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232014AbiDMVmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbiDMVma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:42:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE4F220D9;
        Wed, 13 Apr 2022 14:40:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kdwx20Rvxz4x7Y;
        Thu, 14 Apr 2022 07:40:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649886006;
        bh=UP6/pj+13gaL+ZuQaVo7KqqAUtsPYadAPh9E4WOCb5M=;
        h=Date:From:To:Cc:Subject:From;
        b=qP1njSa0jzWo7tHyqK9xb16YgL4V9vtM9t4RsWZECOZgMRxh5iMgxYEocdABZqWa8
         PdEACXXbAD8flKLrysGTdphoniBQqKTcTWetN2yhCwwBhRFW5L5frkq8FntA8Jfc4S
         +n035euQVUMTi4gxmfxqQGXXOTvmxlNQeMl7KSMRhGlaf4Y2YBopvuPJRBDii0lj2m
         i9Y/JzgyjCb6lCYfIpWl+VBMd0sSez3P2Ld2vfzaWwVTpvLUuqiCPuxuM/crRT5QKF
         mRVTmxQYdcnx/RK0F7ycLViEBU6HOn7SLVWc2LxRuMPu6rMvrKfM7eVsvlfJSlYZg/
         63wGFtdXeiIgA==
Date:   Thu, 14 Apr 2022 07:40:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andy Gross <agross@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the qcom tree
Message-ID: <20220414074005.18cb9ed7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/yKL+LmmIjsnDDf0AA7NwZnM";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/yKL+LmmIjsnDDf0AA7NwZnM
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5827e2830467 ("arm64: dts: qcom: msm8994: Fix sleep clock name")

Fixes tag

  Fixes: 9204da57cd65 ("arm64: dts: qcom: msm8994: Provide missing "xo_boar=
d" and "sleep_clk" to GCC")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: 4dd1ad619274 ("arm64: dts: qcom: msm8994: Provide missing "xo_board"=
 and "sleep_clk" to GCC")

Also, please keep all the commit message tags together at the end of
the commit message.

--=20
Cheers,
Stephen Rothwell

--Sig_/yKL+LmmIjsnDDf0AA7NwZnM
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJXQzUACgkQAVBC80lX
0Gx7Bwf9FsC7u/YsWMqSoq3Flfy0DPO7s3/E+OnDgXoPjq4HZbb0Vj6MB7JlMEoI
jXCh0H3Us+nM57rLCF92AW1uJr5kpuS2d1lRnTDGCWG3wmMMOMIs9Zo1v6v9hIBl
A2Za+d470E5yKF8NfiYswDHBs2pwyOO3c476SncSOSXOOmAnAQRT6jR8h6Dq+jUC
j+cQPlukB0tLKdkdtYhxPJHZJdEWxD9Fj5K7wdlRX/SrjYIBL3Twg4cZ6AcNTItu
4rpqjP9Y2IWtuG6CzUuEI1ohvNdIcJ3AIlUrnR3erost8f/MYNxBwQmu8K5CvLX/
Jaomg0TcKoyre8HDrdN7HC3fwOEXPQ==
=sdU5
-----END PGP SIGNATURE-----

--Sig_/yKL+LmmIjsnDDf0AA7NwZnM--
