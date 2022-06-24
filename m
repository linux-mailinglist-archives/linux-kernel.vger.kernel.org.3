Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED61558C8F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 03:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbiFXBBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 21:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230308AbiFXBBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 21:01:21 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34395517D0;
        Thu, 23 Jun 2022 18:01:17 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-101dc639636so1759909fac.6;
        Thu, 23 Jun 2022 18:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=i9j3ONJVzt/4rtG5tOGhsAy+f1GNk6EtJ6qV36pgxT4=;
        b=VYDivN0DTruPKF4W1Y/QC07vpI4JgdbzSnJtmyYNHh9z9YfpY5DM+NJVilgJXg5cyb
         93L2NowmGE7PMIr6gL9m3DAW3WYvzUIxQiNzU8F0Y2KyF8Jjerd5jwnoFrFDOmYCqNg4
         MoFspdm4EqXDRMeMjTiCJUuPRNj6RCz+m+P6SeAir7vlXaTV8ODc0QHzlzB5UhCum8In
         We211XKV/GOKJgJYOSJC0NgPNY4YonDDY6Ddl8tuGldT62AsM9uOOJr79q6IhDBhUag9
         XT73+DKII+a2HJnnAO6jx6NEd3mQpcN2dWeTYjtBAIAwW1mDQk8uZ2A7ZFwljlutpkMB
         NH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=i9j3ONJVzt/4rtG5tOGhsAy+f1GNk6EtJ6qV36pgxT4=;
        b=V0s2z8i/fcKlcK+8ZSSIvDiaBwb8RBS1LSG0ay2/aqBa2Jes7s5108/kI96B5VzJvU
         pxqih2NO+zB0tvfcj3lhoVMCNro2Qg6FOoux7LCyHaBdFPPibD93ln7bfamf6X44Y761
         AUK9wmxtsHpij+x1xex0ucRlo30KpbREOEb8VlMJoXOXlVH6pcI7jpTWJNRFY2or+f9h
         FvWjGtv1Ju6HFO4yldOULCBU4do4DHFYT1xR0VIFBLqZNAfa4g7uacyqkL4lSYlRCsGA
         Va008OU/dKkc/Cd6ZrlGq5udTw4Az5HivmAyw1WGn/GwFjLKm57orAyn2in5+uPKGwFW
         lfNw==
X-Gm-Message-State: AJIora93N0LXuaHF0TQexgWUMQaSt+Y4/7yLQQmc5W+NgHcPchU1vN9e
        PXXx0+gOd7EJUUF+4JaDwYs=
X-Google-Smtp-Source: AGRyM1toXccCGNAoUQkZBfjQbibCxKyjQNblKNG4fv0m9HlIyxCF5oA0bmTcPTPHXCHAVqiyhf2G1g==
X-Received: by 2002:a05:6870:899e:b0:101:be11:a071 with SMTP id f30-20020a056870899e00b00101be11a071mr447840oaq.168.1656032476518;
        Thu, 23 Jun 2022 18:01:16 -0700 (PDT)
Received: from ?IPV6:2600:1700:2442:6db0:742c:47ee:54c0:bcc7? ([2600:1700:2442:6db0:742c:47ee:54c0:bcc7])
        by smtp.gmail.com with ESMTPSA id 189-20020aca06c6000000b0032f63c4638esm435495oig.2.2022.06.23.18.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 18:01:15 -0700 (PDT)
Message-ID: <56822a64-f289-3b7d-2175-3669194587c9@gmail.com>
Date:   Thu, 23 Jun 2022 20:01:14 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v1 1/2] of: base: populate of_root node if not set
Content-Language: en-US
From:   Frank Rowand <frowand.list@gmail.com>
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
 <ecf13de1-531f-b73b-b325-44ef78a3f818@gmail.com>
In-Reply-To: <ecf13de1-531f-b73b-b325-44ef78a3f818@gmail.com>
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

