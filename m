Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E974951D1C4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358380AbiEFHCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 03:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiEFHB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 03:01:59 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C872C10C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:58:16 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k126-20020a1ca184000000b003943fd07180so3812838wme.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 23:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7NQDxom4Md+SF3JBtM9QM8HwZJZp3wgsQ5x/9kk1ouI=;
        b=ILMjHHtNQzWa0xh6HeDP/oqVu8poke5Qmvml6hgYLwBv9S6AStdzgPSlHRycqiVJzx
         MiL4dH66H0RPPg1YXuiNVRiO0loo/IJjOmwKpqa+CgLN8PfyloRIak1uFaesy1HpsHXX
         Q2+JXk7xnaj/+mZn1yMIR8jHivMBl4fRYJMnsS1JEr8i88TYGzPJchcqnSyuirlOarRD
         Nn3C8GN2aklDdd1ZTsEFzfkocbCgQ9QcZzCZFFwjl+20W9Qzp9pbAHWZlPuTA0b7olED
         M1nuzZxsiswK3fTwH+PksmxBvZdlVnyGT1dcUvTjkCpnbMQj56J7Uiju9vaLqVRkhXcJ
         BUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7NQDxom4Md+SF3JBtM9QM8HwZJZp3wgsQ5x/9kk1ouI=;
        b=U74FVY9g1pmr2u0YBTBIjtkiJpZm1PIu/oZGj65T3dDf/eluq/hE9mL4Arbk9f4HR0
         GbmROVVUkHmyuIHb5FKga6v1THQPeFn1D5DlFzQ1WpqAUtqnEL6b1JFW/GoHoTY94CKF
         9taVhwOTYn4xIlKmnWumpGUylaGrnUaTg0NEejWgj94Bfso/Q6COEJK70gSV3ZaSW3wa
         US+2cdAAni0Cs/nMdAOYTgyviZDKA8NBeoL0ptp/1TInHrRtc1r6x/QZ++bg0j8gnkmB
         jltu/DlWrX7dByMZb9T2w2hlUv+loIwlm8Y2h8q85mW/phgJLuhzPictypVf9qsU3aWF
         dayA==
X-Gm-Message-State: AOAM532gIJebuG8aHdA/g7B6/d1td5Z2tjhEOSlisH/OoM3KyHiUFonz
        A3CNxGtYoqQYn4hNUHbdcGgibg==
X-Google-Smtp-Source: ABdhPJwfhheblu+SZxAuxaecE30axXh+1ZOJYealHB6pGee+YSp7i0i+25+At+988imSp2kBp2CFew==
X-Received: by 2002:a05:600c:4e93:b0:394:e58:c446 with SMTP id f19-20020a05600c4e9300b003940e58c446mr1834067wmq.21.1651820294700;
        Thu, 05 May 2022 23:58:14 -0700 (PDT)
Received: from [192.168.0.222] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id 67-20020a1c1946000000b003942a244f2csm9408328wmz.5.2022.05.05.23.58.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 23:58:14 -0700 (PDT)
Message-ID: <921b8df5-bd01-1ca5-cbe9-4a4e48acdab8@linaro.org>
Date:   Fri, 6 May 2022 08:58:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH RFC v5 5/6] usb: host: add xhci-exynos driver
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     open list <linux-kernel@vger.kernel.org>,
        "open list:DESIGNWARE USB3 DRD IP DRIVER" <linux-usb@vger.kernel.org>,
        "moderated list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
References: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220506063339epcas2p41de479fb6b2d11012a45ac50ccc19a26@epcas2p4.samsung.com>
 <1651818679-10594-6-git-send-email-dh10.jung@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1651818679-10594-6-git-send-email-dh10.jung@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 08:31, Daehwan Jung wrote:
> This driver is for Samsung Exynos xHCI host conroller. It works based on

https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> xhci platform driver and extends functions by xhci hooks and overrides.
> Vendor ops(xhci hooks) should be mapped before probing driver.
> It overrides functions of hc driver on vendor init.
> 
> It supports USB Audio offload with Co-processor. It only cares DCBAA,
> Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
> on specific address with xhci hooks. Co-processor could use them directly
> without xhci driver after then.
> 
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> ---
>  drivers/usb/host/Kconfig       |   8 +
>  drivers/usb/host/Makefile      |   1 +
>  drivers/usb/host/xhci-exynos.c | 775 +++++++++++++++++++++++++++++++++

This is your fifth version and *it still does not compile*. Can you
compile your changes before sending them? It saves reviewer's time.

