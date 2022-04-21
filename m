Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2CB50A01F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232000AbiDUM6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386447AbiDUM5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:57:43 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F133885
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:54:49 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id h12so1092351plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pbT0ufs8hhFUmGFXmvk8EHCBgVcwB+SywVbegWDB+bs=;
        b=HkSXIHtS+C43UypZg4urQxLWl81TI5WPaZcpcHogdhzQ1qIwaFTq0hVztAYUoI6C+0
         kVxg/tBsW2Yazj5CCvgeE4QHtnoRBRAM3IJ9Bgw8NyBxDfgf+oHDRAWT2R0ptK4KEoer
         xlQHrdNivGcRlsYe+v473ZA/qNcTDBkjJvG6ghQvIjsI6AtvMR2XpHniouJlQOXL+bjM
         Cp7ljott8sZXx5JVGSvZJbtqsINKGNpbxsIFciv7oLxxUOk+rYId3ON2A3qpLOkCus9B
         a/gYyu2cKp+wqRe5giSE9WqqtU0rI6I+jDpwdPK/o/uIVisOArAmUzBXVHmprkXeNLV4
         xIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pbT0ufs8hhFUmGFXmvk8EHCBgVcwB+SywVbegWDB+bs=;
        b=OTOBVyYTmbh4XXu/rzMzgEm92alKJktivbZMiGxNR7OgGrjEd35y0QhOz4hXEG4Cde
         oXZa8MnOrIvMo9KSFm6elGnGs0V76jN3T2Kdf+W4pbxRNZlhJmnsQSNUAdOCbrPwfoZr
         xi0qZObXKfRqvbzWj6Smr9fV2tYclvK5Ng0OjwZsgSIgUr+EGbjQ+f26WEu5ZhJCOk6q
         fW9MXZF9iNW1aWB2lC0dTlugFywokhlOlXUDArpwo2OydicDUetbEL1EltOjgsD3PZhm
         4sa00B+ztSSvGal8ye1S3oKSHVbzzp+vvn0ZpPlUVp5PAbmY5IjiYgAA9Pw2VdRK2XH4
         G4Ow==
X-Gm-Message-State: AOAM530NrENqJxrBADW7ktjtdZmS7zUpxqYJoP+QJyp1I4gB9ISrStkK
        mOLaG+O7In/TkkcWY/Rsoust8Qw6Xb/1LRCOpl8=
X-Google-Smtp-Source: ABdhPJx+8395YqausJ5yKUEqAmsX6qaS7KThwCRy2ZPLMLA3pGeKRsSBn+8saoZhtpNw6BfhbSsSGsDTgWnX84jOevA=
X-Received: by 2002:a17:902:7e0d:b0:156:47a4:a7c4 with SMTP id
 b13-20020a1709027e0d00b0015647a4a7c4mr25977133plm.141.1650545689357; Thu, 21
 Apr 2022 05:54:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <b3f7e288-3341-8c6f-1b95-e553ac5ebc35@suse.de> <CAMeQTsbh-Fy4CORBTX=AfZ+K-fZYUQ=hY=ctLFyu9KcJ5NgFUA@mail.gmail.com>
 <dce29330-e40c-860e-2c72-7ddebdd96e20@redhat.com>
In-Reply-To: <dce29330-e40c-860e-2c72-7ddebdd96e20@redhat.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Thu, 21 Apr 2022 14:54:37 +0200
Message-ID: <CAMeQTsYYpw5+uLgmDrbB6PUBotRC4F+_rfK+sxT0CpPHoiOmmw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        James Hilliard <james.hilliard1@gmail.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
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

On Thu, Apr 21, 2022 at 2:47 PM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> Hello Patrik,
>
> On 4/21/22 14:39, Patrik Jakobsson wrote:
> > On Thu, Apr 21, 2022 at 1:49 PM Thomas Zimmermann <tzimmermann@suse.de> wrote:
> >>
> >> Hi
> >>
> >> Am 09.04.22 um 06:23 schrieb James Hilliard:
> >>> Select the efi framebuffer if efi is enabled.
> >>>
> >>> This appears to be needed for video output to function correctly.
> >>>
> >>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> >>> ---
> >>> Changes v2 -> v3:
> >>>    - select EFI_FB instead of depending on it
> >>> Changes v1 -> v2:
> >>>    - use depends instead of select
> >>> ---
> >>>   drivers/gpu/drm/gma500/Kconfig | 2 ++
> >>>   1 file changed, 2 insertions(+)
> >>>
> >>> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
> >>> index 0cff20265f97..a422fa84d53b 100644
> >>> --- a/drivers/gpu/drm/gma500/Kconfig
> >>> +++ b/drivers/gpu/drm/gma500/Kconfig
> >>> @@ -2,11 +2,13 @@
> >>>   config DRM_GMA500
> >>>       tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
> >>>       depends on DRM && PCI && X86 && MMU
> >>> +     depends on FB
> >>
> >> Why do we need FB here? Framebuffer support should be hidden by DRM's
> >> fbdev helpers.
> >
> > It is not needed but gives him video output since it enables the drm
> > fbdev emulation.
> >
>
> I'm not sure to understand this. Shouldn't depend on DRM_FBDEV_EMULATION then?

No, it shouldn't depend on any FBDEV stuff since it's not actually
required. It just happens to help in this case since weston + fbdev
backend works but not weston with drm backend (or whatever config
James have set).

>
> > I looked some more at the logs and it seems weston doesn't work on his
> > system without the fbdev backend. So the question is why weston isn't
> > working without fbdev? Perhaps this is just a Weston configuration
> > issue?
> >
>
> But is weston using the fbdev emulated by DRM or the one registered by
> efifb? I thought that the latter from what was mentioned in this thread.

It's using drm fbdev emulation with gma500 so EFIFB has nothing to do
with this. I believe it was just simply incorrectly reported. If I'm
correct then "depends on FB" is what makes video output work for
James.

>
> --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>
