Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856E24CB002
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiCBUib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238537AbiCBUi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:38:28 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903E6DEE1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:37:42 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id d62so3254216iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:37:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PITAejhp5addOJEECsyAFsn+IidGaNKUeolD2o1Iu5Q=;
        b=PoBC/43YZvGUMmCXr2U3UCSYQxPgqcU2t4h5MEKI6iwqEMFsHCmUklvmf2xpDvKuKr
         +6Y5Vuw70YmFaOt+w6k3rZEffAV0jBSRp9LaMm98pBQ8bLBWFpjFGRvjX9pY1ltp0ZGv
         QIqxQhwoiXJF6iB0zQNfXl1y10DWNmej/4M4E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PITAejhp5addOJEECsyAFsn+IidGaNKUeolD2o1Iu5Q=;
        b=A4fFGvs5KRJjKL6S8JIBb4r2FSi86KuI/NzThAZJ7k4jGThX9k+OOmh84evT9Z9RL8
         504YppQaFWRjwvEmafS5UUF9riGlqVl9tH+X0ugN7S3D0ooMknWASkvULdIXMlFoemB4
         GGeTtps3zanlg3Z5/Hnl+gaxqJBXrnJLslzKDtcOGwHBigDQkTKBDsWsWAPbffkw95I3
         PNHTjLCv9oMXfXgbx2dv2TR7xk70xUza6lSThFORuOvbcrD9E9p5e/sa/CgnkGBaYszR
         Z+TvmfOQKI5J7K5nqueT8LGdlcnqRpTUW3MekQR/Zmjyx5gaRQ0FuJ0atQIhkfabYtuD
         NaGg==
X-Gm-Message-State: AOAM532m2AdYwGrjJZw//TNb67+OdoJ9G8n0YsB17IV4SY3OkHqL3A4U
        ucF1xA1hYlkIHCYGHY/RWHH2d2+P0JVw6A==
X-Google-Smtp-Source: ABdhPJzRu57z9GBWfBxja1vTPSY3jTMIRK8EFabp100S34hq0f1Dxgzs3NiV4xUkAE8YR1vi+aMukw==
X-Received: by 2002:a02:ccac:0:b0:314:2074:fec4 with SMTP id t12-20020a02ccac000000b003142074fec4mr26963338jap.41.1646253462175;
        Wed, 02 Mar 2022 12:37:42 -0800 (PST)
Received: from google.com (h24-56-189-219.arvdco.broadband.dynamic.tds.net. [24.56.189.219])
        by smtp.gmail.com with ESMTPSA id s13-20020a056e0218cd00b002c5f74a97d6sm51472ilu.39.2022.03.02.12.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:37:41 -0800 (PST)
Date:   Wed, 2 Mar 2022 13:37:40 -0700
From:   Raul E Rangel <rrangel@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     "Anand K. Mistry" <amistry@google.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Add a prompt for HPET_EMULATE_RTC
Message-ID: <Yh/VlNy1owvTh979@google.com>
References: <20210429155950.v2.1.I2392cf11fb353d10459958100b69d93346fa167c@changeid>
 <87bl9se07w.ffs@nanos.tec.linutronix.de>
 <CAATStaMkJ_xdkHutcgH2bmZiO3z6fKoLNrP5=Q3XUsNTpvHP5g@mail.gmail.com>
 <87zgxbhr17.ffs@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgxbhr17.ffs@nanos.tec.linutronix.de>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2021 at 09:55:16AM +0200, Thomas Gleixner wrote:
> On Tue, May 04 2021 at 11:21, Anand K. Mistry wrote:
> > On Mon, 3 May 2021 at 17:38, Thomas Gleixner <tglx@linutronix.de> wrote:
> >> On Thu, Apr 29 2021 at 16:00, Anand K. Mistry wrote:
> >>
> >> > This does two things:
> >> > 1. Makes the option visible in menuconfig, allowing the user to easily
> >> >    disable this option
> >> > 2. Allows olddefconfig to respect the option if it is set in the old
> >> >    .config file
> >>
> >> Well, it's pretty clear WHAT it does, but there is absolutely no
> >> reasoning WHY this knob is needed in the first place.
> >
> > Without this option, 'make oldolddefconfig' ignores the option in the
> > old .confg file and just sets it to the calculated default for the
> > platform. An easy way to test this is to do 'make defconfig' on
> > x86-64, set CONFIG_HPET_EMULATE_RTC=n in the generated .config, and
> > run 'make olddefconfig'. Without this patch, olddefconfig will ignore
> > the set option and overwrite it with CONFIG_HPET_EMULATE_RTC=y.
> 
> Rightfully so because it's a functional correctness issue. When HPET is
> enabled in legacy mode it takes over the RTC interrupt line, which makes
> RTC alarms disfunctional and therefore we have to emulate it. 
> 
> So, no.
> 
> > So, part of the why is that this enables the use of olddefconfig with
> > the CONFIG_HPET_EMULATE_RTC option. The other part of why is that my
> > team uses 'make olddefconfig' by providing a base config and then
> > using olddefconfig to fill in the unset values with defaults to make a
> > complete config file for a kernel build. I'd like to disable RTC
> > emulation on a particular platform, but I can't use a config option to
> > do it without this patch because 'make olddefconfig' will just ignore
> > the option.
> 
> You can like to disable it, but that does not make it more correct. See
> above. If your platform does not have RTC_DRV_CMOS then you have to
> disable that which will also clear CONFIG_HPET_EMULATE_RTC.

So on recent AMD Chromebooks we have disabled the RTC emulation by
setting rtc-cmos.use_acpi_alarm=1.

* https://chromium-review.googlesource.com/c/chromiumos/overlays/board-overlays/+/3472221
* https://chromium-review.googlesource.com/c/chromiumos/overlays/board-overlays/+/2355073

It looks like recent Intel platforms have also disabled the RTC
emulation.

* https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.15/drivers/rtc/rtc-cmos.c;l=1202

One thing I've been wondering is why is the legacy mode enabled
unconditionally by the kernel?

* https://source.chromium.org/chromiumos/chromiumos/codesearch/+/main:src/third_party/kernel/v5.15/arch/x86/kernel/hpet.c;l=1096

If it's not enabled, can we leave it disabled? I know some firmware
doesn't correctly populate the INT_ROUTE_CAP to describe which IRQs
are available, but if it is populated can we use it and avoid the 
RTC HPET emulation layer? I'm not sure what the story is on MSIs or if
that's a supported use case.

I have been leaving the INT_ROUTE_CAP register unset on the AMD
Chromebooks since it's getting ignored by the kernel.

Thanks,
Raul

> 
> Thanks,
> 
>         tglx
