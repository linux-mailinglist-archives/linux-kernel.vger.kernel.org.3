Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 587C654B4DA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356909AbiFNPiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbiFNPiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:38:18 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA4613D3C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:38:15 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id i19so6686313qvu.13
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z2yLINaTzV8fSrfmCIDVzIix1NCFViFEnmZVJZZ6Sa4=;
        b=eL5IL1nulrSQ4Sp0dXS0I23ihVz+S36hijRsX7WL+U/iLrea3l0Nv8O6qZrtfJl9Si
         DHQlBtZH2UGBGVWy7IYYYRi8LnMeZmMmhVqksRKVrvmdx95gukiTPTSWXMLKYhFzWw/8
         SFTfT2ZX615lJasNk/W7iiIB4fQBYZztiKhVWNi0cTbnsefL0S3cwUH0RSHpUqKT4BzZ
         qnjMdpBbHC9/zJsohCvySI41JbFTjZl4pxRSEIfk3PUCycbmEvB2/vbABuRhO6fB1ihm
         y/L3RfL8dLOKAI+6vpfyzsytSUBNRfC06LTi47Ib5GnANNub7EVVbRClXHK4vcZGPWuW
         o/uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z2yLINaTzV8fSrfmCIDVzIix1NCFViFEnmZVJZZ6Sa4=;
        b=LEh+EIvy+cVl3kYWCO4AERt3e2O4J0fK4oqpbKrVmfqII4qGH8ExJc1cFWlJvyAYlG
         v8roEHZypGuG4JyDebJM3u/ov4YzQbeRkzVqX1yHDl7Pgb9hPtTM4Zb9qFaJ8Qk6zrJM
         vO8nvp4fkK2oQmr5+IgJt82t1F6TPLLH9AiCvYHw9BNBxrdxwsF6eN1piiBZf0epO7vD
         S/5Lq3VzmN7rTzAfFNXZFfemya7DKWYWUe9JkdxFsSJboK/jqnn0QL/tQqA/f1EWHJqr
         sGPmzWI4JltaM9PRPjUfJpkx+hHphC3o16z2vnxjZC4+hHnXP/kgp9Kn/OaznpF9NxcY
         6NJQ==
X-Gm-Message-State: AJIora+zkMoG7g4EqKJLcv08izRJRroF5YihD4s7vh+Gej3M2zI6uKok
        sCgKYrzchvR+G4hgW/BEIZw+7SYwQKlWAYPIxA/pAA==
X-Google-Smtp-Source: AGRyM1td/rPSbsDPtwajD50WhjsLg3QFEDBWftZKqAEd+cbeoSRsVxg4lt/ba5CXFnCbN7OomFghAvTe9nTeMMiSBTA=
X-Received: by 2002:ad4:5aa4:0:b0:465:2b11:cfd with SMTP id
 u4-20020ad45aa4000000b004652b110cfdmr4031385qvg.55.1655221094880; Tue, 14 Jun
 2022 08:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220613204910.2651747-1-robdclark@gmail.com>
In-Reply-To: <20220613204910.2651747-1-robdclark@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 14 Jun 2022 18:38:04 +0300
Message-ID: <CAA8EJpoU8ZqHTTcGWH3=cBRecFTKErjz2paTEjCYt8hTsvpbAQ@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Make msm_gem_free_object() static
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jun 2022 at 23:49, Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Misc small cleanup I noticed.  Not called from another object file since
> 3c9edd9c85f5 ("drm/msm: Introduce GEM object funcs")
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/msm_gem.c | 2 +-
>  drivers/gpu/drm/msm/msm_gem.h | 1 -
>  2 files changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 35845e273d81..3ef7ada59392 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -1004,7 +1004,7 @@ void msm_gem_describe_objects(struct list_head *list, struct seq_file *m)
>  #endif
>
>  /* don't call directly!  Use drm_gem_object_put() */
> -void msm_gem_free_object(struct drm_gem_object *obj)
> +static void msm_gem_free_object(struct drm_gem_object *obj)
>  {
>         struct msm_gem_object *msm_obj = to_msm_bo(obj);
>         struct drm_device *dev = obj->dev;
> diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
> index 6b7d5bb3b575..d608339c1643 100644
> --- a/drivers/gpu/drm/msm/msm_gem.h
> +++ b/drivers/gpu/drm/msm/msm_gem.h
> @@ -175,7 +175,6 @@ void msm_gem_active_get(struct drm_gem_object *obj, struct msm_gpu *gpu);
>  void msm_gem_active_put(struct drm_gem_object *obj);
>  int msm_gem_cpu_prep(struct drm_gem_object *obj, uint32_t op, ktime_t *timeout);
>  int msm_gem_cpu_fini(struct drm_gem_object *obj);
> -void msm_gem_free_object(struct drm_gem_object *obj);
>  int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
>                 uint32_t size, uint32_t flags, uint32_t *handle, char *name);
>  struct drm_gem_object *msm_gem_new(struct drm_device *dev,
> --
> 2.36.1
>


-- 
With best wishes
Dmitry
