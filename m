Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C93DD469123
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 09:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238813AbhLFIID convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Dec 2021 03:08:03 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:47141 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238716AbhLFIIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 03:08:02 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MK3eC-1n8vmD1mEo-00LTqQ; Mon, 06 Dec 2021 09:04:31 +0100
Received: by mail-wr1-f51.google.com with SMTP id u1so20527609wru.13;
        Mon, 06 Dec 2021 00:04:31 -0800 (PST)
X-Gm-Message-State: AOAM5329/VjG+2AlUocRidzx40G58O6uf91YVapQVZJOEnkpSgDtfvQD
        GC6nZIoilDcv+7ILmewgZEqRHyWns5dCPVAhBTk=
X-Google-Smtp-Source: ABdhPJxIlJKexaVFuSHywpkgMXuIh2sGVtvavHcOYjn08Sbs3218l2JWTeOtoIWJst6gvZ4jyZPR0HnL5GJFged0EUw=
X-Received: by 2002:a05:6000:110b:: with SMTP id z11mr41529354wrw.32.1638777871012;
 Mon, 06 Dec 2021 00:04:31 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com>
 <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a2XW=9ch58x7Shjd1ZeFka67sxEb5ZfJy-ZNtQe-j7xVg@mail.gmail.com> <9233c42fc4714122a3054a6c5bda0d3e@sphcmbx02.sunplus.com.tw>
In-Reply-To: <9233c42fc4714122a3054a6c5bda0d3e@sphcmbx02.sunplus.com.tw>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 6 Dec 2021 09:04:14 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2AgO2R-yQsT6nkiVU0J6pXa-bMnckrShey2EUZjAq3Uw@mail.gmail.com>
Message-ID: <CAK8P3a2AgO2R-yQsT6nkiVU0J6pXa-bMnckrShey2EUZjAq3Uw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
To:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:juVhkTxSm7ns/Oh2a/bnVUiBysxEHGeHUFgqW7yce3N9yKK9idv
 dbxge00yTpOvK21KBccTPpFX+/YkHFbiWA7lBoWonoirF0j6kPU6DJNhN84vezRuRb963ed
 IdbMKUod65k8XxiEaK1h1YHPNnFhqAWCEgRhr44Md4gJ54CqPvD3CsIOSOyyNiKJleouIpI
 7aXnFf8R1R+qXwE4cjKGA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:dBHeySd63oo=:/TmnEmNX+Qs1G5udsbxtS4
 EkD33hATNOk3R3nIs72+WttdnkmqVGrotN4zhFk9e3vkERIS7iVkRU+/ZnZiUUVK/+igpreLy
 moEf7Y94iUyMLE7A/3H0UOTeXFnq3rurVtliOoPdZf9pCZFyGjNnzXluIgoCwKJiciLPX7LjQ
 F2PRBMn1SdrCF4GBywHJ+Y5sNz3xBdM4qh8DYrzx0ZgM2i/iYzaLfvWovyr30GAzmCiVm8YqM
 N2qTZojKmNrEUCVG/IzwdjviAH8TWrGvatRNkYKxWy3sS/zwdtZLFefrjCdk+Nh3Yy2ebLasP
 sNV9TZw3d3Qql+4iUuHmQ/tLXA5z72eHPQUJKbsAf3kShz3LwSdN9g9gnRiNoLSJsFb/5/8q8
 sx5knM4AtVLQ4ijIm/uNyY+GUfccPqJYNA0v9XzWBn87z6V+ZfgLjvuNJAEVolhGF7Qhl2urE
 LaeF+eWpUtm7jrOvkUUnKJjg41AW8q8dbt673ahOYWPTyf+2VlGL27mbf84AP5RczsD1vYyFd
 hxGY41VqfSaxYv6RDNetL1CpfIsiACTuuXu5UNvcp6KZH7cSVoO2YFmbt6mZrGIbI/xos5f91
 rUFxd3CB49x/E0+vd81P3Uz1ntnjYJ5p+xP3yTAP04DRbC+/eFktlvAyqnp0yC6c4NryAInJg
 uulk4/tp+ZX71kRtg/uRzzoxsCb82OTX/zuvYdA5RTsVgf+LGkq6YYaK6fex1x/YRBwI=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 6, 2021 at 4:42 AM Tony Huang 黃懷厚 <tony.huang@sunplus.com> wrote:
> > Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
> > On Fri, Dec 3, 2021 at 4:48 AM Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
> > > +
> > > +static const struct file_operations sp_iop_fops = {
> > > +       .owner                  = THIS_MODULE,
> > > +       .open                   = sp_iop_open,
> > > +       .read                   = sp_iop_read,
> > > +       .write                  = sp_iop_write,
> > > +       .release                = sp_iop_release,
> > > +};
> >
> > This does nothing because all the callbacks are empty. You removed the
> > inappropriate user space interfaces as I asked you to, but if there is no way for
> > either kernel or user space to interact with the hardware, I don't see a point in
> > merging the driver until you add a new interface that is usable.
> >
>
> I will modify sp_iop_read() to monitor IOP mailbox data.

Why is this a useful interface to have? If this is only for debugging,
a tracepoint
may be more useful than a full character device.

> > Something looks wrong here, maybe reread the documentation for runtime
> > power management to find a way of putting the device into low-power mode
> > when it is unused.
> >
>
> When the poweroff command is executed, the run sp_iop_platform_driver_poweroff(void)
> function will enter the standby mode. The power off will be executed.
> In the system, IOP can continue to work when other modules in the system enter
> standby / power down modes to monitor whether the system wakes up through RTC.

Ok, in that case you can probably just remove the empty callback functions.

         Arnd
