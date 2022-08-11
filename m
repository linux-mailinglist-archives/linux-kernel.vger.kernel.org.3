Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E5CF590553
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiHKRBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239128AbiHKRA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:00:59 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674FEDEA4F;
        Thu, 11 Aug 2022 09:33:06 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id j5so16257723oih.6;
        Thu, 11 Aug 2022 09:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=X4v1+9M+lzJNhjmu0VSf3gTMP0So1BV3q3LJQbuMFXw=;
        b=RPAc0fEzeU+2pzE6N5pkSQY0cZtsVivrHMqBPS8FyZ6sWRakSb9Z2PTJ6YttJcQfXt
         HzHIQR/n4Ng8b6SAXHJVD3XAU3ewK4VJIWLmQV9tjHaodwgHOxbWA3wUn5rS4JMru7ml
         F0s4i+8gLdNILQ8K749Eqc4I4b+vG0CZnX25zDHl5XKU82YCVJgzXCYynDesqHbLY6/x
         RqIrMop6HieggT5l0c0lOXVbn2nH+Y5bzcghBdSYYC9so0CxbWMy0BEUOizRtFED1mCH
         2m0D6Z+qRTqNNj3qgpsDChlHVEEdRFoa+8MuTeYf/zpKE8IL2hfUDbq/KlsJxPWW2b7q
         fmEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=X4v1+9M+lzJNhjmu0VSf3gTMP0So1BV3q3LJQbuMFXw=;
        b=y6CtKwkfrlsRVrzvl54ezccGktd88bhrRWgwkyxaXPlg7Y9vwig7Pw0BR+/T+ZIXw8
         fsn452i14F9QaHthQ++uoRcCbflo9HnHkH5c/5UBC//dqst0rPHnWxhKo9+UKGK1QwLS
         myWgPT0AMw6Z0ZP/wWBL/ARNYfd1adgPFEFzmL825EYrUyb0Eu97ZhmAWGZT1ikB5KX4
         1vz+k8DFPk1ZTWERuGBu0YhQkOEJ1Hcnt/wmRI2u7NqSh32zOKQLS/eUfFG/2dwCrXZf
         5+TO4ZVlDXSviJY/+XZgJNZJJoPYpUgFoIyDNmp/9iKb/aXodbtW2doUVP6duxBAI+SW
         1e3A==
X-Gm-Message-State: ACgBeo2uKtD9zJ4WfpTErJuzoYPJQRtqFzNVHQiC9clevFOT1ODremoQ
        xptCT9BpfuJM4al+sqysIhugMf+PFVn19u96zSI=
X-Google-Smtp-Source: AA6agR7nn2jBlh9kqBmNI654QihqMenEiy9qbh+AfpMKzePccSF8dP9jSQFso5k4gHo9wp0B7T+QhL4SEn7/RTZtXvA=
X-Received: by 2002:a05:6808:ecb:b0:33a:3b54:37f9 with SMTP id
 q11-20020a0568080ecb00b0033a3b5437f9mr15131oiv.33.1660235583346; Thu, 11 Aug
 2022 09:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1657360984.git.mchehab@kernel.org> <879d916ad72029ea9611f78de1181df01dee5ca3.1657360984.git.mchehab@kernel.org>
In-Reply-To: <879d916ad72029ea9611f78de1181df01dee5ca3.1657360984.git.mchehab@kernel.org>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Thu, 11 Aug 2022 12:32:51 -0400
Message-ID: <CADnq5_OuMzr6R3aZQue7rQRjXh9VX_4WayEQMUoKWYDgGKU6wg@mail.gmail.com>
Subject: Re: [PATCH v3 09/21] drm/scheduler: fix a kernel-doc warning
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        David Airlie <airlied@linux.ie>,
        Alex Deucher <alexander.deucher@amd.com>
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

On Sat, Jul 9, 2022 at 6:08 AM Mauro Carvalho Chehab <mchehab@kernel.org> wrote:
>
> The dev field was not documented:
>
>         include/drm/gpu_scheduler.h:463: warning: Function parameter or member 'dev' not described in 'drm_gpu_scheduler'
>
> Document it.
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>

Patches 9, 10 are:
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Do you have commit rights to drm-misc or do you need me to push them?

Thanks,

Alex


> ---
>
> To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
> See [PATCH v3 00/21] at: https://lore.kernel.org/all/cover.1657360984.git.mchehab@kernel.org/
>
>  include/drm/gpu_scheduler.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> index addb135eeea6..c7c487e0c40e 100644
> --- a/include/drm/gpu_scheduler.h
> +++ b/include/drm/gpu_scheduler.h
> @@ -435,6 +435,7 @@ struct drm_sched_backend_ops {
>   * @_score: score used when the driver doesn't provide one
>   * @ready: marks if the underlying HW is ready to work
>   * @free_guilty: A hit to time out handler to free the guilty job.
> + * @dev: pointer to struct device.
>   *
>   * One scheduler is implemented for each hardware ring.
>   */
> --
> 2.36.1
>
