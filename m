Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0E4F4DD223
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 01:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiCRA5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 20:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiCRA5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 20:57:10 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E20186147;
        Thu, 17 Mar 2022 17:55:51 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KKQYK01lsz4xw9;
        Fri, 18 Mar 2022 11:55:48 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647564950;
        bh=dLiSWckYYtCyaQxnZS0EI/Fqn7krxPz0DTfM9jp/tCQ=;
        h=Date:From:To:Cc:Subject:From;
        b=Shs3v3BozHrVRzw0s2N7WjkWfMma0keeLaMClMZYInrv42EXvb9BicZhFj90cLePZ
         vUHLtX2Ry/Ic8oHeqINJBj85Ge9yxFCSRqVlQFP5UOmBjR+L9wJRSUGfs4WHavm3OM
         1wXbXhFwmhjFzPkIhmdjfNastSY+OsE9GALor2I1iYLEze2Eb0Kt+CV3owe41nD2WA
         hJRc9vAmk6YlTSjh4XKqr74LaNsD+2AEr5fAQeLVAm74N+5q9Wcw4COor5Mjv7/n5Q
         iwO2hjEX4PtGcEiVI+eyNYAVpxs/cVCMLW72JHKn1vB4DLn342TRn1HmybaPwuxWcy
         djKtQ61L5TWng==
Date:   Fri, 18 Mar 2022 11:55:44 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>
Cc:     DRI <dri-devel@lists.freedesktop.org>,
        Julian Braha <julianbraha@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Foss <robert.foss@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: linux-next: manual merge of the drm tree with the drm-misc-fixes
 tree
Message-ID: <20220318115544.0c977415@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/vG/0mWiiww1HR.wIUTPt1mc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/vG/0mWiiww1HR.wIUTPt1mc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm tree got a conflict in:

  drivers/gpu/drm/bridge/Kconfig

between commit:

  3c3384050d68 ("drm: Don't make DRM_PANEL_BRIDGE dependent on DRM_KMS_HELP=
ERS")

from the drm-misc-fixes tree and commit:

  803abfd8dda5 ("drm: bridge: fix unmet dependency on DRM_KMS_HELPER for DR=
M_PANEL_BRIDGE")

from the drm tree.

I fixed it up (I just used the latter) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

--Sig_/vG/0mWiiww1HR.wIUTPt1mc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIz2JAACgkQAVBC80lX
0GzqGwf+JdNbV8TunrhuNZ+HguT1OG1W5wAGXpTFB4TEhHGczJML2kuo3/3Z8ata
N+bicMVbWsdsYDdWRxB0i5LkQ3R4D58BVuDLPo7D0/tqhT0PiSRmtCjox5GBUx6a
cVQY/F7iAjKkvbe5Y1HkVO6luHLutiGZhRPM4HU3Y/CA8cj7AJEGglxYchQkUSOl
vyLMN/C2lVEHAeg0ue3OMYCGFdGs3n/shu//0dmW+3uAVpzzE4dTsd0aRbFivfxV
yKi9mOeFT5eciBhdfXgbsDMfRdluaH4FBt2HPROobFf4f841vghuJn24AzZJ1zn9
6SqqlWKJu5r1OX69XZv00wFSCPMtbA==
=Bo5s
-----END PGP SIGNATURE-----

--Sig_/vG/0mWiiww1HR.wIUTPt1mc--
