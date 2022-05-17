Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBA5297E5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237007AbiEQDXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232494AbiEQDXD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:23:03 -0400
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AADC644A3F;
        Mon, 16 May 2022 20:23:01 -0700 (PDT)
Received: by mail-vk1-xa35.google.com with SMTP id y27so8445971vkl.8;
        Mon, 16 May 2022 20:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=nEvgnb6e8KbkPHvMqBVVP/uj+xcyJbgepFxDgl/Iwok=;
        b=p9Uz5g3xzyf5lryie2kbAjeaWgNf3qqdxTAltT5buWzdQ/X+3KizNrYxZYWdRZWNXM
         ZSsoHsn7SJ5Qnp9AbLU7F1OvCJVW1s7KmXTPc2OiPX5B9fERgBiImQINhmbv2N7WR7Za
         V2Hh6FBu8W1SGwDOmsHL2MmmfvYUFHJG/cQTXw7y/iR+wCbRdTS32V/V9BAOMVDfqGnf
         BMMuGyzfBcmheuxL0Ojj0RhMZFZf/ZTAmS0UwkjYWK3+OrVwKt+sFOjhmoB3YQ/NTB97
         YL4xMS4DqWfxLOjwjzQ6EWbf3oLuGk1rn5l4Vi1IWkvCl3NWw3Z3fAi9bMy8Bg0R8hmq
         xXoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=nEvgnb6e8KbkPHvMqBVVP/uj+xcyJbgepFxDgl/Iwok=;
        b=nQBYAJgK3erEg1pBOCZ4Y7WDOxngp4cpoTCeIiW8ozNhsgz70PTdgbbQJDqAtnT+ND
         HF+hZpkRx/RmR3JaJYCyEitmFbmAI8Xvlg/SOjW6y+e2SYe2hYDDal3vga6eRieuUksS
         05d+6MZhg/ZKWJ3qU69mxsRwdlZMbaRl1dURBWVxVTn+Zy3A/WEnI8n5QJ9T822I0jax
         6oqDrqEtdeUSrKfNSA+iecZJINDvMhKCalF1KOJNwT79QPBdmc9cVo5CXuNJS0C4lbEv
         L2JLV0g78tJQfMYb7hgZX5rzYXJOuGKbSmNy99PpsEFs+LtfbgzCruwYBh9apWfefASV
         8gqA==
X-Gm-Message-State: AOAM531XpiN0M6yrPCyz4fzbjfBvb4EwtuLWBLxjs2tB/YD89sqzwkYq
        4YqdVVFzK2JRgnJM0m447Wjf6MwHyko=
X-Google-Smtp-Source: ABdhPJzl1IsdtVXJz7nlTPX+u2ijkOPUFUHxrBI/kHJdcqYtzHNz0u5QIGYVKwnlnbCCTsEdRtHN8A==
X-Received: by 2002:a05:6122:154:b0:351:c442:e34e with SMTP id r20-20020a056122015400b00351c442e34emr7641410vko.26.1652757780711;
        Mon, 16 May 2022 20:23:00 -0700 (PDT)
Received: from [192.168.1.140] ([65.35.200.237])
        by smtp.gmail.com with ESMTPSA id 7-20020a670407000000b0032d275e690asm1004148vse.10.2022.05.16.20.22.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 20:23:00 -0700 (PDT)
Message-ID: <48b43291-b65a-0939-16ee-95b342e46377@gmail.com>
Date:   Mon, 16 May 2022 23:22:57 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH V2 Create empty OF root 1/1] of: create empty of root
Content-Language: en-US
To:     Lizhi Hou <lizhi.hou@xilinx.com>, devicetree@vger.kernel.org,
        robh@kernel.org
Cc:     linux-kernel@vger.kernel.org, yilun.xu@intel.com, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, Max Zhen <max.zhen@xilinx.com>
References: <20220216050056.311496-1-lizhi.hou@xilinx.com>
 <20220216050056.311496-2-lizhi.hou@xilinx.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220216050056.311496-2-lizhi.hou@xilinx.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/16/22 23:00, Lizhi Hou wrote:
