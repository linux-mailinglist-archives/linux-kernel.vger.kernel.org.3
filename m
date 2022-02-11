Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 936614B2953
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 16:46:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348285AbiBKPqe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 10:46:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234142AbiBKPqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 10:46:31 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2168821F;
        Fri, 11 Feb 2022 07:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644594390; x=1676130390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+oJ6/3w5SLph8vgBKsnG5VB05lSV2gievuHwWZZDctw=;
  b=HFlRaONArNCXKkxogpDM1F063hWyMaJtTle9l5io3W0pvCxZcbJ3eARU
   e5DLC4G48gMbGjoi3sKWzNgjahF3C6eTn+3fITMAeY3bd5xLtF7yA0HSZ
   mIkDJrYEvFhNWgrvVXNT9g+m1hj/V8eFC2lmVRjsesmvqMue20F3icgtP
   hnB5EvjFZRAqgkjjxv+OmGOnuMJ7GjTJ/N2Nya6uPRjHQb3+0EajHEoiC
   XkMZ1jtAr7+3vzAmyB2D76Ubh+E+bvPkV2iVxrX3qJqAaKx9ZsAz5qlPo
   Xr3vQCeUpcAYxM6bkuXpVvnfeGqboDt6+hVlOG/wKjlwYvEfiKwClJ6JR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10254"; a="336175088"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="336175088"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 07:46:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="542134128"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.68])
  by orsmga008.jf.intel.com with ESMTP; 11 Feb 2022 07:46:26 -0800
Date:   Fri, 11 Feb 2022 23:38:01 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     devicetree@vger.kernel.org, robh@kernel.org,
        linux-kernel@vger.kernel.org, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, Max Zhen <max.zhen@xilinx.com>
Subject: Re: [PATCH V1 Create empty OF root 1/1] of: create empty of root
Message-ID: <20220211153801.GA1273192@yilunxu-OptiPlex-7050>
References: <20220126054807.492651-1-lizhi.hou@xilinx.com>
 <20220126054807.492651-2-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126054807.492651-2-lizhi.hou@xilinx.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 09:48:07PM -0800, Lizhi Hou wrote:
> Add OF_EMPTY_ROOT config. When it is selected and there is not a device
> tree, create an empty device tree root node.

Maybe add some description about why a empty device tree root node is
needed. Note that the Patch #0 will not be present in the repo when the
series will be merged, so add your description here please.

> 
> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/of/Kconfig         |  3 +++
>  drivers/of/Makefile        |  1 +
>  drivers/of/of_empty_root.c | 51 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 55 insertions(+)
>  create mode 100644 drivers/of/of_empty_root.c
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index 80b5fd44ab1c..42afb126f91a 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -94,4 +94,7 @@ config OF_DMA_DEFAULT_COHERENT
>  	# arches should select this if DMA is coherent by default for OF devices
>  	bool
>  
> +config OF_EMPTY_ROOT
> +	bool

Also some descriptions for better understanding?

Thanks,
Yilun

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
> -- 
> 2.27.0
