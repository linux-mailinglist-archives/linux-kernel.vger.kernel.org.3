Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAC34CFBE2
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 11:50:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241395AbiCGKui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 05:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241665AbiCGKr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:47:58 -0500
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54D1926AFA;
        Mon,  7 Mar 2022 02:07:44 -0800 (PST)
Received: by mail-ej1-f41.google.com with SMTP id kt27so30814400ejb.0;
        Mon, 07 Mar 2022 02:07:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=G+EB4AFFggnOrILvZ54WrATwjsSqh5U/oFtHwdFDjNI=;
        b=K9gAwwYl408q54rxkD1td/0UhPqIUuKqcnkmti32Rr8Zkzr9gJcXhh6w0S/Kdx34AD
         Jn62Y3lq+i/zPAeP4/6hEYfhMQf3Y6vvRcewF31grKVvsUbbQhYurVxAGg9eZqgAZ4jD
         Gv32MmlMsWN7pG/ktSjsXEFiis3m/Qs7foAKWxl3r5L4hg0q1sGrHdRxX1B9WX9oZ06O
         ChL8PRujG2+5Lzfiefi2Wo/nHwh5F9vPjjwh0RGBM5RgYdko0tln6tJlu/9b+Lurm5bk
         bCrgTFyOSjb3ojVrzcpCWVMzyNnvBA9EnP2cmvcXnVjNrTxi5d0pf/ewtDYkAUGE0vRF
         7EbQ==
X-Gm-Message-State: AOAM531be3so1qG4lzYrukpUBw/6Mk0MirEoEoTuLDXRwQFNOT+MKyYg
        WgdJ5fM7UBIxSdeTHpXg5lKA2qE+/w4=
X-Google-Smtp-Source: ABdhPJxHr9JJBLHk0ehHjtgsScZD3zqslWKk6tyAugnkbdNvtf7SfIi6l8BrB33uqcUBr3UUUQh4Cw==
X-Received: by 2002:a17:906:314b:b0:6d6:da31:e545 with SMTP id e11-20020a170906314b00b006d6da31e545mr8769492eje.125.1646647626072;
        Mon, 07 Mar 2022 02:07:06 -0800 (PST)
Received: from [192.168.0.141] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id lw3-20020a170906bcc300b006db3e2aa7c9sm254733ejb.171.2022.03.07.02.07.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:07:05 -0800 (PST)
Message-ID: <32e72657-a43d-0ae1-1bf2-d15b7426765f@kernel.org>
Date:   Mon, 7 Mar 2022 11:07:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 4/4] usb: host: add xhci-exynos module
Content-Language: en-US
To:     Daehwan Jung <dh10.jung@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        "chihhao . chen" <chihhao.chen@mediatek.com>, sc.suh@samsung.com,
        cpgs@samsung.com, cpgsproxy5@samsung.com
References: <1646375038-72082-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220304062618epcas2p2e3c73b5c4ed0c9bc0ca0c02aa658d3fb@epcas2p2.samsung.com>
 <1027007693.21646375582736.JavaMail.epsvc@epcpadp4>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1027007693.21646375582736.JavaMail.epsvc@epcpadp4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 07:23, Daehwan Jung wrote:
> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>

+Cc Randy,
I guess here is the rest of the patches.

> ---
>  drivers/usb/host/xhci-exynos.c | 2025 ++++++++++++++++++++++++++++++++
>  drivers/usb/host/xhci-exynos.h |  150 +++
>  2 files changed, 2175 insertions(+)
>  create mode 100644 drivers/usb/host/xhci-exynos.c
>  create mode 100644 drivers/usb/host/xhci-exynos.h
> 
> diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
> new file mode 100644
> index 000000000000..3913c48d4b20
> --- /dev/null
> +++ b/drivers/usb/host/xhci-exynos.c
> @@ -0,0 +1,2025 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
> + *
> + * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
> + * Author: Daehwan Jung <dh10.jung@samsung.com>
> + *
> + * A lot of code borrowed from the Linux xHCI driver.

> + */
> +
> +#include <linux/clk.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/phy.h>
> +#include <linux/slab.h>
> +#include <linux/phy/phy.h>
> +#include <linux/acpi.h>
> +#include <linux/usb/of.h>
> +#ifdef CONFIG_SND_EXYNOS_USB_AUDIO

This does not exist.

Please do not add dead code to Linux kernel.

> +#include "../../../sound/usb/exynos_usb_audio.h"
> +#include <linux/types.h>
> +#include "xhci-trace.h"
> +#endif
> +
> +#include "../core/hub.h"
> +#include "../core/phy.h"
> +#include "xhci.h"
> +#include "xhci-plat.h"
> +#include "xhci-mvebu.h"
> +#include "xhci-rcar.h"
> +#include "../dwc3/dwc3-exynos.h"
> +#include "../dwc3/exynos-otg.h"

No, how XHCI is related to dwc3? What if different block provides XHCI,
not DWC3?

> +#include "xhci-exynos.h"
> +#include <soc/samsung/exynos-cpupm.h>

This does not exist and does not even compile.

Please do not send code which does not compile... Also, just in case -
do not send code which compiles but does not work. :)


Best regards,
Krzysztof
