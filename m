Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202195808A0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 02:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230311AbiGZABI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 20:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237108AbiGYX7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 19:59:11 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0567727FD9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 16:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=O2ubfH2wQgxmJZWUP8M1vkKi6rTyTW4C61EL27uDGLI=; b=FdDGoOYDIjVUe17qJdSxcppF/6
        BgyYILkT7FztFKmP5+K0qCFLxZJWgrWhYxWMSilPQ4diZCLP3Se96eLLn4WPnI6lY6ITlMj6DAPQy
        VhK13AaOvQEp+JM6mzrrAjFHoNgvCfFnIecAQWxnBDbLf/CfOiQWjd7I/V6rMW2ANaWfyI1THxdfJ
        2RRlR/Yi0CZ/dCebV1OhcjrSLd08zWg6GCAaPZSivHXCg/pYcRO1jjChs9qJFJNdIwNDcvmD+M9oP
        X/Ye4KdN1/p09or297EABop8W2NJ0cxKaB0HTzJ5EL18QHUWC8KRSokCcfX598Lc1yTlEhUU7Dwck
        hIqTgYGw==;
Received: from [165.90.126.25] (helo=mail.igalia.com)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1oG7yX-006bNf-8M; Tue, 26 Jul 2022 01:59:01 +0200
Date:   Mon, 25 Jul 2022 22:58:48 -0100
From:   Melissa Wen <mwen@igalia.com>
To:     Magali Lemes <magalilemes00@gmail.com>
Cc:     harry.wentland@amd.com, sunpeng.li@amd.com,
        Rodrigo.Siqueira@amd.com, alexander.deucher@amd.com,
        christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch, mairacanal@riseup.net, isabbasso@riseup.net,
        siqueirajordao@riseup.net, andrealmeid@riseup.net,
        tales.aparecida@gmail.com, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drm/amd/display: include missing headers
Message-ID: <20220725235848.372aapiwvmxiiowt@mail.igalia.com>
References: <20220725181559.250030-1-magalilemes00@gmail.com>
 <20220725181559.250030-2-magalilemes00@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fydmeijpi4u4gmq5"
Content-Disposition: inline
In-Reply-To: <20220725181559.250030-2-magalilemes00@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fydmeijpi4u4gmq5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07/25, Magali Lemes wrote:
> Add missing headers to solve the following warnings from sparse:
>=20
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:656:17: wa=
rning: symbol 'ddr4_wm_table_gs' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:693:17: wa=
rning: symbol 'lpddr4_wm_table_gs' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:730:17: wa=
rning: symbol 'lpddr4_wm_table_with_disabled_ppt' was not declared. Should =
it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:767:17: wa=
rning: symbol 'ddr4_wm_table_rn' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:804:17: wa=
rning: symbol 'ddr4_1R_wm_table_rn' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn20/dcn20_fpu.c:841:17: wa=
rning: symbol 'lpddr4_wm_table_rn' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c:217:17: =
warning: symbol 'ddr4_wm_table' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn301/dcn301_fpu.c:254:17: =
warning: symbol 'lpddr5_wm_table' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/dcn31_fpu.c:53:30: war=
ning: symbol 'dcn3_1_ip' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/dcn31_fpu.c:117:37: wa=
rning: symbol 'dcn3_1_soc' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/dcn31_fpu.c:197:30: wa=
rning: symbol 'dcn3_15_ip' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/dcn31_fpu.c:262:37: wa=
rning: symbol 'dcn3_15_soc' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/dcn31_fpu.c:293:30: wa=
rning: symbol 'dcn3_16_ip' was not declared. Should it be static?
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/dcn31_fpu.c:358:37: wa=
rning: symbol 'dcn3_16_soc' was not declared. Should it be static?
>=20
Hi Magali,

Nice catch! See some comments below:

> Signed-off-by: Magali Lemes <magalilemes00@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h | 1 +
>  drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c      | 1 +
>  drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c    | 1 +
>  drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c      | 3 +++
>  4 files changed, 6 insertions(+)
>=20
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h b/=
drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h
> index 2e088c5171b2..f1319957e400 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.h
> @@ -28,6 +28,7 @@
> =20
>  #include "clk_mgr.h"
>  #include "dm_pp_smu.h"
> +#include "clk_mgr_internal.h"

