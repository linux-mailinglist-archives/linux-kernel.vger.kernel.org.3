Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BB2550A745
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390841AbiDURmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238923AbiDURmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:42:03 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6D649F91
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:39:12 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-e67799d278so2259981fac.11
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 10:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rd1UX9GwU1UbKATOeeYflGhns40gVcjdRs94Rp50K6c=;
        b=ILILE0CBHmLrsx1gA8mBceAuRT9Vwau5GzEqNXp+KSDhWEUOTRMm91JQ7Prn4nqo2p
         pjuqqXyQRwv0tsidil81T/T2l02QBioWszxelY/LwDGvbojb0DARMjb2d3spcUs2u044
         qenPfAG/wDIZktD7emJve70unzwaq+OKAvUuFyBYragmcHAY/+8a6aKWbq3lz7Lm2zHK
         pmpN0l32/2uPvejYwnRP6guv3ntHIJ65S9ZoFzHdcy3zz926hyFxFrtLGvUN6Ya/dcb2
         LbneX1yS/28OBhU9LClvkTPqxUR+BYoMmf73Jp1SD5EP3/TrNOA1HI1JFeZzBzGJAuht
         fQ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rd1UX9GwU1UbKATOeeYflGhns40gVcjdRs94Rp50K6c=;
        b=n0JB3qSPRSv2dV45rvnQnEGLT24zO+ss39YCRjhSQlwCCkPEHRN7xpqaUzo2lHfa4u
         6oziMJarJN7qk/d2W/9EvgbND7xM3/kxkC6M6gTFIV0UWdqtPbLUdDxWjNiMCJEBpahG
         vzMBpW1BzfcX0BULbqQ3p7Z4SID0aouZP26XwiYdqy+DNOg3EwJKP4SagIaRNdkZqw/b
         JZGwMdxXkwc5Tyd5mrPSwuGJNPdcepfx03otH5wzOIYNQKic/THPh3r34oBVitfv2gW/
         us/QY4Yso/j6b4w3c2lt7LM0LK76IE6Auw0L+wKmf3kNp+AR4RF9LsJSQz6yUghxOR8c
         T+SQ==
X-Gm-Message-State: AOAM531JvUaz3CACH58m2rc6o1BMiTn9OItX5NaERMNbYJfhRID/n2TT
        J1ccHYhzKs3oeykBuxotseNgmLFS3hVx/kvRyD0=
X-Google-Smtp-Source: ABdhPJyvgYAEQbb7MBc++PWNoLsV1Ey1bVvwcov5O8XOEtS5Hv7oQM4YH0GQnaKtpuNRcOc3a6adUar26sW4/3ZKZA4=
X-Received: by 2002:a05:6870:a40d:b0:e5:ea09:df91 with SMTP id
 m13-20020a056870a40d00b000e5ea09df91mr272460oal.99.1650562751735; Thu, 21 Apr
 2022 10:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220409042321.3184493-1-james.hilliard1@gmail.com>
 <b3f7e288-3341-8c6f-1b95-e553ac5ebc35@suse.de> <CAMeQTsbh-Fy4CORBTX=AfZ+K-fZYUQ=hY=ctLFyu9KcJ5NgFUA@mail.gmail.com>
 <dce29330-e40c-860e-2c72-7ddebdd96e20@redhat.com> <CAMeQTsYYpw5+uLgmDrbB6PUBotRC4F+_rfK+sxT0CpPHoiOmmw@mail.gmail.com>
 <10c81e57-2f09-f4f8-dc2f-6bd05ef819d7@redhat.com>
In-Reply-To: <10c81e57-2f09-f4f8-dc2f-6bd05ef819d7@redhat.com>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Thu, 21 Apr 2022 12:39:00 -0500
Message-ID: <CADvTj4oms8R1fhFpyZ+juU=4Eozie6f-3fzz4+jtptj3M9VCbw@mail.gmail.com>
Subject: Re: [PATCH v3] drm/gma500: depend on framebuffer
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 8:22 AM Javier Martinez Canillas
<javierm@redhat.com> wrote:
>
> On 4/21/22 14:54, Patrik Jakobsson wrote:
> > On Thu, Apr 21, 2022 at 2:47 PM Javier Martinez Canillas
> > <javierm@redhat.com> wrote:
>
> [snip]
>
> >>>>> diff --git a/drivers/gpu/drm/gma500/Kconfig b/drivers/gpu/drm/gma500/Kconfig
> >>>>> index 0cff20265f97..a422fa84d53b 100644
> >>>>> --- a/drivers/gpu/drm/gma500/Kconfig
> >>>>> +++ b/drivers/gpu/drm/gma500/Kconfig
> >>>>> @@ -2,11 +2,13 @@
> >>>>>   config DRM_GMA500
> >>>>>       tristate "Intel GMA500/600/3600/3650 KMS Framebuffer"
> >>>>>       depends on DRM && PCI && X86 && MMU
> >>>>> +     depends on FB
> >>>>
> >>>> Why do we need FB here? Framebuffer support should be hidden by DRM's
> >>>> fbdev helpers.
> >>>
> >>> It is not needed but gives him video output since it enables the drm
> >>> fbdev emulation.
> >>>
> >>
> >> I'm not sure to understand this. Shouldn't depend on DRM_FBDEV_EMULATION then?
> >
> > No, it shouldn't depend on any FBDEV stuff since it's not actually
> > required. It just happens to help in this case since weston + fbdev
> > backend works but not weston with drm backend (or whatever config
> > James have set).
>
> I see. Then the correct approach for them would be to just enable CONFIG_FB
> and DRM_FBDEV_EMULATION in their kernel config, rather than making this to
> depend on anything FB related as you said.

Yeah, so it looks like CONFIG_FB_EFI is not needed but
CONFIG_DRM_FBDEV_EMULATION is, I think I just assumed efifb
was what was needed based on the kernel logs.

This does not work:
CONFIG_FB enabled
CONFIG_DRM_FBDEV_EMULATION disabled

This works:
CONFIG_FB enabled
CONFIG_DRM_FBDEV_EMULATION enabled

>
> >
> >>
> >>> I looked some more at the logs and it seems weston doesn't work on his
> >>> system without the fbdev backend. So the question is why weston isn't
> >>> working without fbdev? Perhaps this is just a Weston configuration
> >>> issue?
> >>>
> >>
> >> But is weston using the fbdev emulated by DRM or the one registered by
> >> efifb? I thought that the latter from what was mentioned in this thread.
> >
> > It's using drm fbdev emulation with gma500 so EFIFB has nothing to do
> > with this. I believe it was just simply incorrectly reported. If I'm
> > correct then "depends on FB" is what makes video output work for
> > James.
> >
>
> Got it. Thanks for the clarification.

Here's my weston.ini:
[core]
shell=kiosk-shell.so
modules=systemd-notify.so
backend=drm-backend.so
idle-time=0
require-input=false
use-pixman=true

[shell]
locking=false
cursor-theme=Obsidian
panel-position=none

[output]
name=DVI-D-1
transform=rotate-270

[output]
name=DP-2
mode=off

[output]
name=LVDS-1
mode=off

[libinput]
touchscreen_calibrator=true

>
> --
> Best regards,
>
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
>
