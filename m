Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0083355E2A6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239350AbiF0VjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbiF0VjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:39:16 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41ECDB39
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:39:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u12so21790582eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bbdSb2cTZ0htDASIs4pX7vkvL5oD25vksluOzr2XcSs=;
        b=GxRdWAzs+A4aw28qbnHYzF6sgFjJtNW/9+gd2VO19JgtV0Q7IQF7D22365cu5DoXD1
         gz56oEIsl+W22kzUC7dO8n4vFZzKyauew1ddf4+Po8WULnJNQEEx8qKedCEAvOmdB4p1
         jIUWOWdI8ma2GAnhvY+Fm7zd5+ejqXh6iU4AAm2VGvcvPVPEM6B3WcbJGRBf0i4r2UxC
         Iyfh0ZmhdjUZQqoBojFg3Pfb2ZQhQw0DKS8HBpvRSPaTxiy+XQsVXS92tKncxB0qn/q0
         jnrTk853Duoe+8dUamO33oScwdroGkW00qjNxgFMhxOwaOTH6wXbRgiia3S8e1TBiqlA
         zD0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bbdSb2cTZ0htDASIs4pX7vkvL5oD25vksluOzr2XcSs=;
        b=IKVe1uinenqmgE8ggA7eaKxiAtFgZlQK4JB8ahAkpldP5a6dx1LqRpZTVqBgHIDOWK
         miSS/gTFxCjEKNCScOlQ1WSkF0EiV0OvlrKqBBkGnBscB1U+LHvqACrYnjsYiCgJpSGW
         BbJYi+ghWVNSI1kzdKL1HV4JWmTu3HHA/BaY8bvSayMIzzihGq8EozQWF3kuCE2d+g78
         R3hIEOic+wFdKg+mS2bqQC8JVb7M5KsTzcXaNs+0LMJbMgY0XVr1XXQAD6X7g9Q+toAQ
         FFMlFIrqZT3J6TZtmHEGjJsqFnBR21vcKmdaHS3rpErKmGSEMM/hATiRS/ecqRjT56xZ
         gBqQ==
X-Gm-Message-State: AJIora+IITZnVzmM0z/EZWt1cIblTmV7FyVmkiRqqJx+MxK4EnIgJSn2
        7BWRudkLIWB/VYG00jo7m9+vkHvCquqyThgg0mA=
X-Google-Smtp-Source: AGRyM1vR3YQYUmiaHSFQiFk4p7DhkSC+ahsp6sDc8p2/glRlJGZlfXGcuDzQXqHJdsSub/M0Ib2jJiBhUqFcH+JFpAc=
X-Received: by 2002:a17:907:94cf:b0:726:c81a:f30e with SMTP id
 dn15-20020a17090794cf00b00726c81af30emr2387143ejc.451.1656365953879; Mon, 27
 Jun 2022 14:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220625014157.5004-1-jrdr.linux@gmail.com>
In-Reply-To: <20220625014157.5004-1-jrdr.linux@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Jun 2022 17:39:02 -0400
Message-ID: <CADnq5_McHFHKiXWMpMEo0QtKW_HMe5dkp9-Q-3LFs1AjDQ0Kzg@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Removed unused variable ret
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>, Jun Lei <Jun.Lei@amd.com>,
        Jimmy Kizito <Jimmy.Kizito@amd.com>,
        Jerry Zuo <Jerry.Zuo@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        "Leo (Hanghong) Ma" <hanghong.ma@amd.com>,
        kernel test robot <lkp@intel.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Applied.  Thanks!

Alex

On Fri, Jun 24, 2022 at 9:42 PM Souptick Joarder <jrdr.linux@gmail.com> wrote:
>
> From: "Souptick Joarder (HPE)" <jrdr.linux@gmail.com>
>
> Kernel test robot throws below warning ->
>
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:
> In function 'dc_link_reduce_mst_payload':
>    drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link.c:3782:32:
> warning: variable 'ret' set but not used [-Wunused-but-set-variable]
>     3782 |         enum act_return_status ret;
>
> Removed the unused ret variable.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Souptick Joarder (HPE) <jrdr.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 55a8f58ee239..445357623d8b 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -3706,7 +3706,6 @@ enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw
>         struct fixed31_32 pbn_per_slot;
>         struct dp_mst_stream_allocation_table proposed_table = {0};
>         uint8_t i;
> -       enum act_return_status ret;
>         const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
>         DC_LOGGER_INIT(link->ctx->logger);
>
> @@ -3777,7 +3776,7 @@ enum dc_status dc_link_reduce_mst_payload(struct pipe_ctx *pipe_ctx, uint32_t bw
>                         &link->mst_stream_alloc_table);
>
>         /* poll for immediate branch device ACT handled */
> -       ret = dm_helpers_dp_mst_poll_for_allocation_change_trigger(
> +       dm_helpers_dp_mst_poll_for_allocation_change_trigger(
>                         stream->ctx,
>                         stream);
>
> --
> 2.25.1
>
