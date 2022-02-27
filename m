Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 302CE4C5DCE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:30:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbiB0RbN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:31:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiB0RbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:31:12 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4749F25E96
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:30:34 -0800 (PST)
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MEVBa-1nPz7r0yLq-00Fzuo for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022
 18:30:33 +0100
Received: by mail-wm1-f45.google.com with SMTP id o62-20020a1ca541000000b00380e3cc26b7so4735547wme.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:30:33 -0800 (PST)
X-Gm-Message-State: AOAM531rPEyH7Ea4A0ESC2CsUF/kmcwIL4riIgaUjR3x20vALmn1vF9f
        EWdNeM0pO5sDfTxoRPi5pkHbcB1HfIYlZtoQup8=
X-Google-Smtp-Source: ABdhPJwWQPX+WO4ZFIxdng/hWsq3PtI1KI58HrYUwP0fUnhubYI0+LbCGjUUGeUmZA0Of6HrpYFGO9CF/iADLqXHOzw=
X-Received: by 2002:a05:600c:3b87:b0:381:428c:24c1 with SMTP id
 n7-20020a05600c3b8700b00381428c24c1mr6876110wms.1.1645983032924; Sun, 27 Feb
 2022 09:30:32 -0800 (PST)
MIME-Version: 1.0
References: <20220226222457.13668-1-rdunlap@infradead.org> <CAK8P3a07PoFGC8jyRG5_CjfVPCc2T79c7Fs_WmHZEkuqtG+oPg@mail.gmail.com>
 <449d6ceb-7308-9543-c23c-831bebffda21@infradead.org>
In-Reply-To: <449d6ceb-7308-9543-c23c-831bebffda21@infradead.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sun, 27 Feb 2022 18:30:16 +0100
X-Gmail-Original-Message-ID: <CAK8P3a30RbSk3Y5CyRrOjfTiq0c9XGxC3qjAD0154j3a7k+xQQ@mail.gmail.com>
Message-ID: <CAK8P3a30RbSk3Y5CyRrOjfTiq0c9XGxC3qjAD0154j3a7k+xQQ@mail.gmail.com>
Subject: Re: [PATCH -next] misc: rtsx: fix build for CONFIG_PM not set
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Wei WANG <wei_wang@realsil.com.cn>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:x8HtxP8Lcj1tXiYIsvhDYYMSJCHjcgMsFI+1G7Dn3O9PjCUE3D0
 QEWUYx991VT9wpgBjfNInHbYui55hCAu/N0EDaspfVTtBgFqf4Vn/2f6VjEni/mvtw5SsgA
 XXysaeXsO7i7Kd04Jdedlf2D9zfBovRWsHofWZ6EdfugnTEqG2BKX33VlkvI6dGMQ5RSsLJ
 SKMWApTFAX70dGUFuwJOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:M7hsI5rETnM=:bMJE9hUddH/fmz9PovUUPK
 1fh/KgC+IW7/qKvUBdpxzAawwLX3WWhSOxBArhMSLc7+c3StGx0Lam8JVELTelq7WH0nHoS5n
 IAVtNmTr5L3EJ4PLeaU1U4BjmTaTEsyUPI2VlWj9F6AbrvcNwFl/O8M1tOE9eRMdHix/qG7J4
 h9Lppu24CE5YJ6S+z/B0GnynROQ3o7kYB/H2nz7m5Hn7Iy+OZlzmfHOlACHgIQxuTc9QlMySm
 R+zbkZY16d00YNsqHW65y6fL+A4do2NMuFn610k3URo5kjWDT7eJ3WibgY/ODQ5OdV8SvWlCZ
 a87S8K1dP2pOJ4qJTCE83SxoK2NQFeLMwwGUXVo+DmisvFSD3nfwzxDMlojd5WMBlkvKpt6hh
 9GGAksYRUZSg1NmEIc/FvkZrpiLEbRtqkPfFM3cljY9vdFU64mUaQh5XNrGqplrurYoExFZn4
 fPvcApKQW8LK6v07mkLJPsV0ODml3c9TGXmq60I2fl1gTlDz8/1mfFl12iuEukPDrvWgeiYOr
 xiSxd77f2FmlfSYEYn+2ZqNtRraEuyNORx3MOictIEa1EVErq+jNo0WP1x37CvjBtJ4PHJLmk
 +SbqpKqLmW29ezyXh97idE8VqkiO9cuqaaZqiAUX03HYpa1YSjnK0xJrd5gZoyEhmVLpwOTc0
 7P+NPfhTMrtjhXUvFGzQtDnXKBQeeJSAiQfykIZVqSn1kNh00pJiB/tsZ6YMuNqPGNIA=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 27, 2022 at 5:57 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 2/27/22 04:04, Arnd Bergmann wrote:
> > On Sat, Feb 26, 2022 at 11:24 PM Randy Dunlap <rdunlap@infradead.org> wrote:
> >
> >> ---
> >>  drivers/misc/cardreader/rtsx_pcr.c |    2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> --- linux-next-20220225.orig/drivers/misc/cardreader/rtsx_pcr.c
> >> +++ linux-next-20220225/drivers/misc/cardreader/rtsx_pcr.c
> >> @@ -1054,6 +1054,7 @@ static int rtsx_pci_acquire_irq(struct r
> >>         return 0;
> >>  }
> >>
> >> +#ifdef CONFIG_PM
> >>  static void rtsx_enable_aspm(struct rtsx_pcr *pcr)
> >>  {
> >>         if (pcr->ops->set_aspm)
> >> @@ -1085,6 +1086,7 @@ static void rtsx_pm_power_saving(struct
> >>  {
> >>         rtsx_comm_pm_power_saving(pcr);
> >>  }
> >> +#endif
> >
> > Now that we have DEFINE_SIMPLE_DEV_PM_OPS() etc, I think we should
> > no longer add more __maybe_unused annotations or #ifdef CONFIG_PM checks
> > but just use the new macros for any new files or whenever a warning like
> > this shows up.
>
> In this case it looks like DEFINE_RUNTIME_DEV_PM_OPS() is better.
> Using DEFINE_SIMPLE_DEV_PM_OPS() still produces build warnings/errors
> for unused functions. And I do see 4 drivers that are already using
> DEFINE_RUNTIME_DEV_PM_OPS().
>
> Patch coming right up.

DEFINE_RUNTIME_DEV_PM_OPS() only references the three runtime functions
(rtsx_pci_runtime_suspend, rtsx_pci_runtime_resume and rtsx_pci_runtime_idle)
but not the pm-sleep functions (rtsx_pci_suspend and rtsx_pci_resume), so your
second patch doesn't look correct either.

I see there is a _DEFINE_DEV_PM_OPS() helper that appears to do
what we want here, but I'm not sure this is considered an official API. Adding
Rafael, Paul and Jonathan to Cc for extra input. As the macros are still
fairly new, I suspect the idea was to add more as needed, so maybe should
add a DEFINE_DEV_PM_OPS() to wrap _DEFINE_DEV_PM_OPS()?

        Arnd
