Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD9C5168B5
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 00:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355821AbiEAWmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 18:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344401AbiEAWm3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 18:42:29 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E43135D;
        Sun,  1 May 2022 15:39:03 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Ks1Nj3slsz4yST;
        Mon,  2 May 2022 08:39:01 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651444741;
        bh=xDkfU0lm2LrEa5wGgVjShzustLq/cMpaiB7Nlma1ydI=;
        h=Date:From:To:Cc:Subject:From;
        b=DoSS264S9MFh787CGL9Fc/51gHMDTbK9dK1EKpj4M+KM49OxKAZvilIysjHUpIjW+
         AiYn9V3R+SX9sv52ZEF/eWwGRUOfRvZzmgAkfgyMqmK582LAESfJQrewEEe4bTbn5x
         B8S3c/+z1pCA5s/XNM06zquI5Yc2JX6xIH8F7VFeE9/i+sooZeGyleaZ9Q3aVt1D9E
         2ZGUoxAopS6gWY9xFluS08xdadYfvqyIphHZw25p6Vv4QKZyVgXoBbm1TOue1U/7Cq
         CCIHpKuSJ+0pP+V505yaQDooF77Q9MpEgQAhC1K+k1Mwm4ia7FUbWuQWbnZAl5/DN6
         hMKVvIgcp+gMw==
Date:   Mon, 2 May 2022 08:39:00 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Rob Clark <robdclark@gmail.com>, Sean Paul <seanpaul@chromium.org>
Cc:     Vinod Polimera <quic_vpolimer@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm-msm tree
Message-ID: <20220502083900.407fbd70@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DPhQDLNfj5=tkf4Ga/EWcdH";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DPhQDLNfj5=tkf4Ga/EWcdH
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  adfed3ba1ecb ("drm/msm/disp/dpu1: set vbif hw config to NULL to avoid use=
 after memory free during pm runtime resume")

Fixes tag

  Fixes: 25fdd5933e4 ("drm/msm: Add SDM845 DPU support")

has these problem(s):

  - SHA1 should be at least 12 digits long
    This can be fixed for the future by setting core.abbrev to 12 (or
    more) or (for git v2.11 or later) just making sure it is not set
    (or set to "auto").

--=20
Cheers,
Stephen Rothwell

--Sig_/DPhQDLNfj5=tkf4Ga/EWcdH
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvDAQACgkQAVBC80lX
0GxhCwf/e9HFcrFmIiyHG7zGVvTLtsUtZDIFCdUbglSAXFweQ1cOISc4kdpLz1af
kJmSp44APw2o+9lxGses+WmpKvnP2cM9aW7CGIkQttjQiAzSP243TUP6wPVps0Ho
LnnIyylF1N52IPni7R8Ce/7DljZDqEUIpr+XHxqgdzI9S2sp/4BuJUiqsQZu7CFE
Gb6QRJP758ZkVh8mV2k+wx4TD+FbOI26SyEMeMXPOSHtfOyTAecD4WEWNayEVqBB
a6UB8hWkCUbXe/I4xywuLBGafzAiOVi/PNh7NC05HMyRIwei8TOoAlzxiHntL2V4
gCKp0F7OZPa7s5WIObfgLOWdY02oSw==
=/OIj
-----END PGP SIGNATURE-----

--Sig_/DPhQDLNfj5=tkf4Ga/EWcdH--
