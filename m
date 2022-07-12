Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D286057187D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 13:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbiGLL1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 07:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiGLL1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 07:27:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4074C2F3B8;
        Tue, 12 Jul 2022 04:27:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lhz4Z0gwsz4xZD;
        Tue, 12 Jul 2022 21:27:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657625249;
        bh=+YGTCzQRzac0AtHW8tlQEqC1DOb+T9EcWqte1XHzozs=;
        h=Date:From:To:Cc:Subject:From;
        b=jDif5u4TW8UUqTQDtFTlN5EBR9Uk8zU/PVpZ/qrydjYztw+Itiokp/2q+p8gj2M9g
         VWHqWzbPuK/TnY3QePg/RE+5RJGlG8CNn8mfhIAzIUB5056hSxOYrume9taDKl460p
         cEivKUS4PQfOLSPWEu3hRcjTxlgXrsgSO5i530YigPBL88lHt5aarFIRt1oH9wuTNW
         +BtRy3X4bCEvY0Uo0d7PWG5pFqXK58z2bH5KxkVoXiind1Hi2GfcU43pU942Dn4MVQ
         eRuWUBmmUGAIMGI0/zzVkuvlZ5TJCORL78jseRDY43xGrY/01KcztgyiDkpxCfdvGX
         +fYfjSUTPJ2EQ==
Date:   Tue, 12 Jul 2022 21:27:24 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the drm tree
Message-ID: <20220712212724.7424de74@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/5R9Dchy+ES7s1AIf/0jJGhQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/5R9Dchy+ES7s1AIf/0jJGhQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  d8e4fb9112e8 ("drm/amdgpu/display: Protect some functions with CONFIG_DRM=
_AMD_DC_DCN")

Fixes tag

  Fixes: 9b0e0d433f74 ("drm/amd/display: Add dependant changes for DCN32/32=
1")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant:

Fixes: d3dfceb58de5 ("drm/amd/display: Add dependant changes for DCN32/321")

--=20
Cheers,
Stephen Rothwell

--Sig_/5R9Dchy+ES7s1AIf/0jJGhQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLNWpwACgkQAVBC80lX
0GzZXAf7BRXo0+e9LJK1gmuB1r1hnfC7jbh4AkkZ76oMj0YM96hn4VJ15pfegzBQ
EqhF3pj0jmVuzB5WitY4SIqRQjmqQzFb+tInTwEM8bGTkEo13xKbgpLHxT6zarFD
iri8Qkpb5GA3+KW2LpA9Qx22HLnCVLedaY3Um7Lk0gdO8jnrNx4AtFvjt4vQPtzb
GLoRqoaaVj+h4tNujqnTreWKhvbaSiS3iUJ2cJQfFI3XhRSYRjFcEWRbUb0Oz2fE
U+2zjWpMVQbQS9mGTcLFAmBYRHKhmBY2U0ZfXiGKsxoivMRS4R64ssCj4c8Pqa0D
MUw7YfihgM2gxoGWs0TXzjuUVvIimQ==
=aZGl
-----END PGP SIGNATURE-----

--Sig_/5R9Dchy+ES7s1AIf/0jJGhQ--
