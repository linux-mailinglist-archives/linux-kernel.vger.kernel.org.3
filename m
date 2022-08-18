Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3125A598C6E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344447AbiHRTPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbiHRTPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:15:50 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDBEAA3DF;
        Thu, 18 Aug 2022 12:15:47 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-3246910dac3so66783877b3.12;
        Thu, 18 Aug 2022 12:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sYP+9qNwIyDLFoEUvQXDyPtx/FoGhIOtPcaM79/4lYE=;
        b=en+OrA/MPbCzDMw6B2sjE8UIJ3itx4qg4etpbiCDA55zTKwwj4Bl/8sbdJgTk7XITt
         Occzc361Af0V3i5nt+j+29hWsIJstWjchA303kQ6KaH8dSboDFxlofyhMV79Ul6gQW5Z
         jmt3BVN9kerutUCrk8fAnIC/lkCDlFEZq+63tsWL/o9NwavqPfpW2YI2ShMT6EBQ+wBy
         DJNvF7PJWAHtsBnqPmR/sk472I6vw9jKOk5/BgWV45oY31uoEJNUJIVDZXVThkqwhScP
         6soIXff+09HQEFFWpECOXitWAXO2W5uV1zcaSpEsB+EytmYJiigu7Ji+p5xgEkxnD80A
         vwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sYP+9qNwIyDLFoEUvQXDyPtx/FoGhIOtPcaM79/4lYE=;
        b=3lSv/FdwChZ0zmXm7l78o2G6BiR+ZuymkV47+DvQaJWXZNtY9kdfUPwXhJ6mxpkYcZ
         rKEpdYq0D4NJsxIr11+dU7i2L5BFKCkm87SyMPZnqMRcMaQc5p8ua87yxH9HuhyF/RVA
         Wjhzx83ti+PLGJ/ZYWyvN71aEnA3wymUxZRy0dX0X3lO2Vmc8VyMJ2o5uBkXrZXknmpc
         kS2yUGRfqADtkCe7H2X9M34lnsbSfdTEJ/Hkr/SSIgGHKvkBjgqN2MS6+gv0v5Fq+vaw
         osrzXh4Xa7v6Oc/9jHY6HSDyajI/KTPMrgpZ2y+c1pK6ZxcoYC5lm06484IbEPqL/0kG
         ZSeA==
X-Gm-Message-State: ACgBeo35IqWwkniFo25cZ0x+Ek+5b5hLX2lo3VTaLP1RWNf7vRIXG4G/
        Qxf6T2ujRoRJkxD1mZ4W/Edk+rr0hTZGJ70V1rI=
X-Google-Smtp-Source: AA6agR6NhKTP6dK/rnSflJDd7I8DGOq10wzhEsbsIVztuTgYWO5Ul7BkxPdhivVrz7UKcheuAilCdJQzcMtkDj8bX/Y=
X-Received: by 2002:a0d:c942:0:b0:337:5cf9:1c04 with SMTP id
 l63-20020a0dc942000000b003375cf91c04mr2114294ywd.39.1660850146313; Thu, 18
 Aug 2022 12:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <Yv1lepjhg/6QKyQl@debian> <CADnq5_Od9W1iuzYpsmODOB=Xem97ogeH_t0JrjWC-S8h0XM9fA@mail.gmail.com>
 <5638aaf1-b808-bdc6-d84a-820f24facea6@infradead.org> <CADVatmNA6-qCJEHNn-gRO6Nx88SsTrPsJn_F5J0NiFhyvijNxA@mail.gmail.com>
 <c1869a4b-ead1-2ae5-c9ec-61834b578216@infradead.org>
In-Reply-To: <c1869a4b-ead1-2ae5-c9ec-61834b578216@infradead.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 18 Aug 2022 20:15:10 +0100
Message-ID: <CADVatmPCd5KQ0mAfQGHvqVGFJtK+fyQPB4XUktgfc3fzYJvyCg@mail.gmail.com>
Subject: Re: build failure of next-20220817 for amdgpu due to 7bc913085765
 ("drm/amdkfd: Try to schedule bottom half on same core")
To:     Randy Dunlap <rdunlap@infradead.org>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-next <linux-next@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Thu, Aug 18, 2022 at 4:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
>
>
> On 8/18/22 03:43, Sudip Mukherjee wrote:
> > On Thu, Aug 18, 2022 at 3:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> >>
> >>
> >>
> >> On 8/17/22 19:01, Alex Deucher wrote:
> >>> On Wed, Aug 17, 2022 at 6:03 PM Sudip Mukherjee (Codethink)
> >>> <sudipm.mukherjee@gmail.com> wrote:
> >>>>
> >>>> Hi All,
> >>>>
> >>>> Not sure if it has been reported, build of next-20220817 fails with the
> >>>> error:
> >>>>
> >>>> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
> >>>>
> >>>> Trying to do a git bisect to find out the offending commit.
> >>>>
> >>>
> >>> Thanks.  I don't see that symbol in the driver at all.  Not sure where
> >>> it is coming from.
> >>>
> >>
> >> It's powerpc only.
> >>
> >> Sudip, is it non-CONFIG_SMP by any chance?
> >
> > Ohhh.. really sorry for the incomplete report. I should not try to
> > mail while travelling.
> >
> > The error is seen with powerpc allmodconfig and it has CONFIG_SMP=y.
>
> OK, I see that also, but it doesn't make any sense (to me).
>
> I did 'objdump' on the code file (amdgpu.o) and it's listed as
> undefined but there are no code references to it.

cpu_smt_mask() is called by drivers/gpu/drm/amd/amdkfd/kfd_device.c.
and cpu_smt_mask() is an inline function in
arch/powerpc/include/asm/smp.h which is doing "return
per_cpu(cpu_smallcore_map, cpu);"

So, the offending commit is 7bc913085765 ("drm/amdkfd: Try to schedule
bottom half on same core").


-- 
Regards
Sudip
