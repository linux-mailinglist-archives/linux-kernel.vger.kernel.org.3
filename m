Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4F3B558B9E
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiFWXPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbiFWXPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:15:36 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABD9609C7;
        Thu, 23 Jun 2022 16:15:35 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-101dc639636so1479869fac.6;
        Thu, 23 Jun 2022 16:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=F8orSQtOec8KrzPU44fdlfLRNKNSwXPREkwc+TPv8+I=;
        b=X5ojva3y1aiV0YOPI1U3n3i+eZQAJS89mQnbOnNM4nKcQWxaDlme/8/t0sU3mv/0fN
         d04Qql1LbR9KL3zWudxS/uf1i37U9vkBOSahzol8lxVdLcmOr0TO6zaw/hLo31Viy67+
         uC1pBiJstUTbNAmOLmkhMdTytHGSSOu2fxtxMyu80iLVpc7kHjxesOE0g8xDg2Z6xqkg
         Z/2B7wdBgC8Yupz4djtBvHBhne6ohHiJir1hqCtgpnDLYnlMZkO5ziyE6dw9Rx1m9Pas
         LVgoHeCa8a6BTIt5OpT/QKmZ+ahzQhvlIBxsMAqhNWwpO7YiYFU3Qff0sg62Q3Cu2Bh/
         IgDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F8orSQtOec8KrzPU44fdlfLRNKNSwXPREkwc+TPv8+I=;
        b=t0BuCRcfx48G79AvXNb927KdZFj7+cdwStipEut2N9WCly33Dc8s/K4eXH8YrwBSMw
         QJfjJ3SzAVCR841L3j8TZA6H9itg+SKyF9GOINuvH4xRoWRXMpHRi0ucv8olTivU5R8+
         pi4VyyoKbIeDlWz1/6EfO+R/84nqCGUMFTxl34l4dnDHP8POv1pUEDZ78+8+5ClPW9O7
         FWBjgoYcPruPXVNCWLB00YqaCVuFtC/kt/9aK7rS1frfiQYpo0+iCJQgon5ZHbvNsrUV
         GztM9RgCrYmkg8/VAkaqd7RyF7WBflKe/cJBBHC7SiUGn9N/Sw3wVbAhlhXFOMavlRVo
         xGSw==
X-Gm-Message-State: AJIora8ruDxEU2PqIzNAZqOWB6uUceSEEhMVqzvR6suH6w2m+tupDbeK
        VWE8T6tEcHIaXfmFM5r1TVM=
X-Google-Smtp-Source: AGRyM1vwMmfQCtpaLtdMlr5OMZbuc/fCmoNhHdSMVjEjgbNRQYZJo04ONYqOyhbBOD9O/UPhIaUL7Q==
X-Received: by 2002:a05:6871:29b:b0:101:c395:a100 with SMTP id i27-20020a056871029b00b00101c395a100mr251838oae.174.1656026133423;
        Thu, 23 Jun 2022 16:15:33 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:742c:47ee:54c0:bcc7? ([2600:1700:2442:6db0:742c:47ee:54c0:bcc7])
        by smtp.gmail.com with ESMTPSA id y203-20020aca4bd4000000b0032eb81e352asm256043oia.38.2022.06.23.16.15.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 16:15:32 -0700 (PDT)
Message-ID: <ecf13de1-531f-b73b-b325-44ef78a3f818@gmail.com>
Date:   Thu, 23 Jun 2022 18:15:31 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/2] of: base: populate of_root node if not set
Content-Language: en-US
To:     =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>
References: <20220623105044.152832-1-clement.leger@bootlin.com>
 <20220623105044.152832-2-clement.leger@bootlin.com>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220623105044.152832-2-clement.leger@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clement,

I said that I would send a patch to do this, but have failed to follow
through.  Sorry about that.


On 6/23/22 06:50, Clément Léger wrote:
> When enabling CONFIG_OF on a platform where of_root is not populated by
> firmware, we end up without a root node. In order to apply overlays and
> create subnodes of the root node, we need one. Create this root node
> by unflattening an empty builtin dtb with of_fdt_unflatten().
> 
> Co-developed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> ---
>  drivers/of/Makefile       |  2 +-
>  drivers/of/base.c         | 18 ++++++++++++++++--
>  drivers/of/empty_root.dts |  6 ++++++
>  3 files changed, 23 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/of/empty_root.dts
> 
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index e0360a44306e..ce56c8b95c83 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> -obj-y = base.o device.o platform.o property.o
> +obj-y = base.o empty_root.dtb.o device.o platform.o property.o
>  obj-$(CONFIG_OF_KOBJ) += kobj.o
>  obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>  obj-$(CONFIG_OF_FLATTREE) += fdt.o
> diff --git a/drivers/of/base.c b/drivers/of/base.c
> index d4f98c8469ed..43e0f027a49c 100644
> --- a/drivers/of/base.c
> +++ b/drivers/of/base.c
> @@ -22,6 +22,7 @@
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/of_device.h>
> +#include <linux/of_fdt.h>
>  #include <linux/of_graph.h>
>  #include <linux/spinlock.h>
>  #include <linux/slab.h>
> @@ -163,6 +164,8 @@ void __of_phandle_cache_inv_entry(phandle handle)
>  		phandle_cache[handle_hash] = NULL;
>  }
>  
> +extern const char __dtb_empty_root_begin[];
> +
>  void __init of_core_init(void)
>  {
>  	struct device_node *np;
> @@ -176,6 +179,18 @@ void __init of_core_init(void)
>  		pr_err("failed to register existing nodes\n");
>  		return;
>  	}
> +
> +	if (!of_root) {
> +		void *dt;
> +		const unsigned long *fdt = (const unsigned long *)
> +							__dtb_empty_root_begin;
> +		dt = of_fdt_unflatten_tree(fdt, NULL, &of_root);
> +		if (!dt) {
> +			pr_err("Failed to setup empty root dt\n");
> +			return;
> +		}
> +	}
> +
>  	for_each_of_allnodes(np) {
>  		__of_attach_node_sysfs(np);
>  		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
> @@ -184,8 +199,7 @@ void __init of_core_init(void)
>  	mutex_unlock(&of_mutex);
>  
>  	/* Symlink in /proc as required by userspace ABI */
> -	if (of_root)
> -		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
> +	proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
>  }

This approach is adding an additional method of unflattening the tree.
I would prefer to consolidate in a single location.

I have leveraged this patch series into a different patch series to
accomplish that.  I have boot tested with one configuration, but want
to test two more configurations before sending the new series.  It
should only take "a few minutes".

-Frank

>  
>  static struct property *__of_find_property(const struct device_node *np,
> diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
> new file mode 100644
> index 000000000000..cf9e97a60f48
> --- /dev/null
> +++ b/drivers/of/empty_root.dts
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/dts-v1/;
> +
> +/ {
> +
> +};

