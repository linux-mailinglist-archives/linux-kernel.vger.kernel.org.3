Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B784554D4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350648AbiFOW7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350676AbiFOW7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:59:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217CC22519;
        Wed, 15 Jun 2022 15:59:40 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LNgjj6jzpz4xYC;
        Thu, 16 Jun 2022 08:59:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655333978;
        bh=TeLimy5oNDN3N8iAo1Oqoz8dV3Vut+iMNx/ADAvdbDI=;
        h=Date:From:To:Cc:Subject:From;
        b=ZlnFoqM4tc18wjHpdYHh/r5uBqWmgQIZimMAAxqwuEP0v7g1N/u0jkLT85OT7SFBt
         IiGNaxiHKpFdjn+DOZ0UnpwoZjiwzouLOdW/gqKqN3tQM4tnNClLdjAdQHKvYasLpS
         Pe+mGX/iL8Gv9vrpXnZ/LQ1ShGalZXZQG4QKUzYwNaXc3Z1SkZqUMi5ARbW/WSnx7Y
         tgjcONTl965QIDaCGAMdGnF4Wgx4xcojoj8yvhMIKHZeVzUwL4GpNcWADpHIhGWyfz
         TwOvl7pWEHnHzo+p4RlEWogu+cyZzsV2jZ1cQarHQB6LE3AirD7CLbBAgzO1AR7tNZ
         nYjWeEleXW0mQ==
Date:   Thu, 16 Jun 2022 08:59:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tags need some work in the drm-msm-lumag tree
Message-ID: <20220616085937.2de4c9a5@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/acJQP/UKUofGI_l70R5T9.z";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/acJQP/UKUofGI_l70R5T9.z
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  c2bff24488ca ("drm/msm/dpu: remove hard-coded linewidth limit for writeba=
ck")

Fixes tag

  Fixes: d7d0e73f7de3 ("introduce the dpu_encoder_phys_* for writeback")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Fixes: d7d0e73f7de3 ("drm/msm/dpu: introduce the dpu_encoder_phys_* for wri=
teback")

In commit

  583e280ebb28 ("drm/msm/dpu: fix maxlinewidth for writeback block")

Fixes tag

  Fixes: 53324b99bd7b ("add writeback blocks to the sm8250 DPU catalog")

has these problem(s):

  - Subject does not match target commit subject
    Just use
	git log -1 --format=3D'Fixes: %h ("%s")'

Fixes: 53324b99bd7b ("drm/msm/dpu: add writeback blocks to the sm8250 DPU c=
atalog")

In commit

  defeb127761a ("drm/msm/dp: check core_initialized before disable interrup=
ts at dp_display_unbind()")

Fixes tag

  Fixes: a65c95ff88f2 ("drm/msm/dp: stop event kernel thread when DP unbind=
")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes; 570d3e5d28db ("drm/msm/dp: stop event kernel thread when DP unbind")

--=20
Cheers,
Stephen Rothwell

--Sig_/acJQP/UKUofGI_l70R5T9.z
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKqZFkACgkQAVBC80lX
0GxMIgf+PjDg6ArXbPPrT8eJH4H/wVofgg10GjEOTibRiclx5Sw++sxgyfsNTowm
2RVbzOBnot2nR+rVWNMRWbUGDvS/LCoPnKS9yy171MPG5qgNcNTW5L8EWiRCw4LR
NKZ/t3gTYDtcKT1z+t8UdfEl4ga08fADhg0exTP5nRtebGLPCNhLjJRmEE0l5Jjq
b3idtukFkqXaw8RpCj0YmBxBSl1u9B55ozMzWuw8M47osNYPBUD74sImjrX1RiU2
MEL93D76Gt+SX6+thZFTZu84Wd4JEkltjilYoNGhTNAnIDZLq2ph7E/O3bDxk7Oe
ZAO83BgLOCImel+u+5pkRX//jtCXGQ==
=pxGY
-----END PGP SIGNATURE-----

--Sig_/acJQP/UKUofGI_l70R5T9.z--
