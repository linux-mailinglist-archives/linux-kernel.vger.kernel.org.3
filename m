Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBC056D30E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbiGKCrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGKCrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:47:53 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C75917E16;
        Sun, 10 Jul 2022 19:47:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lh7bM5bY4z4xMW;
        Mon, 11 Jul 2022 12:47:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657507666;
        bh=ImZg73woeRL/6pJYSTs9jApSEo/CdR975e2jvaOLVSk=;
        h=Date:From:To:Cc:Subject:From;
        b=fVIrA5lf8Jjc0JLHFuXHhWhjplfV6WpoGvpjuY4pR5arVyrV1Nx1O6E9j+Z8VzwZA
         wxC79xuP7dL1TCYFSNoXWg5BFAnxtaSPt1dIVE5KPvmGWamJJl5m0qsm9btDmSwMq6
         mWO2a0zl+dNIhvW/j5ks7ivxsyTYOAEOtt9mMfT0m6ZBtiPK+PuxbuqWWgpLb4TUgz
         u8kd8K1lIqe/YbBoeLNfqRdsxQl68xJ6TrEAOTOVRPF3TB7Jnp70/iwjRmVJn1uTvP
         JiqcUz0dzZPJlPESWSwtvMe75epdoJfPS6QAFkY0CObyF70Jg9vA0bONMkREPZMOKD
         inyAQFaLphd5g==
Date:   Mon, 11 Jul 2022 12:47:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Cc:     Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <20220711124742.3b151992@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/smMUJeGZzOH+aH15NIcQmOg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/smMUJeGZzOH+aH15NIcQmOg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c

between commit:

  925b6e59138c ("Revert "drm/amdgpu: add drm buddy support to amdgpu"")

from the drm-misc-fixes tree and commit:

  5e3f1e7729ec ("drm/amdgpu: fix start calculation in amdgpu_vram_mgr_new")

from the drm tree.

This is a mess :-(  I have just reverted the above revert before mergin
the drm tree for today, please fix it up.

--=20
Cheers,
Stephen Rothwell

--Sig_/smMUJeGZzOH+aH15NIcQmOg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLLj04ACgkQAVBC80lX
0GxMzgf/dC6QJfFPofDeEzs9hvc5vhaw+egnc3apm1nrEP7M2pja0U46UZOLvMcA
CoLNAKuA7CuJPEBNmxSDvWbKJlIczsEABFo40Kjv3bUFe0vImqctm/tV5gE0ejqp
hAW8rswWpcNRNi3Rf2CHLtmkdAxynBX45+kPD63K1hmmWayeNE3tXEjZn4XWbcmb
lieyknIODGyMA7LuDm3X9xQIzNo3FoaZ/q6OGlXVjARp/AseSdHnOf4jzoNkRjLo
1jONNlOkgndCvarZhqfrqTli3pRwMwU0ZS0KJdX4JAmB7Qz5ARiBhNDnam6n/get
CO9ZX1k1LEA8bMhT03UVigg6Ac5ZHA==
=j8bV
-----END PGP SIGNATURE-----

--Sig_/smMUJeGZzOH+aH15NIcQmOg--
