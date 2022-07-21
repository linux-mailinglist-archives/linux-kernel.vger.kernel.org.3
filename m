Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4D3D57D3C5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 21:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiGUTAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 15:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiGUTAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 15:00:42 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E55558FB
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=9S3fxKZh9UeJAPH4kwDIzMXKbMyI/F1Km6cNIyHaDjs=; b=Mll4HX5q2rq67pYbaoeReNpNmQ
        D6toJShIN6W+GKg3V0EDEDWGZ9QnzJ5Y4lOv2L8cVrJf1Obb00Y7MbbPu6FZ+uYqHtxNKPXeb4eWP
        b4aMGYvhZcK60o6YZz+55wK6Vgziu0Ur+GIcfaFRnQ/P98j3O19RVPh6uKpEVgsGJDG7PpJXih0uZ
        O7NlJQDGYR3q+dmNZQfcQ9mK09bv72dJ53HiAASb8rCVkI0SPwMnKluw4t6ScQbZjDyUO0FoylkVQ
        BmnvpZTFAvwTxQNnekqvmJoiw2bTszzmrClRj3DK+WxjIelLOz815L1JbhkqLZMlK1LNFEYJ63VdG
        /S0UDsGA==;
Received: from 201-13-50-220.dsl.telesp.net.br ([201.13.50.220] helo=[192.168.15.109])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oEbPS-001k2Z-Bh; Thu, 21 Jul 2022 21:00:30 +0200
Message-ID: <aaf722ef-7ead-9d88-ec66-0ab269b65a8f@igalia.com>
Date:   Thu, 21 Jul 2022 16:00:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/4] drm/amd/display: Drop dm_sw_gfx7_2d_thin_l_vp and
 dm_sw_gfx7_2d_thin_gl
Content-Language: en-US
To:     =?UTF-8?Q?Ma=c3=adra_Canal?= <mairacanal@riseup.net>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        christian.koenig@amd.com, Xinhui.Pan@amd.com,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
        Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc:     magalilemes00@gmail.com, tales.aparecida@gmail.com,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        mwen@igalia.com, Isabella Basso <isabbasso@riseup.net>,
        andrealmeid@riseup.net
References: <20220721183633.1004611-1-mairacanal@riseup.net>
From:   =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@igalia.com>
In-Reply-To: <20220721183633.1004611-1-mairacanal@riseup.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for the quick revision!

Series is Reviewed-by: André Almeida <andrealmeid@igalia.com>

