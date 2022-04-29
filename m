Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1001151579D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 00:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377970AbiD2WDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 18:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378803AbiD2WDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 18:03:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D1411B7AC;
        Fri, 29 Apr 2022 15:00:14 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c11so2567088wrn.8;
        Fri, 29 Apr 2022 15:00:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3YvJQ8AnVTjfxXBmIcp4SKnbUwO/iQ1O2/sNT7auhlc=;
        b=Mt/mI0/OBXBeNhi9sXshjI8jxnT5wdIT8DJ3pLbrSH5vmO4Cd5tRHisCYP9Szu+M+e
         1i0MOQGIeOEWLLM3DbI++ffIRdM44r//1bhYJnM6WYFAHuH3hMxgSCZorYLY4YIrIBxz
         yvbIRpUHCuKQUB09fySYM8xYFW9V6VOqhuQcuIN6uTngS6JELu22Q2qtRXnVoKAf0kHg
         hBThL82Tc+5LAJLkfrQVwIEPTlxUkGrbzDzmTFjMCJwy4Y37aDoiJg0ZKRVbjeKb1ZnO
         f/niq1HPBVrZPWO5rTcaDsnvzYy6UkSn5Umu4KvCn+aKuwQF4uk90AUGy+Hh2abxlefT
         B8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3YvJQ8AnVTjfxXBmIcp4SKnbUwO/iQ1O2/sNT7auhlc=;
        b=7LCpfwuhKHGB/0R3Xmjmv5j3quDCJRIDKEZlqNYhJ0be1j5fKQcT1ftgmq7RtBV3LK
         CuEf3bPK6r26peOFdJL43U0gjhlbLOIAPYVjeKkobPxioEbaKP/DtmvINZoG/yivTfvN
         9Xq7SSEpv/L1Co5kPoshRvyvF1eWgyv9mWhopWdRr/fRTf7hQt1t6/1NZBCSegJ+UF2g
         Vpk/nWVbuBLsrwcsG7BRIQMc6WxrW2nezDruoocdBWQ11+vLmuJInBkXDcoYmbRPXG4h
         hcGP7al3egGdK+c8rL7/sBOIZ1ER8x/Cpb63A5wjhaCqjjDrKoyirQdJP+OGbNhL/ytP
         1NdQ==
X-Gm-Message-State: AOAM530FMywxX5K+jffGtbrc76UgiVxXH7Ibmx1CF3pAbdN5ZBv4bz3I
        yZjukaq+fQM7h1kmMakmd0osIqzrQkdNpJTXPSk=
X-Google-Smtp-Source: ABdhPJzfbZNuQ24oj/IbRhwz5VVFSzob3RDgay6MXgeZTuyPfwNUqu7QRyHY+WjpuSo4eoDsyxQebCkk3u3qwldIH24=
X-Received: by 2002:a05:6000:18c5:b0:207:ac0d:f32 with SMTP id
 w5-20020a05600018c500b00207ac0d0f32mr789629wrq.574.1651269612858; Fri, 29 Apr
 2022 15:00:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220429215324.3729441-1-dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429215324.3729441-1-dmitry.baryshkov@linaro.org>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 29 Apr 2022 15:00:02 -0700
Message-ID: <CAF6AEGu+Ve1i_WHwcyXkGZKnv0aOiQNW7NCv=ToDpoorsn=TgA@mail.gmail.com>
Subject: Re: [PATCH v2] MAINTAINERS: Add Dmitry as MSM DRM driver co-maintainer
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 2:53 PM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> For the past several releases I have been assisting Rob by writing,
> collecting, testing and integrating patches for non-GPU and non-core
> parts of MSM DRM driver, while Rob is more interested in improving the
> GPU-related part. Let's note this in the MAINTAINERS file.
>
> While we are at it, per Rob's suggestion let's also promote Abhinav
> Kumar to M: (as he is actively working on the driver) and switch Sean
> Paul to R: (since he isn't doing much on msm these days).
>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

Acked-by: Rob Clark <robdclark@gmail.com>

> ---
>  MAINTAINERS | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 61d9f114c37f..782934f318d4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6254,8 +6254,9 @@ F:        drivers/gpu/drm/tiny/panel-mipi-dbi.c
>
>  DRM DRIVER FOR MSM ADRENO GPU
>  M:     Rob Clark <robdclark@gmail.com>
> -M:     Sean Paul <sean@poorly.run>
> -R:     Abhinav Kumar <quic_abhinavk@quicinc.com>
> +M:     Abhinav Kumar <quic_abhinavk@quicinc.com>
> +M:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> +R:     Sean Paul <sean@poorly.run>
>  L:     linux-arm-msm@vger.kernel.org
>  L:     dri-devel@lists.freedesktop.org
>  L:     freedreno@lists.freedesktop.org
> --
> 2.35.1
>
