Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 510B95AF332
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 19:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiIFR5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 13:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiIFR5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 13:57:36 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B44BDA2227
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 10:57:31 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-11eab59db71so29992842fac.11
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 10:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=DcuJjcKS4jJbXVMP5Wd0b50SSm9sdjry/1ptymv2bdU=;
        b=mtxBBWiGaGJBp8Ti1daeCE+qJm1BxX2aMbndG9r1JX4kRoCk1yPCWquN4cnFe+CkoJ
         AXyHZwZFu2PFmgYuOgXQ5lQRwbyX9E0LVJhfk0aDfHyF+inRT6rX6fPrv4xMU8ij1d7y
         Pav9Lnxx8SKdXT7iqiaPL4TsHmePP0lw2xkHu04rvgyCEkqmrvKNfbaDAbrmmoRPysm7
         7/2QY+I38SHoGWbpQ+SV31NECre/optPr//HbaOf8Yb6S/Zrf+bEq8ynxl5OgWSMhBK1
         4HepHBATEiXGtR74+RIIl3AzkbE/gLqcjh2P26rMy6Gzs/y4fdtMqPN1dcJoOqYUB3dp
         X/Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=DcuJjcKS4jJbXVMP5Wd0b50SSm9sdjry/1ptymv2bdU=;
        b=WN3ObYXq1KrJfqqTIFUJh9BLs/H/Nlw9sEy5xIqKRC+PEWANMCdo6TxHsdMPU1pvB8
         8l5E67IjdWz+2aAuMOEZ3PGIo36AKClTzFRL5CfIpwqR0Ic24JSCR6v7r62UZASBrPT+
         88rYjnqr568Pku8lfn+s41zESjbCAACPpYG5MJxtmA9u4mhHwF0b289cjA/OlKmwFg8g
         jTTxbhsIVCw2Lpfj5Z+6Qc6i3miwEE3OZmuC2aTAPiZCrSfu2jx7lf+L6qL0Pj5qZ9r5
         jJP8CMTki+9q0O15XinB52/Mmj+rJrBQcSTW8zWgPwuudYgRArk+LwkTffNAKQIqX7dO
         4cYg==
X-Gm-Message-State: ACgBeo1rA26tMV1rfMnvMUO+nR0OHfP3XFUX+WlNzexwofeTR5feRwkb
        upxs3sR5HGarN6XXCBqvsgGMFBf7nFzlb6pqiFg=
X-Google-Smtp-Source: AA6agR6AUNJUTifY94FATZjSANwKer+WpsUtUrhyJOiyHo9njJyR4t4VsApgP9RwWmHSjS8KV9G2Du7GW18pi6z2pgg=
X-Received: by 2002:a05:6870:3484:b0:11e:4465:3d9b with SMTP id
 n4-20020a056870348400b0011e44653d9bmr12911245oah.46.1662487049675; Tue, 06
 Sep 2022 10:57:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220404213040.12912-1-rdunlap@infradead.org> <68961bab-6448-9a98-8916-9c3cb0c5d020@amd.com>
 <e61a6903-550d-df70-6297-f49cc2750244@infradead.org> <ddde170c-7f2c-d9bc-7044-4c609bc915b5@amd.com>
In-Reply-To: <ddde170c-7f2c-d9bc-7044-4c609bc915b5@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 6 Sep 2022 13:57:18 -0400
Message-ID: <CADnq5_NEgVxjAOgvire32K1=PTGzHcs3GL9BqhmQCqq3EBzVDA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/scheduler: quieten kernel-doc warnings
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>, Jiawei Gu <Jiawei.Gu@amd.com>,
        dri-devel@lists.freedesktop.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nayan Deshmukh <nayan26deshmukh@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
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

On Tue, Sep 6, 2022 at 1:38 PM Andrey Grodzovsky
<andrey.grodzovsky@amd.com> wrote:
>
> I RBed, see bellow.

Can you push the patch to drm-misc?

Alex

