Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F00597988
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 00:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241442AbiHQWLe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 18:11:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235858AbiHQWLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 18:11:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5F3BA723E;
        Wed, 17 Aug 2022 15:11:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M7Mg3364yz4x3w;
        Thu, 18 Aug 2022 08:11:27 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1660774288;
        bh=F66RbYXiYyVuI/3tkkg221uAGbsIY1Cnm1yFM4222QU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cUaYwjSbYhgfG7JnQcyDVoJNz3jd1HmaPmKvMDl6rJVkWJj/5MZ7OoOs2OWLk24tG
         OVUHwjyRKI72kEGqeHd4Qy2MMYcYNF8u5Xn/4TrNT2OD8ZVLfj+fcGQzT10Dt+GaSf
         GzVAEnSsBRRKQlwitnW+nBeukoOZl1+zFiy+VRS3RPxKrnBKxyhtH+0gmtaQW4CWQU
         h9HZWgFmn3flvalEzornOdqumgKK5x57UKkomgMKkGUwCHDXJUozu1VEjOwPX/DnoU
         QhTBYkXQmEgWIBnoAUzlW/cWbaRSBe7dAMQzsY+QF9tcZLI2lRxo7buDXT0SUBSgav
         jIcHHYSrEBt/w==
Date:   Thu, 18 Aug 2022 08:11:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>
Subject: Re: build failure of next-20220811 due to b1a63a0b48ad
 ("drm/amd/display: consider DSC pass-through during mode validation")
Message-ID: <20220818081126.4421bb3e@canb.auug.org.au>
In-Reply-To: <CADVatmO-kc93dQc9TPy7ZjGuLUUut7or1VLGYkLWTw803mkWiQ@mail.gmail.com>
References: <YvU4GD8HtZ1A4dhI@debian>
        <20220812090731.31da7d85@oak.ozlabs.ibm.com>
        <20220817094309.140c346e@canb.auug.org.au>
        <CADVatmO-kc93dQc9TPy7ZjGuLUUut7or1VLGYkLWTw803mkWiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/y_P4uE_RmhYMsSeHGlsEA4e";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/y_P4uE_RmhYMsSeHGlsEA4e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Sudip,

On Wed, 17 Aug 2022 21:39:17 +0100 Sudip Mukherjee <sudipm.mukherjee@gmail.=
com> wrote:
>
> On Wed, Aug 17, 2022 at 12:43 AM Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
> >
> > On Fri, 12 Aug 2022 09:07:31 +1000 Stephen Rothwell <sfr@rothwell.id.au=
> wrote: =20
> > >
> > > On Thu, 11 Aug 2022 18:10:48 +0100 "Sudip Mukherjee (Codethink)" <sud=
ipm.mukherjee@gmail.com> wrote: =20
> > > >
> > > > Not sure if it has been reported, builds of riscv, alpha, s390, arm,
> > > > arm64, xtensa, mips, csky allmodconfig have failed to build next-20=
220811
> > > > with the error:
> > > >
> > > > ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/a=
md/amdgpu/amdgpu.ko] undefined!
> > > > ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd=
/amdgpu/amdgpu.ko] undefined!
> > > >
> > > > git bisect pointed to b1a63a0b48ad ("drm/amd/display: consider DSC =
pass-through during mode validation")
> > > > And, reverting that commit has fixed the build failure.
> > > >
> > > > I will be happy to test any patch or provide any extra log if neede=
d. =20
> > >
> > > I have reverted that commit in today's linux-next. =20
> >
> > I have removed that revert.  Sudip, can you recheck when linux-next is
> > released, please? =20
>=20
> The build failure is not seen with next-20220817.

Excellent, thanks.

--=20
Cheers,
Stephen Rothwell

--Sig_/y_P4uE_RmhYMsSeHGlsEA4e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmL9Z44ACgkQAVBC80lX
0Gxx+gf+KDLvy87g7b1sZVfaG9pEljZ5Ynr/9YvGBEjJWYYs/rxOvYAmYyXRmWt5
oO3+wj0BOXGBmvnvXDcsW5L3wkigUfI0rloJGGHKuXKssmQTi7lqmt1S9/jeH6cD
hOkUaXTJj1TTApBLUCImG3jfC5TmetOLXkruU5aoQQ/YZBV4ljBvwiuJ3FXi0gRK
hJO0EYBu7pZtetLL/yEbG3oiipzyPhLYt+wv4Mm9b8Hrk+JBZ77gs7qgk2hCqlpX
rNsNDf+ePiJOqWPlDWd3AK5m9AhJm1g9CIr+kjAmUGP24+yuiMNvEDc0E1zxdlk1
EcbrLOvEmtSU7giPmQxfSME6fl8/1g==
=01UZ
-----END PGP SIGNATURE-----

--Sig_/y_P4uE_RmhYMsSeHGlsEA4e--
