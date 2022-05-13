Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43EB5267AA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 18:56:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376866AbiEMQze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 12:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiEMQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 12:55:27 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C16A663DE
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:55:26 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id r1so10822839oie.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 09:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TK9SPkHUxrXz76RcXOz5GQr5aMMZCUKY9fHznaMvUFc=;
        b=Y2kHX9BRB/slIAcQK8ffXtZq1gzumLjI6eAUx7m/JtKnUVA3Aq5xTbcS/nRhfTc8o3
         MEtDoDeIw1jDZHD0Ay9d2KhEZXDEdc8b9DZS+91ESMH0xfvp7Ouj8CaMvT++ur1M6u+p
         4bWWFBtPivMjtbDqupJVe1YLlJ7/j4nP3+wWyH34maheV7Rlu6bKuMptMAWpKKBdNqOw
         Qw2DQg7eGrh1pNWSxemuoe3n88sHpoK6mEDWEmHIRoe1x4B4OyPdqTRSwFpuOrVvH1rD
         McS1Vr4w7xeXgFg6h9MRccvTVroorSomHTeXERGqxoWnrX2GMLzKMnmC7UbP9KZ4lA2Q
         TxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TK9SPkHUxrXz76RcXOz5GQr5aMMZCUKY9fHznaMvUFc=;
        b=uqbX7aYYunoO+URuIMaI1xwGV+Z83pj0I3AlL/2KuLU6J161mWNepy03k2c2RY36ia
         aEPoq2ZfoqzBg85k2nsBg2w6z9cOke0Avbk6HAVwtBV/jnt49EtGQLfwvbidqNz0kvW0
         bK2lqWeTAofJ4yb6d+wK9N1yGEuDI9HoW2yEGHZ4rUVYtKqKTpWShSjwfxME/qHPAoxZ
         QylmwHlZws6qGW5IMK3rnbCfayA1sV2fVZIngiT5H79VJtTMRmpLTc1gNqdTGXDAwniY
         TOZtLAcmYKwDEetW+jv4t6B2gxC8Iw2rGdUX0dlQ4WxCldEynjlCCxh5vNcYnNr3kmrO
         2inw==
X-Gm-Message-State: AOAM5305hiLY5nzY1g7IcQ3zNvz1fSKO4JPmkWat3AwvdZN13Jr6G5sH
        7cp68x+M3kjtD3cbk10t/Gqdu7a7BiRi3kLfrjlV3OmMPMc=
X-Google-Smtp-Source: ABdhPJzqrHzphKSCdlocUZx8Aj+3sq2G1MgCZf/YS6GgPR1SQGjwjL113lRcVEJYHPOdnzBt5x19EnbXGJFnXfjYx1Y=
X-Received: by 2002:a05:6808:f8e:b0:328:a601:a425 with SMTP id
 o14-20020a0568080f8e00b00328a601a425mr2898988oiw.253.1652460926174; Fri, 13
 May 2022 09:55:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220513062045.840780-1-pengfuyuan@kylinos.cn>
In-Reply-To: <20220513062045.840780-1-pengfuyuan@kylinos.cn>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 13 May 2022 12:55:15 -0400
Message-ID: <CADnq5_P+ibMk_z69CxH_Q60YL259US9f7uv3MDnMgU7pX47MuQ@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: Remove macro DC_DEFAULT_LOG_MASK
To:     pengfuyuan <pengfuyuan@kylinos.cn>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>, xinhui pan <Xinhui.Pan@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75 autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 3:20 AM pengfuyuan <pengfuyuan@kylinos.cn> wrote:
>
> [Why]
> The DC_DEFAULT_LOG_MASK macro has not been used for a long time, so remove it.

I'm sure there are lots of macros in the driver that are not used at
the moment.  Any particular reason to remove it?  DC_MIN_LOG_MASK
doesn't appear to be used at the moment either.

Alex

>
> Signed-off-by: pengfuyuan <pengfuyuan@kylinos.cn>
> ---
>  .../drm/amd/display/include/logger_types.h    | 33 -------------------
>  1 file changed, 33 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/include/logger_types.h b/drivers/gpu/drm/amd/display/include/logger_types.h
> index f093b49c5e6e..1b38cfc41718 100644
> --- a/drivers/gpu/drm/amd/display/include/logger_types.h
> +++ b/drivers/gpu/drm/amd/display/include/logger_types.h
> @@ -131,37 +131,4 @@ enum dc_log_type {
>  #define DC_MIN_LOG_MASK ((1 << LOG_ERROR) | \
>                 (1 << LOG_DETECTION_EDID_PARSER))
>
> -#define DC_DEFAULT_LOG_MASK ((1ULL << LOG_ERROR) | \
> -               (1ULL << LOG_WARNING) | \
> -               (1ULL << LOG_EVENT_MODE_SET) | \
> -               (1ULL << LOG_EVENT_DETECTION) | \
> -               (1ULL << LOG_EVENT_LINK_TRAINING) | \
> -               (1ULL << LOG_EVENT_LINK_LOSS) | \
> -               (1ULL << LOG_EVENT_UNDERFLOW) | \
> -               (1ULL << LOG_RESOURCE) | \
> -               (1ULL << LOG_FEATURE_OVERRIDE) | \
> -               (1ULL << LOG_DETECTION_EDID_PARSER) | \
> -               (1ULL << LOG_DC) | \
> -               (1ULL << LOG_HW_HOTPLUG) | \
> -               (1ULL << LOG_HW_SET_MODE) | \
> -               (1ULL << LOG_HW_RESUME_S3) | \
> -               (1ULL << LOG_HW_HPD_IRQ) | \
> -               (1ULL << LOG_SYNC) | \
> -               (1ULL << LOG_BANDWIDTH_VALIDATION) | \
> -               (1ULL << LOG_MST) | \
> -               (1ULL << LOG_DETECTION_DP_CAPS) | \
> -               (1ULL << LOG_BACKLIGHT)) | \
> -               (1ULL << LOG_I2C_AUX) | \
> -               (1ULL << LOG_IF_TRACE) | \
> -               (1ULL << LOG_HDMI_FRL) | \
> -               (1ULL << LOG_SCALER) | \
> -               (1ULL << LOG_DTN) /* | \
> -               (1ULL << LOG_DEBUG) | \
> -               (1ULL << LOG_BIOS) | \
> -               (1ULL << LOG_SURFACE) | \
> -               (1ULL << LOG_DML) | \
> -               (1ULL << LOG_HW_LINK_TRAINING) | \
> -               (1ULL << LOG_HW_AUDIO)| \
> -               (1ULL << LOG_BANDWIDTH_CALCS)*/
> -
>  #endif /* __DAL_LOGGER_TYPES_H__ */
> --
> 2.25.1
>
