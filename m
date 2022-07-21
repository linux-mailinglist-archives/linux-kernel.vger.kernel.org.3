Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8E57C22A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 04:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbiGUCQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 22:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231598AbiGUCQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 22:16:26 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D5A56D2D9;
        Wed, 20 Jul 2022 19:16:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LpGQW5q2Tz4x1h;
        Thu, 21 Jul 2022 12:16:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658369779;
        bh=7VsGzyLSIlUXoL9tBmDBhsJtgMbbanTcoqRPv+zZg7E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WwQs4QDD1zAMQtopxEOdY7wlC4K1DRfuWDOiA65x3q4AQ4fihgDXZ2GKkcjSTFDMq
         lsDST9rRDBFjFu87s07o918dqQT5PtiqDKcf1a6HEwy1FYsnZW0yLfy8/+PGPEMMxg
         qPtkJeI56nurWdmHJ/oIH/OFxB1df1bbsnjl4CWLpeqP5X/wQzxSVHqMrSMLWC0cNM
         /wEAYKVCGMsfcumSWLXrYaRHVhnOX+kyZWPWQAuKSfDF0mQN1yaRpWZYzWl+4Gs5kx
         kYwCUFTJbptrTBvy7tQd3GJwNU4QXeEh1DG0DuIrIxvSQq+TNEmwVaJOuYCht06iMG
         QgS1pjJWXtdWg==
Date:   Thu, 21 Jul 2022 12:16:18 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220721121618.049b9c00@canb.auug.org.au>
In-Reply-To: <20220720124732.4aeb3748@canb.auug.org.au>
References: <20220719123607.63cbb3c5@canb.auug.org.au>
        <20220720124732.4aeb3748@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/PA5GB2es=AsdGUk3H1gfIHJ";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/PA5GB2es=AsdGUk3H1gfIHJ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 20 Jul 2022 12:47:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.=
c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.=
c:3799:1: error: the frame size of 2464 bytes is larger than 2048 bytes [-W=
error=3Dframe-larger-than=3D]
> >  3799 | } // ModeSupportAndSystemConfigurationFull
> >       | ^ =20
>=20
> This is still here, but the frame size is down to 2336.

Today it is down to 2128.

--=20
Cheers,
Stephen Rothwell

--Sig_/PA5GB2es=AsdGUk3H1gfIHJ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLYtvIACgkQAVBC80lX
0Gxd3wf+Ojr46o/0kPWH0GRXLbSEqnau2ERG4Dle0ucSuoDsEgnks2qC3ffywsIG
5kKK0CeaefHI4Dw22Bmh3zJB16dNmWhpmUJWPQtxHKsGKRkSOEgsWP6yC1qlLVs1
46HEkTcmPXK4GEECyFjqfH1xx12HndxzPqi/E0Vw7TYeWlfGtIl9cbr1/HNyLXls
8Ku1ONdAUMLFxEfROsqnyBm7Ah29NEOm9ujx/6njPxv3nbuSbxCkyhz1ZOLZw+WL
aC4Y/hvfuvNITGV6mg5aA5AC2FbPMDxT4zeWPFtit6T7oLOKWIpoocisPqJNzWv5
pPNdsF+XTZBAvGeSmSdrmlVLq9IlkQ==
=VoWl
-----END PGP SIGNATURE-----

--Sig_/PA5GB2es=AsdGUk3H1gfIHJ--
