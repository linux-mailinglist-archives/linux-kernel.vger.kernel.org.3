Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F2446A6AF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349557AbhLFUUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:20:23 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:48678 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349550AbhLFUUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:20:22 -0500
Received: from [192.168.50.18] ([146.241.138.59])
        by Aruba Outgoing Smtp  with ESMTPSA
        id uKPnm567IrmmOuKPnm6yxl; Mon, 06 Dec 2021 21:16:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1638821810; bh=Qdhx0uLObD6VmjbgQi/LtOmpCJZiNuHaAIau9CFzCwQ=;
        h=Subject:To:From:Date:MIME-Version:Content-Type;
        b=b0fR8m/obSGPPpKT7k9c0PgnumBdaFeeclYGZw/vBCPuWkIOLaghSlcg5YGuh/2Yx
         3p/3sokWT+onlNpbHIfkJKvQq+KqB2r3CVpynKTrSvp8L1opy7gu7aYo9m8LuS19gV
         UdSgXyxrdY5XWSA4fZDYav5Edgnja4Z52YzgYRgTUhHR+Bqv2kpSq3v4Mh/iUeoexN
         2e5Gq9xENYFTvMjbYfPARKbXqgw+cwYH+Oaxf+KVPC707c/jlHK/ri7tO6yDhncsmq
         12ldkM0pHniA2S2mrLyp310xclrrhTubuhYwXNvo1fmEg7dwGInk8uxL+1NDkYTuNR
         UUSX51Evuby5g==
Subject: Re: [PATCH v4 13/13] ARM: imxrt1050_defconfig: add i.MXRT1050
 defconfig
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        nobuhiro1.iwamatsu@toshiba.co.jp, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-serial@vger.kernel.org
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
 <20211204061042.1248028-14-Mr.Bossman075@gmail.com>
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
Message-ID: <ab5026f8-4881-6483-5a42-121860a02c10@benettiengineering.com>
Date:   Mon, 6 Dec 2021 21:16:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211204061042.1248028-14-Mr.Bossman075@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfCbBD1k9Iy5MXE/bMLzKubSwohvt/2zyaZBzfKOfH44CiqXeP9aQj1PLrpsIUVgbO9jY8DsjMVABgzBI2+fgtS5mNkRkACOKuuaewQmfzFc6UFp3gWVy
 sPnsdeNJ8N7Zt9fhBZMEPtv72CBM9SgWED+4dog4RukHKZVyPjpKCgRmg40z9+stiY5m/6krLcnj3PJszuA5/AJw1au5Pb/gAJ0SVysVeyLED8mFi5TQNsrY
 KvXmLJnVM9nYkycSRPV2WykSZNjS4WU9TeDyhtydQMjQOoDVMJbfzEfB7dLQxhrcUpQEpF1Q+6sleQOn7OftMVG/6dPbDAkMyWgzXXIqlKaRMjOU5yljGLli
 3gwHf3dg2ulJ+IEkpPs3NnENcrZNR3nYvQJBad3+tTwzRNvsexNa3oJlwy4f7/UiZ6Mdz3FNCoADbM4u4YFTqsLTRIG1eLHZy+E9wqQCwA9okDysgGIE35Ju
 QzVPk9720+2mK/iRUtLeX/8rRnAhfSD+6HUDKg4IXwIDA8aHMUTZGb9bNxumBphuZr80WCQ7K4gURi6Y/lOZAiGuRGtvnbUXvWv+nG1886hTSmTfe+ITsRPB
 pf6brlUlLnh+erfLhbZ2Tc/Qg4y16k6g417t651LCH7GOWShXgmUJMGR7qpU/dMYRPauQPcN1CXuwOt2Yrw3ppOhFBYn1PjrOTd+dmNkxhx/nIFBLMs/rhSt
 yg3FQv+XEkTFiGeFDoTMURFY0ydnTpkCP3XHEb2bXjXsxBkgq7InqJy2137xef28/SfmHtyvdyDbzHUg+CuLshmFx8Dt+G6LY6YOM203PF1ZwRmuOPo0P80p
 qJLvSQW+GeaQnfAJHI+zwQ76J/JrfFVDql0587t8bzItbvMuEeK5sPY4sVkijWqCwKLxnBqcQZjlqzO/viUaodxQr3y5IjtdmukmPZGlUWmucq3yKjX9Q39Q
 M3EbTWzXb9umRWdcR47SKsfhwEBQPOyJvV1fnWBNlzAXvjpHH0WUdERwKllPZWb6G8u3IWy6HW2I9duv0kXe8m5tcZMqkoCXMdwA4HXo1LbL1WA/eFZHmPJG
 xJt6REMY58OsrNqS07uCQzV+xxktX2VXinr9isx15PPrDX4MUJ+G24aywKbpzfA2dXzZwAQ+jufKNiGd2JiW/iQQIsxbm68O/7Q=
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

