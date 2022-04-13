Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44CBC4FEBC8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 02:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiDMAKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 20:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiDMAKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 20:10:09 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A839CB7EB;
        Tue, 12 Apr 2022 17:07:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KdNFw07rXz4xNl;
        Wed, 13 Apr 2022 10:07:47 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1649808468;
        bh=5D9JzxHZ9SkP4A+S2Dk3RBo3Rj+IgKIna634rjs7ueM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AR+q3v0GVUiC6+rG8rjn2soRuwRhphOarvrA9QRwT+ngr4Og7jHFHLxSSlykuQUe/
         FP976yIHfn9XE/ETuUycy8VFOFLlV5TQTnUy9Sx/8CNkiJeqUvQWZ0w1GXQrrjhK+6
         iuTenBxVFb+/aSj02MP3JYVjOBkQUNqWFzJE7kfBzZXMSwZHmXbxMVlON/JaCLeKqf
         iGnpCxEw4Ihs9flTvvfKg/FMP4nF9sjAsEZOPZg+BTWP+PjdNlJ4Mc0kPmMaB+8IJt
         g2+v8k+AhF1BzOXw9LSgvbV7JP67AYRtUcx8H3w7nJOpnUTavimwba9t9hf/RhWNG3
         YfFj/YQGpcRMQ==
Date:   Wed, 13 Apr 2022 10:07:47 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings after merge of the drm-misc tree
Message-ID: <20220413100747.2f9deea0@canb.auug.org.au>
In-Reply-To: <20220406154431.567414c3@canb.auug.org.au>
References: <20220406154431.567414c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/x4tk9Sq/vj5k4I8tIVUDpa0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/x4tk9Sq/vj5k4I8tIVUDpa0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 6 Apr 2022 15:44:31 +1000 Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>
> After merging the drm-misc tree, today's linux-next build (KCONFIG_NAME)
                                                             ^^^^^^^^^^^^
htmldocs

> produced these warnings:
>=20
> drivers/gpu/drm/drm_edid.c:1589: warning: Function parameter or member '_=
edid' not described in 'drm_edid_header_is_valid'
> drivers/gpu/drm/drm_edid.c:1589: warning: Excess function parameter 'raw_=
edid' description in 'drm_edid_header_is_valid'
> drivers/gpu/drm/drm_edid.c:1737: warning: Function parameter or member '_=
block' not described in 'drm_edid_block_valid'
> drivers/gpu/drm/drm_edid.c:1737: warning: Excess function parameter 'raw_=
edid' description in 'drm_edid_block_valid'
>=20
> Introduced by commits
>=20
>   6d987ddd6843 ("drm/edid: make drm_edid_header_is_valid() accept void po=
inter")
>   1f221284ab63 ("drm/edid: split drm_edid_block_valid() to check and act =
parts")

These warnings are now produced by the drm tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/x4tk9Sq/vj5k4I8tIVUDpa0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJWFFMACgkQAVBC80lX
0Gxe7Af+KjcSkaNCgtVa8zaHJRKB5qqFCZt8SkokMrvYUTSUhwdJZ00R9ZHUPA3D
WzrZs1FgZx/PtDb2D8GGI5Vh1wRQRM6M+Ub5MOQ6qxn4EO0zBX+dJqtEf1TobbiY
amCmL0MXjJJ0WMXdn2O1tLtQGXam/4LHJcCymj9W+qgGtunCeVUtwd6BW6Akgpnb
6neh99KbhgxTABz3ufr3ZwvuIbSPyo1GFbnIvqj7VWbpn2Kdk6hh2heHZITOCOOn
a4DTh4B7AD352p0Gkf6aQTTz7WPftVMayQz8hnVJ0ADq6it1qEusaPSIMbNayVEC
9I9DB5Xznz7aSzEdhW97BTQOmD21ZQ==
=hpkW
-----END PGP SIGNATURE-----

--Sig_/x4tk9Sq/vj5k4I8tIVUDpa0--
