Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 214ED4B70A5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 17:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240429AbiBOPkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 10:40:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240481AbiBOPj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 10:39:58 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9C5BF514;
        Tue, 15 Feb 2022 07:33:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id b14so58257ede.9;
        Tue, 15 Feb 2022 07:33:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZsGLRegII5LzYpB5pLn2eLB4RyUDQ3r2yhRyz4Zymro=;
        b=jfNjEi8CbnksxEcuUDLclL+6IjLUbKE123nwv+rvok1mLpVJRp+r0E8Ej2fX+oxXzJ
         yB6diuj6l+jftbmTJI3LMAqckJpGuNV3FYEU//5xKnrF7aGH+RCSYf6xm8J2rUM46da8
         S1TYcD2dVyS6I1xuZthtUfuuUz74usvZo4Mlx90aHYEa0H2JWImI+lEpvFzDGiGjR/SD
         c9AlqopcUGDQ/H+L2xY8+IpJJq8u7j2b7j7M27GfJ3RrXQm6AvgTVSOQSvdlaRkU3VLz
         n6tY8IdGWw7jK62SI6SmJlzzFlil+bwvgHyvqF/7tRMEH9p3sX4F3yQ5mDrGJwxnMfwH
         SATg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZsGLRegII5LzYpB5pLn2eLB4RyUDQ3r2yhRyz4Zymro=;
        b=MVh3E/AuoJpSYgw/8NcvcutEOakpnjxEHyOxan+mDFsp27PzOKZGDtbWCIlfQQ+uhi
         QQTLBdF8hvatxHdVdkJEBAZdPH3w4EH6yL0O5EGKZoHEp7FAkVJT6eyZyxcIBLUcECNC
         YKmFquF+U6d/h8PUvcfo/wmdmuZ7BrMXTzm6juIyF4BKwvhGaqWNFnduiXD6fD0KtAXt
         LOLXR5vqo5NL6hll03yp4+7otuP3dIPOEZO3gmWhYoFNZ2GD8SSEprVIkxzxDMFPIh4W
         VfOyhyiNWZoMcQOXIpIW4LNmejmntPQpSuZzMK9z09DR+4+pzSCaGuNj0fcHkjxWDOOl
         RqMA==
X-Gm-Message-State: AOAM530jA++WYvi2GFSnatKNHps1zCW1OYjFIuerQsGYwZReLPBdEDy2
        HMh/mMulVm06d6MC+QwNK5XTJH6PG5A9YL9Vq+lzvVVjTlo=
X-Google-Smtp-Source: ABdhPJx0iQBEjNIc0Q8xmP1W7X7hBCZCJz9B4zqeyE+5FeHf3/ETNGTJUXd0iuv8b/zzGZWu/aRpf1HbvXA8SSNqgaQ=
X-Received: by 2002:aa7:c395:: with SMTP id k21mr4518413edq.436.1644939196400;
 Tue, 15 Feb 2022 07:33:16 -0800 (PST)
MIME-Version: 1.0
References: <20220215042011.2266897-1-kai.heng.feng@canonical.com>
 <CAHp75VfBQPgrbuxazuoyDbFtGZR=rU5wqPhSXhkoiA_2HR1EHA@mail.gmail.com> <CAAd53p6tjWtKSqDDG_hjbFGKeR7-L3uYwgOTRNHfwAhmE8nV+g@mail.gmail.com>
In-Reply-To: <CAAd53p6tjWtKSqDDG_hjbFGKeR7-L3uYwgOTRNHfwAhmE8nV+g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 15 Feb 2022 17:31:48 +0200
Message-ID: <CAHp75Vdsd1sfDfvc=mutGGR8d4G9Q2b1t_m+Z=cDVkLhmzPU3Q@mail.gmail.com>
Subject: Re: [PATCH v3] iio: accel: adxl345: Add ACPI HID table
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Tue, Feb 15, 2022 at 1:30 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> On Tue, Feb 15, 2022 at 4:28 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Tue, Feb 15, 2022 at 6:20 AM Kai-Heng Feng
> > <kai.heng.feng@canonical.com> wrote:

...

> > > +       { "ADS0345:00", ADXL345 },
> >
> > This is wrong. First of all, on the left side you put the device
> > instance name (which must not be in the ID tables, since the device
> > instance name is "ID + instance number"). Second, the motivation of
> > this is not clear, if the device is enumerated by ACPI, why do you
> > care about board code?
>
> I was uncertain on this at first, but later I saw some drivers use
> this form (*:00) too, so I just followed through.

Those "drivers" are actually so called board files, i.o.w. hard coded
pieces of what firmware(s) missed. That's why they are using device
instance name(s) instead of the device IDs.

-- 
With Best Regards,
Andy Shevchenko