On 04/12/21 07:10, Jesse Taube wrote:
> From: Giulio Benetti <giulio.benetti@benettiengineering.com>
> 
> Add i.MXRT1050 defconfig, that will be the basis for the i.MXRT family.

here we need a generic imxrt_defconfig file for i.MXRT1xxx family, like 
sunxi_defconfig, stm32_defconfig etc.

Kind regards
-- 
Giulio Benetti
Benetti Engineering sas

> Signed-off-by: Giulio Benetti <giulio.benetti@benettiengineering.com>
> Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
> ---
> V1->V2:
> * Nothing done
> V2->V3:
> * Nothing done
> V3->V4:
> * Remove unnecessary CONFIGs
> * Add futex suport after "ARM: 9122/1: select HAVE_FUTEX_CMPXCHG"
> 9d417cbe36eee7afdd85c2e871685f8dab7c2dba
> ---
>   arch/arm/configs/imxrt_defconfig | 35 ++++++++++++++++++++++++++++++++
>   1 file changed, 35 insertions(+)
>   create mode 100644 arch/arm/configs/imxrt_defconfig
> 
> diff --git a/arch/arm/configs/imxrt_defconfig b/arch/arm/configs/imxrt_defconfig
> new file mode 100644
> index 000000000000..52dba3762996
> --- /dev/null
> +++ b/arch/arm/configs/imxrt_defconfig
> @@ -0,0 +1,35 @@
> +# CONFIG_LOCALVERSION_AUTO is not set
> +CONFIG_BPF_SYSCALL=y
> +CONFIG_SCHED_AUTOGROUP=y
> +# CONFIG_MMU is not set
> +CONFIG_ARCH_MXC=y
> +CONFIG_SOC_IMXRT=y
> +CONFIG_SET_MEM_PARAM=y
> +CONFIG_DRAM_BASE=0x80000000
> +CONFIG_DRAM_SIZE=0x02000000
> +CONFIG_BINFMT_FLAT=y
> +CONFIG_UEVENT_HELPER=y
> +CONFIG_DEVTMPFS=y
> +CONFIG_DEVTMPFS_MOUNT=y
> +CONFIG_IMX_WEIM=y
> +CONFIG_LEGACY_PTY_COUNT=2
> +CONFIG_SERIAL_FSL_LPUART=y
> +CONFIG_SERIAL_FSL_LPUART_CONSOLE=y
> +CONFIG_SERIAL_DEV_BUS=y
> +CONFIG_PINCTRL_IMXRT1050=y
> +CONFIG_GPIO_MXC=y
> +CONFIG_MMC=y
> +CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
> +CONFIG_MMC_SDHCI_ESDHC_IMX=y
> +CONFIG_DMADEVICES=y
> +CONFIG_FSL_EDMA=y
> +CONFIG_CLK_IMXRT1050=y
> +CONFIG_EXT4_FS=y
> +CONFIG_EXT4_FS_POSIX_ACL=y
> +CONFIG_EXT4_FS_SECURITY=y
> +CONFIG_VFAT_FS=y
> +CONFIG_FAT_DEFAULT_UTF8=y
> +CONFIG_EXFAT_FS=y
> +CONFIG_NLS_ASCII=y
> +CONFIG_NLS_UTF8=y
> 

