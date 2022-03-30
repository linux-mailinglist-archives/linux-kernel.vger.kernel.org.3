Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EBFE4EC64C
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:15:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346681AbiC3ORV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346662AbiC3ORU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:17:20 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBC741998
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LiPPmN2r0YWvf6YSX4r7qp957zayCxgjDaHPgZHbWSk=; b=LhHqr2DKecTJvJ9A4vAAq5ZVV4
        HFUtX87tV3LjCCXqDNCqelTD2ys7p1oZ7lHD2+4NNIMacZTNpWTulTxt8IMKsfkJ9HfsuFSO0vjRG
        Rbr/T0Nvg0R2n/pMZM32iTTr0wjjiwEZBqJf+6vzFEkiYmBBtL313bSdTU580DTJLst8ucS7l6rNN
        TPKb3j2sPQSMH6SuXYa7sdr/s0UdLgqdbTnbMYfFdiYt5le33va9k8Ovk7L06Tsif1ikuMXgazYt2
        vgcOoVADdemwB+B9Jiwm6WB6ELyv+8tqINlVh7u9cSQIpyijsevPr0S/d/N3En8PNdi9CgyyQltDC
        nVU0tTRA==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1nZZ6c-0002t4-89; Wed, 30 Mar 2022 16:15:26 +0200
Date:   Wed, 30 Mar 2022 13:15:13 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Rodrigo Siqueira Jordao <rjordrigo@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, airlied@linux.ie,
        alexander.deucher@amd.com, christian.koenig@amd.com,
        daniel@ffwll.ch, harry.wentland@amd.com, Rodrigo.Siqueira@amd.com,
        sunpeng.li@amd.com, Xinhui.Pan@amd.com,
        Qingqing Zhuo <qingqing.zhuo@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Jasdeep Dhillon <jdhillon@amd.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] remove DC_FP_* wrappers in dml files
Message-ID: <20220330141513.s6gw44gbh6whwqow@mail.igalia.com>
References: <20220326202448.2046077-1-mwen@igalia.com>
 <1721b4cb-adab-4e5b-070f-c26d0e2c6bbf@amd.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="z7lxjmd4y3nsnzuv"
Content-Disposition: inline
In-Reply-To: <1721b4cb-adab-4e5b-070f-c26d0e2c6bbf@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--z7lxjmd4y3nsnzuv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/30, Rodrigo Siqueira Jordao wrote:
>=20
>=20
> On 2022-03-26 16:24, Melissa Wen wrote:
> >  From FPU documentation, developers must not use DC_FP_START/END in dml
> > files, but invoke it when calling FPU-associated functions (isolated in
> > dml folder). Therefore, the first patch renames dcn10_validate_bandwidth
> > in dml/calcs to dcn_ for generalization, declares dcn10_validate_bandwi=
dth
> > in dcn10 - that calls dcn_validate_bandwidth and wraps with DC_FP_*
> > accordingly. The second patch removes invocations of DC_FP_* from dml
> > files and properly wraps FPU functions in dc code outside dml folder.
> >=20
> > Melissa Wen (2):
> >    drm/amd/display: detach fpu operations from dcn10_validate_bandwidth
> >      in calcs
> >    drm/amd/display: remove DC_FP_* wrapper from dml folder
> >=20
> >   .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 10 ++++++++--
> >   .../drm/amd/display/dc/dcn10/dcn10_resource.c | 16 ++++++++++++++++
> >   .../drm/amd/display/dc/dml/calcs/dcn_calcs.c  | 19 +------------------
> >   .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  |  2 --
> >   .../gpu/drm/amd/display/dc/inc/dcn_calcs.h    |  2 +-
> >   5 files changed, 26 insertions(+), 23 deletions(-)
> >=20
>=20
>=20
> Hi,
>=20
> Thanks a lot for your patch!
>=20
> I reviewed and tested this series and lgtm. Applied to amd-staging-drm-ne=
xt.
>=20
> Btw, I agree with Christian. Can you try to find a way to add a compilati=
on
> error or warning if the developer tries to add DC_FP_* inside DML?

Yes, I agree too. I'll try to address it as soon as possible.=20
>=20
> Also, about the question of recursive calling to DC_FP_*, it should be sa=
fe
> if using DC_FP_*.

Thanks,

Melissa
>=20
> Thanks
> Siqueira

--z7lxjmd4y3nsnzuv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmJEZe0ACgkQwqF3j0dL
ehyvKQ//WM6GLxBSzGMkxkvL8lb+02tZyIMirq8fvaxe16llFJ3bLKadPHSMjweI
Ki2KG7wWM81D0bZHf4vw6TYLIZXMPhl11N4mgm+Y1LwWht+hHcLpvAJj8ClC2Hdu
9k+EiNiv2xH77QOHf8pHcWpvxLX18VU6iEnfXsu4E2qmo/tG4rtD/u4W2vdzzKfC
N0z5F8cftdoeJkuXDvzab/DGt/ejVsZNSZsc1uawxpIdK56C35t8Ya9ahA2IdRmm
eCNZLlOUUD1DCYaQ2MCV4+WkCB5VOXDf0TJ0iyuhUT/LkSE72wfkkKY6ompC1v/E
J5lqIDYnc3COlAUx3uXfal0lUWdr5eRGMAkllRDpCdS188355S5Rx0+S3pa9R46s
UcbZOVMxdaVV6aV7tsz0XT7V5Zfb5y5EyCTOQ8HXjkAk29xZgAU+yBQBIlWWeLq/
Oj9ER6Qqv3G20x2t2xYBGrdmhuOWbOLcD+XUdY56+jdiObJMmBXXZ2T1+2Zom/D+
1s9RCXlmop3wGsx8/InQuWEULjuOFBnay8w6llq2vGS0lx9scG0XW8HIir+nTubc
DkMfucxn8dTkAT+r61A9S2wo6POTAmY/xT38t6KVoM4pr5xsiPXZu12AWq09H82D
LR8TnWC6EYN8GKLlXcHbjZpGFOM2l5AhRZ8fs4yR1T3yJtmRAek=
=3gRv
-----END PGP SIGNATURE-----

--z7lxjmd4y3nsnzuv--
