Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7370A4A3E38
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 08:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347972AbiAaHaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 02:30:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbiAaHaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 02:30:06 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17B6C061714;
        Sun, 30 Jan 2022 23:30:06 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 132so465949pga.5;
        Sun, 30 Jan 2022 23:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8540buR6jq4JvTgLvEtqgUz40tmjsRstSslY4tLKDMc=;
        b=Et3BD/iiynlv5xZwILZXCUQes0i5+49+ovLlfAAxgMKZV4RKOxN3vZ3OEu4abqUvQ4
         jurqpuj84lERJh2b9w1HE6uXnvOmsF4NwxDSE+F2zBH8r0/lfiPjb28W1J5m10xvAu9P
         TWu6MUxl9JFmtjSzt2rUmlBvO9CAsBc8WsUe5nu2mmm31BwqwFIY6YVAXj+L/O/YvQZo
         3dtNpQ2zlWc0ySsIfPuz+Z3nS8J0D0eOpn/anmfzNAenmsTVO/7yok/1tEna29DSW2jD
         QJOKqHKb1FrHcvH3L1xwKrU/QqarkvZ2ndD280n33Hdn+fOWAtoDse+N9NcGDmbhsZuu
         EXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8540buR6jq4JvTgLvEtqgUz40tmjsRstSslY4tLKDMc=;
        b=D1OiNm8DqIbLfgtfktuK5XSWPBbC1AsoqXQdG2FMqs2DD7/jYbhsKZEqVIg0zeFIkW
         r8YYRLKM2lFfDvZA8N6ZAcl99exqkxyagmb1aZLWf/LvmdDHGVRwTm3xoDMOd6GvbrUJ
         tk2RnLcE0nZv05cWENA+jX7grO2a/dTj8aNk32HhIwP9U6TUDCChxyxgYvwKOGXe01N5
         EBUxvlOtmBXaADTnmC3H90GB67UVNPMSaV2fSBWSS2ZmdDg5vpUR4fuPMInO2bzaL7ZW
         G9H7x6D1rFmHiYaZc9WpK1vMJ3gc/2K/2qDngq7YgAXYP1UVioAFra2X+5OhfRZ4IVfn
         Mvxg==
X-Gm-Message-State: AOAM530wLKH5HewvhHqhD+JDIa0S1cnO7thtB22m9gEvoSfU60AuBFfE
        OnM+nVO94jRSFhZyFfW+4JrFRErIEsJGxKqLkbb0BJOnriw/eafH
X-Google-Smtp-Source: ABdhPJzxfzG32qlypUjhnyF9fB4n7ejHS1EcQ/SrPbWGXsMVTo4xyyN7xnDOx+GFeBD2jC/WsKr7YwXP4gSjvTKsnxQ=
X-Received: by 2002:a65:6b90:: with SMTP id d16mr15447785pgw.129.1643614206035;
 Sun, 30 Jan 2022 23:30:06 -0800 (PST)
MIME-Version: 1.0
References: <CAM+2Eu+G2YK-O4ioYCBTJOs9VV9k5fVfQSii+m3kcyouJRg_vA@mail.gmail.com>
 <20220128103554.000028ff@Huawei.com> <YfQA8wRpauq058WK@smile.fi.intel.com>
 <CAM+2EuKKX5v5vz5vZcSgdZ1xHJzAqiMmfZDU=KARehOLCU=14g@mail.gmail.com> <20220130130729.0df15678@jic23-huawei>