I see that this fix (right above) comes from another warning not listed
in the commit message. Can you explicit it there or split it in
another commit if possible?

Also, clk_mgr/dcn21/rn_clk_mgr.c includes clk_mgr_internal.h and
rn_clk_mgr.h; I wonder if a cleaner solution is to remove the
`#include clk_mgr_internal.h` from rn_clk_mgr.c too.

The remaining changes seems correct to me.

Thanks,

Melissa

> =20
>  extern struct wm_table ddr4_wm_table_gs;
>  extern struct wm_table lpddr4_wm_table_gs;
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> index eeeae52fe6fc..45e9f4663abe 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
> @@ -30,6 +30,7 @@
>  #include "dchubbub.h"
>  #include "dcn20/dcn20_resource.h"
>  #include "dcn21/dcn21_resource.h"
> +#include "clk_mgr/dcn21/rn_clk_mgr.h"
> =20
>  #include "dcn20_fpu.h"
> =20
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/dri=
vers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> index 7ef66e511ec8..d211cf6d234c 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
> @@ -26,6 +26,7 @@
>  #include "clk_mgr.h"
>  #include "dcn20/dcn20_resource.h"
>  #include "dcn301/dcn301_resource.h"
> +#include "clk_mgr/dcn301/vg_clk_mgr.h"
> =20
>  #include "dml/dcn20/dcn20_fpu.h"
>  #include "dcn301_fpu.h"
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drive=
rs/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> index e36cfa5985ea..2d11a2c13345 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
> @@ -25,6 +25,9 @@
> =20
>  #include "resource.h"
>  #include "clk_mgr.h"
> +#include "dcn31/dcn31_resource.h"
> +#include "dcn315/dcn315_resource.h"
> +#include "dcn316/dcn316_resource.h"
> =20
>  #include "dml/dcn20/dcn20_fpu.h"
>  #include "dcn31_fpu.h"
> --=20
> 2.37.1
>=20

--fydmeijpi4u4gmq5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEd8WOo/JViG+Tu+XIwqF3j0dLehwFAmLfLhYACgkQwqF3j0dL
ehxzPBAAlERN6pDxUTfpiujfTDPJOWpVtWnC1Masl4psyPTOojPrar7khCz7lyZL
BVRSXjIGV7seRAe765s8oEb9D5GQUqMU3Jlpro1EBWF7AQ77qV3/hPlyhYCDr4tM
am9En8V4PynUgos/ayu+ALEmgPNlBAlJd46fY2rln/4VlPAAyJosp1ipVMzMe4vL
6QPonpOvTVcVoc3LjNGc2sDGfu1Ktmmou6fRKiHAXk4Wfk8ak55yzH5AoWG+X881
SiiDdT+kt7U8c0cIdVvdt9T7aksOgPtAixDe22pZon2FaMfqjvOWrobRwOg2qAUG
UXxHXxWUs1+2+y1J+AYx91WWdJ9A9S/po+Qaw/pdKNmGMwRQljcVTwrk4J46ib78
F71NSi+39+cvyNOmnZoYpCy0A+YXJWoLsXv6bw225ntqA7Jyqf3LstklMaJYeTgh
m0gGwQ4eJXZqcnfY29S7W+O4jo6gQXJJBC6Di/bJO1MBUQmPgmFWjaKJdpt7Peax
SHrzyQwz2GZr1g3hq8MM+9KezYp5BpcjJEdNyC22Tu4+5mEmvs8aR+ZlY4VEEfXE
+UeILM57PyFFeYoqvL9wcyzPDCZwp+aHtl3Y7H7zxHZLcUmlpx9uAmipI3hobiKF
k1a5jmi5Y3ez0FP14YsQPtyIE1EaEs+vSHbAXlPsn7tLIqpm16g=
=MbwT
-----END PGP SIGNATURE-----

--fydmeijpi4u4gmq5--
