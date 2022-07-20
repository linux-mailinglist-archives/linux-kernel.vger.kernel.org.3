Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99E1057BD62
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 20:06:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237616AbiGTSG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233387AbiGTSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 14:06:26 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 143CE3AB12;
        Wed, 20 Jul 2022 11:06:25 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h8so4515209wrw.1;
        Wed, 20 Jul 2022 11:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XGKnzbMlHj8GUec+IENgeIL+e8Iozm5CYX6A25Jtb4=;
        b=PrnMQ8vHhngi5J7j1BVnxFKb/74czR3F267cpgzjf2pGO01ccscPJKZpsuemgRg4hU
         pwDFIuAaoXfu1Tdzl2yHqgVe3j6kt329wRISAkepEa/JFWEUmtURCyLULIB/tej25wR0
         Eho9ym6aP5W8rc4DluksS5/iy0SnNdXMWxRXGOR3/7e7vd+cOWgMo4uAYetQqGAN90Wz
         ICdZ9YqX7fH2AapH+RQpbffvOWJMQxkjknb0Aa9pNUoVuxrznuiQX1iaW9yd8rMUgxsy
         v1NSzr85Ua55QoNfQaFS/FEpMTx7vPZtxyeAveL37xKUP/+25dMgcuuYoIJAEeDLNJfI
         raqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XGKnzbMlHj8GUec+IENgeIL+e8Iozm5CYX6A25Jtb4=;
        b=3W8aVWa6DjMSODWj2IqM4ITF68pBjWlJ2/27rzFAKjDCNxjnBlc6wklMqK2kPua8gI
         r0JwxfkFNO9/uz91lbpA1RRGvvX9svwKnTYOGMn32xl1WrnLilKhJHWAQxv+t9urzIZB
         5fcyIcX+c8SPAXaAcDuf9TBaVVr29N/oV9HCM5DgoNJyiM88HSUMZkOUhz+UC8Z50HHV
         hkNuwbeh3ZxSgCwIuYZN3GmN9S1qoT00hXWGdFdGsOn0h3k7Oj3p9lMU4sfXgbIMUolC
         VooG7X8mGTiROxMXYN3FxliBB1fF3MCwjso/o6pKGEX+3IIiS/QSYSo4rljjGWZxXKCh
         slvA==
X-Gm-Message-State: AJIora+CI55ooYRHhkVeNzxeg1apazwpSUhroeYCARqDv1RickPa/Ki6
        XOdo+GiVQuKw/OhLPK2RfQyzy+PSCe8KfXrNDC0=
X-Google-Smtp-Source: AGRyM1uV3du6LMb0MF9Xsx7pwJt117rZWWe6Qxgvs8U23ehNnT/6d9KIkiaDDj5Pq81JRm5DrR/zwX1CLQj32uOhIVo=
X-Received: by 2002:adf:e187:0:b0:21d:64c6:74f0 with SMTP id
 az7-20020adfe187000000b0021d64c674f0mr30710994wrb.221.1658340383459; Wed, 20
 Jul 2022 11:06:23 -0700 (PDT)
MIME-Version: 1.0
References: <1657346375-1461-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220709112837.v2.3.I4ac27a0b34ea796ce0f938bb509e257516bc6f57@changeid>
 <CAD=FV=U=J+yf6Qu0VgJ8A5Lhs_s8Fszw=Oa0XUny5XT-5z56xQ@mail.gmail.com>
 <1299312f-e614-e4e2-72cb-fd7fb99922ce@quicinc.com> <CAF6AEGvjD3LRm40mPr4n+jzx71WmwYpVWizUDLct9cgafjFRyw@mail.gmail.com>
 <3c150bc9-68a0-7a35-6511-f80a42e8945b@quicinc.com>
