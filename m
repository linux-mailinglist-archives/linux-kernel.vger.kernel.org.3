Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D875590669
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 20:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbiHKSek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 14:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234136AbiHKSeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 14:34:37 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA7C95E51
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:34:37 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id bk13-20020a056830368d00b0063723999f31so2907015otb.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 11:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ypfUihgknhSkUuVKlo5q79CX2DsZsxGfKokpDPBIzrw=;
        b=KLbwFXT6NwkEad4tNRu8k7mE7isrRNrDVY9/jmfCgfyTN0s/eTzvNo4/W4HYHXO28o
         ojwDtL2hAoacO4OsPltVzR5sjrqjeXFu0kXdaAcg06WsOX+jrhgIPP7gi2LtPG+2o3mg
         +lPmFF1mkDojrKGqSPZ4b4p+isAcC3bWsqPVdFj0i5mAM9xn7WmTXWcq0527n3m+SC0E
         p4OYt1XebYnlmK6cIP3XLiKCSFgbFFiV9xKAq3q23t2ND2vZeIT/R0qNJw6DPTScOu4+
         Kt+yQJGSXXCvFZxpWAHw+ZGCnt0gepeMbEZmXTJl6/8iUAgGck/m9H8bCF1tU0OrWTc3
         vwVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ypfUihgknhSkUuVKlo5q79CX2DsZsxGfKokpDPBIzrw=;
        b=E2vmkvQ9QE7mKexqAJSepZSJoZVF9XQQbOy5ixHYVS7LYvpgp0zLhxlCEans2jFe3S
         9W94Duva5eI3OAL3FK8SX3lDn/Uy6YkU6uwNOk95q7LqARQNNRwXPUUrnvieOgSWMbmt
         Kp8K4pcisACPfFridEJ30/1kpjCfueZi2TDQejIP1m2Jy/uzvNpw2swkNeDXd8T2l4RV
         hKtQJ1ERtPst4ACKk48zoRt3b545utfa5pUyP9UqOorl03ttg1xpcare6sD3l/UH/yKf
         jl2u6ftsNImVCGTmy9ghG9yR6ozVFCZSjx7ER+GPhJyqVNVvFlH2k7Gh7XhBAiRrk9NL
         CcYQ==
X-Gm-Message-State: ACgBeo0/Y0yptxaAdwfYrWuWxmve1c9GinOA/XGY15NnhlWAl5RwfGF6
        eVb0UY1wumIwT73W37C9fd8ARi4EKjtkTrkFQeOVSwCZ
X-Google-Smtp-Source: AA6agR6p1C2CpLXaH+oFcV7hJzLsaq0ZAz8LZ0QxQhsosGR7BFUV+mabGRAt20oIuIlSoD2OA9B+MuRl2mzR7FT2EPw=
X-Received: by 2002:a05:6830:25c4:b0:637:2a66:1dfd with SMTP id
 d4-20020a05683025c400b006372a661dfdmr127055otu.383.1660242876510; Thu, 11 Aug
 2022 11:34:36 -0700 (PDT)
MIME-Version: 1.0
References: <CADVatmN_TzJKdfM40BQPW=cRm5VxX=qAKxq2yW4P_xDN6=VoOA@mail.gmail.com>
 <20220811175759.1518840-1-hamza.mahfooz@amd.com>
In-Reply-To: <20220811175759.1518840-1-hamza.mahfooz@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 11 Aug 2022 14:34:25 -0400
Message-ID: <CADnq5_Oo2RBdk5gXq3NKtwTui3+4mZuSXk2+DSYoNMfk2JQCng@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: fix DSC related non-x86/PPC64
 compilation issue
To:     Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc:     linux-kernel@vger.kernel.org,
        Anders Roxell <anders.roxell@linaro.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Leo Li <sunpeng.li@amd.com>, dri-devel@lists.freedesktop.org,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Roman Li <Roman.Li@amd.com>, amd-gfx@lists.freedesktop.org,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Fangzhi Zuo <Jerry.Zuo@amd.com>,
        hersen wu <hersenxs.wu@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <Wayne.Lin@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 2:00 PM Hamza Mahfooz <hamza.mahfooz@amd.com> wrote:
>
> Need to protect DSC code with CONFIG_DRM_AMD_DC_DCN.
> Fixes the following build errors on arm64:
> ERROR: modpost: "dc_dsc_get_policy_for_timing" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> ERROR: modpost: "dc_dsc_compute_bandwidth_range" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>
> Fixes: 0087990a9f57 ("drm/amd/display: consider DSC pass-through during mode validation")
> Reported-by: Anders Roxell <anders.roxell@linaro.org>
> Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>

Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

> ---
> v2: Fix WERROR build failure by guarding unused variables
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index ef6c94cd852b..ce6929224a6e 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -1387,8 +1387,6 @@ bool pre_validate_dsc(struct drm_atomic_state *state,
>         return (ret == 0);
>  }
>
> -#endif
> -
>  static unsigned int kbps_from_pbn(unsigned int pbn)
>  {
>         unsigned int kbps = pbn;
> @@ -1416,17 +1414,19 @@ static bool is_dsc_common_config_possible(struct dc_stream_state *stream,
>
>         return bw_range->max_target_bpp_x16 && bw_range->min_target_bpp_x16;
>  }
> +#endif /* CONFIG_DRM_AMD_DC_DCN */
>
>  enum dc_status dm_dp_mst_is_port_support_mode(
>         struct amdgpu_dm_connector *aconnector,
>         struct dc_stream_state *stream)
>  {
> +       int bpp, pbn, branch_max_throughput_mps = 0;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>         struct dc_link_settings cur_link_settings;
>         unsigned int end_to_end_bw_in_kbps = 0;
>         unsigned int upper_link_bw_in_kbps = 0, down_link_bw_in_kbps = 0;
>         unsigned int max_compressed_bw_in_kbps = 0;
>         struct dc_dsc_bw_range bw_range = {0};
> -       int bpp, pbn, branch_max_throughput_mps = 0;
>
>         /*
>          * check if the mode could be supported if DSC pass-through is supported
> @@ -1461,13 +1461,16 @@ enum dc_status dm_dp_mst_is_port_support_mode(
>                         return DC_FAIL_BANDWIDTH_VALIDATE;
>                 }
>         } else {
> +#endif
>                 /* check if mode could be supported within full_pbn */
>                 bpp = convert_dc_color_depth_into_bpc(stream->timing.display_color_depth) * 3;
>                 pbn = drm_dp_calc_pbn_mode(stream->timing.pix_clk_100hz / 10, bpp, false);
>
>                 if (pbn > aconnector->port->full_pbn)
>                         return DC_FAIL_BANDWIDTH_VALIDATE;
> +#if defined(CONFIG_DRM_AMD_DC_DCN)
>         }
> +#endif
>
>         /* check is mst dsc output bandwidth branch_overall_throughput_0_mps */
>         switch (stream->timing.pixel_encoding) {
> --
> 2.37.1
>
