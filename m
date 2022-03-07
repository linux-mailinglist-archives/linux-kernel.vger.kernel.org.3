Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE54D4CFCBA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238599AbiCGL0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:26:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240166AbiCGL0W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:26:22 -0500
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C050A7B576;
        Mon,  7 Mar 2022 02:59:26 -0800 (PST)
Received: by mail-ej1-f48.google.com with SMTP id d10so30972440eje.10;
        Mon, 07 Mar 2022 02:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=r5VXslgP94xhLV5io8KJ01AqHztBTaI4x6W9LXcGA90=;
        b=adaCimCEapoeMYpC/ZE2NLgvStFiaW0VcbYV3GwhSoqjEeBraZzqFoRcIjXsjP4gqy
         cMssg5boVXUWj6spHFArGC0GdpcZ/uTNoHfPrIHUEnTGpFVreJf85nq+j0AknJNJJwE0
         2gs5xOWbbSbzpTjB/4ekFu/5SrlKgTpiKJO0R+wR9RH23tYealJ46s4tJSSmxbkJhFwF
         BJDEDc/4o2KS8/BsgatU7cu9bHuO5QUK0ocp/oqp35xzfE0EioyB6y8YtjrMFT27/eij
         XRNVg76PUimdQXhWRO9YOhQM7Y4BRz7a6HBRZcStpXaEb/y51zDidyCYcW2qImMxOVCz
         yBVQ==
X-Gm-Message-State: AOAM532/bynPl6pG+6uDVSMGysauFyf32yoDWhlSCFhBn5MOIwEJQ9Wk
        owAJjMLNBq3YFWElBxBGj8A=
X-Google-Smtp-Source: ABdhPJzgorhzP42AxP+JSuvqOu+8dKd4gFe+NvN34jFpSiNFvrBV+ToNj4a4mEKPhuTh+iMqHgGtZA==
X-Received: by 2002:a17:906:4796:b0:6d6:dd04:147b with SMTP id cw22-20020a170906479600b006d6dd04147bmr8736146ejc.80.1646650765283;
        Mon, 07 Mar 2022 02:59:25 -0800 (PST)
Received: from [192.168.0.142] (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.googlemail.com with ESMTPSA id c5-20020a170906d18500b006ce371f09d4sm4656903ejz.57.2022.03.07.02.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 02:59:24 -0800 (PST)
Message-ID: <ee5ad930-7b48-5b7c-f810-76fe497595f3@kernel.org>
Date:   Mon, 7 Mar 2022 11:59:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v1 4/4] usb: host: add xhci-exynos module
Content-Language: en-US
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
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
 <32e72657-a43d-0ae1-1bf2-d15b7426765f@kernel.org>
 <1983025922.01646649181793.JavaMail.epsvc@epcpadp4>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <1983025922.01646649181793.JavaMail.epsvc@epcpadp4>
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

On 07/03/2022 11:26, Jung Daehwan wrote:
> On Mon, Mar 07, 2022 at 11:07:04AM +0100, Krzysztof Kozlowski wrote:
>> On 04/03/2022 07:23, Daehwan Jung wrote:
>>> Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
>>
>> +Cc Randy,
>> I guess here is the rest of the patches.
>>
>>> ---
>>>  drivers/usb/host/xhci-exynos.c | 2025 ++++++++++++++++++++++++++++++++
>>>  drivers/usb/host/xhci-exynos.h |  150 +++
>>>  2 files changed, 2175 insertions(+)
>>>  create mode 100644 drivers/usb/host/xhci-exynos.c
>>>  create mode 100644 drivers/usb/host/xhci-exynos.h
>>>
>>> diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
>>> new file mode 100644
>>> index 000000000000..3913c48d4b20
>>> --- /dev/null
>>> +++ b/drivers/usb/host/xhci-exynos.c
>>> @@ -0,0 +1,2025 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
>>> + *
>>> + * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
>>> + * Author: Daehwan Jung <dh10.jung@samsung.com>
>>> + *
>>> + * A lot of code borrowed from the Linux xHCI driver.
>>
>>> + */
>>> +
>>> +#include <linux/clk.h>
>>> +#include <linux/dma-mapping.h>
>>> +#include <linux/module.h>
>>> +#include <linux/pci.h>
>>> +#include <linux/of.h>
>>> +#include <linux/of_device.h>
>>> +#include <linux/platform_device.h>
>>> +#include <linux/usb/phy.h>
>>> +#include <linux/slab.h>
>>> +#include <linux/phy/phy.h>
>>> +#include <linux/acpi.h>
>>> +#include <linux/usb/of.h>
>>> +#ifdef CONFIG_SND_EXYNOS_USB_AUDIO
>>
>> This does not exist.
>>
>> Please do not add dead code to Linux kernel.
>>
>>> +#include "../../../sound/usb/exynos_usb_audio.h"
>>> +#include <linux/types.h>
>>> +#include "xhci-trace.h"
>>> +#endif
>>> +
>>> +#include "../core/hub.h"
>>> +#include "../core/phy.h"
>>> +#include "xhci.h"
>>> +#include "xhci-plat.h"
>>> +#include "xhci-mvebu.h"
>>> +#include "xhci-rcar.h"
>>> +#include "../dwc3/dwc3-exynos.h"
>>> +#include "../dwc3/exynos-otg.h"
>>
>> No, how XHCI is related to dwc3? What if different block provides XHCI,
>> not DWC3?
>>
>>> +#include "xhci-exynos.h"
>>> +#include <soc/samsung/exynos-cpupm.h>
>>
>> This does not exist and does not even compile.
>>
>> Please do not send code which does not compile... Also, just in case -
>> do not send code which compiles but does not work. :)
>>
> 
> Hi Krzysztof
> 
> I'm sorry to confuse you. But, it's just for reference module to introduce
> new feature. That's why I just submitted source code and header without
> makefile. It's not going to compiled at all now.

Thanks for explanation. Such of tree code must be clearly marked in
commit title and subject (e.g. RFC). Additionally this out of tree
module does not solve the problem of lack of users. For all your sound
hooks you need in-tree user.

Best regards,
Krzysztof
