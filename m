Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D31573C11
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 19:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbiGMRjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 13:39:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiGMRjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 13:39:05 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4763C2126B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:39:03 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-31c89653790so120137577b3.13
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 10:39:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RD0GRH4Ql0YFFRlQ5WE7C4dx47duLZOd3i+Z4AO1DPM=;
        b=65eBjroirebcZZM+EXzJz01FsZav20mYrG1Yh43n5ISRXLySVqv2uOFXWNhbcVS42X
         hfGJWP9ah1JgWnblcUcCjhNDUUubVz8ow1UrWu1LDr8mJc27v1M4C4X5hITyx9FdXDuU
         2FDYavHsKKsLp7YpMzBBpzpDQ3m+wv2jiZEZAblHPleIXmFdA/Q036Ii3PsrwwalpEuP
         GW087rtAYOW9R/SoSKO0EulDKYi8cvn95Z2VseWuGEqkE0ETom1ho3sePrWNMvQQZWkR
         1cNqk0m3RHSYFRf2k+HDfJIHCzZUsxweK/QWO0Jmu11Ddp/wEw10sasdNGnHXAhyZzkb
         oF9A==
X-Gm-Message-State: AJIora/3LyWkhgoJTOeTByo57Y8GY3Xy2s6B5xPsH1s+PsBaIsOiJ0Nn
        priXDErkiVWuWnn/ugT8zQ9cmYSOqDfnDzy49BzxJfNY
X-Google-Smtp-Source: AGRyM1s4gXeCWRoXNhtxbRUwfe+h4fflXmP7GIjzQVbWWOGK5bt8/DGvLyPhaJsXJeFMTc+CnqMHIcbg69MakuyRZuc=
X-Received: by 2002:a81:cd6:0:b0:31d:72e3:8b81 with SMTP id
 205-20020a810cd6000000b0031d72e38b81mr5388854ywm.301.1657733942517; Wed, 13
 Jul 2022 10:39:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220713170239.84362-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0gReYjq5uBFZMF_r=fthTB6M_JpyG07-WAs=d+BC0H_Yw@mail.gmail.com> <Ys7++n8ZsmTY6J6s@smile.fi.intel.com>
In-Reply-To: <Ys7++n8ZsmTY6J6s@smile.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Jul 2022 19:38:51 +0200
Message-ID: <CAJZ5v0gVJM7t1k99wT0xtJPQTpQ44gXdxde-gH3iiu5Ua0G88g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] virt: acrn: Mark the uuid field as unused
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Fei Li <fei1.li@intel.com>, Shuo Liu <shuo.a.liu@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 7:21 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jul 13, 2022 at 07:10:18PM +0200, Rafael J. Wysocki wrote:
> > On Wed, Jul 13, 2022 at 7:03 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > After the commits for userspace [1][2] the uuid field is not being
> > > used in the ACRN code. Update kernel to reflect these changes.
> > > I.e. we do the following:
> > > - adding a comment explaining that it's not used anymore
> > > - replacing the specific type by a raw buffer
> > > - updating the example code accordingly
> > >
> > > [1]: https://github.com/projectacrn/acrn-hypervisor/commit/da0d24326ed6
> > > [2]: https://github.com/projectacrn/acrn-hypervisor/commit/bb0327e70097
> >
> > Why don't you use a Link tag for each of these?
>
> I can use Link tags.
>
> > > Fixes: 5b06931d7f8b ("sample/acrn: Introduce a sample of HSM ioctl interface usage")
> > > Fixes: 9c5137aedd11 ("virt: acrn: Introduce VM management interfaces")
> >
> > Typically, the changelog should explain what was wrong in a previous
> > commit that is being fixed in the current one, but that information is
> > missing here.
>
> The advertised field confused users and actually never been used. So
> the wrong part here is that kernel puts something which userspace
> never used and hence this may confuse a reader of this code.
>
> Would it be sufficient? Another way is to drop Fixes tag.

Yes, it would.
