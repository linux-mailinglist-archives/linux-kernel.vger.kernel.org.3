Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A629A4DDEC7
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 17:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238960AbiCRQY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 12:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239025AbiCRQX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 12:23:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C8C8F9A2;
        Fri, 18 Mar 2022 09:20:02 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id u10so12377263wra.9;
        Fri, 18 Mar 2022 09:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u0HCPymtXblIB+cZc09PIw1aKsO6ejAhOpetsA4QzYg=;
        b=HsS8bf4hFr1h53r1GWW5J7P80c2rigF1ZXd1iqF5XPOsMXq6p4ok6Sn2H3x7cUexPv
         YABq8nJvMpMu/YHEMd143F6Qp5fA4nP7ubMhCEOPXswql4pg7XkYAMKHiv7rl+pDoZWx
         H0bO0FDj3TAj6uKTbqplAHlMjsd1f+IEw2ZN38QxEypKSTFEkQEJ53OjC6bu5nL7r56L
         Q1pPMFjEB8OhRlo6aBuSvQ2ffSBXMm5ZskqqZUxpIbkn/hYc62OjFPO0+xXgPsEu/sf8
         Jbf18oIGb/IAdnQdYoeDEK01G6VXumHILoRrEZuQIhV6NkpZvGur8FIbJwWyBxMxx94s
         MNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u0HCPymtXblIB+cZc09PIw1aKsO6ejAhOpetsA4QzYg=;
        b=rYwVa/WYKSJwD3jxLNKPbY+Jf92HjCz7L2VlavW7g3/J6Ts2IRwWJ0VnSTEMV5JSjF
         KBtYnkHJT1lh69GSqPhjGYF45JEPSB+Np1Sq7LfqclzySRiNqNWwP3a9sGlmxW33KgaW
         3Ozc7zTapmPoc2Wu/afV/t+bwy4BS1YKIOAXmdq+vLsKeONKlGpS0Fu23dUKtnIhZfzP
         R0QF7eyKQ3P+kxjK0u+8+qBL2Dr5L8c+KNaxEjdP2bkQVIaYF61lBmU/tCkqxyF68nEB
         coaDQmi9MaGH5AlBMH0jFATkHW1/sleLwdbK4kIuRktwrE14qYs9B22ywtsHRFEArWCX
         pT9A==
X-Gm-Message-State: AOAM533R/E36koBVCIdNymdpmziqQ+HXDLKMjPwwqzFsTuhJgb2IBWvn
        9v7/9/ke1aHRkjrM+88QzDRWK/ohzQM35zgRpek=
X-Google-Smtp-Source: ABdhPJxNnjhQkWgGh3BiZCURGeabRTHOG3URIEu48sVr5c+bgDz9d6ZlaTpPV7k9bDjxcXo9LX1ybNqvt19BuaGSvdU=
X-Received: by 2002:adf:914f:0:b0:1ed:bb92:d0cc with SMTP id
 j73-20020adf914f000000b001edbb92d0ccmr8615326wrj.297.1647620398559; Fri, 18
 Mar 2022 09:19:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234611.424743-1-robdclark@gmail.com> <20220310234611.424743-3-robdclark@gmail.com>
 <YjMGac4Hnjmg1wE8@phenom.ffwll.local> <3945551d-47d2-1974-f637-1dbc61e14702@amd.com>
 <CAF6AEGv36V8bLoDn5O1SW3iTUtzd3O1XeuT5gJxyLMxd1E-o3Q@mail.gmail.com>
 <865abcff-9f52-dca4-df38-b11189c739ff@amd.com> <CAF6AEGuoBeYoMTR6-KM9xGZ05XSSnSJWMDciawczi7qtiLN9Vw@mail.gmail.com>
 <915537e2-ac5b-ab0e-3697-2b16a9ec8f91@amd.com> <CAF6AEGsyFAOPmHqT7YX1wsukP4-gYAstCukr89r9w28V0YSCUw@mail.gmail.com>
 <3a475e5a-1090-e2f4-779c-6915fc8524b1@amd.com> <CAF6AEGtPrSdj=7AP1_puR+OgmL-qro0mWZDNngtaVPxpaCM76A@mail.gmail.com>
 <1c847474-8ee1-cc7e-3d4d-261a4e92fb2d@amd.com> <CAF6AEGuw45gi4f+mVs7cVyjCHY9O4N1O8OfuGHv-wAkzP3UpMA@mail.gmail.com>
 <dd7d3f20-8288-3a7c-a368-a08282746ff1@amd.com>
In-Reply-To: <dd7d3f20-8288-3a7c-a368-a08282746ff1@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 18 Mar 2022 09:20:37 -0700
Message-ID: <CAF6AEGvp+f4=EjQ9tWwcEafBEOAy6nCd8bOTqLXopiFhjx_Y_w@mail.gmail.com>
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
        open list <linux-kernel@vger.kernel.org>,
        "Alexander.Deucher@amd.com" <Alexander.Deucher@amd.com>
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

On Fri, Mar 18, 2022 at 9:04 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
>
> On 2022-03-17 16:35, Rob Clark wrote:
> > On Thu, Mar 17, 2022 at 12:50 PM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >>
> >> On 2022-03-17 14:25, Rob Clark wrote:
> >>> On Thu, Mar 17, 2022 at 11:10 AM Andrey Grodzovsky
> >>> <andrey.grodzovsky@amd.com> wrote:
> >>>> On 2022-03-17 13:35, Rob Clark wrote:
> >>>>> On Thu, Mar 17, 2022 at 9:45 AM Christian K=C3=B6nig
> >>>>> <christian.koenig@amd.com> wrote:
> >>>>>> Am 17.03.22 um 17:18 schrieb Rob Clark:
> >>>>>>> On Thu, Mar 17, 2022 at 9:04 AM Christian K=C3=B6nig
> >>>>>>> <christian.koenig@amd.com> wrote:
> >>>>>>>> Am 17.03.22 um 16:10 schrieb Rob Clark:
> >>>>>>>>> [SNIP]
> >>>>>>>>> userspace frozen !=3D kthread frozen .. that is what this patch=
 is
