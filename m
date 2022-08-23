Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DFB59E651
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiHWPr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243375AbiHWPq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:46:59 -0400
Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BAD02AD405
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 04:47:38 -0700 (PDT)
Received: from fews2.riseup.net (fews2-pn.riseup.net [10.0.1.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256
         client-signature RSA-PSS (2048 bits) client-digest SHA256)
        (Client CN "mail.riseup.net", Issuer "R3" (not verified))
        by mx1.riseup.net (Postfix) with ESMTPS id 4MBnWk5CFXzDqMd;
        Tue, 23 Aug 2022 11:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1661255219; bh=GwIk1+ABB8Bt5RsJjevljtBAXhkaMQvoMH9paXaD1CU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XjuQxErfaidsto+3rb54e4iiOUd0WZZWHDpo4zxjQRxZcOYZh6Lffs8t8is3XQj5I
         2DlXqEeTxLpm8b1iK+z/n/6FRlfjBWprZAYuDlY+Aw1/50yO+gBC/v7gBetN5IT7wl
         iCEDTVtgoO9PmnAT1W/+MuI57GbxyIc9wozGFBc0=
X-Riseup-User-ID: 811DE57B9BADAD06DCC2871B63C045F761751702C7BD4FA6B502FAF4B736F29C
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by fews2.riseup.net (Postfix) with ESMTPSA id 4MBnWd3SxVz1yWm;
        Tue, 23 Aug 2022 11:46:53 +0000 (UTC)
Message-ID: <f3c614e5-cc96-4313-0279-4b4500049f90@riseup.net>
Date:   Tue, 23 Aug 2022 08:46:47 -0300
MIME-Version: 1.0
Subject: Re: [PATCH v2] drm/amd: remove duplicated argument to &&
Content-Language: en-US
To:     Bernard Zhao <bernard@vivo.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>,
        Samson Tam <Samson.Tam@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     zhaojunkui2008@126.com
References: <20220823071426.26015-1-bernard@vivo.com>
From:   =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>
In-Reply-To: <20220823071426.26015-1-bernard@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard

On 8/23/22 04:14, Bernard Zhao wrote:
> This patch trf to fis cocci warning:

I believe that there are a couple of typos on this description. Maybe 
you could fixed to s/trf/try and s/fis/fix.

> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c:
> 2349:8-34: duplicated argument to && or ||
> drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c:
> 3680:8-55: duplicated argument to && or ||
> 
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Also, it would be nice to have a changelog between the versions.

Other than those small nits,

Reviewed-by: Maíra Canal <mairacanal@riseup.net>

Best Regards,
- Maíra Canal

> ---
>   .../gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c    | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> index cb2025771646..f99c1696a1f6 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/display_mode_vba_32.c
> @@ -2346,8 +2346,7 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   
>   			if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.ForcedOutputLinkBPP[k] != 0)
>   				mode_lib->vba.DSCOnlyIfNecessaryWithBPP = true;
> -			if ((mode_lib->vba.DSCEnable[k] || mode_lib->vba.DSCEnable[k])
> -					&& mode_lib->vba.OutputFormat[k] == dm_n422
> +			if (mode_lib->vba.DSCEnable[k] && mode_lib->vba.OutputFormat[k] == dm_n422
>   					&& !mode_lib->vba.DSC422NativeSupport)
>   				mode_lib->vba.DSC422NativeNotSupported = true;
>   
> @@ -3678,7 +3677,6 @@ void dml32_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>   			if (mode_lib->vba.SourcePixelFormat[k] != dm_444_64
>   					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_32
>   					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
> -					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_16
>   					&& mode_lib->vba.SourcePixelFormat[k] != dm_444_8
>   					&& mode_lib->vba.SourcePixelFormat[k] != dm_rgbe) {
>   				if (mode_lib->vba.ViewportWidthChroma[k] > mode_lib->vba.SurfaceWidthC[k]