Às 15:36 de 21/07/22, Maíra Canal escreveu:
> As the enum entries dm_sw_gfx7_2d_thin_gl and dm_sw_gfx7_2d_thin_l_vp
> are not used on the codebase, drop those entries from enum
> dm_swizzle_mode.
> 
> Signed-off-by: Maíra Canal <mairacanal@riseup.net>
> ---
> v1 -> v2:
> - Replace "enum" to "enum entries" (André Almeida).
> - Describe changes in imperative mood (André Almeida).
> ---
>  .../dc/dml/dcn20/display_mode_vba_20.c        | 26 +++++-------------
>  .../dc/dml/dcn20/display_mode_vba_20v2.c      | 26 +++++-------------
>  .../dc/dml/dcn21/display_mode_vba_21.c        | 27 +++++--------------
>  .../amd/display/dc/dml/display_mode_enums.h   |  2 --
>  .../display/dc/dml/dml_wrapper_translation.c  |  9 -------
>  5 files changed, 19 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> index d3b5b6fedf04..4e4cb0927057 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20.c
> @@ -938,7 +938,7 @@ static unsigned int CalculateVMAndRowBytes(
>  		*MetaRowByte = 0;
>  	}
>  
> -	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
> +	if (SurfaceTiling == dm_sw_linear) {
>  		MacroTileSizeBytes = 256;
>  		MacroTileHeight = BlockHeight256Bytes;
>  	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
> @@ -3347,26 +3347,12 @@ void dml20_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  										== dm_420_8
>  								|| mode_lib->vba.SourcePixelFormat[k]
>  										== dm_420_10))
> -				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
> -						|| mode_lib->vba.SurfaceTiling[k]
> -								== dm_sw_gfx7_2d_thin_l_vp)
> -						&& !((mode_lib->vba.SourcePixelFormat[k]
> -								== dm_444_64
> +				|| (mode_lib->vba.DCCEnable[k] == true
> +						&& (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
>  								|| mode_lib->vba.SourcePixelFormat[k]
> -										== dm_444_32)
> -								&& mode_lib->vba.SourceScan[k]
> -										== dm_horz
> -								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
> -										== true
> -								&& mode_lib->vba.DCCEnable[k]
> -										== false))
> -						|| (mode_lib->vba.DCCEnable[k] == true
> -								&& (mode_lib->vba.SurfaceTiling[k]
> -										== dm_sw_linear
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_8
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_10)))) {
> +										== dm_420_8
> +								|| mode_lib->vba.SourcePixelFormat[k]
> +										== dm_420_10))) {
>  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> index 63bbdf8b8678..eaa0cdb599ba 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/display_mode_vba_20v2.c
> @@ -998,7 +998,7 @@ static unsigned int CalculateVMAndRowBytes(
>  		*MetaRowByte = 0;
>  	}
>  
> -	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
> +	if (SurfaceTiling == dm_sw_linear) {
>  		MacroTileSizeBytes = 256;
>  		MacroTileHeight = BlockHeight256Bytes;
>  	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
> @@ -3454,26 +3454,12 @@ void dml20v2_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode
>  										== dm_420_8
>  								|| mode_lib->vba.SourcePixelFormat[k]
>  										== dm_420_10))
> -				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
> -						|| mode_lib->vba.SurfaceTiling[k]
> -								== dm_sw_gfx7_2d_thin_l_vp)
> -						&& !((mode_lib->vba.SourcePixelFormat[k]
> -								== dm_444_64
> +				|| (mode_lib->vba.DCCEnable[k] == true
> +						&& (mode_lib->vba.SurfaceTiling[k] == dm_sw_linear
>  								|| mode_lib->vba.SourcePixelFormat[k]
> -										== dm_444_32)
> -								&& mode_lib->vba.SourceScan[k]
> -										== dm_horz
> -								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
> -										== true
> -								&& mode_lib->vba.DCCEnable[k]
> -										== false))
> -						|| (mode_lib->vba.DCCEnable[k] == true
> -								&& (mode_lib->vba.SurfaceTiling[k]
> -										== dm_sw_linear
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_8
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_10)))) {
> +										== dm_420_8
> +								|| mode_lib->vba.SourcePixelFormat[k]
> +										== dm_420_10))) {
>  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
> index 8a7485e21d53..198d81861ac5 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dcn21/display_mode_vba_21.c
> @@ -1342,7 +1342,7 @@ static unsigned int CalculateVMAndRowBytes(
>  		*MetaRowByte = 0;
>  	}
>  
> -	if (SurfaceTiling == dm_sw_linear || SurfaceTiling == dm_sw_gfx7_2d_thin_gl || SurfaceTiling == dm_sw_gfx7_2d_thin_l_vp) {
> +	if (SurfaceTiling == dm_sw_linear) {
>  		MacroTileSizeBytes = 256;
>  		MacroTileHeight = BlockHeight256Bytes;
>  	} else if (SurfaceTiling == dm_sw_4kb_s || SurfaceTiling == dm_sw_4kb_s_x
> @@ -3579,26 +3579,13 @@ void dml21_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_l
>  										== dm_420_8
>  								|| mode_lib->vba.SourcePixelFormat[k]
>  										== dm_420_10))
> -				|| (((mode_lib->vba.SurfaceTiling[k] == dm_sw_gfx7_2d_thin_gl
> -						|| mode_lib->vba.SurfaceTiling[k]
> -								== dm_sw_gfx7_2d_thin_l_vp)
> -						&& !((mode_lib->vba.SourcePixelFormat[k]
> -								== dm_444_64
> +				|| (mode_lib->vba.DCCEnable[k] == true
> +						&& (mode_lib->vba.SurfaceTiling[k]
> +								== dm_sw_linear
>  								|| mode_lib->vba.SourcePixelFormat[k]
> -										== dm_444_32)
> -								&& mode_lib->vba.SourceScan[k]
> -										== dm_horz
> -								&& mode_lib->vba.SupportGFX7CompatibleTilingIn32bppAnd64bpp
> -										== true
> -								&& mode_lib->vba.DCCEnable[k]
> -										== false))
> -						|| (mode_lib->vba.DCCEnable[k] == true
> -								&& (mode_lib->vba.SurfaceTiling[k]
> -										== dm_sw_linear
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_8
> -										|| mode_lib->vba.SourcePixelFormat[k]
> -												== dm_420_10)))) {
> +										== dm_420_8
> +								|| mode_lib->vba.SourcePixelFormat[k]
> +										== dm_420_10))) {
>  			mode_lib->vba.SourceFormatPixelAndScanSupport = false;
>  		}
>  	}
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
> index f394b3f3922a..0e06727d40b3 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
> +++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_enums.h
> @@ -89,8 +89,6 @@ enum dm_swizzle_mode {
>  	dm_sw_var_s_x = 29,
>  	dm_sw_var_d_x = 30,
>  	dm_sw_var_r_x = 31,
> -	dm_sw_gfx7_2d_thin_l_vp,
> -	dm_sw_gfx7_2d_thin_gl,
>  };
>  enum lb_depth {
>  	dm_lb_10 = 0, dm_lb_8 = 1, dm_lb_6 = 2, dm_lb_12 = 3, dm_lb_16 = 4,
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
> index 4ec5310a2962..9edcb6fc83c1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dml_wrapper_translation.c
> @@ -35,15 +35,6 @@ static void gfx10array_mode_to_dml_params(
>  	case DC_ARRAY_LINEAR_GENERAL:
>  		*sw_mode = dm_sw_linear;
>  		break;
> -	case DC_ARRAY_2D_TILED_THIN1:
> -// DC_LEGACY_TILING_ADDR_GEN_ZERO - undefined as per current code hence removed
> -#if 0
> -		if (compat_level == DC_LEGACY_TILING_ADDR_GEN_ZERO)
> -			*sw_mode = dm_sw_gfx7_2d_thin_l_vp;
> -		else
> -			*sw_mode = dm_sw_gfx7_2d_thin_gl;
> -#endif
> -		break;
>  	default:
>  		ASSERT(0); /* Not supported */
>  		break;
