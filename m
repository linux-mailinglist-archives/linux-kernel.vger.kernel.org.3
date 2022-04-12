Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4054FE380
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356449AbiDLOPc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356450AbiDLOPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:15:25 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F8E1D309
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:13:08 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id q129so19152741oif.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=b6YpDp+6gFKoLmapSHMcJ8pQjcQrhKppqQPW1qrfY/M=;
        b=OmQRrxF3c5o1KlJk1ADfn7bF1BdDYI/6MzKE+UbXY8zUlFZmDyaVY3FvxTnAIEa0XJ
         4njrXVLgTxy6M22LJHmyxDfpJ7ZGyeTQwYjdZCYrJlB4P1TCHokXDPBq9hXwtsFzPiWV
         dgVxr0e8bR4X5oAl7zInOA16ohEyFad8aP7T4sk4AS+xF5vZwobNU3fowFkP4aZo1fbw
         p5IEFDRpGPhubpCsos0x6RUgdyVguFDtpUZxDOjAPjuhuidHL356qXpQcP8A5ddnoNNS
         KgnmhtBR9lboTPrbisNcTRfyJQ52UT4qMduUb8bIQChazq0kaFpbJW5pSfXsgoz4EILd
         NrMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=b6YpDp+6gFKoLmapSHMcJ8pQjcQrhKppqQPW1qrfY/M=;
        b=2d5s93UxWbLMBHQuPHb+E4dqsbDLv8vFJREbXgTBLvPdO6ixgiFUkxBYsOM0KTYGas
         1Dlv3M7e4kVeGZ3ULOUPF0pBTk+0hoEZcW9I2ny4pxYT7+vHPn0OxQAz0ey27+I5Xjbl
         i+IQDi7oTKRYwMlqwhKReRuVULjL/lcqC2F9Se9LsSoZRFD31Ai/mM92PS/bP98dSDIL
         j/Uq0NPHz/dagWgBklebO+3wIRCTMpRo1eTwfAehjcaUvAs6nNIx9iHGhoVBeUaMpr9V
         VEMNRoGfOWZYFSF+rLj03OID/8AYB7OYufgkONHvbWZUQWOYeu+p5o4V9r6xYooPjZ6s
         Y/7Q==
X-Gm-Message-State: AOAM530Ei9YPLS5F57vWVDHBh7oVisBMeXdrZuHzJtfIZ/ckM0vL7sPM
        iiwZ3tx99KN1ZZIAFy98seHvpY2PaECqBSHvJaw=
X-Google-Smtp-Source: ABdhPJzvkvG7jo+a/gm9nQ/3deFhOzLJ1KErpfqpA3Uh0OwD50/Y3p6TDExGZgiwG1OsiMG6x7cSUe+vQyEzjC7hRNI=
X-Received: by 2002:a05:6808:1486:b0:2f9:e821:51d9 with SMTP id
 e6-20020a056808148600b002f9e82151d9mr1913551oiw.253.1649772787730; Tue, 12
 Apr 2022 07:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220411135939.906700-1-yongqiang.sun@amd.com>
 <f06ce5e3-158b-88a8-06f0-53b88c4fad45@molgen.mpg.de> <CADnq5_PSZX+11meHYn9CR3A4LiseGo30TwbkOuPgTQsfbYxmCg@mail.gmail.com>
 <88760cd1-d1ed-8952-d061-15e238b2ec57@molgen.mpg.de>
In-Reply-To: <88760cd1-d1ed-8952-d061-15e238b2ec57@molgen.mpg.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 12 Apr 2022 10:12:56 -0400
Message-ID: <CADnq5_MdSn0_X6Bqd-Ljv_QzVpgtBYXUkkALEdFasCiiXx=o7g@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with vega10
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Yongqiang Sun <yongqiang.sun@amd.com>,
        Jingwen Chen <jingwen.chen2@amd.com>,
        "Luo, Zhigang" <zhigang.luo@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        "monk.liu" <monk.liu@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
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

On Tue, Apr 12, 2022 at 4:01 AM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>
> [Cc: +x86 folks]
>
> Dear Alex, dear x86 folks,
>
>
> x86 folks, can you think of alternatives to access `X86_HYPER_MS_HYPERV`
> from `arch/x86/include/asm/hypervisor.h` without any preprocessor ifdef-e=
ry?

I don't really see what problem that solves.  X86_HYPER_MS_HYPERV is
an X86 thing.  Why do we need a processor agnostic way to handle it?
Any code related to that is X86 specific.

Alex

>
>
> Am 11.04.22 um 18:28 schrieb Alex Deucher:
> > On Mon, Apr 11, 2022 at 11:28 AM Paul Menzel wrote:
>
> [=E2=80=A6]
>
> >> Am 11.04.22 um 15:59 schrieb Yongqiang Sun:
> >>> MS_HYPERV with vega10 doesn't have the interface to process
> >>> request init data msg.
> >>
> >> Should some Hyper-V folks be added to the reviewers list too?
> >>
> >>> Check hypervisor type to not send the request for MS_HYPERV.
> >>
> >> Please add a blank line between paragraphs.
> >>
> >>> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
> >>> ---
> >>>    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
> >>>    1 file changed, 10 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/d=
rm/amd/amdgpu/amdgpu_virt.c
> >>> index 933c41f77c92..56b130ec44a9 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> >>> @@ -23,6 +23,10 @@
> >>>
> >>>    #include <linux/module.h>
> >>>
> >>> +#ifdef CONFIG_X86
> >>> +#include <asm/hypervisor.h>
> >>> +#endif
> >>> +
> >>>    #include <drm/drm_drv.h>
> >>>
> >>>    #include "amdgpu.h"
> >>> @@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_=
device *adev)
> >>>                        break;
> >>>                case CHIP_VEGA10:
> >>>                        soc15_set_virt_ops(adev);
> >>> -                     /* send a dummy GPU_INIT_DATA request to host o=
n vega10 */
> >>> -                     amdgpu_virt_request_init_data(adev);
> >>> +#ifdef CONFIG_X86
> >>> +                     /* not send GPU_INIT_DATA with MS_HYPERV*/
> >>> +                     if (hypervisor_is_type(X86_HYPER_MS_HYPERV) =3D=
=3D false)
> >>> +#endif
> >>
> >> Why guard everything with CONFIG_X86? (If it=E2=80=99s needed, it shou=
ld be done
> >> in C code.)
> >
> > X86_HYPER_MS_HYPERV only available on x86.
>
> Sorry, I missed the X86 dependency when quickly looking at the Hyper-V
> stub IOMMU driver `drivers/iommu/hyperv-iommu.c`, but missed that
> `HYPERV_IOMMU` has `depends on HYPERV && X86`.
>
>
> Kind regards,
>
> Paul
>
>
> >>> +                             /* send a dummy GPU_INIT_DATA request t=
o host on vega10 */
> >>> +                             amdgpu_virt_request_init_data(adev);
> >>>                        break;
> >>>                case CHIP_VEGA20:
> >>>                case CHIP_ARCTURUS:
> >>
> >>
> >> Kind regards,
> >>
> >> Paul
