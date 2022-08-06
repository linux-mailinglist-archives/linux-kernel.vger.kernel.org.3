Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2FA58B530
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 13:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241842AbiHFLR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 07:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241745AbiHFLR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 07:17:26 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28BD12611;
        Sat,  6 Aug 2022 04:17:25 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id cr9so375492qtb.13;
        Sat, 06 Aug 2022 04:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ummOq0BPRVh49xOI3AREULY3XTQqUE/33/Tmxt5Px+U=;
        b=DpBs4GUVDTiOVEUMYMRow6UHM4NfXCXXOVkLZebNcwq7bSD24XEkE0zwj23gyzWYiL
         usJzG2chmTGk3bU4o1HKudAAH5gFJdVMwAGAFR+zolN3DoVwFkdJsKhV90n2oCjbNPjb
         L6a238UjQu2mdls9+6K0CnXG3fcf16r/OrDIM1nLMPPZFYAQcZuYICJJJZU2sx5XM/Lw
         KTMXfIba8bqNLg9UfiuzZ1PMKAzKL3cVj0lU5DZKMyw2ijVIiIIkCSJ/1Ls1YbV4F+of
         a/kzGiViNbC0qlkL4HD9NHjN0gPnsyMUn7CiuuifYXOHJ5o7A+iIUYJGMWlFzZ8dPClz
         TTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ummOq0BPRVh49xOI3AREULY3XTQqUE/33/Tmxt5Px+U=;
        b=mUBscbqm0D7qswLTvjGOPjSZt4nU8DJA+F4uXjPkouH8T1+E6pGCrwATuFQVtXjlAj
         bL/2GoXEf8PeYL3Oai2UsXXM+DYnKJLj080ZhiO6iYqmAa82p82/gp+LWHnqHv/S0Cor
         6cjbWNlT/Y+jaCpHgIqucajBcND2gI+jEReZku7cVjHUkBLdSaF7SZciXPPfrE9NC0oR
         j3OcsK1QOP2EbKoEIc8UiTA6a3mTwoyXtvRmM2/VC27Ls7exrzxZzbu3qZ6Nim5CggHf
         ofmj9h++yzFYLGYVh/IATxc3ZQ/M9aILgYSUH7Yf44PPiPqQwatXw8OAqYaYEiym6uw4
         RuzQ==
X-Gm-Message-State: ACgBeo2EFrOmrm4jfGbg41RJTgtAWL53u2nI0Jb1XQvpKh8RE5i7mhJP
        hFezh4EWLm6tQoLHtbFDEkjOshNlFbfLOOhsblU=
X-Google-Smtp-Source: AA6agR7CbpMK7mHkc4It3zrHbkZJvqt/INRFSgrtKLRnOiz7BaIjieDIyj7PrhkkSFr55YMX+51Sol7+Zu5wIt/Ahc8=
X-Received: by 2002:ac8:7d49:0:b0:340:81b1:e320 with SMTP id
 h9-20020ac87d49000000b0034081b1e320mr9252340qtb.61.1659784644782; Sat, 06 Aug
 2022 04:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220805081909.10962-1-luke@ljones.dev> <CAHp75Vd4iEGkAE1Ds_Zyqi0P+gQbOyqvGoJctpOHNmMD7cUG0g@mail.gmail.com>
 <J6T6GR.SW0RXSJSYG9R1@ljones.dev> <CAHp75VcrSe4aTYo_cVCfhX=y1LjZPOJG1yh9SrLt_XQBzNoGhA@mail.gmail.com>
 <DPW6GR.725XHI643Y0N2@ljones.dev>
In-Reply-To: <DPW6GR.725XHI643Y0N2@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 6 Aug 2022 13:16:48 +0200
Message-ID: <CAHp75Vfas8mhAFBt2W002qFx7LCQLVs93v2tRmysS5E28Qiadg@mail.gmail.com>
Subject: Re: [PATCH 0/5] asus-wmi: Add support for RGB keyboards
To:     Luke Jones <luke@ljones.dev>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Sat, Aug 6, 2022 at 12:49 PM Luke Jones <luke@ljones.dev> wrote:

Please, do not top-post! It's not appreciated in the OSS community(ies).

> I do agree. It's what I meant by prepped. I think I've addressed
> everything you've raised, so I'll leave it to bake a few days with my
> testing then submit new version on Tuesday (Hans please wait for v2).

We are now at the merge window, it means you have enough time to take
review comments and address them carefully, no need to rush. Your
series at the best can be in v6.0, which is 2 months ahead, which
means we have somewhat 6-7 weeks for you to clean up and make the
series better.

> Many thanks for your time taken to review this. I'm not an expert at C
> or the kernel by any stretch so reviews are critical for me. Also thank
> you for the link on git messages - I'll go through each patch and
> ensure they're better.

You are welcome!

> On Sat, Aug 6 2022 at 12:02:19 +0200, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Aug 6, 2022 at 11:33 AM Luke Jones <luke@ljones.dev> wrote:
> >>  On Sat, Aug 6 2022 at 11:10:37 +0200, Andy Shevchenko
> >>  <andy.shevchenko@gmail.com> wrote:

...

> >>  I do have another version already prepped
> >
> > Hold on and try to address many more review comments. It seems the
> > series needs much more work, otherwise it will be spam in the mailing
> > list and demotivating reviewers to continue.

-- 
With Best Regards,
Andy Shevchenko
