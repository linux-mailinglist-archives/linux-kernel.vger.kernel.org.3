Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D706A4D0055
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242916AbiCGNoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238096AbiCGNoD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:44:03 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A94E39BB5
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:43:08 -0800 (PST)
Received: from mail-wm1-f53.google.com ([209.85.128.53]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M730b-1nWSAf2e2J-008d4S; Mon, 07 Mar 2022 14:43:06 +0100
Received: by mail-wm1-f53.google.com with SMTP id 7-20020a05600c228700b00385fd860f49so8466386wmf.0;
        Mon, 07 Mar 2022 05:43:06 -0800 (PST)
X-Gm-Message-State: AOAM5325uxvMeZJhs7tB3Wtt5JfYsN7qiVM3AFXkR9JirypI050qM5Fa
        3A/XNWfBuZ1A473NuecMAoI87I8FySHyK39B2f0=
X-Google-Smtp-Source: ABdhPJyTtGPr9s9B1mZzmqCrZmSsLyAz3eETwOB51BFC6zHOSBf2jVQeZcONFBUofjQXajeBJF0dq7rq6IexZ7L5htw=
X-Received: by 2002:a05:600c:3b89:b0:389:a466:43bf with SMTP id
 n9-20020a05600c3b8900b00389a46643bfmr4690265wms.1.1646660586211; Mon, 07 Mar
 2022 05:43:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1646629400.git.tonyhuang.sunplus@gmail.com> <c6b959b3ac966f0c95487df0f9b9efc79c93983f.1646629400.git.tonyhuang.sunplus@gmail.com>
In-Reply-To: <c6b959b3ac966f0c95487df0f9b9efc79c93983f.1646629400.git.tonyhuang.sunplus@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 7 Mar 2022 14:42:49 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2TmizZhkqxqB9DnmjnwzRZwWH+90Wc7WWaCMCm7KP7pg@mail.gmail.com>
Message-ID: <CAK8P3a2TmizZhkqxqB9DnmjnwzRZwWH+90Wc7WWaCMCm7KP7pg@mail.gmail.com>
Subject: Re: [PATCH v10 2/2] misc: Add iop driver for Sunplus SP7021
To:     Tony Huang <tonyhuang.sunplus@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <Dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        gregkh <gregkh@linuxfoundation.org>,
        =?UTF-8?B?V2VsbHMgTHUg5ZGC6Iqz6aiw?= <wells.lu@sunplus.com>,
        Tony Huang <tony.huang@sunplus.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:TIlCeZuYCAYIf5zfU2gE4gAe0V+zbE19DN5Yj0Da3T5+OQk8Uac
 mYR2nvqJJ6ImE6V2C6IoPjcHQG76bdQ1uLdMlxFH6eAemp9IL0AMcEbvLLqo39t0qO7VCm/
 2ZZAFRupBX4kLwPMw9n7bu1Wxp7BkRG6O1BMqGHvwEdcXFaWK6HXYwhyYeQVjB25iCKN6Pm
 nS1Nm8ucrfh9YlMF5DdWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Os1sH2Kone0=:Bhh3UJj+duHblOQ5KVUumJ
 h+UTe2RW91ivmoA4iYStMlXgci+SVgSMD11G7PzqKnZByf3GBc1T04IZOKcahI9WjjeGz6mvb
 Cc2MwiTAFf6+kCaa1k7kR2pMmdAcz5xFXMDqvzNVGz5UeMyp33UupJdtLdAGA4NuxJRCf17jZ
 locTSiiggLZg2lBAXmCsT3JcvOpJPrMnDtIqxGiGfOI/PbcW+FF9hF2VGRfU5LIlPHSa/66Bn
 VDbjD4W5lLlaseEznkFT7bn6OzImfGivBPlYSeRM+R8sfdsiVOqGZMEGESBbWsDNvxT5g8KMJ
 AsgexjTtqAVq7/iXTIcxUfSjh4QDcSjYmWtV0ZD5YtFXT01+HEL4NByMw4+br+8UmYQHWBNki
 UbzzzKlRnlXyfoPIc7L9u3Qb+EHqmDoS+BMJ/5+ZNoN7LR2WlwWcKxpuWCY/vjRmz0oRZwF2E
 15Tw/eTdmh2VhO2xgLBl/TB9Wen0ZqM84K5SRKiPubIN3eiD/Qp5MykYMUv0HpJCRh57f3ta4
 yIxajs+QjaxTNd9/F3XSolxUSXXlg9F16sXWEmzckYJf7sl+AQdGAlVxfEOAL5a5Ke0L82hzI
 ZTQeszJohbjaEpWe6WbLw2T++mvL5y5ApVuJiP2zYMowmu29sf5f12ITQqPK+Ay7Sd+ft6Qqn
 rZzz5npOBFG3yjFrhMQDj0nZgJs16bGALD67KF7u5MfDigg/zmocATg2mWAUcomyAsA0gCeKD
 Xb+4MCUZT99KWamgHdvwRQQI/jSM7MpWVPBwb+tTFaiQBSGjRgajCnblDHnwHasbPs28H9AgZ
 Zp/nBPvz8bDgYr6Hq1UYcoErcvhv439N57Hqtm3qzeQIHJxYsg=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 7, 2022 at 6:25 AM Tony Huang <tonyhuang.sunplus@gmail.com> wrote:
>
> This driver is load 8051 bin code.
> Processor for I/O control:
> SP7021 has its own GPIO device driver.
> The user can configure the gpio pin for 8051 use.
> The 8051 support wake-up with IR key after system poweroff.
>
> Monitor RTC interrupt:
> SP7021 system has its own RTC device driver (rtc-sunplus.c).
> The user can set the RTC wake-up time through rtc-sunplus.c.
> The IOP code does not need to increase the RTC subsystem function,
> set the RTC register.   When the linux kernel system is poweroff.
> Only the 8051 CPU has power and can monitor the RTC wake-up interrupt.
>
> PMC in power management purpose:
> Add sp_iop_poweroff() function. pm_power_off=sp_iop_poweroff.
> When the poweroff command is executed.
> The 8051 has a register to control the power-on and power-off
> of the system. If you turn off the power through the 8051
> register(DEF_PWR_EN_0=0). The current measured by the circuit
> board is 0.4mA only. In order to save power.
> Changes in v10:
>  - Added sp_iop_poweroff function for poweroff command.
>

Thank you for finally adding support for one of the functions of the
hardware!

> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 0f5a49f..3106f15 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -470,6 +470,42 @@ config HISI_HIKEY_USB
>           switching between the dual-role USB-C port and the USB-A host ports
>           using only one USB controller.
>
> +config SUNPLUS_IOP
> +       tristate "Sunplus IOP support"
> +       default ARCH_SUNPLUS
> +       help
> +         This driver is load 8051 bin code.
> +         Processor for I/O control:
> +         SP7021 has its own GPIO device driver.
> +         The user can configure the gpio pin for 8051 use.
> +         8051 support wake-up with IR key after system poweroff.
> +
> +         Monitor RTC interrupt:
> +         SP7021 system has its own RTC device driver (rtc-sunplus.c).
> +         The user can set the RTC wake-up time through rtc-sunplus.c.
> +         The IOP code does not need to increase the RTC subsystem function,
> +         set the RTC register. When the linux kernel system is poweroff.
> +         Only the 8051 CPU has power and can monitor the RTC wake-up interrupt.
> +
> +         PMC in power management purpose:
> +         Add sp_iop_poweroff() function. pm_power_off=sp_iop_poweroff.
> +         When the poweroff command is executed.
> +         The 8051 has a register to control the power-on and power-off of the system.
> +         If you turn off the power through the 8051 register(DEF_PWR_EN_0=0),
> +         The current measured by the circuit board is 0.4mA only. In order to save power.

The description sounds misleading here: At the moment, you only add
support for poweroff, not for system suspend.

Maybe leave out the description about the RTC and power savings here
and only describe the bits that the driver actually implements. Can you
add some text to the patch changelog to describe what your plans are
for supporting suspend mode, and clarify which functions are implemented
already, compared to those that are possible in hardware but not part
of this patch series?


> +static void sp_iop_run_standby_code(struct sp_iop *iop)
> +{
> +       void __iomem *iop_kernel_base;
> +       unsigned long reg;
> +
> +       iop_kernel_base = ioremap(iop->iop_mem_start, STANDBY_CODE_MAX_SIZE);
> +       memset(iop_kernel_base, 0, STANDBY_CODE_MAX_SIZE);
> +       memcpy(iop_kernel_base, iop->iop_standby_code, STANDBY_CODE_MAX_SIZE);

'standby' mode usually refers to 'suspend-to-ram' mode, which is something
the driver does not (yet) support. Can you clarify whether that means you
want to add it later, or you just used the wrong term here?

> +
> +/* 8051 informs linux kerenl. 8051 has been switched to standby.bin code. */
> +#define IOP_READY      0x0004
> +#define RISC_READY     0x0008
> +
> +/* System linux kernel tells 8051 which  gpio pin to wake-up through. */
> +#define WAKEUP_PIN     0xFE02
> +
> +/* System linux kernel tells 8051 to execute S1 or S3 mode. */
> +#define S1     0x5331
> +#define S3     0x5333

Again, the names here seem misleading: in power management terms,
's1' and 's3' typically refer to types of system power saving modes that
are different from power-off or suspend-to-disk. Maybe try to use less
confusing terms here?

> +       /* IOP Hardware IP reset */
> +       reg = readl(iop->moon0_regs + IOP_RESET0);
> +       reg |= 0x10;
> +       writel(reg, (iop->moon0_regs + IOP_RESET0));
> +       reg &= ~(0x10);
> +       writel(reg, (iop->moon0_regs + IOP_RESET0));

This looks like you are writing individual bits into a shared
clock/reset controller that is part of the SoC. If this is the case,
it would be better to make that a separate driver that owns
the moon0_regs registers and exposes them through the
clk and reset subsystem interfaces (drivers/clk, drivers/reset).

> +static void sp_iop_poweroff(void)
> +{
> +       struct sp_iop *iop = iop_poweroff;
> +       unsigned int ret, value;
> +
> +       value = readl(iop->iop_regs + IOP_DATA11);
> +       sp_iop_run_standby_code(iop);
> +
> +       ret = readl_poll_timeout(iop->iop_regs + IOP_DATA0, value,
> +                                value == 0x2222, 1000, 100000);
> +       if (ret)
> +               dev_warn(iop->dev, "timed out\n");
> +
> +       if (value == S1)
> +               sp_iop_s1mode(iop->dev, iop);
> +       else
> +               sp_iop_s3mode(iop->dev, iop);
> +}

The power-off logic should probably be a separate driver in drivers/power/reset/
that calls into the common driver.

        Arnd
