Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31511508121
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350212AbiDTG2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241372AbiDTG1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:27:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F0F83A5EC;
        Tue, 19 Apr 2022 23:24:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KjrHP1h8Nz4xPw;
        Wed, 20 Apr 2022 16:24:32 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650435874;
        bh=/zHO/0ZsN7tcC3Lxb9ooaUNEwaM2L33rQaty8QyuL8M=;
        h=Date:From:To:Cc:Subject:From;
        b=c8Aq6Qlp2MKgzIdyWLtmFEzRKY3HJYlN0Jd3qG1JTgrrG2sxFnE6mZTEiQ5rHLMRh
         PWgsBKN3GjYC+hXodxKC3fd0krdyPeB1jHFOPks7HFAV4Xax9XDICoEzqFQ29VP6YB
         vpgaWOTIGe6gpfNxD+R/AY8FfDgablX+e/qio7jaj2wAig/eKR/nNOUR27dAXUwVt/
         eJWTtb41gyaodAjjj2m7fHtid0XPV1Uw9qNffjSPRuF3O7GUmcn57BGYPcyTfzqVle
         R7FzlIHRP2c7Fq7sbLINiEm0GU3Gyw2L6zPHu1x+ZaMuIQSPzpG5XjJ1/lewZ3xveO
         O+4psYer2xF1g==
Date:   Wed, 20 Apr 2022 16:24:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Jani Nikula <jani.nikula@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the drm-misc tree
Message-ID: <20220420162431.2b28ddea@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+/yu2sxTOFQJ6m8YC9ZDH_y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+/yu2sxTOFQJ6m8YC9ZDH_y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the drm-misc tree, today's linux-next build (htmldocs)
produced this warning:

drivers/gpu/drm/drm_edid.c:2136: warning: Function parameter or member 'rea=
d_block' not described in 'drm_do_get_edid'
drivers/gpu/drm/drm_edid.c:2136: warning: Function parameter or member 'con=
text' not described in 'drm_do_get_edid'
drivers/gpu/drm/drm_edid.c:2136: warning: Excess function parameter 'get_ed=
id_block' description in 'drm_do_get_edid'
drivers/gpu/drm/drm_edid.c:2136: warning: Excess function parameter 'data' =
description in 'drm_do_get_edid'

Introduced by commit

  89fb7536ad2f ("drm/edid: add typedef for block read function")

--=20
Cheers,
Stephen Rothwell

--Sig_/+/yu2sxTOFQJ6m8YC9ZDH_y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJfpx8ACgkQAVBC80lX
0GxZZAf/T1Y2OmjSqd8ow7L2wUV3wqHTL9yWRQSLudTi092OiWNhhyZ/ub4w++UU
wU+yyI4V7jhVsbd00t+en4S7BvMlzeMfKjF7uso7+XwcsX7/tTcZcWpvW+VUj13V
guOuZM+8Rse9UYaWVYmrH0tWYDiukkICQp779gh2+HH7LULg6wI3dyL1UmCu3NYR
ra2mdJUv98+6jG437X5oytYOy6NKBrx4hcKlhcx2LKnKLwSzeIsENUFpreEjHYu1
ivMGR9lc8yngyi4eCUlnAGdjRhMAl3f7RlshQkb5KjuYbdAD8b0rwLBpk3JpKRuJ
JH1jmonsq35wEKyhtJwip4xkFScKbA==
=GLfA
-----END PGP SIGNATURE-----

--Sig_/+/yu2sxTOFQJ6m8YC9ZDH_y--
