Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B454950EE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 03:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbiDZBvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 21:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiDZBvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 21:51:38 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686A554BED;
        Mon, 25 Apr 2022 18:48:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KnPt22mnPz4xLb;
        Tue, 26 Apr 2022 11:48:25 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650937707;
        bh=9kBhR8QSUgvJZYnXsARchbPfp7Jz9CUax/1FT05p1lA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Nh89AaDkqmpMgnPTvTYxJZIaoHWXHQrt09qUESfqG1L33T7CadwFMY6nDTSOylOO/
         +Mgo1zvutf1AatIgIKLXZvGbYAtGaWuFBspjffWb3KXC1ThItQnxqtd6c0AA9Rdbg0
         mN7lDCIv7mlavS91/Avbr6PPwaIg41Vx5JgZo/ERW6ko6oY77L3FnbnGkpDO8WoRoC
         9bzpDVF3gkET4JZNgHQz5aZu1c1tE02r4IJfV7akO/cx5XWN4DLD8xSCX6S3U6xcIn
         Nu4nVcePRXJvg+kYkXcrcW9bC9PdNO9XzLZ6DzugmMzyeAVjY4YmZqQBIrqtv491PE
         AB8dLgTmDbPfQ==
Date:   Tue, 26 Apr 2022 11:48:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dave Airlie <airlied@linux.ie>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        DRI <dri-devel@lists.freedesktop.org>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the drm-misc tree with the
 drm-misc-fixes tree
Message-ID: <20220426114825.7a07c67c@canb.auug.org.au>
In-Reply-To: <20220414094715.4c2e0127@canb.auug.org.au>
References: <20220414094715.4c2e0127@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YL0fxYxeUKXBwDs+mgbDYqx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YL0fxYxeUKXBwDs+mgbDYqx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 14 Apr 2022 09:47:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the drm-misc tree got a conflict in:
>=20
>   drivers/gpu/drm/radeon/radeon_sync.c
>=20
> between commit:
>=20
>   022074918042 ("drm/radeon: fix logic inversion in radeon_sync_resv")
>=20
> from the drm-misc-fixes tree and commit:
>=20
>   7bc80a5462c3 ("dma-buf: add enum dma_resv_usage v4")
>=20
> from the drm-misc tree.
>=20
> I fixed it up (I just used the latter version) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

This is now a conflict between the drm tree and Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/YL0fxYxeUKXBwDs+mgbDYqx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJnT2kACgkQAVBC80lX
0GwXPQf7BQigK2+/T5d8A50Z/8M751oZO4FLYt30HQT8qgT98F/AjQcYo6eTKEQx
iqvQfCBGkHv2tjMT1BDykx0VyWFAEZ60BG26odiFZ7Qoelx7/MYdbYe5MPurGEr1
r/xaWxAgmJDg6JzNYbyDLEFAb3Q1Ofa8TyggINUuPitYHR+m821DRSgLwa2ZaAVA
+tGhybE04y85sV1Sme2LhbF6lvrhG4lYe6QoPWk2/MRrmaQgsgvOVagMjsFo6YJ9
Eg1HTePL5GopCLA1dyHaA5wWtQvMNj+Vy5d2LKRyQZZrdpbk8Y41MkhAdkN+McCK
YweRcvJgHysqZ7WQt5nt5czwLp8XbA==
=McuI
-----END PGP SIGNATURE-----

--Sig_/YL0fxYxeUKXBwDs+mgbDYqx--
