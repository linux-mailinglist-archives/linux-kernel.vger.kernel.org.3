Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECF35A4463
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 09:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiH2H7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 03:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbiH2H7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 03:59:48 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C221EE;
        Mon, 29 Aug 2022 00:59:44 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id g16so5466397qkl.11;
        Mon, 29 Aug 2022 00:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=g7t/BY4DanplPrl7da5mnck18jW/2xAc45QCfnvQXO4=;
        b=RK8cgJfTAC5BpVAHLjFNqQRLC96gedrRCTeDrrNy+X+MP2G6ka61dZGTaYkibOJVoK
         d7Dej1HraTuweHeVuEjUjqCCdoa4qgqcyTG1FNKVZucP0xyFek2oVHyAPAtMz6f4VLvv
         +4J4qncWP7X5KzITsf0/ohNYFM1DteLeGZAyB4cBTJJpxXt4oJ5tnqxnjM/UdMf69GNh
         j+d3GNb9mRxWBYgeZiDauzeqZg4rghdnwEPavuo8BrkM5v/PDyX/IrZa3C+2IndWq99o
         ZKYTtnIPIKDPf+c/6/Z4o9aTlDBdqO20jP9spfJinAnvqwisBAsyXVfFC/EKhu+sw4pr
         rInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=g7t/BY4DanplPrl7da5mnck18jW/2xAc45QCfnvQXO4=;
        b=gNnT+HIm69F8cSzxVKQy2iUeYvmxmRtvMBk1inKOWovYMM9xE0Tgl5bvqB3HiG0jIF
         N8uVHYik2SJMYKjlQL9rPZib09mAgWqNbpcp+GdtW2BQxsJqpD90XP9vGXVaurfOZ0FV
         20u7cD/3F2NU/GDtRMBMnSUuNpHS3VAk6KtUijYAUbSe0rYBL4mwpY9UIhLmobAHGVC5
         lkpsBxgvoxWpzHeWqa9EU2YGRAkJLhMO8J8aqblLyiAlE7r/SaOzp98syfoAnkAwrK0d
         RyXvawvQGvxRuc7ODeAAzgzkEEe8x7CM3rFD+aH18kn4pi9yrht/gwBDcNMsA0TPUaXK
         eXRQ==
X-Gm-Message-State: ACgBeo0Qvxjwl9sn2mDP1qiJZKZl/TpapICPLe9oHHA3G2bIINS/vQmz
        x+zk6tt7SKx8bTSeEkvsRKlHyyMPPpj1U955Ia0=
X-Google-Smtp-Source: AA6agR43upvOu7ID2TzzW6S1NEhyG9G3pwO02U2fdyvD3RoRznwwm+L7k66+Oax4H0qLbD6PMidnJweV5UkWi/Z4CgQ=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr7445131qko.383.1661759983909; Mon, 29
 Aug 2022 00:59:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220826170716.6886-1-andriy.shevchenko@linux.intel.com>
 <20220826170716.6886-4-andriy.shevchenko@linux.intel.com> <5ba98dbd91dc981ec7384484b2a498805abef6b0.camel@perches.com>
 <CAHp75VfY5RgAju5ASvAp565oF6VmYYiuowNsPTGSm=+1iFJ98A@mail.gmail.com>
 <2e158f8dc433b6b78d47d209495bed678d92369a.camel@perches.com>
 <CAHp75Vc0NtYcuSUP106V54U6EBYsj3LMx2FDJT4_pfB3gAtpPQ@mail.gmail.com> <25705469f329005a4ff699d1f45a12dcb575adc0.camel@perches.com>
In-Reply-To: <25705469f329005a4ff699d1f45a12dcb575adc0.camel@perches.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Aug 2022 10:59:07 +0300
Message-ID: <CAHp75VezJ41z7KUbJE5Fo-oO7W-+nD00A23Gnqmfp6eUL7VT6w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] pwm: sysfs: Utilize an array for polarity strings
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
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

On Sun, Aug 28, 2022 at 9:19 PM Joe Perches <joe@perches.com> wrote:
> On Sun, 2022-08-28 at 20:40 +0300, Andy Shevchenko wrote:
> > On Sun, Aug 28, 2022 at 4:46 PM Joe Perches <joe@perches.com> wrote:
> > > On Sun, 2022-08-28 at 09:40 +0300, Andy Shevchenko wrote:
> > > > On Sunday, August 28, 2022, Joe Perches <joe@perches.com> wrote:
> > > > > On Fri, 2022-08-26 at 20:07 +0300, Andy Shevchenko wrote:
> > > > > > Code is smaller and looks nicer if we combine polarity strings
> > > > > > into an array.
> >
> > > > First of all, please remove unnecessary context when replying.
> > >
> > > I am _very_ aware of context.
> > > I specifically left the code in.
> > >
> > > > > It's less robust though as PWM_POLARITY_NORMAL and _INVERSED
> > > > > are now required to be 0 and 1.  As the only 2 values in
> > > > > an enum they are, but that's not really guaranteed unless
> > > > > you read the enum definition.
> > > >
> > > > So, what do you suggest here and in many other similar places (yes, ABI
> > > > implied) in the kernel?
> > >
> > > Leaving the code alone.
> >
> > It's good that PWM maintainers look at this differently.
>
> The enum is not userspace so it's not ABI.
>
> The PWM maintainers are free to do what they want but I
> prefer obviousness over compactness.

Why do you not start "fixing" other similar places in the kernel?

-- 
With Best Regards,
Andy Shevchenko
