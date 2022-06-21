Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D00A553E50
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 00:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354403AbiFUWHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 18:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238847AbiFUWHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 18:07:35 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3B72ED4C;
        Tue, 21 Jun 2022 15:07:33 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSLGl56xqz4xYD;
        Wed, 22 Jun 2022 08:07:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655849248;
        bh=eBdXdgqNPOsV0ZFNPKzo3btFsOvgFrYvNq2S8WgVF7M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FNRd62G0hnWpVd0t9txhQD+ISIKd+z4KTsLfDXWO54mW4FrL0B6UMekihuFTHxjA4
         mWqiXvSZaBqMoPjaZkTpqu3W32iI3deEG2SPuOOk3V1t+Ogfo04hn9wfS1OSh42CY1
         40x0JKZbgu1Vc2gPMUdSdEVm0htaqlCsjzqmRRFj3YAxfSqai2zSrTEUgk9ycr1bUf
         zEuzE/1fgq3xszRENwLrSf5jlC6iTdMY3MPBaOyfRDZZVK2Ih8TRD30XJyXoqvySzW
         OLHzz0OEFCYwbN8CI0JXYwTfcHyCZdnXKnZBBwpeZBE/ojgJphCwj/J26s8QTpBy5I
         oUEaqZW6DaZQA==
Date:   Wed, 22 Jun 2022 08:07:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Dave Airlie <airlied@linux.ie>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220622080726.39cbeb14@canb.auug.org.au>
In-Reply-To: <CADnq5_OxNm9EwLDXishu+pMfT2mgOSTvkmgSm+cm98JiCsiJog@mail.gmail.com>
References: <20220603144315.5adcddbf@canb.auug.org.au>
        <20220615150013.30c9d7ad@canb.auug.org.au>
        <20220621181551.5eb294f5@canb.auug.org.au>
        <CADnq5_OxNm9EwLDXishu+pMfT2mgOSTvkmgSm+cm98JiCsiJog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ul+wBTZxn1nqnP+YuJF3goI";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ul+wBTZxn1nqnP+YuJF3goI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Alex,

On Tue, 21 Jun 2022 11:02:30 -0400 Alex Deucher <alexdeucher@gmail.com> wro=
te:
>
> On Tue, Jun 21, 2022 at 4:15 AM Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
> >
> > On Wed, 15 Jun 2022 15:00:13 +1000 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
> > >
> > > On Fri, 3 Jun 2022 14:43:15 +1000 Stephen Rothwell <sfr@canb.auug.org=
.au> wrote: =20
> > > >
> > > > After merging the amdgpu tree, today's linux-next build (powerpc
> > > > allyesconfig) failed like this:
> > > >
> > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba=
_32.c: In function 'dml32_ModeSupportAndSystemConfigurationFull':
> > > > drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba=
_32.c:3835:1: error: the frame size of 2752 bytes is larger than 2048 bytes=
 [-Werror=3Dframe-larger-than=3D]
> > > >  3835 | } // ModeSupportAndSystemConfigurationFull
> > > >       | ^
> > > > cc1: all warnings being treated as errors =20
> > >
> > > I am still getting the above failure. =20
> >
> > I am still getting the above failure ... it has now been 19 days :-( =20
>=20
> Is it still the same error or something else?  I thought this was
> fixed in this patch:
> https://gitlab.freedesktop.org/agd5f/linux/-/commit/d6aa8424bcac64b260845=
2589c9a09984251c01c

Here is the message I got yesterday:

drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c: I=
n function 'dml32_ModeSupportAndSystemConfigurationFull':
drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn32/display_mode_vba_32.c:38=
33:1: error: the frame size of 2720 bytes is larger than 2048 bytes [-Werro=
r=3Dframe-larger-than=3D]
 3833 | } // ModeSupportAndSystemConfigurationFull
      | ^

--=20
Cheers,
Stephen Rothwell

--Sig_/Ul+wBTZxn1nqnP+YuJF3goI
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKyQR4ACgkQAVBC80lX
0Gyy4Qf+MTOK27A9uUCkRmWgbIuRfoGzmMhnLQynnOICyJ3P+sQC2YWOgf2cPuQE
VyVxglP+YR7soZRXcKfm4KVoGT1sNfDWV9H3+QU1WlEaougsUtwA2o3stqTBWl06
BSo6XKjKDMIo1a0xm9ZIpa5sZQNssaZfVoDQ45l5ND13rGBp3NpeICHbIVXSRpEP
E8PNGQvA3XKObDrzQRh5wPs6MAiVwAPLwrEpU4hcGLXvSVNuEFv+Xlj41XRIoXha
bAfWpUiFajtaWKdPY2VQtx3cRwtw24KoKRhBtyEkkefmUhLFJFaKSoy5Lb1bJpiV
/bkcUPfc8nFq9+pOa0sduQ/MIuOSEQ==
=KZM8
-----END PGP SIGNATURE-----

--Sig_/Ul+wBTZxn1nqnP+YuJF3goI--
