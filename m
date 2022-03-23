Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D11FA4E4E4A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 09:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbiCWIfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 04:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237024AbiCWIfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 04:35:53 -0400
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5CE12639;
        Wed, 23 Mar 2022 01:34:17 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id u26so897415eda.12;
        Wed, 23 Mar 2022 01:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:content-language:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=YzmVk12/pkZnsaIeZrD2nBk/zs2U8Fz3i1Xy2hCTtnU=;
        b=DBWnKWdNbpHnqe/sVMjILoYyRMCuM4SeigDcxZ8h26H1hi4irElL8hC9J72aPcBDGs
         HUIjYBtLNCm5FTvU5a83dGXivvlxSQc2+GbXio9QD9JR4BGp81vRNVL5954/WdRE29IX
         S/8vAnpWar0+hC0Op9OzGlvSICD8t8uS3Hx4V/AzeFPeSsx0v0Bot19sVUzhu0psN5Gr
         +yYr2nAK/KlUmE1sA7QMG7a7YJICKU85yGBajw5S8YAYk0WUdh6lyyQe1DoVY8MLwK0d
         TwVGevyNXxsybzAa8ceJ+V9wkJNQX82WQIeiqJKce75b9jEwkEL220aV55xSvUBTpt6L
         m8HA==
X-Gm-Message-State: AOAM532JPKkZOLqN+xo5IvOKPFkly0Qm1eLCd2hR0359bxru8F+5QMkZ
        2oO27KQrwXm8AWm0JD9PO5Y=
X-Google-Smtp-Source: ABdhPJwTon6TIPSIbefKQouCi7eNrz+8puuIzcjjKcqzoxf8UM2UxK3NcqZglzQ42BRAeoANPocCpQ==
X-Received: by 2002:a05:6402:5303:b0:416:13c0:3e75 with SMTP id eo3-20020a056402530300b0041613c03e75mr33644657edb.299.1648024456391;
        Wed, 23 Mar 2022 01:34:16 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id f2-20020a170906738200b006df69629a3dsm9586528ejl.28.2022.03.23.01.34.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 01:34:15 -0700 (PDT)
Message-ID: <94669e28-16e0-440d-e52c-b1e1dd9592b0@kernel.org>
Date:   Wed, 23 Mar 2022 09:34:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>, sc.suh@samsung.com
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
 <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
 <d5161e80-789b-8481-3b8f-bf0cfd9875b6@kernel.org>
 <20220323051732.GE19041@ubuntu>
In-Reply-To: <20220323051732.GE19041@ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/03/2022 06:17, Jung Daehwan wrote:
> On Tue, Mar 22, 2022 at 06:16:58PM +0100, Krzysztof Kozlowski wrote:
>> On 21/03/2022 09:59, Daehwan Jung wrote:
>>> This driver supports USB Audio offload with Co-processor.
>>> It only cares DCBAA, Device Context, Transfer Ring, Event Ring, and ERST.
>>> They are allocated on specific address with xhci hooks.
>>> Co-processor could use them directly without xhci driver after then.
>>>
>>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
>>> ---
>>>  drivers/usb/host/Kconfig       |   9 +
>>>  drivers/usb/host/Makefile      |   1 +
>>>  drivers/usb/host/xhci-exynos.c | 982 +++++++++++++++++++++++++++++++++
>>>  drivers/usb/host/xhci-exynos.h |  63 +++
>>>  4 files changed, 1055 insertions(+)
>>>  create mode 100644 drivers/usb/host/xhci-exynos.c
>>>  create mode 100644 drivers/usb/host/xhci-exynos.h
>>>
>>> diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
>>> index 57ca5f97a3dc..850e6b71fac5 100644
>>> --- a/drivers/usb/host/Kconfig
>>> +++ b/drivers/usb/host/Kconfig
>>> @@ -783,3 +783,12 @@ config USB_XEN_HCD
>>>  	  by the Xen host (usually Dom0).
>>>  	  Only needed if the kernel is running in a Xen guest and generic
>>>  	  access to a USB device is needed.
>>> +
>>> +config USB_XHCI_EXYNOS
>>> +	tristate "XHCI support for Samsung Exynos SoC Series"
>>> +	depends on ARCH_EXYNOS || COMPILE_TEST
>>> +	help
>>> +	  Enable support for the Samsung Exynos SOC's on-chip XHCI
>>> +	  controller.
>>> +
>>> +	  If unsure, say N.
>>> diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
>>> index 2948983618fb..300f22b6eb1b 100644
>>> --- a/drivers/usb/host/Makefile
>>> +++ b/drivers/usb/host/Makefile
>>> @@ -86,3 +86,4 @@ obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
>>>  obj-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
>>>  obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
>>>  obj-$(CONFIG_USB_XEN_HCD)	+= xen-hcd.o
>>> +obj-$(CONFIG_USB_XHCI_EXYNOS)	+= xhci-exynos.o
>>> diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
>>> new file mode 100644
>>> index 000000000000..19ee21f1d024
>>> --- /dev/null
>>> +++ b/drivers/usb/host/xhci-exynos.c
>>> @@ -0,0 +1,982 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
>>> + *
>>> + * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
>>> + * Author: Daehwan Jung <dh10.jung@samsung.com>
>>> + *
>>> + * A lot of code borrowed from the Linux xHCI driver.
>>> + */
>>> +#include <linux/clk.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include <linux/module.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/usb/phy.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/usb/of.h>
>>> +
>>> +#include "xhci.h"
>>> +#include "xhci-plat.h"
>>> +#include "xhci-mvebu.h"
>>> +#include "xhci-rcar.h"
>>
>> Could you explain why do you need RCAR and Marvell code in Exynos? Is it
>> even a real driver here? On what platforms this can be tested? Where are
>> the bindings?
> 
> 2 headers you said are not needed. I'm going to remove it on next
> submission. I tested on Exynos platform and it's real driver. I haven't
> made bindings.

This driver does not fit Linux development style at all. You duplicate
code instead of integrating with existing drivers. You call a driver
"Exynos" but include Marvell, Renesas code and actually do not include
Exynos related bindings. Usage of "generic-xhci" in Exynos-specific
driver looks like it is some hacking of downstream kernel. This driver
does not look at all like ready for submission.

There was entire team in DMC @Samsung and in Polish Samsung R&D devoted
for upstream Linux kernel work. There was in the past Open Source
Samsung Group. There were several folks from SoC division (Samsung LSI)
having significant experience in mainlining code (one of them recently
got as a co-maintainer of Exynos). I can point you to specific names, if
needed. All of them have huge experience in mainlining drivers, so
please reach them for help and get a training on working with upstream.
I mean, around 10 years ago Samsung was ramping up with open-source
submissions, so it was excused from not knowing the process and from
beginner's mistakes. After 10 years it's not a beginner anymore. It is
not expected to make beginner's mistakes anymore...

Best regards,
Krzysztof
