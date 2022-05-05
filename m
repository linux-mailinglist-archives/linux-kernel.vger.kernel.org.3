Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 501C051B50A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 03:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiEEBKE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 21:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234132AbiEEBKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 21:10:01 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69D849255;
        Wed,  4 May 2022 18:06:23 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KtwWL2m53z4xLR;
        Thu,  5 May 2022 11:06:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651712782;
        bh=RZnJ0Bs+kbVt1yem4FzbL5vfR8id23cYqPzyEgoi81c=;
        h=Date:From:To:Cc:Subject:From;
        b=RBVw8GZ8R3A/EwTg6NUH+P9cm5DupsyP4ld8AKiOVhydvtIUVS/z0WIHeT/bg454b
         zEHmN7iUOEcsDL6nT72OQLZF3PQyaakQNH3bUej2KfiT3aq2jsmIGHtXkEup2SBbuK
         ccFebvsj2pGx9nceyhMAeeQ+Iv+NXI37xY+R1b+5AJ0QgzfahOzwmRQH031WTesUKh
         TbHvXBzKXOBUMMiUv8uyvr2C+MUBKABUtaHJDCIcmhoIDKq0ogqOEG/yTE5a6jajsf
         Zd9YY0JI55DTYwSBg3cjZXvlFrOeNBkAQeuasD3ikJrTLVzqkaHCkYbpuihUmKCIwX
         TuoMjOUn4PrsQ==
Date:   Thu, 5 May 2022 11:06:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>,
        Dave Airlie <airlied@linux.ie>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm-msm tree with the drm tree
Message-ID: <20220505110621.66f8420c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kJJbsRGS0nnN8.2vkWr5UrV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kJJbsRGS0nnN8.2vkWr5UrV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm tree got conflicts in:

  drivers/gpu/drm/msm/edp/edp.h
  drivers/gpu/drm/msm/edp/edp_ctrl.c

between commit:

  da68386d9edb ("drm: Rename dp/ to display/")

from the drm tree and commit:

  f1fc2b87de47 ("drm/msm: drop old eDP block support (again)")

from the drm-msm tree.

I fixed it up (I just removed the files) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/kJJbsRGS0nnN8.2vkWr5UrV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJzIw0ACgkQAVBC80lX
0GwAwgf7BHcAx9ccnxJxgWEJEcGjyL2UQRZmwg4SaWyjbRygl+eaXZH60jyIQap3
hmcm3ujc6Fs0Lxt79qdmNYCGMniFP0NGtR0eXA+Ga35z/hwPqafqF+2eLKn7iTZt
yTRbd6Hm4LthV2Gz0eNTfsdrJWmVXtY2VK55Th4lhBrPkk3Uk8/E8LrO+CG5Dj4/
HptzKNckTu105pNNkkulJeNIcjqBjegnA0Uz0u/M2mAcL4TiIHUsKS0l2SvZ6mvT
c7oSL/FngmSLMiIXvWz7yISCqupTxT1x6bZjvJL+dORXn5HmxYeiR0Gm58lP5weP
v2vJ5klirdUqSFTU0q7b3qxa3wkXyQ==
=KdJg
-----END PGP SIGNATURE-----

--Sig_/kJJbsRGS0nnN8.2vkWr5UrV--
