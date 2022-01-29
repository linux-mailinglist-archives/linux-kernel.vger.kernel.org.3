Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFBAA4A2BAE
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 05:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352406AbiA2Eyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 23:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352399AbiA2Ey3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 23:54:29 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21D28C061714;
        Fri, 28 Jan 2022 20:54:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id o11so8458299pjf.0;
        Fri, 28 Jan 2022 20:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1ktm236G0QkwmG44KAUluQZrFkW4Jko9pQso9DRXJbk=;
        b=nYylmxt5SGB897xKEjjFsoUc3H4xzxB8AyUDSKkOzaA5ynWzhr93XIwS6oLOzumtSj
         xzvHa9KVHfKhyMoa8M/f+v6aeobUny9MmfCEOgOUfK6IoBiScvgzd8Z4F8mvn6YRR65/
         CYRkPTKfLZ6sj59L1nXgyuGxcn9nbxTuoXYxOvXgn7nRFLvUmB0hcqXTH5uBvhcO0XtV
         ITHr40Qe94is6qsHS40n1aVUJHP8KokQgeMNwHn6liE4awc4YWWRvAo2tWo2JElDBtk5
         Fsg3dUqU6S6lYaTRnuAJQAxuD7Nj0XtnXLaowd1i8cXR/5MB9u1gfjSGu023CnSHEaeL
         Qb4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ktm236G0QkwmG44KAUluQZrFkW4Jko9pQso9DRXJbk=;
        b=C4Ugds7YCLirQ/oLkFe+ZLM50lUZlU/AlBk65kwAOkb8dqYh2aztXhknVZCxHfwvI7
         RCUMIT9oRC2ejOovta/cJNgtbRpmr35gBFEAA/jiG21GgI3oyWNAhP9xYlEWr/zyAT0K
         OEHMFXcx6eRRNS+TkvdnPWDjCavRjBL7qV3SPbL0qX5zGAD0PZcXSpz13oFrC45QdzpI
         vkI2CpgVU+niLWsXgG0+rQ4Qzq+PZbD+HTpHtpsrPjbC8tWDyW6xsWVgQF6I/PaBz9VK
         WS6AxU6HMhE2TBfQAgu7i5IY2s0DJ34b1t9ECwoeRKg1fMhD0b54tRkc0iqstb/JZlJT
         XixA==
X-Gm-Message-State: AOAM533O/74Rp2snvsWNsl70KIBiLLjDNjel/6Bd6RZJlNZNe5YeK3FW
        y011atzuOEXtLXcU0nGIYFy3+yCafHopMhdyqd0=
X-Google-Smtp-Source: ABdhPJyJE3pug2l7rYCJSUNqIusdi+jB5X2pn5LPD5XBzHa0c4/ozEVVkWzYEkyWo9fpBf9nZEErc4yOeQ60zRMgwrU=
X-Received: by 2002:a17:90b:181:: with SMTP id t1mr23050920pjs.240.1643432068514;
 Fri, 28 Jan 2022 20:54:28 -0800 (PST)
MIME-Version: 1.0
References: <CAM+2Eu+G2YK-O4ioYCBTJOs9VV9k5fVfQSii+m3kcyouJRg_vA@mail.gmail.com>
 <20220128103554.000028ff@Huawei.com> <YfQA8wRpauq058WK@smile.fi.intel.com>
In-Reply-To: <YfQA8wRpauq058WK@smile.fi.intel.com>
From:   jagath jogj <jagathjog1996@gmail.com>
Date:   Sat, 29 Jan 2022 10:24:16 +0530
Message-ID: <CAM+2EuKKX5v5vz5vZcSgdZ1xHJzAqiMmfZDU=KARehOLCU=14g@mail.gmail.com>
Subject: Re: IIO Device Driver for Maxim DS3502 potentiometer
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     jic23@kernel.org, lars@metafoo.de, aardelean@deviqon.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Jonathan and Andy Shevchenko,

Thanks for replying.

On Fri, Jan 28, 2022 at 8:14 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jan 28, 2022 at 10:35:54AM +0000, Jonathan Cameron wrote:
> > On Fri, 28 Jan 2022 09:11:28 +0530
> > jagath jogj <jagathjog1996@gmail.com> wrote:
> >
> > > Hello,
> > >
> > > I have a Maxim DS3502 potentiometer breakout and I have written an IIO
> > > driver for learning purposes and tested with Raspberry pi and wanted
> > > to send patches of the driver for the IIO sub-system.
> > >
> > > Can I send the patches for DS3502 POT for review?
> > >
> > > The setup used to write driver
> > > Raspberry pi 3b
> > > DS3502 breakout board
> > > Raspberry pi latest kernel branch - https://github.com/raspberrypi/linux
>
> > Welcome to IIO.
> >
> > Absolutely on sending the patches for review.
> > You'll need to rebase them on latest mainline from kernel.org
> > (pick a tagged version which would currently be 5.17-rc1_

I am using raspberry pi kernel branch rpi-5.17-y which is based on
mainline tag 5.17-rc1.
Is it required to rebase the changes to the latest tag version
5.17-rc1 from kernel.org?

> >
> > and then follow the documentation for how to submit a patch in
> > https://www.kernel.org/doc/html/latest/process/submitting-patches.html

Sure I will follow the documentation for submitting a patch.
I am also learning and recently submitted a patch series of code-style
fixes to the staging branch.

> >
> > Feel free to ask if you have any questions about the process.
> >
> > Looking forwards to seeing your code.
>
> Agree with Jonathan.
>
> One remark though, can you double check that drivers/iio/potentiometer
> doesn't have any similar driver that can be expanded (usually it can be
> done by analyzing a register file of the devices, like register offsets
> and their meanings or bit fields)?

In iio/potentiometer folder the existing Maxim DS1803 is having some
differences with DS3502 like

Maxim DS1803:
Number of wipers - 2
Number of Positions - 256 - 8 bit.
Memory map having 2 volatile registers used to store wiper value.
https://datasheets.maximintegrated.com/en/ds/DS1803.pdf


Maxim DS3502:
Number of wipers - 1
Number of Positions - 128 - 7 bit.
The memory map has 2 registers to store wiper value and mode
Supports non-volatile memory to store wiper value
Supports 2 modes - Mode 0 and Mode 1
https://datasheets.maximintegrated.com/en/ds/DS3502.pdf


So thought of writing the driver for DS3502 in a separate file.
Need some advice on this whether to implement it on a separate file or
to extend the existing driver.

>
> --
> With Best Regards,
> Andy Shevchenko
>

Regards,
Jagath
