Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12A2552CAA
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348077AbiFUIQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiFUIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:15:58 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB91237F2;
        Tue, 21 Jun 2022 01:15:57 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LRzqD1yqlz4xXj;
        Tue, 21 Jun 2022 18:15:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655799353;
        bh=2E5PwMW/yllmF5gZzd1wmtssdamJ4jkSGbKOb/quYE4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=asZT9zsoSemrmQ4dOL6TgHf3lUY6OkIoDhv+OGuVHaziL/+om0P0Vhe91xshCiUi0
         LrVycbCbF0l0jcjv9C6qCT7/oPB3WZp8c2LiXBBqi0DYPaoWhLwIqTf4/3NuxNDV4f
         3U16zLHQvJ6Oyeqb1vZNC9faGpwg84m3hmuN3VcmBT5DUziM/aIESMnMnivNRMqpge
         jv10okWJRp2ZHpLaBzg8AocHhc45AX6fjLnl9aKLKTMmTc2Q5iX3bYw5hy0C20uRWM
         IBQoilkbh8rnbhOQ1YZzaGDvNn6C5AlBii4m5UcahOkc1ktvOBUkyWQqb5h3/Vdotl
         WcmDGun/rgZLw==
Date:   Tue, 21 Jun 2022 18:15:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220621181551.5eb294f5@canb.auug.org.au>
In-Reply-To: <20220615150013.30c9d7ad@canb.auug.org.au>
References: <20220603144315.5adcddbf@canb.auug.org.au>
        <20220615150013.30c9d7ad@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/f6qfnfBBJQs_iRqqx2rm3rV";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/f6qfnfBBJQs_iRqqx2rm3rV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 15 Jun 2022 15:00:13 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> On Fri, 3 Jun 2022 14:43:15 +1000 Stephen Rothwell <sfr@canb.auug.org.au>=
 wrote:
> >
> > After merging the amdgpu tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >=20
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.=
c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.=
c:3835:1: error: the frame size of 2752 bytes is larger than 2048 bytes [-W=
error=3Dframe-larger-than=3D]
> >  3835 | } // ModeSupportAndSystemConfigurationFull
> >       | ^
> > cc1: all warnings being treated as errors =20
>=20
> I am still getting the above failure.

I am still getting the above failure ... it has now been 19 days :-(

--=20
Cheers,
Stephen Rothwell

--Sig_/f6qfnfBBJQs_iRqqx2rm3rV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKxfjcACgkQAVBC80lX
0GxosAf7BLe7e+Qep9x9TBOTlKPRU4VoCcfu4xWob7k9buU7HMEZ2Z85aNEuPcGx
anaR5Iwjsa57j+afexJjik+/2fyjFNDta9EXMF3W4meWXhNjCpdQZWpQAkrDPGpS
hmnAODD20wIOgqJs7VPgdnAtMTaCIRmO0pZYO4udYGiO8sI8DCDuO+Ep5xVYxOMx
byBugvDiL6sJPzyCmrHBSAi2ryY8KiiQ+DVLcT5jvAWgqlrHUNdOgWYuqJ13E+Sa
tttkfLK2D0noQ5FYhFY9kgVv84g7Ddwecq6/ZocYrgcKtGGIj69sGeY5brCx9cyV
GfNO+0K2+OxRtgk/N0FLSduTSemLHA==
=h3cq
-----END PGP SIGNATURE-----

--Sig_/f6qfnfBBJQs_iRqqx2rm3rV--
