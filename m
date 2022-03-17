Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE8234DCC8F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 18:34:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236936AbiCQRgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 13:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236505AbiCQRgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 13:36:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EF2C748B;
        Thu, 17 Mar 2022 10:34:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id k8-20020a05600c1c8800b003899c7ac55dso3775253wms.1;
        Thu, 17 Mar 2022 10:34:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IELfzsVU/wZ7ht4rR86rM2gpBonGJDThNUGcKLGVsXM=;
        b=mS/mF26z2g6jRvaXO3oivJOR6aL0QS0imKt7OV668jL7lKlXy2pyb3R3n1Yd+tpN3M
         xJt00Lsh8EKat+SNZK5Z+bn7G+NKO3oFxtTPEFf3Uw+6EfDe1X+u9ArEH/6VN6icLWY3
         7fKqbiNSDNZVPJvo41IRx33V70LSzHAhiIIChZqTseukFZb/vEu3iYb6gv9HWkr6Aa41
         UXx88aOhL8Yis1PUCDFNTONVKZFRKl8JMEmKFX9YY9Vl264JMS1C6I4zYfqX0cSBHoLg
         ogeF5zeWlzHmpPY3NmQ68t2j+S+Nqei/fPw3e1/oG6gvKbjrJlJae/It6pWYl0RKNsji
         A1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IELfzsVU/wZ7ht4rR86rM2gpBonGJDThNUGcKLGVsXM=;
        b=3hw7qIJHvnszCVWWF2uUPDJZbDu+ZEyANaLQP7bQA07rV6JIsKW3yZUu6j7pf9Vtmr
         Powwdlwk/kthjwQ56dplcbPg8EpkIOtV4RHh5fr214rFuXJm6nCP6jIkRvazQ5Khtpl+
         QpbmN05PmJJXwYLEEkv+OYCvAGtYJHUINGoNlXRAlbS9KRjHj5BPoeaWuhiuQjGFRtoc
         YNRE2caICBlmrYn8e+FZzVfGQhX5RJRiAPLylkvIwG4JKrVrhIkx1SHwFXX3Qd6GXTaY
         t+yJ6DjaK4H2E8C8XYGHBrFG0Wvu3wK2vnM8nVw8A2d8qJTw7bGyeXfHHYRyzOeECbZU
         oRTw==
X-Gm-Message-State: AOAM5334tD9kiMYip24+gjrzom8MMjqaoLzqozrupgTbPz3bnwydEY28
        zsTHYvs2zzSfYc+/HSi48meVK1HELKY79enuQNg=
X-Google-Smtp-Source: ABdhPJzTfpFd8M5Xt44uoKu43Gt3h63iam3/mvcGzOYZWKbsOVzgolMeZrOa6ovX+WlSUY5RUDd0mD691DuXN+RfuvQ=
X-Received: by 2002:a7b:cc0d:0:b0:381:220e:a3a0 with SMTP id
 f13-20020a7bcc0d000000b00381220ea3a0mr5003576wmh.59.1647538482957; Thu, 17
 Mar 2022 10:34:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220310234611.424743-1-robdclark@gmail.com> <20220310234611.424743-3-robdclark@gmail.com>
 <YjMGac4Hnjmg1wE8@phenom.ffwll.local> <3945551d-47d2-1974-f637-1dbc61e14702@amd.com>
 <CAF6AEGv36V8bLoDn5O1SW3iTUtzd3O1XeuT5gJxyLMxd1E-o3Q@mail.gmail.com>
 <865abcff-9f52-dca4-df38-b11189c739ff@amd.com> <CAF6AEGuoBeYoMTR6-KM9xGZ05XSSnSJWMDciawczi7qtiLN9Vw@mail.gmail.com>
 <915537e2-ac5b-ab0e-3697-2b16a9ec8f91@amd.com>
In-Reply-To: <915537e2-ac5b-ab0e-3697-2b16a9ec8f91@amd.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Thu, 17 Mar 2022 10:35:24 -0700
Message-ID: <CAF6AEGsyFAOPmHqT7YX1wsukP4-gYAstCukr89r9w28V0YSCUw@mail.gmail.com>
Subject: Re: [PATCH 2/3] drm/msm/gpu: Park scheduler threads for system suspend
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
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

On Thu, Mar 17, 2022 at 9:45 AM Christian K=C3=B6nig
<christian.koenig@amd.com> wrote:
>
> Am 17.03.22 um 17:18 schrieb Rob Clark:
> > On Thu, Mar 17, 2022 at 9:04 AM Christian K=C3=B6nig
> > <christian.koenig@amd.com> wrote:
> >> Am 17.03.22 um 16:10 schrieb Rob Clark:
> >>> [SNIP]
> >>> userspace frozen !=3D kthread frozen .. that is what this patch is
> >>> trying to address, so we aren't racing between shutting down the hw
> >>> and the scheduler shoveling more jobs at us.
> >> Well exactly that's the problem. The scheduler is supposed to shovelin=
g
> >> more jobs at us until it is empty.
> >>
> >> Thinking more about it we will then keep some dma_fence instance
> >> unsignaled and that is and extremely bad idea since it can lead to
> >> deadlocks during suspend.
> > Hmm, perhaps that is true if you need to migrate things out of vram?
> > It is at least not a problem when vram is not involved.
>
> No, it's much wider than that.
>
> See what can happen is that the memory management shrinkers want to wait
> for a dma_fence during suspend.

we don't wait on fences in shrinker, only purging or evicting things
that are already ready.  Actually, waiting on fences in shrinker path
sounds like a pretty bad idea.

> And if you stop the scheduler they will just wait forever.
>
> What you need to do instead is to drain the scheduler, e.g. call
> drm_sched_entity_flush() with a proper timeout for each entity you have
> created.

yeah, it would work to drain the scheduler.. I guess that might be the
more portable approach as far as generic solution for suspend.

BR,
-R

> Regards,
> Christian.
>
> >
> >> So this patch here is an absolute clear NAK from my side. If amdgpu is
> >> doing something similar that is a severe bug and needs to be addressed
> >> somehow.
> > I think amdgpu's use of kthread_park is not related to suspend, but
> > didn't look too closely.
> >
> > And perhaps the solution for this problem is more complex in the case
> > of amdgpu, I'm not super familiar with the constraints there.  But I
> > think it is a fine solution for integrated GPUs.
> >
> > BR,
> > -R
> >
> >> Regards,
> >> Christian.
> >>
> >>> BR,
> >>> -R
> >>>
>