> Xilinx Alveo PCIe accelerator cards use flattened device tree to describe
> describe apertures in its PCIe BARs. Each device tree node represents an
> aperture and each aperture is an hardware unit which requires a driver.
> The product detail:
>     https://www.xilinx.com/products/boards-and-kits/alveo.html
> 
> Thus a base device tree is required. Then the Alveo card driver can load
> its flattened device tree and overlay it to the base tree. However device
> tree does not always exist. To resolve this, add OF_EMPTY_ROOT config.
> When it is selected and there is not a device tree, create an empty device
> tree root node.
> 

Please run scripts/get_maintainer on your patches to see who to put in
the distribution list.

I recently stumbled across this patch series and the previous related
patch series (currently up to
"[PATCH V3 XRT Alveo Infrastructure 0/8] XRT Alveo driver infrastructure overview")
when I noticed it in an email archive.

A similar need of creating an of_root if otherwise empty is being discussed
in the thread "[PATCH 0/3] add dynamic PCI device of_node creation for overlay"
at https://lore.kernel.org/r/20220427094502.456111-1-clement.leger@bootlin.com

-Frank

> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/of/Kconfig         |  5 ++++
>  drivers/of/Makefile        |  1 +
>  drivers/of/of_empty_root.c | 51 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+)
>  create mode 100644 drivers/of/of_empty_root.c
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 80b5fd44ab1c..452d2316b47b 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -94,4 +94,9 @@ config OF_DMA_DEFAULT_COHERENT
>  	# arches should select this if DMA is coherent by default for OF devices
>  	bool
>  
> +config OF_EMPTY_ROOT
> +	# driver which requires at least the empty base device tree to
> +	# overlay its own device nodes should select this.
> +	bool
> +
>  endif # OF
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index e0360a44306e..c65364f32935 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_OF_RESERVED_MEM) += of_reserved_mem.o
>  obj-$(CONFIG_OF_RESOLVE)  += resolver.o
>  obj-$(CONFIG_OF_OVERLAY) += overlay.o
>  obj-$(CONFIG_OF_NUMA) += of_numa.o
> +obj-$(CONFIG_OF_EMPTY_ROOT) += of_empty_root.o
>  
>  ifdef CONFIG_KEXEC_FILE
>  ifdef CONFIG_OF_FLATTREE
> diff --git a/drivers/of/of_empty_root.c b/drivers/of/of_empty_root.c
> new file mode 100644
> index 000000000000..5c429c7a27bd
> --- /dev/null
> +++ b/drivers/of/of_empty_root.c
> @@ -0,0 +1,51 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2022 Xilinx, Inc.
> + */
> +
> +#include <linux/of.h>
> +#include <linux/slab.h>
> +
> +#include "of_private.h"
> +
> +static int __init of_root_init(void)
> +{
> +	struct property *prop = NULL;
> +	struct device_node *node;
> +	__be32 *val = NULL;
> +
> +	if (of_root)
> +		return 0;
> +
> +	pr_info("Create empty OF root node\n");
> +	node = kzalloc(sizeof(*node), GFP_KERNEL);
> +	if (!node)
> +		return -ENOMEM;
> +	of_node_init(node);
> +	node->full_name = "/";
> +
> +	prop = kcalloc(2, sizeof(*prop), GFP_KERNEL);
> +	if (!prop)
> +		return -ENOMEM;
> +
> +	val = kzalloc(sizeof(*val), GFP_KERNEL);
> +	if (!val)
> +		return -ENOMEM;
> +	*val = cpu_to_be32(sizeof(void *) / sizeof(u32));
> +
> +	prop->name = "#address-cells";
> +	prop->value = val;
> +	prop->length = sizeof(u32);
> +	of_add_property(node, prop);
> +	prop++;
> +	prop->name = "#size-cells";
> +	prop->value = val;
> +	prop->length = sizeof(u32);
> +	of_add_property(node, prop);
> +	of_root = node;
> +	for_each_of_allnodes(node)
> +		__of_attach_node_sysfs(node);
> +
> +	return 0;
> +}
> +pure_initcall(of_root_init);

