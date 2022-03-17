Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 489784DCF67
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiCQUgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiCQUgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:36:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D67195331;
        Thu, 17 Mar 2022 13:34:44 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h15so8954928wrc.6;
        Thu, 17 Mar 2022 13:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oAJskbyEigMdhBrsDXA46H1CUC1pPQdTRwKfHPvXIas=;
        b=oEuQwf0ZJEDJhu8J1bZy27VFNh9RTbpoxCpXlLqPKAKn3B15kctg+ZElkzMvVNBO/G
         jmk1g9sEzQzLPFBeeHRtC+MLHsCsONYHw8KxMsxbw/qY9mwHI7Q/5RVrf2OeST4xfhag
         wrlEDUVW0IEWEnx/QLYdTzBzlCzzM9nOOKgnSVZuI32zuH1S88VOgiqgAfCB1gWIWbXV
         Dd2t5WHRu0OVM98lu12IpylTrtWrm23fZctxUrZ/MlRNg+8X96UkK8R3FgTaNGg6iHzd
         0XdTRSNq2ltJoZ+Rqh+TDQLhbfu2W4l9A3nFnQ1LprPdLMABczJYh4f5wcdegRfsYCxj
         NwaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oAJskbyEigMdhBrsDXA46H1CUC1pPQdTRwKfHPvXIas=;
        b=MsdbMf8f++Z839bIYfVEMtiLxE7Ulzw9Giu9LBTfU4wtruzvRvtUMHCYQLTut0qIqv
         tu/z3ciDCe5a5HXm5k2Yj5YcC0Rg5h3yDgme09HdhNaV3Ctrs9IVSDZA8i69gyhlJNyx
         OpE7hiX0Iluv7+YQHt9h6M7cMLklTOPWrR4WYQDw2E9nl8/U2GbeQ3jAVHM+0x9CRGmR
         znOGEsYj7krMIWCA1SgJ5aS2mLgADdhwuw6fyDYdEB3kLwA9TnvqeYHHvwmPKYs1izuZ
         U5yPURz3IOTBRiWtYpVnXeONlIVGp+MISHL3HUTuNpJ4tcKfK774N7CNVZiGbM1gWZRt
         5Yeg==
X-Gm-Message-State: AOAM531Dp9ehMeY8ZJHws9tEZZqGQ9TR33Lt9Zys7/yWPL9NT1kPQXSE
        wUj3izCHAqTh22LceRRfy5ZNVsw39fT3XgRNR1E=
X-Google-Smtp-Source: ABdhPJwz5D+6OUjG940PblL2Vpl7ISgIXGVQbVtLxJ7YGpXTqYORj6Uj/qjxIpnX1B77gaN0lujSYyp7JNozZoY/KaY=
X-Received: by 2002:a05:6000:170c:b0:203:df21:742c with SMTP id
 n12-20020a056000170c00b00203df21742cmr5544567wrc.574.1647549282639; Thu, 17
 Mar 2022 13:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234611.424743-1-robdclark@gmail.com> <20220310234611.424743-3-robdclark@gmail.com>
 <YjMGac4Hnjmg1wE8@phenom.ffwll.local> <3945551d-47d2-1974-f637-1dbc61e14702@amd.com>
 <CAF6AEGv36V8bLoDn5O1SW3iTUtzd3O1XeuT5gJxyLMxd1E-o3Q@mail.gmail.com>
 <865abcff-9f52-dca4-df38-b11189c739ff@amd.com> <CAF6AEGuoBeYoMTR6-KM9xGZ05XSSnSJWMDciawczi7qtiLN9Vw@mail.gmail.com>
 <915537e2-ac5b-ab0e-3697-2b16a9ec8f91@amd.com> <CAF6AEGsyFAOPmHqT7YX1wsukP4-gYAstCukr89r9w28V0YSCUw@mail.gmail.com>
 <3a475e5a-1090-e2f4-779c-6915fc8524b1@amd.com> <CAF6AEGtPrSdj=7AP1_puR+OgmL-qro0mWZDNngtaVPxpaCM76A@mail.gmail.com>
 <1c847474-8ee1-cc7e-3d4d-261a4e92fb2d@amd.com>
