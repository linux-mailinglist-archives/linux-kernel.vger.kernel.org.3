Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EDEC4FF40B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 11:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbiDMJtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 05:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiDMJrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 05:47:40 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DB33BFAA
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:45:17 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-2ebf4b91212so15758807b3.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 02:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hSGkeFmhZfCY7bl7ojSYYAKHWJgwDxi7Ir4Ci3tcsLs=;
        b=EHhDC//D1WFuHO2mC3qY0H5LUeqIEu3S+UoBGhJBXAY9T75gVi03ZTpc6bpwcdOr8B
         FY4l8ChOfdKNhMYWjZjTk5egTQV2UDeLZ/ZiG/cEj1guH0XKT6s4JAxStva4dIG77o4N
         UBmjbmgVS3Olp9yG8Qm3xtJQ/96v9m4L9Ua20Nx2jh9Vcq24iZRV6md6Bjq0AcysSSQv
         dwqf1cAQhelarKL0mLJVtIFbFk76jkglip1+0k6qcZon7R5YBFCfwfFM/XbxMEJaXN0h
         0FzdpzvVOODTdh3woz94BbGj3lVQXLWfHQpu1TSkYkRL+QeWDbS36pluipt8gnF3eUux
         hZCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hSGkeFmhZfCY7bl7ojSYYAKHWJgwDxi7Ir4Ci3tcsLs=;
        b=tN9fq8Dm6/vT8QaWXbtmEQ5IN9L4poiPzg5zg3N+9KGY4dlbIH6wTGq1Z/HBIvdSEF
         OWbhpXBrt3mPouSRtWxP8Az+LV1MVvnBtwnTqSdWZlC34L6HwEb0/TUzSuBHpt/VhqNp
         6SjhuU1+rFJYsfAxxeEXezO5qXuS6ATEDYCuaX4Yso8UZKZ41ySI5Q6IMP6o05pu0R8/
         csA51O4DqIfj5CrvjpEMyK+JZLDBLT4HEbxS8f/IC7+GvBMFVGRmXx+j6a+FW2hYCDpG
         KvMhLDd0G09pZXH3jJHhhTWoSbxfl6SwAztuOrYlSPHuHygkwZ1UP58tvaOuGnig8QRt
         g1VQ==
X-Gm-Message-State: AOAM531xsI5YwsWM3Er8UhVdJsFBLx0NLiYIzRFh/I57sZ8LRZeGAq8J
        NgD2EOH0HCe68P+1JbvAlmnKmoOz5e0wAZNwhT0=
X-Google-Smtp-Source: ABdhPJwCc2DnthjLQRJgg14l5/s7mFdrjCmBRV3wTI5sXrdFwYYDbnc1nLlpoMNz+ntecEZNuhiP0XOW/t8xtziBpJY=
X-Received: by 2002:a81:1187:0:b0:2eb:ee1b:7d00 with SMTP id
 129-20020a811187000000b002ebee1b7d00mr18431819ywr.55.1649843116980; Wed, 13
 Apr 2022 02:45:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220411221536.283312-1-dmitry.osipenko@collabora.com>
 <064d8958-a288-64e1-b2a4-c2302a456d5b@amd.com> <a04733af-5ff1-a1b4-527d-68b28a037231@collabora.com>
 <f6de2b9a-005f-d1f5-9818-cfbee2bdddc5@amd.com> <CAK4VdL3VOtVGi36SY0TEL4P2jW33dM4TOmFXYmewE7cGNhY4Zw@mail.gmail.com>
 <7f0d7ade-1d59-2c43-c1b2-1fa847eb741a@collabora.com>
In-Reply-To: <7f0d7ade-1d59-2c43-c1b2-1fa847eb741a@collabora.com>
From:   Erico Nunes <nunes.erico@gmail.com>
Date:   Wed, 13 Apr 2022 11:45:05 +0200
Message-ID: <CAK4VdL1b3i4fddp00o6ZLbnK1-5ehoyyYtEhGx8t1DAQmBj=dA@mail.gmail.com>
Subject: Re: [PATCH v1] drm/scheduler: Don't kill jobs in interrupt context
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        Rob Herring <robh@kernel.org>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Rob Clark <robdclark@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Qiang Yu <yuq825@gmail.com>
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

On Wed, Apr 13, 2022 at 8:05 AM Dmitry Osipenko
<dmitry.osipenko@collabora.com> wrote:
>
> On 4/13/22 01:59, Erico Nunes wrote:
> > On Tue, Apr 12, 2022 at 9:41 PM Andrey Grodzovsky
> > <andrey.grodzovsky@amd.com> wrote:
> >>
> >>
> >> On 2022-04-12 14:20, Dmitry Osipenko wrote:
> >>> On 4/12/22 19:51, Andrey Grodzovsky wrote:
> >>>> On 2022-04-11 18:15, Dmitry Osipenko wrote:
> >>>>> Interrupt context can't sleep. Drivers like Panfrost and MSM are taking
> >>>>> mutex when job is released, and thus, that code can sleep. This results
> >>>>> into "BUG: scheduling while atomic" if locks are contented while job is
> >>>>> freed. There is no good reason for releasing scheduler's jobs in IRQ
> >>>>> context, hence use normal context to fix the trouble.
> >>>>
> >>>> I am not sure this is the beast Idea to leave job's sw fence signalling
> >>>> to be
> >>>> executed in system_wq context which is prone to delays of executing
> >>>> various work items from around the system. Seems better to me to leave the
> >>>> fence signaling within the IRQ context and offload only the job freeing or,
> >>>> maybe handle rescheduling to thread context within drivers implemention
> >>>> of .free_job cb. Not really sure which is the better.
> >>> We're talking here about killing jobs when driver destroys context,
> >>> which doesn't feel like it needs to be a fast path. I could move the
> >>> signalling into drm_sched_entity_kill_jobs_cb() and use unbound wq, but
> >>> do we really need this for a slow path?
> >>
> >>
> >> You can't move the signaling back to drm_sched_entity_kill_jobs_cb
> >> since this will bring back the lockdep splat that 'drm/sched: Avoid
> >> lockdep spalt on killing a processes'
> >> was fixing.
> >>
> >> I see your point and i guess we can go this way too. Another way would
> >> be to add to
> >> panfrost and msm job a  work_item and reschedule to thread context from
> >> within their
> >> .free_job callbacks but that probably to cumbersome to be justified here.
> >
> > FWIW since this mentioned individual drivers, commit 'drm/sched: Avoid
> > lockdep spalt on killing a processes' also introduced problems for
> > lima.
> > There were some occurrences in our CI
> > https://gitlab.freedesktop.org/mesa/mesa/-/jobs/20980982/raw .
> > Later I found it also reproducible on normal usage when just closing
> > applications, so it may be affecting users too.
> >
> > I tested this patch and looks like it fixes things for lima.
>
> This patch indeed should fix that lima bug. Feel free to give yours
> tested-by :)

Sure:
Tested-by: Erico Nunes <nunes.erico@gmail.com>

Thanks

Erico