In-Reply-To: <3c150bc9-68a0-7a35-6511-f80a42e8945b@quicinc.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Wed, 20 Jul 2022 11:06:45 -0700
Message-ID: <CAF6AEGsQqE+5iE-=ja96wS6EMN1K1PzCa2fRA6DvQWwyqBq3NA@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 12, 2022 at 12:15 PM Akhil P Oommen
<quic_akhilpo@quicinc.com> wrote:
>
> On 7/12/2022 10:14 PM, Rob Clark wrote:
> > On Mon, Jul 11, 2022 at 10:05 PM Akhil P Oommen
> > <quic_akhilpo@quicinc.com> wrote:
> >> On 7/12/2022 4:52 AM, Doug Anderson wrote:
> >>> Hi,
> >>>
> >>> On Fri, Jul 8, 2022 at 11:00 PM Akhil P Oommen <quic_akhilpo@quicinc.com> wrote:
> >>>> There are some hardware logic under CX domain. For a successful
> >>>> recovery, we should ensure cx headswitch collapses to ensure all the
> >>>> stale states are cleard out. This is especially true to for a6xx family
> >>>> where we can GMU co-processor.
> >>>>
> >>>> Currently, cx doesn't collapse due to a devlink between gpu and its
> >>>> smmu. So the *struct gpu device* needs to be runtime suspended to ensure
> >>>> that the iommu driver removes its vote on cx gdsc.
> >>>>
> >>>> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> >>>> ---
> >>>>
> >>>> (no changes since v1)
> >>>>
> >>>>    drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 16 ++++++++++++++--
> >>>>    drivers/gpu/drm/msm/msm_gpu.c         |  2 --
> >>>>    2 files changed, 14 insertions(+), 4 deletions(-)
> >>>>
> >>>> diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>> index 4d50110..7ed347c 100644
> >>>> --- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>> +++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
> >>>> @@ -1278,8 +1278,20 @@ static void a6xx_recover(struct msm_gpu *gpu)
> >>>>            */
> >>>>           gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_GMU_PWR_COL_KEEPALIVE, 0);
> >>>>
> >>>> -       gpu->funcs->pm_suspend(gpu);
> >>>> -       gpu->funcs->pm_resume(gpu);
> >>>> +       /*
> >>>> +        * Now drop all the pm_runtime usage count to allow cx gdsc to collapse.
> >>>> +        * First drop the usage count from all active submits
> >>>> +        */
> >>>> +       for (i = gpu->active_submits; i > 0; i--)
> >>>> +               pm_runtime_put(&gpu->pdev->dev);
> >>>> +
> >>>> +       /* And the final one from recover worker */
> >>>> +       pm_runtime_put_sync(&gpu->pdev->dev);
> >>>> +
> >>>> +       for (i = gpu->active_submits; i > 0; i--)
> >>>> +               pm_runtime_get(&gpu->pdev->dev);
> >>>> +
> >>>> +       pm_runtime_get_sync(&gpu->pdev->dev);
> >>> In response to v1, Rob suggested pm_runtime_force_suspend/resume().
> >>> Those seem like they would work to me, too. Why not use them?
> >> Quoting my previous response which I seem to have sent only to Freedreno
> >> list:
> >>
> >> "I believe it is supposed to be used only during system sleep state
> >> transitions. Btw, we don't want pm_runtime_get() calls from elsewhere to
> >> fail by disabling RPM here."
> > The comment about not wanting other runpm calls to fail is valid.. but
> > that is also solveable, ie. by holding a lock around runpm calls.
> > Which I think we need to do anyways, otherwise looping over
> > gpu->active_submits is racey..
> >
> > I think pm_runtime_force_suspend/resume() is the least-bad option.. or
> > at least I'm not seeing any obvious alternative that is better
> >
> > BR,
> > -R
> We are holding gpu->lock here which will block further submissions from
> scheduler. Will active_submits still race?
>
> It is possible that there is another thread which successfully completed
> pm_runtime_get() and while it access the hardware, we pulled the plug on
> regulator/clock here. That will result in obvious device crash. So I can
> think of 2 solutions:
>
> 1. wrap *every* pm_runtime_get/put with a mutex. Something like:
>              mutex_lock();
>              pm_runtime_get();
>              < ... access hardware here >>
>              pm_runtime_put();
>              mutex_unlock();
>
> 2. Drop runtime votes from every submit in recover worker and wait/poll
> for regulator to collapse in case there are transient votes on
> regulator  from other threads/subsystems.
>
> Option (2) seems simpler to me.  What do you think?
>

But I think without #1 you could still be racing w/ some other path
that touches the hw, like devfreq, right.  They could be holding a
runpm ref, so even if you loop over active_submits decrementing the
runpm ref, it still doesn't drop to zero

BR,
-R
