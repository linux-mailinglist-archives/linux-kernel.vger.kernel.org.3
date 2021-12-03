Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E75246779E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:49:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380925AbhLCMwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:52:47 -0500
Received: from mout.kundenserver.de ([217.72.192.75]:51511 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352128AbhLCMwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:52:44 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]) by
 mrelayeu.kundenserver.de (mreue108 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MIMT4-1mpql11ihY-00EMQE; Fri, 03 Dec 2021 13:49:19 +0100
Received: by mail-wr1-f49.google.com with SMTP id v11so5433881wrw.10;
        Fri, 03 Dec 2021 04:49:19 -0800 (PST)
X-Gm-Message-State: AOAM5300TFWpN4hHu2FE5wekfqBg3SuoFviiQAyKvFI8jj5VW0ax7N1F
        UOUI3QzzKBIGhsn0aNJCKfz6PUqpmPvwk6RskYE=
X-Google-Smtp-Source: ABdhPJwSlRJuFZwxVXh0a0H2e9y+Yzn5R1PWztERTao3ToEeH9gzxSGfWXq1zZ0egoqZqVYgiz1zwEbWGUw8Cm38CT0=
X-Received: by 2002:a5d:4107:: with SMTP id l7mr21409614wrp.209.1638535758993;
 Fri, 03 Dec 2021 04:49:18 -0800 (PST)
MIME-Version: 1.0
References: <cover.1638515726.git.qinjian@cqplus1.com> <c476d24e4492ad4cfff532a10d17a6a09c3a0e1a.1638515726.git.qinjian@cqplus1.com>
In-Reply-To: <c476d24e4492ad4cfff532a10d17a6a09c3a0e1a.1638515726.git.qinjian@cqplus1.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 3 Dec 2021 13:49:03 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0d9Z9ikM6AXGZd7p1T_zJUZg0fwHK=e5CeXtdniL3ExA@mail.gmail.com>
Message-ID: <CAK8P3a0d9Z9ikM6AXGZd7p1T_zJUZg0fwHK=e5CeXtdniL3ExA@mail.gmail.com>
Subject: Re: [PATCH v5 10/10] ARM: sp7021_defconfig: Add Sunplus SP7021 defconfig
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>, wells.lu@sunplus.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v/iNGVFuVF1jl8W4dosm0kQOLtNYlq4aWLjNyY6yL3DyBMydFI1
 Qagl23Roxvb0EPHJ8MIx1cuH6bEgU+O6t2jrzt23gne6lfJCYhce+A6bG1TIP+JRwe6aiBO
 qOlHj2cd9QrNELydi8vidNvYVesIqqiSpNwpsv73asfcpDTFSU7mVVKlmTTxvt7Bab00GXc
 wg3XwwHBkaoLly+xN7OJg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9P8NJgsKUX0=:tYRV2BYnV3YqiDiUiOsW8Y
 SMsdT8i7SCR4u9DPnxlweBEtGfpGuIUbbUM6qh6o98pqiDRvG5nFtA7STFUWeBhXwcOMtu/Te
 9ZCSKV3LLQX03+aTfF97XknA5Yg6TnoA9CfY2Bq27OCwHZARZHx1ZlrP14sFdddbh5EYjRga+
 322IDucysCg8NxxG6ycnAXI9HlxUD4HhB5jlRrExD36Gzg6yD4Ca7a/xnghFwtIZKelyjYCdM
 act51LwjxLB7jlBtYrTPdjcmO/NHQPds3OHwMsGz5CabcDsBFnGAGNy6PMlzB28p8TAtN93Xs
 a1N9opOZCQelRSIARgzPZ4aqPXpdSbSTGmE17hyAoTWmhaUYbCTVm7t8FKLurQLWTVVymue3F
 4ISgdD4Qa+p6Tyza/9sEnxuDKsGF9IuqHg/f+miYO6/bs5ClFQ+OWA89J0ijDpttAisNKaq8/
 PJ3pSgvKEse/WijfVZpp+H/fC59KAKiaY0tb77Orl8kTJW+c473MvKzGsj4VunnlxG1QutRTy
 x2Wt+6vveVsak/0bSpmzKqjUeuhFz/WEs1DlKv/9HQ3HHR32lOhNzeqo9IPquBrwaBjFu4SVM
 2JDmBc1AWUIaSPPiYqs5alHOFeccDrMa0GCZzM7AxN4o+l4UyPxALsQ8F1nwFy+wNSK1lwr5Q
 bgLH4QH2W4Ab65frMXl67iiAACuHqQCHzE3IRodBZ5gBxjwFaM5oqujssNcH5tWV9eTixTvKP
 XlFb5KnNKRDIFodqj8E3Vpc6iWAYRcSdkuyw8uEszcChYmPtDBcO9hevFdpMwz7jXRT9sne0x
 e38n6nRhW3/rknqmjzn3kdlyH4vrybjS9J5hWgM9YrQbBRD7eA=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 3, 2021 at 8:34 AM Qin Jian <qinjian@cqplus1.com> wrote:
>
> Add generic Sunplus SP7021 based board defconfig
>
> Signed-off-by: Qin Jian <qinjian@cqplus1.com>
> ---
>  MAINTAINERS                       |   1 +
>  arch/arm/configs/sp7021_defconfig | 178 ++++++++++++++++++++++++++++++

Most platforms don't even have a custom defconfig any more. If you
think you need this one,
I would suggest naming it sunplus_defconfig so it makes more sense
when other related
SoCs are added to it.

I would also suggest enabling your platform specific drivers in
multi_v7_defconfig,
and testing that one to ensure it works.

> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0ae537a41..9340f8760 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2664,6 +2664,7 @@ F:        Documentation/devicetree/bindings/arm/sunplus,sp7021.yaml
>  F:     Documentation/devicetree/bindings/clock/sunplus,sp7021-clkc.yaml
>  F:     Documentation/devicetree/bindings/interrupt-controller/sunplus,sp7021-intc.yaml
>  F:     Documentation/devicetree/bindings/reset/sunplus,reset.yaml
> +F:     arch/arm/configs/sp7021_*defconfig
>  F:     arch/arm/mach-sunplus/
>  F:     drivers/clk/clk-sp7021.c
>  F:     drivers/irqchip/irq-sp7021-intc.c
> diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
> new file mode 100644
> index 000000000..249fe779e
> --- /dev/null
> +++ b/arch/arm/configs/sp7021_defconfig
> @@ -0,0 +1,178 @@
> +CONFIG_DEFAULT_HOSTNAME="SP7021-Ev"

I'd leave this out of the defconfig

> +CONFIG_SYSVIPC=y
> +CONFIG_USELIB=y

You almost certainly don't need CONFIG_USELIB

> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_INITRAMFS_SOURCE="../rootfs/initramfs/disk/ ../rootfs/initramfs/initramfs.devnodes"
> +CONFIG_INITRAMFS_ROOT_UID=-1

This will cause a build failure for everyone else I think

> +CONFIG_EMBEDDED=y

Probably not needed, otherwise explain what option you need to touch
that depends on this.

> +CONFIG_PERF_EVENTS=y
> +CONFIG_SLAB=y
> +CONFIG_ARCH_SUNPLUS=y
> +# CONFIG_VDSO is not set
> +CONFIG_SMP=y
> +CONFIG_HAVE_ARM_ARCH_TIMER=y
> +CONFIG_THUMB2_KERNEL=y

Ah nice, we don't have enough defconfigs using THUMB2_KERNEL. This may mean
that you get reports about thumb2 specific bugs that nobody else runs
into, but that is
better than if nobody uses that.

> +CONFIG_HIGHMEM=y
> +# CONFIG_HIGHPTE is not set

What is the maximum amount of supported RAM? Note that HIGHMEM support
will likely
go away at some point, so it may be better to use a good VMSPLIT
setting that works with
all your machines without requiring highmem.

> +CONFIG_ZBOOT_ROM_TEXT=0x98307000
> +CONFIG_ZBOOT_ROM_BSS=0x03400000

Where do these come from? I see you don't set CONFIG_ZBOOT_ROM, so they will be
ignored, but if you do rely on these, it likely means that your
machine is unable to
run a multi_v7_defconfig kernel, which is bad.

> +CONFIG_CMDLINE="root=/dev/ram rw init=/init console=ttyS0,115200 earlyprintk mem=512M@0x0"

Remove this, the configuration should come from the bootloader.

> +CONFIG_AUTO_ZRELADDR=y

This is always enabled

> +CONFIG_CAIF=y

Are you actually using CAIF? Which driver do you use?

> +CONFIG_CEPH_LIB=y
> +CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y

Same here, do you use this?

> +CONFIG_INPUT_MISC=y
> +CONFIG_INPUT_UINPUT=y
> +CONFIG_SERIO_LIBPS2=y

Do you have a physical PS/2 keyboard connector

> +CONFIG_USB_VIDEO_CLASS=y
> +CONFIG_FB=y
> +CONFIG_FB_SP7021=y

CONFIG_FB is no longer recommended for new platforms, please use
CONFIG_SIMPLEDRM for the moment, until you have converted your
driver to the DRM framework.

> +CONFIG_GEMINI_USB=y

What is this?

> +CONFIG_EXT2_FS=y

If you use eMMC storage, I recommend using EXT4_FS instead of EXT2_FS


         Arnd
