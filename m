Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E632D4AB7B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:41:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351417AbiBGJf4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 7 Feb 2022 04:35:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbiBGJd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 04:33:59 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1E0C043185
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 01:33:58 -0800 (PST)
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M7sM0-1nLyDu3Ana-004xxj; Mon, 07 Feb 2022 10:33:56 +0100
Received: by mail-wr1-f54.google.com with SMTP id i15so1171093wrb.3;
        Mon, 07 Feb 2022 01:33:56 -0800 (PST)
X-Gm-Message-State: AOAM531FVzFiYBe9oQoUjUVtdbeJA9dkRPw65ncxvITmdjOEmQMNpBFx
        1mLTJlJS3oe/xYPJJVIVc/WOvUtmkVJ3INnKl9s=
X-Google-Smtp-Source: ABdhPJxjtwwhO8HbrAZC+pe3xlqcwLMS67h5t8QPdUjoAiwcCe9JR65SOdpgzS7AoShpWThk/xsDFtoHfw7IoFK1OEg=
X-Received: by 2002:a5d:500c:: with SMTP id e12mr9224078wrt.219.1644226436456;
 Mon, 07 Feb 2022 01:33:56 -0800 (PST)
MIME-Version: 1.0
References: <cover.1644212476.git.tonyhuang.sunplus@gmail.com>
 <b96f039dc071b1d32bb52fa283fd8afc6d3349cc.1644212476.git.tonyhuang.sunplus@gmail.com>
 <CAK8P3a0zNeaeOzC_tPb1KDbyktLpjUJCdEu=C6t_QX4pB9TKnQ@mail.gmail.com>
 <b440dc1dbb044a8c81d083d52774ad6b@sphcmbx02.sunplus.com.tw> <YgDar1O/CeTM8w6J@kroah.com>
In-Reply-To: <YgDar1O/CeTM8w6J@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Feb 2022 10:33:40 +0100
X-Gmail-Original-Message-ID: <CAK8P3a12JMhEB=qxXqRB0WFyUwvJ_VgwqMi6oWfpcgBr9OWrqQ@mail.gmail.com>
Message-ID: <CAK8P3a12JMhEB=qxXqRB0WFyUwvJ_VgwqMi6oWfpcgBr9OWrqQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] misc: Add iop driver for Sunplus SP7021
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     =?UTF-8?B?VG9ueSBIdWFuZyDpu4Pmh7fljpo=?= <tony.huang@sunplus.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Tony Huang <tonyhuang.sunplus@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:0J6Mjirsw0E3IG/qh0q2nAbRKNTVtM37ZcVLZVIhufKdfYTwePb
 ufaBmiVcfHThw1AX+PYgwnRQjrKJ3El1nMCbw7RfaILNYx/HAW8bUO7V3gsPkinRxt4yJzS
 J1iwCkmmsr72BleWDG6EXvtIeI38vIGIaWFhtjxFz/Uc6AJ9z97IoEwdPjL4miUYQo0h2JB
 IcVt6FjGFYyGKrmlOau6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nnk7vXobkyQ=:YU6oj9eTy74vHBOT95xtYq
 +FEDSEshobDZ9YpqhrtWJGdXXQFCuVbTu0c3RSZEq64oN+MTqJ4P/5JyPgGl7OJ4EYQaJRZKO
 h9cp1Nhg4duLBVM9Ezc/lYje0f1rDbg2eqxKGP0gb86r8XCsh5Q8kkO0rEdD2JRCLkQ+bvayW
 yGAsjQl60JEZVSFSBSbnoFpXenR6q4Gzd1mDE6SFZQaafH+lee1pwrSKIjP7XVW0qK/9tbZEU
 q6b48kp4NxYVG7fMfrqtcdZCUCKxEnwr8v4kAFNW7YanX9kAeDEA6EdQ3LOR6+lt23Ct7uNsr
 ItgLmln55CpE/sJC2rf8+zZJEwDbDoKmCAPlVx8CDUSYZni0VRx1nO0pvHyG1aV3E4FbW/Nlo
 sj6EGHgdW2bx9RriqfQ3x9SZ/tTuAnYD9108+jWi7qZMzYCDDRHDZIJH0hViGx1dOxdIWgVUh
 l8wr3XFH5hRYZNUVCPnXOj8mHRkEXwdLnU7VvPWdGSTB9AH+jSgVWKpBAqbXj1zJiM+brY406
 sfx0ePYWTWI3hI2fMv1nzvdyRV2s24NAu1+c7OQ0LYyCAtis/yPPT79ZRPVhj1LT8EBzoaLNa
 W8tBM9ndLzQ9ghtnMbOTlf3BsRBKLxlnAVMn68ckkq16nNWU/sai4OJI5/+e5vN+nqyKYu796
 /elIxYC44stT8pgPAn9nwJcKh/3xFEX7Tgiu9Iu0vmCWMvazY+f87LSeK0ywIUFK41UQ+cYWX
 N5oqIqu8t1DToQPVc+jjClsh0XC8Cmb31TZ5bPJIZSWEWCOn3xLwWVurkvbnLP2taRugeGqC5
 PjIpTiOQp3nkfpNqDcgfuqNyAtBa3VAXBqy36g8E7M4XYROeZk=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 9:39 AM gregkh <gregkh@linuxfoundation.org> wrote:
> On Mon, Feb 07, 2022 at 08:29:40AM +0000, Tony Huang 黃懷厚 wrote:
> > >
> > > As discussed before, I would suggest leaving out all custom attributes for now,
> > > and first hooking up the driver to all the in-kernel subsystems.
> > >
> > > The mailbox0 register data definitely feels like an implementation detail, not
> > > something that should be exposed to user space as an interface.
> > >
> > > For standby mode, this would normally be handled by the power management
> > > subsystem in the kernel. not a custom interface. From your earlier description,
> > > I assume this interface puts the main CPU into standby mode, not the IOP,
> > > right?
> > >
> > > CPU standby is handled by the cpuidle subsystem, so you need a driver in
> > > drivers/cpuidle/ to replace your sysfs attribute.
> > > If you plan to hook up the driver to multiple subsystems, keeping a generic
> > > driver file is ok, so  you'll end up with two driver modules, with one of them
> > > calling into the other, using
> > > EXPORT_SYMBOL() to link between them.
> > >
> >
> > The purpose of adding sysfs is only for users to debug.
> > So this is not needed?
>
> If this is only for debugging, please put it in debugfs and not sysfs.

I don't think that works for the idle mode interface, as this is the only
thing the driver really does at the moment.

In a previous review round, I already asked for the driver to implement
at least two in-kernel interfaces before any custom user interface
is added.

         Arnd
