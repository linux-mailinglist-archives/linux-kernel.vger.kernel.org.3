Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9401650EE82
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 04:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240791AbiDZCLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 22:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbiDZCLM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 22:11:12 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE671F62E;
        Mon, 25 Apr 2022 19:08:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnQJg3vzhz4xTX;
        Tue, 26 Apr 2022 12:08:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650938885;
        bh=TNAVydjYCb9DTrJq/cMaICTHKvDZYEfDbt6G/BYvxMk=;
        h=Date:From:To:Cc:Subject:From;
        b=nqGPHklm+Nun06RoEmvTamSEPML8BcjNsPJA4KqqZPbGUWyMC0im3xqUweX5WRMA1
         Jx1SwMr8TE48AUuZBW1hraIaYyc3ATBTadd6CBM3Qya7BW56fJYGT+OgyiEtksKx2T
         hUuuv0Y8jF/QZrE4aDo58IV6s0oppWprFEQrZnxlD63lRfDlEtcEKWKH+WFqHVxzj5
         1FSkLYfxVcJxHuA/IwC7hiy3GzNmPe/m7NDaSPKpP9LecW0a4r089PedfWNfyEUKp/
         6ejUqcWnM5DfOyFmRWOf/GwTKQdPL/H6ZzQXicBH/S2UetGZ0QRUSbNrBVPakW/Ys3
         CnsDk1E6OzMcQ==
Date:   Tue, 26 Apr 2022 12:08:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Christoph Hellwig <hch@lst.de>, Zhi Wang <zhi.a.wang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the drm-intel tree
Message-ID: <20220426120802.574a9659@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/d6o.Js+XmlPJaW/uB/gDnOS";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/d6o.Js+XmlPJaW/uB/gDnOS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-intel tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "intel_runtime_pm_put" [drivers/gpu/drm/i915/kvmgt.ko] unde=
fined!

Possibly caused by commit

  8b750bf74418 ("drm/i915/gvt: move the gvt code into kvmgt.ko")

or one of tehe follow ups.

I have used the drm-intel tree from next-20220422 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/d6o.Js+XmlPJaW/uB/gDnOS
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnVAIACgkQAVBC80lX
0GxX5Qf/QE3urzrjqWKGBR/P2SMtDCUZKjJBxSw2ArT/sPrYZ1/26E8r/kRdRm5f
Wo5Bhb/4b6yl5u3GHssQ4HKvoDAMMtJWsa6IhuyaSHrFnWGa1RGwf9m/wMK1q1Xg
xZmBoCOxNpX8yjHG1HDtmsMfSPS5Bpv7fjHrl9JgqqZ7HQFzPYyQ22ErfluIuSdX
PeOqjjMgPx3SjYLy/r6CkhvbkZuENaWMLtPJR8LEEHZa6KbNVfpHVfWupswcdJZl
RjYSZgPCrgyX8gC+WcrV/ZKPDVKITaSgB4sZNDZA63wsi5vXzoML3YNdYenPeHKs
4m/VqV0PodR5/YVLWI5vGdoZM8GXuw==
=dZVe
-----END PGP SIGNATURE-----

--Sig_/d6o.Js+XmlPJaW/uB/gDnOS--
