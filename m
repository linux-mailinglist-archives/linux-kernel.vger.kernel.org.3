Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F059B4EF787
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344628AbiDAQEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:04:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349537AbiDAP6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 11:58:50 -0400
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 314666378
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 08:28:43 -0700 (PDT)
Received: by mail-ot1-x32a.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so2316120otq.13
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S2r7fRVo+SDwb9PoKS073Z4FNCpCz2xt1aUwpzgKYYE=;
        b=VQkzFQjH3jayS+KzQ35Yjy19gVTMDC5MhpUMAlAUbqNS+gkHfNtDagx0QxnpcMYPhP
         awCo+eQfv8LItW6p3o+iwtP1cspQrIlzDrS/CRxlfuXBbKHZlB2r9kJOd0h+LutBBaBI
         b3Av0UGhC/799+BGbTKFSReDC74hMAsPCwO49FGRMrUWoe8oAzaoQgM5IHpIX/wS/T8D
         UxhTxkpMvYMvpCTHEcn0MxF7JGSQOrGl0BAmMLFKC3QV5lxKETY+WRAjpccWUxWjTk7V
         hLEa/phzaj9Gb6PF7/RIquxPgKMyhNMfcioLDM2ZvRI64N78vfJCBMpXkI5CUorvReW0
         OhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S2r7fRVo+SDwb9PoKS073Z4FNCpCz2xt1aUwpzgKYYE=;
        b=aSa1CJzu0qOjds/qyMLmk6jJ8LhT0HtVEnxwzU/2mYgwvCobq9b3ea7hiOiLU92lz7
         ravTGSVOLCkf3bCp84ICGnU70KFeQz7TrVi3pPTfRyLZCxgcQBytI0j0U+VuijzcWNOm
         DuNlDsyYDFm6aCq9VY09MD18atWuhslMI6EpX2mwWtlY5FXJ4Nj1Bkk/tJylOS2uC11w
         UCTJBI4Dlb0Z12nwzc0rhrYLz1z9PvMZxqGs3iQIHsdpqpCZ8GF8IWOTAPQox0Plda49
         0vtyuZJnQwbJ0sUl/D08E6+ktp1RQ0cPJxEtlIFZWtSsEqz7Fi1O0sJ1j3lr4WVgWLq9
         moFA==
X-Gm-Message-State: AOAM530mgLOkTV5G88ZboWIYpnqBRpNgr3DS7fNW+dWX88ooY3AGCU3g
        YGkCt99Nyv+bQCZI9re7UIs1zoS8huhaA0wgfqQ=
X-Google-Smtp-Source: ABdhPJwWFucrD+Zmo2lOnzUOch/2fcBZJtQUF7mE2PyRD9jYXcM1O9tSChQwAW+/Cg6rugZ9hNTsc1NFq0pmQoySsKQ=
X-Received: by 2002:a05:6830:1552:b0:5cd:bc6e:62b1 with SMTP id
 l18-20020a056830155200b005cdbc6e62b1mr7783681otp.357.1648826922905; Fri, 01
 Apr 2022 08:28:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220324134031.2648315-1-shraash@google.com>
In-Reply-To: <20220324134031.2648315-1-shraash@google.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 1 Apr 2022 11:28:31 -0400
Message-ID: <CADnq5_NTkB3xrZnT44pCBXercCT7225V2Ui5XTKsY4H45EcXrA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amd/display: Fix unused-but-set-variable warning
To:     Aashish Sharma <shraash@google.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Meenakshikumar Somasundaram <meenakshikumar.somasundaram@amd.com>,
        Jake Wang <haonan.wang2@amd.com>,
        Anson Jacob <Anson.Jacob@amd.com>,
        Guenter Roeck <groeck@chromium.org>,
        kernel test robot <lkp@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>, Wayne Lin <wayne.lin@amd.com>,
        Anthony Koo <Anthony.Koo@amd.com>
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

Applied.  Thanks!

Alex

On Thu, Mar 24, 2022 at 9:46 AM Aashish Sharma <shraash@google.com> wrote:
>
> Fix the kernel test robot warning below:
>
> drivers/gpu/drm/amd/amdgpu/../display/dmub/inc/dmub_cmd.h:2893:12:
> warning: variable 'temp' set but not used [-Wunused-but-set-variable]
>
> Replaced the assignment to the unused temp variable with READ_ONCE()
> macro to flush the writes. READ_ONCE() helps avoid the use of
> volatile and makes it obvious from the code that the read here is
> intentional. Also verified on x86 that the generated code is exactly the
> same as before.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Aashish Sharma <shraash@google.com>
> ---
> v2: Removed unnecessary volatile qualifier in the typecast and an unnecessary comment. Also reworded the commit message.
> ---
>  drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> index 873ecd04e01d..a58f460f431d 100644
> --- a/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> +++ b/drivers/gpu/drm/amd/display/dmub/inc/dmub_cmd.h
> @@ -2913,13 +2913,11 @@ static inline void dmub_rb_flush_pending(const struct dmub_rb *rb)
>         uint32_t wptr = rb->wrpt;
>
>         while (rptr != wptr) {
> -               uint64_t volatile *data = (uint64_t volatile *)((uint8_t *)(rb->base_address) + rptr);
> -               //uint64_t volatile *p = (uint64_t volatile *)data;
> -               uint64_t temp;
> +               uint64_t *data = (uint64_t *)((uint8_t *)(rb->base_address) + rptr);
>                 uint8_t i;
>
>                 for (i = 0; i < DMUB_RB_CMD_SIZE / sizeof(uint64_t); i++)
> -                       temp = *data++;
> +                       (void)READ_ONCE(*data++);
>
>                 rptr += DMUB_RB_CMD_SIZE;
>                 if (rptr >= rb->capacity)
> --
> 2.35.1.894.gb6a874cedc-goog
>
