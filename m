Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4A3496D2F
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 19:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234654AbiAVSCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 13:02:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234642AbiAVSCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 13:02:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6C2C06173B;
        Sat, 22 Jan 2022 10:02:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 901A660E97;
        Sat, 22 Jan 2022 18:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F0B9C004E1;
        Sat, 22 Jan 2022 18:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642874556;
        bh=DHZ83qWLfNcBtCSmnXBCZiiYLp4jLMHJJYrG3LGuaC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QJS91lJzbSSyc/RUycYlfVhYHIulWqJ1zOqfcOR4ixHRU5h43Ouge1GGMcbbLXwkr
         VOtaxLmYxDhnunljy2pRbsM67yOYTUPA3ae1Ww/DwrgmWW03ZgvfDrGd/rMfuDTqU7
         sx9H9jAM68YJDQSTneaOzjRs/QnhF2Q1geGDwrWAC3QZyLou8GW+0oe2ju1TYs2vS+
         Sn7baoacO52KJlULAzFd09YBdh1r4yLVD+VMsAxrZap47zhxwqATJI+Z6TOggzG59U
         Ur0qZ1enyxcwNKhatNkG7OZBts46vvG7TlgZ4zmjzJgQo8kIhg6Pzap1bpe+Rh0Efx
         dVKnzDhUdgaGQ==
Date:   Sat, 22 Jan 2022 18:08:43 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andrea Merello <andrea.merello@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Matt Ranostay <matt.ranostay@konsulko.com>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v2 06/10] iio: document bno055 private sysfs attributes
Message-ID: <20220122180843.2fa8ca0c@jic23-huawei>
In-Reply-To: <CAN8YU5OT44Wz813tKA62-Dvq3=VoTcoyVE__5UuRw+i7+B7i8w@mail.gmail.com>
References: <20210715141742.15072-1-andrea.merello@gmail.com>
        <20211028101840.24632-1-andrea.merello@gmail.com>
        <20211028101840.24632-7-andrea.merello@gmail.com>
        <20211028120405.6ffb01d1@jic23-huawei>
        <CAN8YU5Orbbzq-eDxmrR00xHwXQ=0LU2G3_yEtHGMkbVhmdcqgg@mail.gmail.com>
        <20211114162032.425ab36d@jic23-huawei>
        <CAN8YU5NO5mcrPa5ZCB3XnAb=3N3cyXZUT=gH5G+EbnM-En0a3Q@mail.gmail.com>
        <20220115152749.173b7172@jic23-huawei>
        <CAN8YU5OT44Wz813tKA62-Dvq3=VoTcoyVE__5UuRw+i7+B7i8w@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jan 2022 10:37:33 +0100
Andrea Merello <andrea.merello@gmail.com> wrote:

> Trivial inline comments below. Beside that, I've found another
> pleasing issue with this "range" thing on this device..
> 
> One one hand, things seem to always work as we discussed for the
> accelerometer (i.e. range doesn't affect the scale; the HW always
> provides readings in the same scale, but with different range and
> precision) on the other hand, the gyroscope behavior depends by the
> internal IMU firmware version.. great..

*sigh* :)

> 
> Stock firmware has a bug[0], so that the "range" gyroscope registers
> do change the scale indeed. AFAICT stock firmware is the one you find
> in most (all?) breakout boards, which are usually available (and which
> I'm using right now for this driver mainlining attempt). Upgrading
> firmware looks like a rather obscure process that AFAICT can be done
> only in some specific USB-stick demo-board ("shuttle board") or with
> maybe with FAE assistance on custom developed boards [1] (i.e. maybe
> can be done by some professional user; I would say not for most
> people).
> 
> So, I'm now wondering how to handle this... I really want to support
> the stock FW, which seems the most widespread, and the one I have
> right now; I'd say this means: the accelerometer thing will still work
> as we discussed (i.e. the range attribute thing), while the gyro will
> have writeable scale, and a (ro) scale_available attrib. But what
> about the gyro range thing? Should I drop it, or keep it as
> informative read-only?

I'd be cynical and for initial version at least, just hide it as 'too
complex' with a comment in the driver code on why.

> 
> Then I could also support the new firmware (which I cannot test right
> now with my actual breakout board, but I might see whether I could get
> a board with an updated IMU), keeping also the current driver behavior
> (i.e. range stuff).
> 
> But the question is: in either cases (new vs old fw) should the
> non-necessary attributes disappear or they may just be RO or locked
> (i.e. scale_available for new FW and range stuff for the old one)?

If they don't have meaning then they should disappear, but it would
also be valid to have the 'broken' one be read only if there is
an appropriate value.

> 
> Any thoughts and advice on this whole thing would be very welcome :)
> my current inclination anyway now tends to be: go on supporting only
> the stock FW (i.e. the board I have here now) and eventually add
> support for the new fw later on, after merge.

Sounds sensible - but.... Make sure you check the firmware version
number (I hope it has one) and print a warning at least if you get
one that you have strong reason to believe will handle this differently
from whatever the driver is supporting.

This is definitely going to be a case for detailed comments in
the driver code so that we can 'recall' what on earth was
going on here in N years time!

> 
> [0] https://community.bosch-sensortec.com/t5/MEMS-sensors-forum/BNO055-Wrong-sensitivity-resolution-in-datasheet/td-p/10266
> [1] https://community.bosch-sensortec.com/t5/MEMS-sensors-forum/BNO055-Software-Version/td-p/14001
> 
> > > I've looked at other iio sysfs attributes in the DOC.  It seems  that
> > > "thesh" and "roc" attributes allows for both preprocessed and raw
> > > data: I found e.g. "<type>[Y][_name]_<raw|input>_thresh_value", but
> > > the related "what" entries written above all seem to omit both "_raw"
> > > and "_input"; I don't understand why.  
> >
> > Excellent point.  That documentation is garbage.  Events are meant
> > to pick it up implicitly from the related channel _raw or _input.
> > I don't remember them ever having raw or input in their naming but
> > it's possible they did right at the beginning before the ABI was anywhere
> > near stable.  Gah. I dread to think how long that that has been wrong.  
> 
> Ok, great :)
> 
> > So I think range_raw postfix is the best bet.  
> 
> Will go with this, thanks.
> 
> > Jonathan
> >
> >
> >
> >
> >  
> > >  
> >  
> > >
> > > Andrea  
> >  

