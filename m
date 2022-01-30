Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23AA34A366E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 14:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347062AbiA3NBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 08:01:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347045AbiA3NBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 08:01:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F598C061714;
        Sun, 30 Jan 2022 05:01:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1F707611B6;
        Sun, 30 Jan 2022 13:01:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BA29C340E4;
        Sun, 30 Jan 2022 13:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643547666;
        bh=lv1NYkTsnpKsQ6QkpeAhopAhLE8l2nu1E7smKsJjD9E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OmxHjNugVw3zmQ2E23vHMwTkMh3bHM6Swnkpyl26d5M9YK3m0A01K18a7r1WNjR6G
         ug+GHBJ4Y45KcmSUo5yq2umZyWqWKxJZcRHOCY4za/cFei5kB1+ND8mF8Bh5XirCfC
         MuBjZ95ydNcaOxR3046aZOD9cStsn3gzJQkSPUAXnBDy6FQeuuSKPLE34OKubhb3NH
         vHsIC6+5XftgNL9urtbp8ZdrpXd+twDU/lppXaOXKf4vtRypEjxfZZMLkCmcxX1EGJ
         dS2SGab2GN6SiWuv8kqZGb6HCcVVzq+PkGmTQpV1IbQOi86WGGp5JoB1lk6s09qXih
         IB4cHyqm0u6Wg==
Date:   Sun, 30 Jan 2022 13:07:29 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     jagath jogj <jagathjog1996@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        lars@metafoo.de, aardelean@deviqon.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: IIO Device Driver for Maxim DS3502 potentiometer
Message-ID: <20220130130729.0df15678@jic23-huawei>
In-Reply-To: <CAM+2EuKKX5v5vz5vZcSgdZ1xHJzAqiMmfZDU=KARehOLCU=14g@mail.gmail.com>
References: <CAM+2Eu+G2YK-O4ioYCBTJOs9VV9k5fVfQSii+m3kcyouJRg_vA@mail.gmail.com>
        <20220128103554.000028ff@Huawei.com>
        <YfQA8wRpauq058WK@smile.fi.intel.com>
        <CAM+2EuKKX5v5vz5vZcSgdZ1xHJzAqiMmfZDU=KARehOLCU=14g@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2022 10:24:16 +0530
jagath jogj <jagathjog1996@gmail.com> wrote:

> Hello Jonathan and Andy Shevchenko,
> 
> Thanks for replying.
> 
> On Fri, Jan 28, 2022 at 8:14 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Jan 28, 2022 at 10:35:54AM +0000, Jonathan Cameron wrote:  
> > > On Fri, 28 Jan 2022 09:11:28 +0530
> > > jagath jogj <jagathjog1996@gmail.com> wrote:
> > >  
> > > > Hello,
> > > >
> > > > I have a Maxim DS3502 potentiometer breakout and I have written an IIO
> > > > driver for learning purposes and tested with Raspberry pi and wanted
> > > > to send patches of the driver for the IIO sub-system.
> > > >
> > > > Can I send the patches for DS3502 POT for review?
> > > >
> > > > The setup used to write driver
> > > > Raspberry pi 3b
> > > > DS3502 breakout board
> > > > Raspberry pi latest kernel branch - https://github.com/raspberrypi/linux  
> >  
> > > Welcome to IIO.
> > >
> > > Absolutely on sending the patches for review.
> > > You'll need to rebase them on latest mainline from kernel.org
> > > (pick a tagged version which would currently be 5.17-rc1_  
> 
> I am using raspberry pi kernel branch rpi-5.17-y which is based on
> mainline tag 5.17-rc1.
> Is it required to rebase the changes to the latest tag version
> 5.17-rc1 from kernel.org?

I'll probably be fine as I wouldn't expect the raspberry pi tree to
be carrying any changes in this area.  If there are minor issues I can
usually just fix them up whilst applying.

> 
> > >
> > > and then follow the documentation for how to submit a patch in
> > > https://www.kernel.org/doc/html/latest/process/submitting-patches.html  
> 
> Sure I will follow the documentation for submitting a patch.
> I am also learning and recently submitted a patch series of code-style
> fixes to the staging branch.
> 
> > >
> > > Feel free to ask if you have any questions about the process.
> > >
> > > Looking forwards to seeing your code.  
> >
> > Agree with Jonathan.
> >
> > One remark though, can you double check that drivers/iio/potentiometer
> > doesn't have any similar driver that can be expanded (usually it can be
> > done by analyzing a register file of the devices, like register offsets
> > and their meanings or bit fields)?  

Excellent question.

> 
> In iio/potentiometer folder the existing Maxim DS1803 is having some
> differences with DS3502 like
> 
> Maxim DS1803:
> Number of wipers - 2
> Number of Positions - 256 - 8 bit.
> Memory map having 2 volatile registers used to store wiper value.
> https://datasheets.maximintegrated.com/en/ds/DS1803.pdf
> 
> 
> Maxim DS3502:
> Number of wipers - 1
> Number of Positions - 128 - 7 bit.
> The memory map has 2 registers to store wiper value and mode
> Supports non-volatile memory to store wiper value
> Supports 2 modes - Mode 0 and Mode 1
> https://datasheets.maximintegrated.com/en/ds/DS3502.pdf
> 
> 
> So thought of writing the driver for DS3502 in a separate file.
> Need some advice on this whether to implement it on a separate file or
> to extend the existing driver.

These potentiometer drivers tend to be very simple, (the ds1803 is
only 167 lines long so you may find that you'd end up adding more
code to make it flexible enough to take your new part than a
new driver would need.

So perhaps the question we should ask is if we are likely to see
support for a wide range of similar parts?  If we are then now
is a good time to make the driver more flexible.

Working that out will require some datasheet diving..
My guess is the ds3501 is pretty similar but with some extra bits.

Given these are fairly simple, your best route to an answer might
be to try adding it to the existing driver and see if you run
into any significant complexity.

It's not unheard of for us to merge drivers together in the future
once it becomes clear that we are supporting lots of similar ones
but it is easier done at the start!

Jonathan


> 
> >
> > --
> > With Best Regards,
> > Andy Shevchenko
> >  
> 
> Regards,
> Jagath

