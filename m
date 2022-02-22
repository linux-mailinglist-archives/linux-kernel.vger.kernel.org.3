Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D3DA4BFF24
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:45:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbiBVQqH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:46:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234300AbiBVQqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:46:06 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964E2169384
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:45:39 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id p15so15163522oip.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BiTH8veyolAI3Fepio67cDwgp9/0CZ3ZhBAQz6LqnXY=;
        b=o9AqQK8vBGSclCZstinXzJr/iSF4gKn9SY1VD0v03lJOgZhg/TbvHXacMT2HI0Cdp0
         ZQlUL0FxT7zbB6Yo+hzPu5gJInHxSpcfa+k/RvUZk3mvGozvNkmQakypRGQ0bVkZq4V/
         eLCqSr/u2AaGTvOkV1rePJXaSwekinAbv4CnNoS8XqFizsM4kuew4ogDXF73CkjQ0Uv3
         Rsg9F2rr8BKQ+Ra9qbmAdBf2uZqcByZq2ONVULsZMPg3gfgzkF431xnoNDvNkxwcsIw5
         ge2PkzhdPY3oBY9ORAVM3R+r2q5Kcb+Dg2bmSYDfrd50VU4JkKf1SOemRFTxRvlauqP6
         4hVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BiTH8veyolAI3Fepio67cDwgp9/0CZ3ZhBAQz6LqnXY=;
        b=Wz0jglspei+bBY65l6zP6VEtYWHA4s2MYNavrXO4nVeqX722oBn6OXE00l3M6EPVkY
         DaFihddH/so9kgqmT5xArdqOowH7+G8BdkewaNwOMBAaG1MGWsSuWlmrsAuksUqBF+l8
         DvJQdYNYGm3h+K7pX4swH73jp4QfqBUsgyQNlX/MTtZ+LIYjdOQlBsAqt8LQPOxLHj4n
         I5+yL3DhOfElSwc7alhe8LJ9jZ0TLiavh0QDjR4MQZLeHsMwh1203aHgIF+8/W+8gKCL
         ieWhqP2zFVBV8f3hjDn44tEB7Wq1WPq8ROqtrlsenYIigLtLOrpXhQYriPyRVkYJ1F82
         Hp2w==
X-Gm-Message-State: AOAM531xk0QKIobKGVMc3FbszFESo56tDLvUgD00oz5IaADu4T5o9mPu
        cAYo15apib/O/9XF8cezP7qHYCHj8rWm+UqDVQ0=
X-Google-Smtp-Source: ABdhPJxqwvD5NzKUsaokv4n4oD8Uxf1FQmBrb++b2A1mClgdQG0AwdkWuKSKXDyX0LdCNwThLofQKm8bAl6EQiccVYw=
X-Received: by 2002:aca:ab4c:0:b0:2d4:7c7d:606e with SMTP id
 u73-20020acaab4c000000b002d47c7d606emr2408438oie.132.1645548338864; Tue, 22
 Feb 2022 08:45:38 -0800 (PST)
MIME-Version: 1.0
References: <20220222131701.356117-1-maira.canal@usp.br> <20220222131701.356117-11-maira.canal@usp.br>
In-Reply-To: <20220222131701.356117-11-maira.canal@usp.br>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 22 Feb 2022 11:45:27 -0500
Message-ID: <CADnq5_MmE63R5kQJj97bjBGMK80hwtCr85MF-_2z=agk1vNv3A@mail.gmail.com>
Subject: Re: [PATCH 10/10] drm/amd/display: Turn global functions into static functions
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>,
        Tao Zhou <tao.zhou1@amd.com>,
        "Chai, Thomas" <YiPeng.Chai@amd.com>,
        "Tuikov, Luben" <luben.tuikov@amd.com>,
        "Stanley.Yang" <Stanley.Yang@amd.com>,
        Dennis Li <Dennis.Li@amd.com>,
        "Joshi, Mukul" <mukul.joshi@amd.com>,
        "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>,
        Magali Lemes <magalilemes00@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>, mwen@igalia.com,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Isabella Basso <isabbasso@riseup.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 8:18 AM Ma=C3=ADra Canal <maira.canal@usp.br> wrote=
