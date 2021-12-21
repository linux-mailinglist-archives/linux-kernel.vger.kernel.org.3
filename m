Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB41E47C360
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 16:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236650AbhLUP4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 10:56:07 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:46399 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLUP4G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 10:56:06 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1N8oOk-1mNVDO3JJe-015uY1 for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021
 16:56:04 +0100
Received: by mail-wr1-f54.google.com with SMTP id a9so27810831wrr.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 07:56:04 -0800 (PST)
X-Gm-Message-State: AOAM532vfFJ4JtKrwmUcxxEV8tf6joYBHX93laX/sP9WDEfgocPTQCyH
        liM1/XyyJsCW3djDgT3NizFtDLzatmY5AlsfMGg=
X-Google-Smtp-Source: ABdhPJxf/tJ7mCajW2ItM8WsByzyghssZ+nfXJxfafMfPB7JDp3ZNP/6lkEbkqEgC9ywiAmTR2r4PviIBqZZ07+hCrQ=
X-Received: by 2002:a5d:484f:: with SMTP id n15mr3152015wrs.219.1640102164401;
 Tue, 21 Dec 2021 07:56:04 -0800 (PST)
MIME-Version: 1.0
References: <20211217172806.10023-1-vigneshr@ti.com> <CAK8P3a2VSBvOn1o+q1PYZaQ6LS9U4cz+DZGuDbisHkwNs2dAAw@mail.gmail.com>
 <06e60038-1365-fc35-801e-448c9025fb2a@ti.com> <20211221153250.GA2081238@bill-the-cat>
In-Reply-To: <20211221153250.GA2081238@bill-the-cat>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 21 Dec 2021 16:55:48 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2wNNSQkN_m3DzEF5RLmq1aED1JpOkXW9Yq13+ypiAaGQ@mail.gmail.com>
Message-ID: <CAK8P3a2wNNSQkN_m3DzEF5RLmq1aED1JpOkXW9Yq13+ypiAaGQ@mail.gmail.com>
Subject: Re: [GIT PULL 1/2] arm64: TI K3 SoC configs changes for v5.17
To:     Tom Rini <trini@konsulko.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>, Nishanth Menon <nm@ti.com>,
        Olof Johansson <olof@lixom.net>, SoC <soc@kernel.org>,
        arm-soc <arm@kernel.org>, Tero Kristo <kristo@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:Ru147CRvzypAdaQ2mwKc7gaSG0I/j2QEUfI7XeBumnmhTc1yxt7
 5Uh9/q8Vw9kfk0WiuFNfzTDGuxUorBxgfXzFOHV8XS31kk4yRNywOsWejZdTgNvnCd+p9ri
 +U4cnHqAopi5+ldJe64v7k4EjVb1cF/VJdOrlme2qyu4Q4pSs8yZnH7u3NHn8OQEAJh/guj
 gB1pMiJxbqQ1zGQ9zHjZA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:YO/WkdXpzw0=:8dBUT4spRE2Df1j9ddDVRs
 0djuaXgwm4Got+zd22TITBYn4GOXbdGAgt8yDRegd1aAE6l9a6XIbxXNKHqUurLCrefRqpxqK
 ermtpK7R/tPx1PBMIDhGgDdk3AE1Yz069P4Ve4OSRhtJU/6MjSGEYIjW5++4p260zhtD7qqfV
 B1ILIAmQ1jzNYsCPEZgfT/0PHNOzv6946uEqVPxbmkMvqKJjIdvk0eoq4D1Hw7XgZ6eKyyXO/
 334aHixDrIWmckronJZJA5KYGOQV6ACXLl65BqvmIkZgjIDDRTJEG1GGRUnqP0GGXC7EDV1WZ
 gF0pVJ+C7bNHIUlLAsYaCqeq8fCpd3QHfXz2OiqBvY8lNCdeQ84TX5Vk3sBRu9IYrrkzpEDP8
 pIAQwNSHgokEAW9TTOZpr7nMAjL4aw6Y2yRV+32NG0zCyUDyNPLVzOn5wPMsKJTv6WoZlzjW/
 LsUfXBPMXPGeeWZx1JE17HuOVqejeM1/Ut88xsh1wkX5EM0I83ByU1nT8M88MfYtqQq925FW/
 VvKNvgwtyKOABv1nnIWWNd1TYq91hU3rhbRUGX447dCtD82SM7civNs9g4MZ7IJyMk7XiGkrr
 k3mXtmAIA+Hiz3x1+ZarUzQwNQLcdSkI8Qiks2yrNnJ1ExlU1Z3NMulBF+wDaiZNDnToqUit+
 9CkpPim8xtlvaR+PAjfAkuSHK39tob7tA9zUUm9mSqUD0UJBu1y1RNeRXB+CeTWjGzxw=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 4:32 PM Tom Rini <trini@konsulko.com> wrote:
> On Mon, Dec 20, 2021 at 11:10:25PM +0530, Vignesh Raghavendra wrote:
> >
> > Currently its not possible to build PCIE_CADENCE_PLAT_HOST/EP drivers as
> > modules (symbols are bool only).
> > PCIe is not necessary for basic boot either. So, I can drop these
> > configs until these drivers are build able as modules, if you prefer.
>
> Is PCIe required for basic boot for the other platforms in the defconfig
> which do enable it in the defconfig today?  It is required for non-basic
> boot (whatever storage one puts in a PCIe slot).  If someone is going to
> be fixing the PCIe driver to be able to be modular, that's fine too but
> I ran in to this trying to see what works out of the box in the
> defconfig, on this platform and hit both of these rather large
> omissions.

If PCI is often used for storage, then that's ok. There are a number of
other platforms where PCIe is only used for wireless networking or
other secondary devices, but they are still built-in because they got
added before it became possible for PCIe host drivers to be loadable
modules. I would like to eventually go through and turn those into
loadable modules, but for the moment it would be good to only add
built-in drivers where this is actually useful.

       Arnd
