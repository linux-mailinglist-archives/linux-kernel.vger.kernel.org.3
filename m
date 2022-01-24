Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B9249A825
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1316591AbiAYC6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 21:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3414983AbiAYAyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 19:54:53 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF33C07A943;
        Mon, 24 Jan 2022 14:39:29 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JjPzz4m54z4xkH;
        Tue, 25 Jan 2022 09:39:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1643063967;
        bh=i8kDZCk52QI8veF0YomrMra8rtjhC+F06h4pX7lV/MA=;
        h=Date:From:To:Cc:Subject:From;
        b=A45HUIx+CN1OPW2vsz5JsRM8YAmVMwaRxPJq30VBlj+P9heEQazdOQfjS1d+LXjAP
         hU3BUgDb0nTbFz2hy2BlXFXbxUFxWfBhOAGANQUNIZa1w6O5zT7oc4hm4jEbss8kK4
         f5K+MGirhsRTLPT77DPgXGssiSGRO8uYS+y3K6FBgxHaObdGa58EK8beNSdJChnUmC
         5ipxwkJEDZCF1z+EUAnFD1eGIkbfwhcKhLUpq5Aq4+7BZkPtUpNDGIiAgSrNql1/Hj
         Slr5fekEPr6QrjmYhPUlKBwID2NKHyzIo/YiY1JOMkbhmxWoztFgRCIzXBmoMXrfgb
         2i4D4t70Q8iqA==
Date:   Tue, 25 Jan 2022 09:39:26 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        Ville =?UTF-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Subject: linux-next: manual merge of the drm-intel tree with Linus' tree
Message-ID: <20220125093926.4fb47c1d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/g327f7tNmvB4ReKlEHWCmvv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/g327f7tNmvB4ReKlEHWCmvv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the drm-intel tree got a conflict in:

  drivers/gpu/drm/i915/intel_pm.c

between commit:

  cca084692394 ("drm/i915: Use per device iommu check")

from Linus' tree and commit:

  8172375ea95a ("drm/i915: Remove zombie async flip vt-d w/a")

from the drm-intel tree.

I fixed it up (the latter removed the code modified by the former, so
I just did that) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.



--=20
Cheers,
Stephen Rothwell

--Sig_/g327f7tNmvB4ReKlEHWCmvv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmHvKp4ACgkQAVBC80lX
0Gzftwf9G/Z+OFpX3Ft6lBKRffI/D7FLgonwACugMslqyaFfotafVx4RImrj5SnV
qPSyRBm0OVG0vAWgiVl2X8QvB8If7cjqjCAp685s58ZMUIku/uZdJE8ePdPqcWBw
KAeK1pLdi26bWaL1drypmBlQOljzDH42RfV05dWv5+EnpvnzzTMEzG0+4LFnI7f+
WxBSsIeJWEX6uHOKtyOHpem0ska9PRJs05m8+APJdLTEClD2LJJmDivOBUDfZb39
hMP356gFRQ49JPJnljorEZZsnpcyxHLY8R0mtwXSwQZw8toApe3AJpqCuUlgP7Zf
PVN7lhxkfCBxpbTQwVMyj3Jta5+1mw==
=9bPh
-----END PGP SIGNATURE-----

--Sig_/g327f7tNmvB4ReKlEHWCmvv--
