Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61548467728
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:18:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380738AbhLCMVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:21:21 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:58659 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352004AbhLCMVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:21:18 -0500
Received: from mail-wr1-f52.google.com ([209.85.221.52]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MqJZl-1mFR1n2mCR-00nOFh; Fri, 03 Dec 2021 13:17:52 +0100
Received: by mail-wr1-f52.google.com with SMTP id a9so5284460wrr.8;
        Fri, 03 Dec 2021 04:17:52 -0800 (PST)
X-Gm-Message-State: AOAM533xWpn0cKNz6+T1yDbvViAv/WkEORtxfziiOzMsN2e3tOIZ/ZUV
        blCqBXAXuGUZ0YMhOPqKlwJOIV5USTf3E3jnPj0=
X-Google-Smtp-Source: ABdhPJwRnUClqFcZZLA3gYDrqnxJVnsISTuZXWTX8qrKJrfJr1zOhwX0AxekQAwy9F1umOSxmDj7hKn+a4j2epGOJSU=
X-Received: by 2002:a5d:6886:: with SMTP id h6mr21922197wru.287.1638533867300;
 Fri, 03 Dec 2021 04:17:47 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638499659.git.tonyhuang.sunplus@gmail.com> <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <9bb79f74ff1b08a5f9a1f6707b3b41484506468a.1638499659.git.tonyhuang.sunplus@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Dec 2021 13:17:31 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2XW=9ch58x7Shjd1ZeFka67sxEb5ZfJy-ZNtQe-j7xVg@mail.gmail.com>
Message-ID: <CAK8P3a2XW=9ch58x7Shjd1ZeFka67sxEb5ZfJy-ZNtQe-j7xVg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] misc: Add iop driver for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>, wells.lu@sunplus.com,
        Tony Huang <tony.huang@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:kWNk2lH3BIM1bR2hpQH7Xpwj+7HR3ziR++kaKHPzhVCPjkuoPeH
 YKUAWf1XafLjpW6EQlra959UFGn79A+nRHWcs1gPVgXL83Td1IxFDyu9quMdvk3bqAysb2F
 h5fhn6KWMKRHhoXPiDoAgAXIHl3km7+xyfwuOq+TWjL++QEaCJwhTogutaraInRiYwW6wU3
 Rk9IAOl1QQuJ+IWjB8CDQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:T6c7MhmhFLw=:SD+fgpm8IqM5VwUeAXnvjJ
 N94l8E+lY5Zc8eloA0SW6Huqz4M+sY2lvAXqRcBgzo6lAaTTKyC6kJcB2CHMR9bWX1Md4oxfv
 yjipThATZobXo6AvK+LSOq5+e+m+C9qMnvC9eqVK1U5SukC2WbwJp7AyXuxnspIPvug2CAzb+
 KyUkCPBX1COi9f7W6yOZ3d1QkSXsUWcX7HNI8zyFBgNN92hVSzAh7p0IfW0qwS5a4aiQjvEXI
 Qkar2P8QaxT3QMT6ZSAo/uLH2FvOfnt/D4Z+B256y76RValg4eKcmUQ9kqSn1DiXEDtNI/KMl
 gNYTFtE54ucurIEZJWkB7+RnJot1f11uv2f5tSEHOdwMM8HgTT7AVK+xyvR9DJtvTTMzHf1v8
 AIqQ0Nj0zPhgzzpdvGDxFxftb685E+dIIE770wcJ8Ie1G3/lhwlu4bmAsYNJZky9MLD58FPH7
 HUuEChA4Pl0IuGkPNOsmYQI/h9y5JCDqSywRVmv3QHd+GqBBZTzcf7+S07Kh6296rFz6Agggx
 bLn5a0Ri0RMpBvL3pToyouA/Zm077tfZpw2X+hlV4BbwKSpvNDlt0Bjqao65rnBmBEcizOMAv
 zhV8wT9ifN4sEEXjJaEx7hs789/jJnzjkJKsaUyIBdCtE3V2IieiGYT0QZuvGuYiIYx/9TWfJ
 B0HaGCcWCoUrGYQ1/Q55522hup9aC51fE7zRBPg9gBSeets1hhRlBgBtcmFKjAW0CJR2qA2sy
 VwP+eKeKcl9rJG0Stp19ddcDxyDdDSMzqIilXevelXB4yET63+CFUKLEl0k0D7onlUgL5zFwV
 Xx8PMxTZ10AlaIRwxZaTsD0jXrBuQOUR/1r5iR8lQ0tU27etGg=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 4:48 AM Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
