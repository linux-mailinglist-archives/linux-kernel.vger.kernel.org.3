Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEC4DCD86
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237424AbiCQS0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbiCQS0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:26:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3DA1D12E0;
        Thu, 17 Mar 2022 11:24:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h23so7919923wrb.8;
        Thu, 17 Mar 2022 11:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5WOWImhAUqDCpINz5GAMHG6O7lsNY7VMT01bdVagZWc=;
        b=aq6DxaZijrN5HrtIcyJc8/ndCbKMm4kjpXUP+iUT09yTZppIbKxEHZb/r7JKNq5AlX
         msy8fbXcZNH5bFBn0r1JrWF+4/zw+lpu9VNyrrMbKj76h1sJINSdXAeXLr5eFkKuIKt+
         ysbfM666oKJRhu/VnQNVuqjDaMjzJiXrmxA7/w6/2OMVjNIaWHgjgDG1RfP3MLc17E3X
         yLitqncP0ZG3GC9a+4ONnVrzyerUWaCH8v92bJd8l/mkZ3aLCliELsK2aPLaj64UmYyu
         BUelbuhAC707tKScoxuuav+bkU0e5MPdUgiWtsIRujlGk0By8c7wccwTEuaYkfnIUX5S
         Qrhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5WOWImhAUqDCpINz5GAMHG6O7lsNY7VMT01bdVagZWc=;
        b=cF7kjKPwBk2HEekKNutRV8TIs1YcqWaU2oszoXBR4TMpw3vSL+fZuat4sOsNPofFqL
         Oc7hSkyxWjSs/RA0kaog2oQQhXdo47+vibCO3e4e4H2qndvlnZm7VT1DL/wovuutXADq
         41bM0WW1nL9wSkZIBc1EgusgEsBJ/9cXk6/JSpdB2ZVMoMnL104EwW7+wd+RRvebigch
         Rtve00PAS0VNMIna2h13Wlz0eT4KiW+1+EVfQ3KwAMfF46fjA4uyhfEdZnM80xSfSLTh
         RSCMllBisiMw1iYSB1LypnbC7Bwc2iPbqKd9jhI0lQMLG9+Cyko36l0XRHhQEgDydbfR
         mYGQ==
X-Gm-Message-State: AOAM530gl8wGvNivQjQSXBnD+w7h890kXdBJSiHO+Lx7K7viNWNyW3hz
        dTK+7sdM9FQVrkNXaeu1/W+BN8hQEmSP5W3+XJDqc7Pe
X-Google-Smtp-Source: ABdhPJwnz53z1Rtn2kSyDL8yXaceWrJVmARz5BjG/m7nsW0MZePheVDYKySSeb2wxNNkLlOqQKGmpMyw2VSnnqTRnT8=
X-Received: by 2002:a05:6000:170c:b0:203:df21:742c with SMTP id
 n12-20020a056000170c00b00203df21742cmr5175530wrc.574.1647541489710; Thu, 17
 Mar 2022 11:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234611.424743-1-robdclark@gmail.com> <20220310234611.424743-3-robdclark@gmail.com>
 <YjMGac4Hnjmg1wE8@phenom.ffwll.local> <3945551d-47d2-1974-f637-1dbc61e14702@amd.com>
 <CAF6AEGv36V8bLoDn5O1SW3iTUtzd3O1XeuT5gJxyLMxd1E-o3Q@mail.gmail.com>
 <865abcff-9f52-dca4-df38-b11189c739ff@amd.com> <CAF6AEGuoBeYoMTR6-KM9xGZ05XSSnSJWMDciawczi7qtiLN9Vw@mail.gmail.com>
 <915537e2-ac5b-ab0e-3697-2b16a9ec8f91@amd.com> <CAF6AEGsyFAOPmHqT7YX1wsukP4-gYAstCukr89r9w28V0YSCUw@mail.gmail.com>
 <3a475e5a-1090-e2f4-779c-6915fc8524b1@amd.com>
In-Reply-To: <3a475e5a-1090-e2f4-779c-6915fc8524b1@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 17 Mar 2022 11:25:31 -0700
Message-ID: <CAF6AEGtPrSdj=7AP1_puR+OgmL-qro0mWZDNngtaVPxpaCM76A@mail.gmail.com>
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

On Thu, Mar 17, 2022 at 11:10 AM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
>
> On 2022-03-17 13:35, Rob Clark wrote:
> > On Thu, Mar 17, 2022 at 9:45 AM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Am 17.03.22 um 17:18 schrieb Rob Clark:
> >>> On Thu, Mar 17, 2022 at 9:04 AM Christian K=C3=B6nig
> >>> <christian.koenig@amd.com> wrote:
> >>>> Am 17.03.22 um 16:10 schrieb Rob Clark:
> >>>>> [SNIP]
> >>>>> userspace frozen !=3D kthread frozen .. that is what this patch is
> >>>>> trying to address, so we aren't racing between shutting down the hw
> >>>>> and the scheduler shoveling more jobs at us.
> >>>> Well exactly that's the problem. The scheduler is supposed to shovel=
ing
> >>>> more jobs at us until it is empty.
> >>>>
> >>>> Thinking more about it we will then keep some dma_fence instance
> >>>> unsignaled and that is and extremely bad idea since it can lead to
> >>>> deadlocks during suspend.
> >>> Hmm, perhaps that is true if you need to migrate things out of vram?
> >>> It is at least not a problem when vram is not involved.
> >> No, it's much wider than that.
> >>
> >> See what can happen is that the memory management shrinkers want to wa=
it
> >> for a dma_fence during suspend.
> > we don't wait on fences in shrinker, only purging or evicting things
> > that are already ready.  Actually, waiting on fences in shrinker path
> > sounds like a pretty bad idea.
> >
> >> And if you stop the scheduler they will just wait forever.
> >>
> >> What you need to do instead is to drain the scheduler, e.g. call
> >> drm_sched_entity_flush() with a proper timeout for each entity you hav=
e
> >> created.
> > yeah, it would work to drain the scheduler.. I guess that might be the
> > more portable approach as far as generic solution for suspend.
> >
> > BR,
> > -R
>
>
> I am not sure how this drains the scheduler ? Suppose we done the
> waiting in drm_sched_entity_flush,
> what prevents someone to push right away another job into the same
> entity's queue  right after that ?
> Shouldn't we first disable further pushing of jobs into entity before we
> wait for  sched->job_scheduled ?
>

In the system suspend path, userspace processes will have already been
frozen, so there should be no way to push more jobs to the scheduler,
unless they are pushed from the kernel itself.  We don't do that in
drm/msm, but maybe you need to to move things btwn vram and system
memory?  But even in that case, if the # of jobs you push is bounded I
guess that is ok?

BR,
-R
