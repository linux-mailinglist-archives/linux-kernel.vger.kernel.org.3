Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145774B9366
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 22:57:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235889AbiBPV5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 16:57:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBPV5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 16:57:42 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85961C0877
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:57:28 -0800 (PST)
Received: from mail-wr1-f46.google.com ([209.85.221.46]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N7zJl-1oOjyv3eE7-0155LK for <linux-kernel@vger.kernel.org>; Wed, 16 Feb
 2022 22:57:26 +0100
Received: by mail-wr1-f46.google.com with SMTP id p9so5593213wra.12
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 13:57:26 -0800 (PST)
X-Gm-Message-State: AOAM531pOF0NGET/47C6e93tRVmynxFJRwByagclvh3SDv6mKNKyEw+P
        dDUP7vx+PweCcCfejsXaPPmyqtdaMJgIIpCIaVw=
X-Google-Smtp-Source: ABdhPJy4TaSAbu3O4akLaPE582nz9GPbUnUBrmFHllvu9wsGBth6d7vyhyzP/+yZHKneOvXUmzYgT2XOaiks1750mBM=
X-Received: by 2002:adf:90c1:0:b0:1e4:ad27:22b9 with SMTP id
 i59-20020adf90c1000000b001e4ad2722b9mr19974wri.219.1645048646454; Wed, 16 Feb
 2022 13:57:26 -0800 (PST)
MIME-Version: 1.0
References: <nick.hawkins@hpe.com> <20220216183704.42084-1-nick.hawkins@hpe.com>
In-Reply-To: <20220216183704.42084-1-nick.hawkins@hpe.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 16 Feb 2022 22:57:10 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com>
Message-ID: <CAK8P3a2Ryjr738XgLsGQngvc7j=Kk620LMjWpu-_HiwdK_fX4Q@mail.gmail.com>
Subject: Re: [PATCH] [v1] arch: arm: configs: gxp_defconfig
To:     "Hawkins, Nick" <nick.hawkins@hpe.com>
Cc:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Russell King <linux@armlinux.org.uk>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Olof Johansson <olof@lixom.net>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:RD6IGPs35jvz9huTuylUJHNsorL0sMoNb0B0rKBnuOUaw1/hHsS
 eN+K3oOgVgk7DkY+zkhcb9rXbqaigrVTgna+LKXngDf8tUKOzdNHVhAD3KZqe7cc/1QzH0C
 reADJHTrJ0VOct5SMJSiknTr+PSmpTe8tfFq/GPU4F96I1uRg2LArhDeX25WinlcLaITPRi
 5T/tmdTl5ViM1UgJHvyOQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YIPEPRLBR9E=:7GvOp3MNW7e8EONZiGrqqY
 Vt9O1wWl9kDPDB5/LQXopNEw4mIOWVDfA+LZ74sbyjmFf9AbYlRPNURsnZpLXezB17eYg+4gy
 eMdXYA51KOAjFJ4+/+XyDL1IKdSXLUoygoavtlwvnkLEhQJB9KUQTMGOIxFp43PCgYYxzqu6K
 dA7uDcg2I/Pw1h68wFjAlp3ovH+AqeWhtOaTOYdYRzDXULUfAEEItfvkfHy+friPesDe9isvJ
 ecaOOits+kKm42rfm5vFZUpY7WWSe8ThlrSr6p2tp3ilkoYWcN00TXa21WkxERQIlNMQmYsre
 7Z9SMH9ZxnVZZ+oCOQFU7r6Tf6bjz2J2vFuB1ruU/Lna80QAZvZXlGHcBMvk0/j2aXXR8Hjk7
 d+G6upHkGtm+J1gieGV5aH9hfDYrj12wA0y+Yn/4471vUx3YjfoNEbrbo+zkknuRywNkfio2p
 8hFjtF53+4F5bTIISPzY5ramNr7gNFkiarpjURd6TSiR/8Z+UtkSRXIPW1xE9nO1tVdRpOKiT
 5MQc2H5p7YWfNUHAFJrJtSlUIwk1rcmj2neMh+tShGPF+1uzPGNJIrCVoRQqTz2q00ejHxtj1
 91FecTz76ASSrDfjhwTshoouMRP6hDUWXb3y45m9p+UoGLd9z3qboP50Qyq4aUMDJy2Dvv8Gh
 M1rmTVipfGGQlbztrhogArmw9YbA4yAg5fFLLhNlHIiUe/KuYhcX+DCnJutMzg5JVkak=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 16, 2022 at 7:36 PM <nick.hawkins@hpe.com> wrote:
>
> From: Nick Hawkins <nick.hawkins@hpe.com>
>
> Description: Adding the configuration file for the upcoming
>  hpe gxp soc.
>
> Note: This patch is part of a set with patches:
>   [v4] arch: arm: boot: dts: Create HPE GXP Device Tree
>   [v1] dt-bindings: timer: Add HPE GXP Timer binding
>   [v1] dt-bindings: watchdog: Add HPE GXP Watchdog timer binding
>   [v1]dt-bindings: vendor-prefixes: add HPE Prefix
>   [v1] dt-bindings: soc: Add HPE GXP SOC binding
>
> Additional Note: Maintainers will be updated in separate patch
>  to cover all of the above patches.

Please have a look at other patch series for the style of the submission.

All the information above doesn't really go in the individual patches, as it
is not meant as part of the permanent git history. Instead, keep the
series together as one thread the way that git-format-patch generates it,
and put information about the patch series into the cover letter.

One bit of information that I would like to see in the defconfig patch
is an explanation about why you need a custom defconfig in the
first place, rather than using multi_v7_defconfig. Please also add
a patch to enable your platform in the multi_v7_defconfig, along with
the drivers you need (as loadable modules).

See Documentation/process/submitting-patches.rst for more detail.

> Information: GXP is the name of the HPE SoC.
>  This SoC is used to implement BMC features of HPE servers
>   (all ProLiant, Synergy, and many Apollo, and Superdome machines)
>    It does support many features including:
>     ARMv7 architecture, and it is based on a Cortex A9 core
>     Use an AXI bus to which a memory controller is attached,
>     as well as multiple SPI interfaces to connect boot flash,
>     and ROM flash, a 10/100/1000 Mac engine which
>     supports SGMII (2 ports) and RMII Multiple I2C engines to
>     drive connectivity with a host infrastructure
>     A video engine which support VGA and DP, as well as
>     an hardware video encoder
>     Multiple PCIe ports
>     A PECI interface, and LPC eSPI
>     Multiple UART for debug purpose, and Virtual UART for
>     host connectivity
>     A GPIO engine.

More whitespace damage here, probably from a copy-paste mistake.

> Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>
> ---
>  arch/arm/configs/gxp_defconfig | 243 +++++++++++++++++++++++++++++++++
>  1 file changed, 243 insertions(+)
>  create mode 100644 arch/arm/configs/gxp_defconfig
>
> diff --git a/arch/arm/configs/gxp_defconfig b/arch/arm/configs/gxp_defconfig
> new file mode 100644
> index 000000000000..f37c6630e06d
> --- /dev/null
> +++ b/arch/arm/configs/gxp_defconfig
> @@ -0,0 +1,243 @@
> +CONFIG_KERNEL_XZ=y
> +CONFIG_DEFAULT_HOSTNAME="gxp"
> +CONFIG_SYSVIPC=y
> +CONFIG_NO_HZ=y
> +CONFIG_HIGH_RES_TIMERS=y
> +CONFIG_BSD_PROCESS_ACCT=y
> +CONFIG_BSD_PROCESS_ACCT_V3=y
> +CONFIG_LOG_BUF_SHIFT=18
> +CONFIG_CFS_BANDWIDTH=y
> +CONFIG_RT_GROUP_SCHED=y

Try to trim the bits that you don't actually rely on, such as hostname

> +CONFIG_CGROUP_FREEZER=y
> +CONFIG_CGROUP_DEVICE=y
> +CONFIG_CGROUP_CPUACCT=y
> +CONFIG_NAMESPACES=y
> +CONFIG_SCHED_AUTOGROUP=y
> +CONFIG_RELAY=y
> +CONFIG_BLK_DEV_INITRD=y
> +CONFIG_CC_OPTIMIZE_FOR_SIZE=y
> +CONFIG_KALLSYMS_ALL=y
> +CONFIG_EMBEDDED=y

You probably don't need BLK_DEV_INITRD if you
use initramfs instead, and you should not need EMBEDDED either.

> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SLAB=y
> +CONFIG_ARCH_MULTI_V6=y

Since there is only one ARMv7 SoC enabled in here, there is no need for enabling
ARMv6. A v7-only kernel will run more efficiently and allow you to
build with more
features such as THUMB2.

> +CONFIG_ZBOOT_ROM_TEXT=0x0
> +CONFIG_ZBOOT_ROM_BSS=0x0

These are just the default

> +CONFIG_NETDEVICES=y
> +# CONFIG_NET_VENDOR_ALACRITECH is not set
> +# CONFIG_NET_VENDOR_AMAZON is not set
> +# CONFIG_NET_VENDOR_AQUANTIA is not set
> +# CONFIG_NET_VENDOR_ARC is not set
> +# CONFIG_NET_VENDOR_AURORA is not set
> +# CONFIG_NET_VENDOR_BROADCOM is not set
> +# CONFIG_NET_VENDOR_CADENCE is not set
> +# CONFIG_NET_VENDOR_CAVIUM is not set
> +# CONFIG_NET_VENDOR_CIRRUS is not set
> +# CONFIG_NET_VENDOR_CORTINA is not set
> +# CONFIG_NET_VENDOR_EZCHIP is not set
> +# CONFIG_NET_VENDOR_FARADAY is not set
> +# CONFIG_NET_VENDOR_GOOGLE is not set
> +# CONFIG_NET_VENDOR_HISILICON is not set
> +# CONFIG_NET_VENDOR_HUAWEI is not set
> +# CONFIG_NET_VENDOR_INTEL is not set
> +# CONFIG_NET_VENDOR_MARVELL is not set
> +# CONFIG_NET_VENDOR_MELLANOX is not set
> +# CONFIG_NET_VENDOR_MICREL is not set
> +# CONFIG_NET_VENDOR_MICROCHIP is not set
> +# CONFIG_NET_VENDOR_MICROSEMI is not set
> +# CONFIG_NET_VENDOR_NATSEMI is not set
> +# CONFIG_NET_VENDOR_NETRONOME is not set
> +# CONFIG_NET_VENDOR_NI is not set
> +# CONFIG_NET_VENDOR_QUALCOMM is not set
> +# CONFIG_NET_VENDOR_RENESAS is not set
> +# CONFIG_NET_VENDOR_ROCKER is not set
> +# CONFIG_NET_VENDOR_SAMSUNG is not set
> +# CONFIG_NET_VENDOR_SEEQ is not set
> +# CONFIG_NET_VENDOR_SOLARFLARE is not set
> +# CONFIG_NET_VENDOR_SMSC is not set
> +# CONFIG_NET_VENDOR_SOCIONEXT is not set
> +# CONFIG_NET_VENDOR_STMICRO is not set
> +# CONFIG_NET_VENDOR_SYNOPSYS is not set
> +# CONFIG_NET_VENDOR_VIA is not set
> +# CONFIG_NET_VENDOR_WIZNET is not set
> +# CONFIG_NET_VENDOR_XILINX is not set

No need to mention all these, leaving them default-enabled is fine.

> +CONFIG_TTY_PRINTK=y
> +CONFIG_IPMI_HANDLER=y
> +CONFIG_IPMI_DEVICE_INTERFACE=y
> +CONFIG_IPMI_SI=y
> +CONFIG_IPMI_SSIF=y
> +CONFIG_HPE_KCS_IPMI_BMC=y
> +CONFIG_HW_RANDOM_TIMERIOMEM=y
> +CONFIG_I2C_CHARDEV=y
> +CONFIG_I2C_GXP=y
> +CONFIG_I2C_SLAVE=y
> +CONFIG_I2C_SLAVE_EEPROM=y
> +CONFIG_SPI=y
> +CONFIG_GPIOLIB=y
> +CONFIG_GPIO_SYSFS=y
> +CONFIG_GPIO_GXP=y
> +CONFIG_SENSORS_EMC1403=y
> +CONFIG_SENSORS_GXP_FAN_CTRL=y
> +CONFIG_SENSORS_GXP_CORETEMP=y
> +CONFIG_SENSORS_GXP_PSU=y
> +CONFIG_SENSORS_GXP_POWER=y

Maybe leave out the custom drivers for now, and only
enable the drivers that are already merged, or added as
part of the same series.

> +CONFIG_WATCHDOG=y
> +CONFIG_GXP_WATCHDOG=y
> +CONFIG_MFD_SYSCON=y
> +CONFIG_FB=y
> +CONFIG_FB_THUMBNAIL=y
> +CONFIG_FB_SIMPLE=y

I would keep CONFIG_FB disabled for new platforms.

> +CONFIG_DEBUG_USER=y
> +CONFIG_DEBUG_LL=y
> +CONFIG_DEBUG_LL_UART_8250=y
> +CONFIG_DEBUG_UART_PHYS=0xC00000F0
> +CONFIG_DEBUG_UART_VIRT=0xF00000F0
> +CONFIG_DEBUG_UART_8250_SHIFT=0
> +CONFIG_EARLY_PRINTK=y

Better leave out the debugging options here, and only list the ones
that you would
enable in a production device.

        Arnd