>
> IOP (IO Processor) embedded inside SP7021 which is used as
> Processor for I/O control, RTC wake-up and cooperation with
> CPU & PMC in power management purpose.
> The IOP core is DQ8051, so also named IOP8051,
> it supports dedicated JTAG debug pins which share with SP7021.
> In standby mode operation, the power spec reach 400uA.
>
> Signed-off-by: Tony Huang <tonyhuang.sunplus@gmail.com>
> ---
> Changes in v2:
>  - Addressed comments from Arnd Bergmann.
>  - Addressed comments from Greg KH.
>  - Addressed comments from kernel test robot.

This looks much better already.

> +#define NORMAL_CODE_MAX_SIZE 0X1000
> +#define STANDBY_CODE_MAX_SIZE 0x4000
> +unsigned char iop_normal_code[NORMAL_CODE_MAX_SIZE];
> +unsigned char iop_standby_code[STANDBY_CODE_MAX_SIZE];

I think these should be part of the sp_iop structure, not global variables.

> +static struct sp_iop *iop;
> +
> +void iop_normal_mode(void)
> +{
> +       struct regs_iop *p_iop_reg = (struct regs_iop *)iop->iop_regs;

local functions should generally be 'static' and take the 'struct
sp_iop' instance
pointer as the first argument.

Functions that need to be global because they are used by other drivers
(if any) should probably also be exported and have documentation
above their definition.

> +static int  get_normal_code(struct device *dev)
> +{
> +       const struct firmware *fw;
> +       static const char file[] = "normal.bin";
> +       unsigned int err, i;
> +
> +       dev_info(dev, "normal code\n");
> +       err = request_firmware(&fw, file, dev);

The file name needs to clearly identify the device to avoid conflicts
with other drivers.

> +static int sp_iop_open(struct inode *inode, struct file *pfile)
> +{
> +       return 0;
> +}
> +
> +static ssize_t sp_iop_read(struct file *pfile, char __user *ubuf,
> +                       size_t length, loff_t *offset)
> +{
> +       return 0;
> +}
> +
> +static ssize_t sp_iop_write(struct file *pfile, const char __user *ubuf,
> +       size_t length, loff_t *offset)
> +{
> +       return 0;
> +}
> +
> +static int sp_iop_release(struct inode *inode, struct file *pfile)
> +{
> +       //dev_dbg(iop->dev, "Sunplus IOP module release\n");
> +       return 0;
> +}
> +
> +static const struct file_operations sp_iop_fops = {
> +       .owner                  = THIS_MODULE,
> +       .open                   = sp_iop_open,
> +       .read                   = sp_iop_read,
> +       .write                  = sp_iop_write,
> +       .release                = sp_iop_release,
> +};

This does nothing because all the callbacks are empty. You removed the
inappropriate
user space interfaces as I asked you to, but if there is no way for
either kernel or user
space to interact with the hardware, I don't see a point in merging
the driver until
you add a new interface that is usable.

> +static int sp_iop_platform_driver_remove(struct platform_device *pdev)
> +{
> +       return 0;
> +}
> +
> +static int sp_iop_platform_driver_suspend(struct platform_device *pdev, pm_message_t state)
> +{
> +       return 0;
> +}
> +
> +static void sp_iop_platform_driver_shutdown(struct platform_device *pdev)
> +{
> +
> +}
> +
> +void sp_iop_platform_driver_poweroff(void)
> +{
> +       iop_standby_mode();
> +       iop_shutdown();
> +}

Something looks wrong here, maybe reread the documentation for runtime
power management
to find a way of putting the device into low-power mode when it is unused.

> diff --git a/drivers/misc/iop/sunplus_iop.h b/drivers/misc/iop/sunplus_iop.h
> new file mode 100644
> index 0000000..fcbfd26
> --- /dev/null
> +++ b/drivers/misc/iop/sunplus_iop.h
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later*/
> +
> +#ifndef __SP_IOP_H__
> +#define __SP_IOP_H__
> +#include <mach/io_map.h>

mach/io_map.h does not exist, so the driver won't compile. I don't think you
need anything else, so it should be fine to remove the #include

The rest of the header only describes the hardware itself, so I'd
suggest merging
all of it into the .c file.

      Arnd