> >>>>>>>>> trying to address, so we aren't racing between shutting down th=
e hw
> >>>>>>>>> and the scheduler shoveling more jobs at us.
> >>>>>>>> Well exactly that's the problem. The scheduler is supposed to sh=
oveling
> >>>>>>>> more jobs at us until it is empty.
> >>>>>>>>
> >>>>>>>> Thinking more about it we will then keep some dma_fence instance
> >>>>>>>> unsignaled and that is and extremely bad idea since it can lead =
to
> >>>>>>>> deadlocks during suspend.
> >>>>>>> Hmm, perhaps that is true if you need to migrate things out of vr=
am?
> >>>>>>> It is at least not a problem when vram is not involved.
> >>>>>> No, it's much wider than that.
> >>>>>>
> >>>>>> See what can happen is that the memory management shrinkers want t=
o wait
> >>>>>> for a dma_fence during suspend.
> >>>>> we don't wait on fences in shrinker, only purging or evicting thing=
s
> >>>>> that are already ready.  Actually, waiting on fences in shrinker pa=
th
> >>>>> sounds like a pretty bad idea.
> >>>>>
> >>>>>> And if you stop the scheduler they will just wait forever.
> >>>>>>
> >>>>>> What you need to do instead is to drain the scheduler, e.g. call
> >>>>>> drm_sched_entity_flush() with a proper timeout for each entity you=
 have
> >>>>>> created.
> >>>>> yeah, it would work to drain the scheduler.. I guess that might be =
the
> >>>>> more portable approach as far as generic solution for suspend.
> >>>>>
> >>>>> BR,
> >>>>> -R
> >>>> I am not sure how this drains the scheduler ? Suppose we done the
> >>>> waiting in drm_sched_entity_flush,
> >>>> what prevents someone to push right away another job into the same
> >>>> entity's queue  right after that ?
> >>>> Shouldn't we first disable further pushing of jobs into entity befor=
e we
> >>>> wait for  sched->job_scheduled ?
> >>>>
> >>> In the system suspend path, userspace processes will have already bee=
n
> >>> frozen, so there should be no way to push more jobs to the scheduler,
> >>> unless they are pushed from the kernel itself.
> >>> amdgpu_device_suspend
> >>
> >> It was my suspicion but I wasn't sure about it.
> >>
> >>
> >>> We don't do that in
> >>> drm/msm, but maybe you need to to move things btwn vram and system
> >>> memory?
> >>
> >> Exactly, that was my main concern - if we use this method we have to u=
se
> >> it in a point in
> >> suspend sequence when all the in kernel job submissions activity alrea=
dy
> >> suspended
> >>
> >>> But even in that case, if the # of jobs you push is bounded I
> >>> guess that is ok?
> >> Submissions to scheduler entities are using unbounded queue, the bound=
ed
> >> part is when
> >> you extract next job from entity to submit to HW ring and it rejects i=
f
> >> submission limit reached (drm_sched_ready)
> >>
> >> In general - It looks to me at least that what we what we want her is
> >> more of a drain operation then flush (i.e.
> >> we first want to disable any further job submission to entity's queue
> >> and then flush all in flight ones). As example
> >> for this i was looking at  flush_workqueue vs. drain_workqueue
> > Would it be possible for amdgpu to, in the system suspend task,
> >
> > 1) first queue up all the jobs needed to migrate bos out of vram, and
> > whatever other housekeeping jobs are needed
> > 2) then drain gpu scheduler's queues
> > 3) and then finally wait for jobs executing on GPU to complete
>
>
> We already do most of it in amdgpu_device_suspend,
> amdgpu_device_ip_suspend_phase1
> followed by amdgpu_device_evict_resources followed by
> amdgpu_fence_driver_hw_fini is
> exactly steps 1 + 3. What we are missing is step 2). For this step I
> suggest adding a function
> called drm_sched_entity_drain which basically sets entity->stopped =3D
> true and then calls drm_sched_entity_flush.
> This will both reject any new insertions into entity's job queue and
> will flush all pending job submissions to HW from that entity.
> One point is we need to make make drm_sched_entity_push_job return value
> so the caller knows about job enqueue
> rejection.

Hmm, seems like job enqueue that is rejected because we are in the
process of suspending should be more of a WARN_ON() sort of thing?
Not sure if there is something sensible to do for the caller at that
point?

>
> What about runtime suspend ? I guess same issue with scheduler racing
> against HW susppend is relevant there ?

Runtime suspend should be ok, as long as the driver holds a runpm
reference whenever the hw needs to be awake.  The problem with system
suspend (at least if you are using pm_runtime_force_suspend() or doing
something equivalent) is that it bypasses the runpm reference.
(Which, IMO, seems like a bad design..)

> Also, could you point to a particular buggy scenario where the race
> between SW shceduler and suspend is causing a problem ?

I wrote a piglit test[1] to try to trigger this scenario.. it isn't
really that easy to hit

BR,
-R

[1] https://gitlab.freedesktop.org/mesa/piglit/-/merge_requests/643

> Andrey
>
>
> >
> > BR,
> > -R
> >
> >> Andrey
> >>
> >>
> >>> BR,
> >>> -R
