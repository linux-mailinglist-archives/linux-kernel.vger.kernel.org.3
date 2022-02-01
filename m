Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8C24A6449
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 19:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242072AbiBASxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 13:53:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231249AbiBASxm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 13:53:42 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6342DC06173B;
        Tue,  1 Feb 2022 10:53:42 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id q14-20020a05683022ce00b005a6162a1620so4372559otc.0;
        Tue, 01 Feb 2022 10:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QFCR/1hC834owOFEy/yMpLb2HK8B3ZOJtDVT0ccY4sE=;
        b=YeXvcvuG/NM5Pa8ySb9pUop7d5OOosVeHp9T5rc8MDxj8HRpTXe399YCyOi6Iv6+7R
         13Nncd4WtVJya7qP1QdZZQil3xB121i+jYZdYp2FQ11mL8sS7XOEXei1YeWVCd35BGPg
         3zCf4fEENpBz2BLbDzAdZq/a8M8pvXz7PxGRRCA1WLNvg2kojCG7q7A1sSAK3ohXSwm3
         l40XAJVrH7plknYY/P3EZKQlaPmAAENi5hhXoU+shddmF6QwkO4ieIIG5BYqrzWKUt8q
         oQqzQU1Qtoj5j9NIvQ8/wBe/yNwgaHWz86WvxQK8/xyszi89W39SrkjNWVnYEg8zxj9W
         3TZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QFCR/1hC834owOFEy/yMpLb2HK8B3ZOJtDVT0ccY4sE=;
        b=QgDs0TpANNTLOtV9VIG9Z1WAJyY4ZFH44XsJ9EzX2tikLjeyECdCJgDPd46yP3CyTY
         yEDBSP0aOCYlLvFWhWFeMWO14uxn8j/0W6TE6t9q7LNpsRsP/k8kgAFWMNu7XPQjQ9wK
         Y5EdyNuxMR5raZoHmyvptbg9fhiSPTlAsTP3pbePZj0JtNt5Ab3jhGzMC4dPbAci1x9U
         nCnhoAr+K42RzMCnUf4V00+RUeMF6Zqw4mrkRQp1yzMYLzFVe+T7qF4O7K9ICxO5szDl
         Rz4GD42B8Su0FD+HCOTXKNcFUCfOEhjL/28Vop7t7ASxNeirUxsfwe2qwTxSHvMmN7/a
         COhA==
X-Gm-Message-State: AOAM533cd5qw+8RGIAxDPVpAvVkYpwXx7xxsPIwiw0zUnNRlayZpMVyh
        y0cWijhW29tXh1tiRMh6PdxOwSoxTdHkhmcmPkMxLW1a
X-Google-Smtp-Source: ABdhPJwagrwa+GOL3uBCU9+tBM+qg4ZgWIZurn9hthvLnhZNRq//CyajVrS7yohT1UANKIAxtnxITurDet/wFUurNiw=
X-Received: by 2002:a9d:e94:: with SMTP id 20mr14796505otj.200.1643741621707;
 Tue, 01 Feb 2022 10:53:41 -0800 (PST)
MIME-Version: 1.0
References: <20220201143201.1883c3aa@canb.auug.org.au> <b679648e-929c-9885-9690-70f8918bfa05@amd.com>
In-Reply-To: <b679648e-929c-9885-9690-70f8918bfa05@amd.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Tue, 1 Feb 2022 13:53:30 -0500
Message-ID: <CADnq5_PpKQOZCL5PnG2236C1HVpcM5tD+XJt0T4d5pfKA6UWOg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Go for it.  I'll squash it into my next -next update.

Alex

On Tue, Feb 1, 2022 at 1:32 PM Limonciello, Mario
<mario.limonciello@amd.com> wrote:
>
> Thanks for the fix.
>
> Alex if no concerns I'll push this patch from Stephen to
> amd-staging-drm-next with my tag.
>
> On 1/31/2022 21:32, Stephen Rothwell wrote:
> > Hi all,
> >
> > After merging the amdgpu tree, today's linux-next build (powerpc
> > allyesconfig) failed like this:
> >
> > In file included from drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c:43:
> > drivers/gpu/drm/amd/amdgpu/amdgpu.h: In function 'amdgpu_acpi_is_s3_active':
> > drivers/gpu/drm/amd/amdgpu/amdgpu.h:1428:87: error: expected ';' before '}' token
> >   1428 | static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
> >        |                                                                                       ^~
> >        |                                                                                       ;
> >
> > (and many more)
> >
> > Caused by commit
> >
> >    11bc42ea179d ("drm/amd: add support to check whether the system is set to s3")
> >
> > I have applied the following patch for today.
> >
> > From: Stephen Rothwell <sfr@canb.auug.org.au>
> > Date: Tue, 1 Feb 2022 14:24:40 +1100
> > Subject: [PATCH] drm/amd: fix semicolon positioning
> >
> > Fixes: 11bc42ea179d ("drm/amd: add support to check whether the system is set to s3")
> > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > index e61078cec072..2931c8ff4cc6 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> > @@ -1425,7 +1425,7 @@ bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev);
> >   bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev);
> >   #else
> >   static inline bool amdgpu_acpi_is_s0ix_active(struct amdgpu_device *adev) { return false; }
> > -static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false };
> > +static inline bool amdgpu_acpi_is_s3_active(struct amdgpu_device *adev) { return false; }
> >   #endif
> >
> >   int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
>
