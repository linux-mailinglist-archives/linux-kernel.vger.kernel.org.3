Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99289572146
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 18:44:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbiGLQo1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 12:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiGLQoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 12:44:23 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA02E111B;
        Tue, 12 Jul 2022 09:44:20 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so5153639wmb.3;
        Tue, 12 Jul 2022 09:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ifJdjMfhd2iKk/La1sz317DTxpZaVFErLsB8EAQCqWU=;
        b=buHV1961ijmLk+EpDYD/b3kQlIAzwXwGHkrSa+qr3YJD8K0JOQTBH18npKu2UAxJI9
         if6nRVZTEsq/N1LXwqAzDW3chSsMT76XzXAV3nIoNRlEvtaMnYamL/Th/dLMoQ/+FKgy
         DuD2ZFZKJ0h6Vk6nl/30AkDRlp+myyLiNQ5J7bbsbS977XiH38IjxU2IBB9+idJTNIlK
         eorXwQ+wZXNQBzGP7DTp0ICtHSXHz2LbwPYgpmC5WYZcErPp4UFOjrr6ZA6k/ncGseGj
         mhc0m97E9Jcq8Z+LwxTMT/NTS3QBA8gVrwg6F685n7+WmKsLURlmnXGApQ8LEn/Bsi+X
         BgBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ifJdjMfhd2iKk/La1sz317DTxpZaVFErLsB8EAQCqWU=;
        b=pHnV+E5fq58gaP03JMiP6YxP7RHD6ewQ883kLEOpVJJBkLKwLCickek5w7qqtz30r9
         7wQcNvN7Jvq9DU7bhDEB2zUsTUlZBZ/Hf8KwYuJtGNkmq67kdL/W+MdhS86pJpuMTUlM
         SNKuafkrmlHQrK1oRFnVww5h8BuxoxonTYdk6AssyP78ajN5dV+oDJ4k5FHOaQu9CzHF
         galRGTr//rF/J7LmnOgJMS+91MYWD3Ro8YQoV8XO3Yq4gKe37u/i1MKONJ2Z+CiU4EZT
         N9O1CP4DqZZXn2JcWVjsPL+FNY3z94U+/NZ5yKRLx90dfOC66/gwHjDdI2vCTY+z7VYq
         FvbA==
X-Gm-Message-State: AJIora9cWIvXO4ccSUwrMX2sL2FPU9wdALcOvlGtB7NAwA4bnfqRgKAr
        d5RO9vruf/GqAUY6KL909RNHpFZwj5/60ah6tmY=
X-Google-Smtp-Source: AGRyM1uF+nw1gsr9kC8U/QPMlY+svjw4dZlywScEVKJHQeUujCWzemXKgKo0sXo6LZbNZ/jGNbp/rV8RVM2souj65kk=
X-Received: by 2002:a05:600c:4f83:b0:3a1:7310:62e7 with SMTP id
 n3-20020a05600c4f8300b003a1731062e7mr5133866wmq.84.1657644258936; Tue, 12 Jul
 2022 09:44:18 -0700 (PDT)
MIME-Version: 1.0
References: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220709112837.v2.3.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
 <CAD=FV=U=J+yf6Qu0VgJ8A5Lhs_s8Fszw=Oa0XUny5XT-5z56xQ@mail.gmail.com> <1299312f-e614-e4e2-72cb-fd7fb99922ce@quicinc.com>
In-Reply-To: <1299312f-e614-e4e2-72cb-fd7fb99922ce@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Tue, 12 Jul 2022 09:44:35 -0700
Message-ID: <CAF6AEGvjD3LRm40mPr4n+jzx71WmwYpVWizUDLct9cgafjFRyw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v2 3/7] drm/msm: Fix cx collapse issue during recovery
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>
Cc:     Doug Anderson <dianders@chromium.org>, Sean Paul <sean@poorly.run>,
        Jonathan Marek <jonathan@marek.ca>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        freedreno <freedreno@lists.freedesktop.org>,
        Chia-I Wu <olvaffe@gmail.com>,
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

On Mon, Jul 11, 2022 at 10:05 PM Akhil P Oommen
<quic_akhilpo@quicinc.com> wrote:
>
> On 7/12/2022 4:52 AM, Doug Anderson wrote:
> > Hi,
> >
> > On Fri, Jul 8, 2022 at 11:00 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >> There are some hardware logic under CX domain. For a successful
> >> recovery, we should ensure cx headswitch collapses to ensure all the
> >> stale states are cleard out. This is especially true to for a6xx family
> >> where we can GMU co-processor.
> >>
> >> Currently, cx doesn't collapse due to a devlink between gpu and its
> >> smmu. So the *struct gpu device* needs to be runtime suspended to ensure
> >> that the iommu driver removes its vote on cx gdsc.
> >>
> >> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >> ---
> >>
> >> (no changes since v1)
> >>
> >>   drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 16 ++++++++++++++--
> >>   drivers/gpu/drm/msm/msm_gpu.c         |  2 --
> >>   2 files changed, 14 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> index 4d50110..7ed347c 100644
> >> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >> @@ -1278,8 +1278,20 @@ static void a6xx_recover(struct msm_gpu *gpu)
> >>           */
> >>          gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
> >>
> >> -       gpu->funcs->pm_suspend(gpu);
> >> -       gpu->funcs->pm_resume(gpu);
> >> +       /*
> >> +        * Now drop all the pm_runtime usage count to allow cx gdsc to collapse.
> >> +        * First drop the usage count from all active submits
> >> +        */
> >> +       for (i = gpu->active_submits; i > 0; i--)
> >> +               pm_runtime_put(&gpu->pdev->dev);
> >> +
> >> +       /* And the final one from recover worker */
> >> +       pm_runtime_put_sync(&gpu->pdev->dev);
> >> +
> >> +       for (i = gpu->active_submits; i > 0; i--)
> >> +               pm_runtime_get(&gpu->pdev->dev);
> >> +
> >> +       pm_runtime_get_sync(&gpu->pdev->dev);
> > In response to v1, Rob suggested pm_runtime_force_suspend/resume().
> > Those seem like they would work to me, too. Why not use them?
> Quoting my previous response which I seem to have sent only to Freedreno
> list:
>
> "I believe it is supposed to be used only during system sleep state
> transitions. Btw, we don't want pm_runtime_get() calls from elsewhere to
> fail by disabling RPM here."

The comment about not wanting other runpm calls to fail is valid.. but
that is also solveable, ie. by holding a lock around runpm calls.
Which I think we need to do anyways, otherwise looping over
gpu->active_submits is racey..

I think pm_runtime_force_suspend/resume() is the least-bad option.. or
at least I'm not seeing any obvious alternative that is better

BR,
-R