/usr/bin/aarch64-linux-gnu-ld: drivers/usb/dwc3/dwc3-exynos.o: in
function `dwc3_exynos_probe':

dwc3-exynos.c:(.text+0x470): undefined reference to
`xhci_exynos_register_vendor_ops'



>  3 files changed, 784 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-exynos.c
> 
> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
> index 682b3d2da623..ccafcd9b4212 100644
> --- a/drivers/usb/host/Kconfig
> +++ b/drivers/usb/host/Kconfig
> @@ -104,6 +104,14 @@ config USB_XHCI_TEGRA
>  	  Say 'Y' to enable the support for the xHCI host controller
>  	  found in NVIDIA Tegra124 and later SoCs.
>  
> +config USB_XHCI_EXYNOS
> +	tristate "xHCI support for Samsung Exynos SoC Series"

XHCI was supported before, wasn't it? If yes, this title does not make
really sense.

You need to provide proper title explaining this option.

> +	depends on USB_XHCI_PLATFORM
> +	depends on ARCH_EXYNOS || COMPILE_TEST
> +	help
> +	  Say 'Y' to enable the support for the xHCI host controller
> +	  found in Samsung Exynos SoCs.

The same.

> +
>  endif # USB_XHCI_HCD
>  
>  config USB_EHCI_BRCMSTB
> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
> index 2948983618fb..300f22b6eb1b 100644
> --- a/drivers/usb/host/Makefile
> +++ b/drivers/usb/host/Makefile
> @@ -86,3 +86,4 @@ obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
>  obj-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
>  obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
>  obj-$(CONFIG_USB_XEN_HCD)	+= xen-hcd.o
> +obj-$(CONFIG_USB_XHCI_EXYNOS)	+= xhci-exynos.o
> diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
> new file mode 100644
> index 000000000000..5318a51ac5ee
> --- /dev/null
> +++ b/drivers/usb/host/xhci-exynos.c
> @@ -0,0 +1,775 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
> + *
> + * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
> + * Author: Daehwan Jung <dh10.jung@samsung.com>
> + *
> + * A lot of code borrowed from the Linux xHCI driver.

Then please keep original copyrights, as a derivative work.

> + */
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +
> +#include "xhci.h"
> +#include "xhci-plat.h"
> +
> +/* EXYNOS uram memory map */
> +#define EXYNOS_URAM_ABOX_EVT_RING_ADDR	0x02a00000

Are these SoC memory map addresses? If yes, they should not be
hard-coded in the driver.

> +#define EXYNOS_URAM_ISOC_OUT_RING_ADDR	0x02a01000
> +#define EXYNOS_URAM_ISOC_IN_RING_ADDR	0x02a02000
> +#define EXYNOS_URAM_DEVICE_CTX_ADDR	0x02a03000
> +#define EXYNOS_URAM_DCBAA_ADDR		0x02a03880
> +#define EXYNOS_URAM_ABOX_ERST_SEG_ADDR	0x02a03C80
> +#define EXYNOS_URAM_CTX_SIZE		2112
> +
> +int xhci_exynos_register_vendor_ops(void);
> +
> +struct xhci_hcd_exynos {
> +	struct	xhci_intr_reg __iomem *ir_set_audio;
> +
> +	struct xhci_ring	*event_ring_audio;
> +	struct xhci_erst	erst_audio;

Why "xHCI support for Samsung Exynos SoC Series" comes specific to
audio? Isn't XHCI related to USB, so a Universal use? Cannot XHCI driver
support mass storage?

> +
> +	struct device		*dev;
> +	struct usb_hcd		*hcd;
> +	struct usb_hcd		*shared_hcd;
> +
> +	struct wakeup_source *main_wakelock; /* Wakelock for HS HCD */
> +	struct wakeup_source *shared_wakelock; /* Wakelock for SS HCD */

None of other USB drivers use wakeloks so why is this one special?

> +
> +	u32 in_ep;
> +	u32 out_ep;
> +	u32 in_deq;
> +	u32 out_deq;
> +
> +	/* This flag is used to check first allocation for URAM */
> +	bool			exynos_uram_ctx_alloc;
> +	bool			exynos_uram_isoc_out_alloc;
> +	bool			exynos_uram_isoc_in_alloc;

This indentation is really troubling me - just few lines above, you
don't indent variables. Here you indent. You need to clean up your
driver before submitting. Run checkpatch --strict and fix all the
issues. Add const to all static variables and most of pointed memory.
Remove any inconsistencies. Remove double blank lines. Fix indentation.

Best regards,
Krzysztof