On 6/23/22 19:15, Frank Rowand wrote:
> Hi Clement,
> 
> I said that I would send a patch to do this, but have failed to follow
> through.  Sorry about that.
> 
> 
> On 6/23/22 06:50, Clément Léger wrote:
>> When enabling CONFIG_OF on a platform where of_root is not populated by
>> firmware, we end up without a root node. In order to apply overlays and
>> create subnodes of the root node, we need one. Create this root node
>> by unflattening an empty builtin dtb with of_fdt_unflatten().
>>
>> Co-developed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Clément Léger <clement.leger@bootlin.com>
>> ---
>>  drivers/of/Makefile       |  2 +-
>>  drivers/of/base.c         | 18 ++++++++++++++++--
>>  drivers/of/empty_root.dts |  6 ++++++
>>  3 files changed, 23 insertions(+), 3 deletions(-)
>>  create mode 100644 drivers/of/empty_root.dts
>>
>> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
>> index e0360a44306e..ce56c8b95c83 100644
>> --- a/drivers/of/Makefile
>> +++ b/drivers/of/Makefile
>> @@ -1,5 +1,5 @@
>>  # SPDX-License-Identifier: GPL-2.0
>> -obj-y = base.o device.o platform.o property.o
>> +obj-y = base.o empty_root.dtb.o device.o platform.o property.o
>>  obj-$(CONFIG_OF_KOBJ) += kobj.o
>>  obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
>>  obj-$(CONFIG_OF_FLATTREE) += fdt.o
>> diff --git a/drivers/of/base.c b/drivers/of/base.c
>> index d4f98c8469ed..43e0f027a49c 100644
>> --- a/drivers/of/base.c
>> +++ b/drivers/of/base.c
>> @@ -22,6 +22,7 @@
>>  #include <linux/module.h>
>>  #include <linux/of.h>
>>  #include <linux/of_device.h>
>> +#include <linux/of_fdt.h>
>>  #include <linux/of_graph.h>
>>  #include <linux/spinlock.h>
>>  #include <linux/slab.h>
>> @@ -163,6 +164,8 @@ void __of_phandle_cache_inv_entry(phandle handle)
>>  		phandle_cache[handle_hash] = NULL;
>>  }
>>  
>> +extern const char __dtb_empty_root_begin[];
>> +
>>  void __init of_core_init(void)
>>  {
>>  	struct device_node *np;
>> @@ -176,6 +179,18 @@ void __init of_core_init(void)
>>  		pr_err("failed to register existing nodes\n");
>>  		return;
>>  	}
>> +
>> +	if (!of_root) {
>> +		void *dt;
>> +		const unsigned long *fdt = (const unsigned long *)
>> +							__dtb_empty_root_begin;
>> +		dt = of_fdt_unflatten_tree(fdt, NULL, &of_root);
>> +		if (!dt) {
>> +			pr_err("Failed to setup empty root dt\n");
>> +			return;
>> +		}
>> +	}
>> +
>>  	for_each_of_allnodes(np) {
>>  		__of_attach_node_sysfs(np);
>>  		if (np->phandle && !phandle_cache[of_phandle_cache_hash(np->phandle)])
>> @@ -184,8 +199,7 @@ void __init of_core_init(void)
>>  	mutex_unlock(&of_mutex);
>>  
>>  	/* Symlink in /proc as required by userspace ABI */
>> -	if (of_root)
>> -		proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
>> +	proc_symlink("device-tree", NULL, "/sys/firmware/devicetree/base");
>>  }
> 
> This approach is adding an additional method of unflattening the tree.
> I would prefer to consolidate in a single location.
> 
> I have leveraged this patch series into a different patch series to
> accomplish that.  I have boot tested with one configuration, but want
> to test two more configurations before sending the new series.  It
> should only take "a few minutes".

"a few minutes" is taking longer than expected.  One of the devicetree
interrupt unittests is not giving the expected result for one of the
configurations I am checking.

-Frank

> 
> -Frank
> 
>>  
>>  static struct property *__of_find_property(const struct device_node *np,
>> diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
>> new file mode 100644
>> index 000000000000..cf9e97a60f48
>> --- /dev/null
>> +++ b/drivers/of/empty_root.dts
>> @@ -0,0 +1,6 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/dts-v1/;
>> +
>> +/ {
>> +
>> +};
> 