In-Reply-To: <20220130130729.0df15678@jic23-huawei>
From:   jagath jogj <jagathjog1996@gmail.com>
Date:   Mon, 31 Jan 2022 12:59:55 +0530
Message-ID: <CAM+2EuJDzjNY7+epBbNVqrOoY60SYFsoyX6uXEAf9hyu-kaKQA@mail.gmail.com>
Subject: Re: IIO Device Driver for Maxim DS3502 potentiometer
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        lars@metafoo.de, aardelean@deviqon.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 6:31 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Sat, 29 Jan 2022 10:24:16 +0530
> jagath jogj <jagathjog1996@gmail.com> wrote:
>
> > Hello Jonathan and Andy Shevchenko,
> >
> > Thanks for replying.
> >
> > On Fri, Jan 28, 2022 at 8:14 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > On Fri, Jan 28, 2022 at 10:35:54AM +0000, Jonathan Cameron wrote:
> > > > On Fri, 28 Jan 2022 09:11:28 +0530
> > > > jagath jogj <jagathjog1996@gmail.com> wrote:
> > > >
> > > > > Hello,
> > > > >
> > > > > I have a Maxim DS3502 potentiometer breakout and I have written an IIO
> > > > > driver for learning purposes and tested with Raspberry pi and wanted
> > > > > to send patches of the driver for the IIO sub-system.
> > > > >
> > > > > Can I send the patches for DS3502 POT for review?
> > > > >
> > > > > The setup used to write driver
> > > > > Raspberry pi 3b
> > > > > DS3502 breakout board
> > > > > Raspberry pi latest kernel branch - https://github.com/raspberrypi/linux
> > >
> > > > Welcome to IIO.
> > > >
> > > > Absolutely on sending the patches for review.
> > > > You'll need to rebase them on latest mainline from kernel.org
> > > > (pick a tagged version which would currently be 5.17-rc1_
> >
> > I am using raspberry pi kernel branch rpi-5.17-y which is based on
> > mainline tag 5.17-rc1.
> > Is it required to rebase the changes to the latest tag version
> > 5.17-rc1 from kernel.org?
>
> I'll probably be fine as I wouldn't expect the raspberry pi tree to
> be carrying any changes in this area.  If there are minor issues I can
> usually just fix them up whilst applying.

Thank you

>
> >
> > > >
> > > > and then follow the documentation for how to submit a patch in
> > > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html
> >
> > Sure I will follow the documentation for submitting a patch.
> > I am also learning and recently submitted a patch series of code-style
> > fixes to the staging branch.
> >
> > > >
> > > > Feel free to ask if you have any questions about the process.
> > > >
> > > > Looking forwards to seeing your code.
> > >
> > > Agree with Jonathan.
> > >
> > > One remark though, can you double check that drivers/iio/potentiometer
> > > doesn't have any similar driver that can be expanded (usually it can be
> > > done by analyzing a register file of the devices, like register offsets
> > > and their meanings or bit fields)?
>
> Excellent question.
>
> >
> > In iio/potentiometer folder the existing Maxim DS1803 is having some
> > differences with DS3502 like
> >
> > Maxim DS1803:
> > Number of wipers - 2
> > Number of Positions - 256 - 8 bit.
> > Memory map having 2 volatile registers used to store wiper value.
> > https://datasheets.maximintegrated.com/en/ds/DS1803.pdf
> >
> >
> > Maxim DS3502:
> > Number of wipers - 1
> > Number of Positions - 128 - 7 bit.
> > The memory map has 2 registers to store wiper value and mode
> > Supports non-volatile memory to store wiper value
> > Supports 2 modes - Mode 0 and Mode 1
> > https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
> >
> >
> > So thought of writing the driver for DS3502 in a separate file.
> > Need some advice on this whether to implement it on a separate file or
> > to extend the existing driver.
>
> These potentiometer drivers tend to be very simple, (the ds1803 is
> only 167 lines long so you may find that you'd end up adding more
> code to make it flexible enough to take your new part than a
> new driver would need.
>
> So perhaps the question we should ask is if we are likely to see
> support for a wide range of similar parts?  If we are then now
> is a good time to make the driver more flexible.
>
> Working that out will require some datasheet diving..
> My guess is the ds3501 is pretty similar but with some extra bits.

Yeah DS3501 is similar to DS3502 with an additional temperature sensor.

>
> Given these are fairly simple, your best route to an answer might
> be to try adding it to the existing driver and see if you run
> into any significant complexity.
>
> It's not unheard of for us to merge drivers together in the future
> once it becomes clear that we are supporting lots of similar ones
> but it is easier done at the start!
>
> Jonathan

Thanks for your input. I will try to add the DS3502 with the existing
driver DS1803
then I will try to add DS3501 to the same driver.
There are drivers like iio/temperature/maxim_thermocouple.c and
iio/adc/max1027.c
where multiple devices with some differences are handled with a single
driver file.
I will consider them as references to add the ds3502 into existing ds1803.c.


>
>
> >
> > >
> > > --
> > > With Best Regards,
> > > Andy Shevchenko
> > >
> >
> > Regards,
> > Jagath
>

Regards,
Jagath