>
> Andrey
>
> On 2022-08-31 14:34, Randy Dunlap wrote:
> > ping?
> >
> > On 4/4/22 14:58, Andrey Grodzovsky wrote:
> >> Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >> Andrey
> >>
> >> On 2022-04-04 17:30, Randy Dunlap wrote:
> >>> Fix kernel-doc warnings in gpu_scheduler.h and sched_main.c.
> >>>
> >>> Quashes these warnings:
> >>>
> >>> include/drm/gpu_scheduler.h:332: warning: missing initial short descr=
iption on line:
> >>>    * struct drm_sched_backend_ops
> >>> include/drm/gpu_scheduler.h:412: warning: missing initial short descr=
iption on line:
> >>>    * struct drm_gpu_scheduler
> >>> include/drm/gpu_scheduler.h:461: warning: Function parameter or membe=
r 'dev' not described in 'drm_gpu_scheduler'
> >>>
> >>> drivers/gpu/drm/scheduler/sched_main.c:201: warning: missing initial =
short description on line:
> >>>    * drm_sched_dependency_optimized
> >>> drivers/gpu/drm/scheduler/sched_main.c:995: warning: Function paramet=
er or member 'dev' not described in 'drm_sched_init'
> >>>
> >>> Fixes: 2d33948e4e00 ("drm/scheduler: add documentation")
> >>> Fixes: 8ab62eda177b ("drm/sched: Add device pointer to drm_gpu_schedu=
ler")
> >>> Fixes: 542cff7893a3 ("drm/sched: Avoid lockdep spalt on killing a pro=
cesses")
> >>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> >>> Cc: David Airlie <airlied@linux.ie>
> >>> Cc: Daniel Vetter <daniel@ffwll.ch>
> >>> Cc: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
> >>> Cc: Nayan Deshmukh <nayan26deshmukh@gmail.com>
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Cc: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> Cc: Jiawei Gu <Jiawei.Gu@amd.com>
> >>> Cc: dri-devel@lists.freedesktop.org
> >>> Acked-by: Christian K=C3=B6nig <christian.koenig@amd.com>
> >>> ---
> >>> Feel free to make changes or suggest changes...
> >>>
> >>> v2: drop @work description (already done by Andrey)
> >>>
> >>>    drivers/gpu/drm/scheduler/sched_main.c |    3 ++-
> >>>    include/drm/gpu_scheduler.h            |    9 +++++----
> >>>    2 files changed, 7 insertions(+), 5 deletions(-)
> >>>
> >>> --- linux-next-20220404.orig/drivers/gpu/drm/scheduler/sched_main.c
> >>> +++ linux-next-20220404/drivers/gpu/drm/scheduler/sched_main.c
> >>> @@ -198,7 +198,7 @@ static void drm_sched_job_done_cb(struct
> >>>    }
> >>>      /**
> >>> - * drm_sched_dependency_optimized
> >>> + * drm_sched_dependency_optimized - test if the dependency can be op=
timized
> >>>     *
> >>>     * @fence: the dependency fence
> >>>     * @entity: the entity which depends on the above fence
> >>> @@ -984,6 +984,7 @@ static int drm_sched_main(void *param)
> >>>     *        used
> >>>     * @score: optional score atomic shared with other schedulers
> >>>     * @name: name used for debugging
> >>> + * @dev: target &struct device
> >>>     *
> >>>     * Return 0 on success, otherwise error code.
> >>>     */
> >>> --- linux-next-20220404.orig/include/drm/gpu_scheduler.h
> >>> +++ linux-next-20220404/include/drm/gpu_scheduler.h
> >>> @@ -328,10 +328,10 @@ enum drm_gpu_sched_stat {
> >>>    };
> >>>      /**
> >>> - * struct drm_sched_backend_ops
> >>> + * struct drm_sched_backend_ops - Define the backend operations
> >>> + *    called by the scheduler
> >>>     *
> >>> - * Define the backend operations called by the scheduler,
> >>> - * these functions should be implemented in driver side.
> >>> + * These functions should be implemented in the driver side.
> >>>     */
> >>>    struct drm_sched_backend_ops {
> >>>        /**
> >>> @@ -408,7 +408,7 @@ struct drm_sched_backend_ops {
> >>>    };
> >>>      /**
> >>> - * struct drm_gpu_scheduler
> >>> + * struct drm_gpu_scheduler - scheduler instance-specific data
> >>>     *
> >>>     * @ops: backend operations provided by the driver.
> >>>     * @hw_submission_limit: the max size of the hardware queue.
> >>> @@ -434,6 +434,7 @@ struct drm_sched_backend_ops {
> >>>     * @_score: score used when the driver doesn't provide one
> >>>     * @ready: marks if the underlying HW is ready to work
> >>>     * @free_guilty: A hit to time out handler to free the guilty job.
> >>> + * @dev: system &struct device
> >>>     *
> >>>     * One scheduler is implemented for each hardware ring.
> >>>     */
