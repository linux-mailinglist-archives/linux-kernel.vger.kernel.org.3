Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 085C85ADCFA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiIFBiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbiIFBiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:38:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C17040BF3;
        Mon,  5 Sep 2022 18:38:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MM7M02TR7z4xD3;
        Tue,  6 Sep 2022 11:38:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662428301;
        bh=EP4v0HVtzqr4OhiGfzW++iM6gOALpxsstR02odUX3Jc=;
        h=Date:From:To:Cc:Subject:From;
        b=Y+xLeyFGikQ1ePNQCUggqfDU6pUG1RTb74hPbXimJ2NJe+1qdngX02Rq18cXRx/ij
         yRNDxPbs7qc2AOcBkeOP14EqWa/e+mZuHm0sWeJY1oy6G7boEkYteQR1tGgJvnW9GN
         2tZV+JJq+VcH8v5oeyd6Geuk++opglvxISfUqfnDD7IcFHSm9Hlx2wM/7lhiC+csnN
         OO1OOmMVRGy2e5X/3Se//PDNt0E3+dxZCsIaMgwG9Avvfk/Kwc1hh8YAzhvU42CpeN
         DzHviGaG3zt/s0HPegpriT+2Tu8IyRyqC04QY3EQyC8hxuxVLQz3om96jUKZUbI0Dr
         N2wdZxyBKiiOQ==
Date:   Tue, 6 Sep 2022 11:38:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Sean Paul <seanpaul@chromium.org>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>
Subject: linux-next: manual merge of the drm-msm-lumag tree with the drm-msm
 tree
Message-ID: <20220906113819.1abecef0@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/b3BY9fikNfi30pYXQU722Fh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/b3BY9fikNfi30pYXQU722Fh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-msm-lumag tree got a conflict in:

  drivers/gpu/drm/msm/msm_gem.h

between commit:

  b352ba54a820 ("drm/msm/gem: Convert to using drm_gem_lru")

from the drm-msm tree and commit:

  aabc003330ed ("drm/msm: fix repeated words in comments")

from the drm-msm-lumag tree.

I fixed it up (the former removed the comment updated by the latter) and
can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/b3BY9fikNfi30pYXQU722Fh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMWpIsACgkQAVBC80lX
0GyrBggAkMNs+ErNLGwBN0icVa04IcdlcCNbNHeIAfy4AHMEPa0zzCIsTR64EI+E
gczZXin8CnzFuPRqAwlhQgLGR4VvBo/ypa3Mk6+xcCRUO6spV7/HvbOxL1clwSDc
1F+p6XbE/KedCTzRZn+4ZySiK5tmew9Pyj/Am4EMCmNvSc8Yr/rh1FHXT5B0nYrv
2WOxMjziJCOYiGM05RQx2yb6ZSlKSrdIVmEaXLmNHWRd6mYkllxQLyh/NWMVgy5i
pVN2ulHdHNOuH2nSVrSMVss9pOVMzdHH9QlN4nRRKEgC9030Rd2ofg69lnQ1P1eh
sYfM6wLDeE6buimEL+H3k0W0Qwv/CA==
=R88x
-----END PGP SIGNATURE-----

--Sig_/b3BY9fikNfi30pYXQU722Fh--