:
>
> Turn previously global functions into static functions to avoid
> -Wmissing-prototype warnings, such as:
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn30/irq_service_dcn30.c:50=
:20:
> warning: no previous prototype for function 'to_dal_irq_source_dcn30'
> [-Wmissing-prototypes]
> enum dc_irq_source to_dal_irq_source_dcn30(
>                    ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/irq/dcn30/irq_service_dcn30.c:50=
:1:
> note: declare 'static' if the function is not intended to be used outside
> of this translation unit
> enum dc_irq_source to_dal_irq_source_dcn30(
> ^
> static
> 1 warning generated.
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:=
488:6:
> warning: no previous prototype for function
> 'dcn316_clk_mgr_helper_populate_bw_params' [-Wmissing-prototypes]
> void dcn316_clk_mgr_helper_populate_bw_params(
>      ^
> drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c:=
488:1:
> note: declare 'static' if the function is not intended to be used outside
> of this translation unit
> void dcn316_clk_mgr_helper_populate_bw_params(
> ^
> static
> 1 warning generated.
>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c             | 4 ++--
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c   | 2 +-
>  .../drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.c  | 3 ++-
>  .../gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c    | 2 +-
>  drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c    | 2 +-
>  drivers/gpu/drm/amd/display/dc/core/dc_resource.c             | 2 +-
>  drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c  | 2 +-
>  drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c  | 2 +-
>  8 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/=
gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index c9ca328d34e3..a99b92526b55 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -6362,7 +6362,7 @@ static bool is_freesync_video_mode(const struct drm=
_display_mode *mode,
>                 return true;
>  }
>
> -struct dc_stream_state *
> +static struct dc_stream_state *
>  create_stream_for_sink(struct amdgpu_dm_connector *aconnector,
>                        const struct drm_display_mode *drm_mode,
>                        const struct dm_connector_state *dm_state,
> @@ -10189,7 +10189,7 @@ static void set_freesync_fixed_config(struct dm_c=
rtc_state *dm_new_crtc_state) {
>         dm_new_crtc_state->freesync_config.fixed_refresh_in_uhz =3D res;
>  }
>
> -int dm_update_crtc_state(struct amdgpu_display_manager *dm,
> +static int dm_update_crtc_state(struct amdgpu_display_manager *dm,
>                          struct drm_atomic_state *state,
>                          struct drm_crtc *crtc,
>                          struct drm_crtc_state *old_crtc_state,
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c =
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> index 389b0cb37995..05573f073b21 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
> @@ -213,7 +213,7 @@ static bool validate_dsc_caps_on_connector(struct amd=
gpu_dm_connector *aconnecto
>         return true;
>  }
>
> -bool retrieve_downstream_port_device(struct amdgpu_dm_connector *aconnec=
tor)
> +static bool retrieve_downstream_port_device(struct amdgpu_dm_connector *=
aconnector)
>  {
>         union dp_downstream_port_present ds_port_present;
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbi=
os_smu.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_s=
mu.c
> index 06bab24d8e27..450eaead4f20 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.=
c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn10/rv1_clk_mgr_vbios_smu.=
c
> @@ -101,7 +101,8 @@ static uint32_t rv1_smu_wait_for_response(struct clk_=
mgr_internal *clk_mgr, unsi
>         return res_val;
>  }
>
> -int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *clk_mgr, =
unsigned int msg_id, unsigned int param)
> +static int rv1_vbios_smu_send_msg_with_param(struct clk_mgr_internal *cl=
k_mgr,
> +               unsigned int msg_id, unsigned int param)
>  {
>         uint32_t result;
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr=
.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> index ffd3d5cb9871..02a59adff90d 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_clk_mgr.c
> @@ -485,7 +485,7 @@ static unsigned int find_clk_for_voltage(
>         return clock;
>  }
>
> -void dcn316_clk_mgr_helper_populate_bw_params(
> +static void dcn316_clk_mgr_helper_populate_bw_params(
>                 struct clk_mgr_internal *clk_mgr,
>                 struct integrated_info *bios_info,
>                 const DpmClocks_316_t *clock_table)
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c b=
/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
> index fd6497fd2dc5..128614dff108 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn316/dcn316_smu.c
> @@ -111,7 +111,7 @@ static uint32_t dcn316_smu_wait_for_response(struct c=
lk_mgr_internal *clk_mgr, u
>         return res_val;
>  }
>
> -int dcn316_smu_send_msg_with_param(
> +static int dcn316_smu_send_msg_with_param(
>                 struct clk_mgr_internal *clk_mgr,
>                 unsigned int msg_id, unsigned int param)
>  {
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/=
gpu/drm/amd/display/dc/core/dc_resource.c
> index 19b56f9acf84..29ab67f42d92 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
> @@ -1622,7 +1622,7 @@ bool dc_add_all_planes_for_stream(
>         return add_all_planes_for_stream(dc, stream, &set, 1, context);
>  }
>
> -bool is_timing_changed(struct dc_stream_state *cur_stream,
> +static bool is_timing_changed(struct dc_stream_state *cur_stream,
>                        struct dc_stream_state *new_stream)
>  {
>         if (cur_stream =3D=3D NULL)

This function is actually used elsewhere.  I've dropped this hunk, but
applied the rest.  Thanks!

Alex

> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c=
 b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> index c4b067d01895..93c31111500b 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn20/irq_service_dcn20.c
> @@ -40,7 +40,7 @@
>
>  #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
>
> -enum dc_irq_source to_dal_irq_source_dcn20(
> +static enum dc_irq_source to_dal_irq_source_dcn20(
>                 struct irq_service *irq_service,
>                 uint32_t src_id,
>                 uint32_t ext_id)
> diff --git a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c=
 b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> index 0b68c08fac3f..ac0c6a62d17b 100644
> --- a/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> +++ b/drivers/gpu/drm/amd/display/dc/irq/dcn30/irq_service_dcn30.c
> @@ -47,7 +47,7 @@
>
>  #include "ivsrcid/dcn/irqsrcs_dcn_1_0.h"
>
> -enum dc_irq_source to_dal_irq_source_dcn30(
> +static enum dc_irq_source to_dal_irq_source_dcn30(
>                 struct irq_service *irq_service,
>                 uint32_t src_id,
>                 uint32_t ext_id)
> --
> 2.35.1
>
