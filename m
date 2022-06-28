Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD9255F042
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 23:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbiF1VQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 17:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiF1VQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 17:16:34 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DE53192A
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:16:32 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-3176d94c236so130428237b3.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9tDe52GGxzPcMmdw3mYkuOmIyW05Nrirch7vLV731MU=;
        b=ljimGrfwxm5aduRgvJ1pepWTHcFxjaYSqtMuTkTWyjsLXWTlNz6xomYBkx1fap/1Fz
         qS8dDnrrWxY3MG3d1mIwuS47Xawi2WwcyElxjPReaRIL8ZV5zWidTLmkfo/ujoVGssRN
         /xsqxr59B4wRpDdgvBn/GQqpXCva/Yt4wMguNchxEVtnpSMOdvU+D5GkDB9kvH2oqLnz
         mYfIbvJKlSA6kOq2I4Pa1ny1gdS/5PDmwr0GfsJX7sSfhmMVZTLMPbnHRa4rTJOG5jft
         DNFUJ1KKOABN5BFrwE0k5F40J5+zHDxJ1iXN9FDtI4TvdLEi0sHrUH5soI2fJcx9esd1
         ta0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9tDe52GGxzPcMmdw3mYkuOmIyW05Nrirch7vLV731MU=;
        b=XnTpUkRNcqFgfok/eepRJnPUFSLiU6Qq4A86zRZB0rf/g81Ymmrr52wE1yVXgtzHlY
         hIRJwi7ZxwGnCU7Vg72pXhj0NkAMtlmVnuUNlLonSzOzefR4fPu/EFiDSyHVcG8w0pdW
         OgICMT//HZsSrWptul04E724wD3m6eTuMwYM4TRg2uyggb5ynoBPgy9mp4tda9Srps/6
         MdahUUTDKFdKeGUTXn+a7KiJdwCqIYbCXEGQ7hYpNhDvQUIzgJ+qHJyh9QjqHclkWKc0
         7J87mBJLiuiF+p8Axr5dzbUaP+/e+Sv0GKu13ebhCZmmOiXdkMZ94lV9W3FdJSu8SqW9
         F0YQ==
X-Gm-Message-State: AJIora8gZ29Yy9KViLsdXY4b5i9zPo+rzocSapb5zx7RWpHqpk1L2tCi
        wEZpwDuEtCCqoa1uDt34e785ja5+mykBUH/JjlrLNQ==
X-Google-Smtp-Source: AGRyM1udrv3zSZinF+m5gMrwovLJdn1y1LkRnjCvhw5Acr31rfHUsleomet3XGcELReoJH28TfIHBgBF3fWyYtV2/tk=
X-Received: by 2002:a0d:e20a:0:b0:317:ce36:a3a0 with SMTP id
 l10-20020a0de20a000000b00317ce36a3a0mr120718ywe.448.1656450991969; Tue, 28
 Jun 2022 14:16:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220607120530.2447112-1-tarumizu.kohei@fujitsu.com>
 <YqNCDrqcp9t8HlUJ@kroah.com> <OSBPR01MB203749DA00C7BEE5741AFEB980AA9@OSBPR01MB2037.jpnprd01.prod.outlook.com>
 <YqiAY689pOJbHKUd@kroah.com> <TY2PR01MB20426C7822E46B2E8B2525FB80AF9@TY2PR01MB2042.jpnprd01.prod.outlook.com>
 <CACRpkdaV8+06gzxi3ou4+nxa28R5Rhzg+KJ8HWh4gyK4AkoC9g@mail.gmail.com>
 <086370dd-281f-5ac6-3a0f-f1b80500c668@intel.com> <CACRpkdYTNuszctk=stB+RLr5kKwhR2ebF2MJCYQwMwYYPPReLg@mail.gmail.com>
 <6934b82d-db12-8a17-7dea-7bcbd4fe8566@intel.com>
In-Reply-To: <6934b82d-db12-8a17-7dea-7bcbd4fe8566@intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 23:17:22 +0200
Message-ID: <CACRpkdaW3nLsemEZgKUTBYR8F_kvA7C1O4i6FjmjOq86Jc5CKA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] Add hardware prefetch control driver for A64FX and x86
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "mchehab+huawei@kernel.org" <mchehab+huawei@kernel.org>,
        "eugenis@google.com" <eugenis@google.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "pcc@google.com" <pcc@google.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "marcos@orca.pet" <marcos@orca.pet>,
        "marcan@marcan.st" <marcan@marcan.st>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org" <ast@kernel.org>,
        "peter.chen@kernel.org" <peter.chen@kernel.org>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        Paolo Valente <paolo.valente@unimore.it>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 11:02 PM Dave Hansen <dave.hansen@intel.com> wrote:
> On 6/28/22 13:20, Linus Walleij wrote:
> >
> > Well if the knobs are exposed to userspace, how do people using
> > these knobs know when to turn them? A profiler? perf? All that
> > data is available to the kernel too.
>
> They run their fortran app.  Change the MSRs.  Run it again.  See if it
> simulated the nuclear weapon blast any faster or slower.  Rinse.  Repeat.

That sounds like a schoolbook definition of the trial-and-error method.
https://en.wikipedia.org/wiki/Trial_and_error

That's fair. But these people really need a better hammer.

> This interface would take a good chunk of the x86 wrmsr(1) audience and
> convert them over to a less dangerous interface.  That's a win on x86.
> We don't even *remotely* have line-of-sight for a generic solution for
> the kernel to figure out a single "best" value for these registers.

Maybe less dangerous for them, but maybe more dangerous for the kernel
community who signs up to maintain the behaviour of that interface
perpetually.

Yours,
Linus Walleij