In-Reply-To: <1c847474-8ee1-cc7e-3d4d-261a4e92fb2d@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 17 Mar 2022 13:35:24 -0700
Message-ID: <CAF6AEGuw45gi4f+mVs7cVyjCHY9O4N1O8OfuGHv-wAkzP3UpMA@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/gpu: Park scheduler threads for system suspend
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        David Airlie <airlied@linux.ie>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Jonathan Marek <jonathan@marek.ca>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        open list <linux-kernel@vger.kernel.org>
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

On Thu, Mar 17, 2022 at 12:50 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
>
> On 2022-03-17 14:25, Rob Clark wrote:
> > On Thu, Mar 17, 2022 at 11:10 AM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >>
> >> On 2022-03-17 13:35, Rob Clark wrote:
> >>> On Thu, Mar 17, 2022 at 9:45 AM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>> Am 17.03.22 um 17:18 schrieb Rob Clark:
> >>>>> On Thu, Mar 17, 2022 at 9:04 AM Christian K=C3=B6nig
> >>>>> <christian.koenig@amd.com> wrote:
> >>>>>> Am 17.03.22 um 16:10 schrieb Rob Clark:
> >>>>>>> [SNIP]
> >>>>>>> userspace frozen !=3D kthread frozen .. that is what this patch i=
s
> >>>>>>> trying to address, so we aren't racing between shutting down the =
hw
> >>>>>>> and the scheduler shoveling more jobs at us.
> >>>>>> Well exactly that's the problem. The scheduler is supposed to shov=
eling
> >>>>>> more jobs at us until it is empty.
> >>>>>>
> >>>>>> Thinking more about it we will then keep some dma_fence instance
> >>>>>> unsignaled and that is and extremely bad idea since it can lead to
> >>>>>> deadlocks during suspend.
> >>>>> Hmm, perhaps that is true if you need to migrate things out of vram=
?
> >>>>> It is at least not a problem when vram is not involved.
> >>>> No, it's much wider than that.
> >>>>
> >>>> See what can happen is that the memory management shrinkers want to =
wait
> >>>> for a dma_fence during suspend.
> >>> we don't wait on fences in shrinker, only purging or evicting things
> >>> that are already ready.  Actually, waiting on fences in shrinker path
> >>> sounds like a pretty bad idea.
> >>>
> >>>> And if you stop the scheduler they will just wait forever.
> >>>>
> >>>> What you need to do instead is to drain the scheduler, e.g. call
> >>>> drm_sched_entity_flush() with a proper timeout for each entity you h=
ave
> >>>> created.
> >>> yeah, it would work to drain the scheduler.. I guess that might be th=
e
> >>> more portable approach as far as generic solution for suspend.
> >>>
> >>> BR,
> >>> -R
> >>
> >> I am not sure how this drains the scheduler ? Suppose we done the
> >> waiting in drm_sched_entity_flush,
> >> what prevents someone to push right away another job into the same
> >> entity's queue  right after that ?
> >> Shouldn't we first disable further pushing of jobs into entity before =
we
> >> wait for  sched->job_scheduled ?
> >>
> > In the system suspend path, userspace processes will have already been
> > frozen, so there should be no way to push more jobs to the scheduler,
> > unless they are pushed from the kernel itself.
>
>
> It was my suspicion but I wasn't sure about it.
>
>
> > We don't do that in
> > drm/msm, but maybe you need to to move things btwn vram and system
> > memory?
>
>
> Exactly, that was my main concern - if we use this method we have to use
> it in a point in
> suspend sequence when all the in kernel job submissions activity already
> suspended
>
> > But even in that case, if the # of jobs you push is bounded I
> > guess that is ok?
>
> Submissions to scheduler entities are using unbounded queue, the bounded
> part is when
> you extract next job from entity to submit to HW ring and it rejects if
> submission limit reached (drm_sched_ready)
>
> In general - It looks to me at least that what we what we want her is
> more of a drain operation then flush (i.e.
> we first want to disable any further job submission to entity's queue
> and then flush all in flight ones). As example
> for this i was looking at  flush_workqueue vs. drain_workqueue

Would it be possible for amdgpu to, in the system suspend task,

1) first queue up all the jobs needed to migrate bos out of vram, and
whatever other housekeeping jobs are needed
2) then drain gpu scheduler's queues
3) and then finally wait for jobs executing on GPU to complete

BR,
-R

> Andrey
>
>
> >
> > BR,
> > -R
