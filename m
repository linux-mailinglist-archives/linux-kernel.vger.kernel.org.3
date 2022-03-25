Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9D14E6BE2
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 02:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357238AbiCYBSL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 21:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347681AbiCYBSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 21:18:09 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90BC2A88B4;
        Thu, 24 Mar 2022 18:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648170996; x=1679706996;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=vajmqn8ClJ33KtqH+YY3naJ71jJv8MZm/ve6MR3XHPw=;
  b=jwQgHrS5Aa1OYxOLmnzmco093bNcK8DpSYDWSE35R7946c9xVwGjeUbt
   MG0pPk5SKf5nnlO2TKF3wFx4Ckx0wHzX912CJ4Kc40dikf3gXKdnHakeL
   pgcfylY0vd8+Dmz/WCvIR2H7H3ZiuVqHTJ2q8oCCz7vpYPo9dHkPmespZ
   gkuJ4v/qkapmcOncfPkmAo7CXv/SCx7uf8aay9vSqpmgTzXJQfraej2X0
   qIPW2W+tXkmVeLK1NFZnFfilF/bmbtbV3Ry7kyA9jfriaBnbgvpIn8cDJ
   7nMDGy04hWtiITcbMBntLcksyJfGcRnDPgMVvHE14UD6G8QrKO9ZaIXLN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="246002942"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="246002942"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 18:16:36 -0700
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="561625280"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.177]) ([10.255.29.177])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 18:16:33 -0700
Subject: Re: [kbuild-all] Re: undefined reference to `node_data'
To:     Michal Hocko <mhocko@suse.com>, kernel test robot <lkp@intel.com>,
        kbuild-all@lists.01.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-mips@vger.kernel.org
References: <202203232042.AS9SV1zv-lkp@intel.com>
 <Yjs0ausRy6/mLUFD@dhcp22.suse.cz> <YjtPAwl/lhh+n3c2@dhcp22.suse.cz>
 <20220324090443.GA5375@alpha.franken.de> <YjxmrTKxRpTFeHnE@dhcp22.suse.cz>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <06178ca0-66ad-c7fc-a79c-0ea1873408bd@intel.com>
Date:   Fri, 25 Mar 2022 09:16:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YjxmrTKxRpTFeHnE@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/24/2022 8:40 PM, Michal Hocko wrote:
> On Thu 24-03-22 10:04:43, Thomas Bogendoerfer wrote:
>> On Wed, Mar 23, 2022 at 05:46:59PM +0100, Michal Hocko wrote:
>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>
>>>>> All errors (new ones prefixed by >>):
>>>>>
>>>>>     mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
>>>>>>> (.init.text+0x1680): undefined reference to `node_data'
>>>>>     mips64-linux-ld: (.init.text+0x1690): undefined reference to `node_data'
>>>>
>>>> OK, I can see what is going here. The page allocator normally
>>>> uses NODE_DATA but arch_refresh_nodedata refers to node_data directly.
>>>> This is a problem with
>>>> arch/mips/include/asm/mach-loongson64/mmzone.h:
>>>> extern struct pglist_data *__node_data[];
>>>>
>>>> #define NODE_DATA(n)            (__node_data[n])
>>>>
>>>> Unfortunately we cannot use NODE_DATA there because of header inclusion
>>>> ordering. I will think about a solution.
>>>
>>> Is there any reason why (some?) MIPS arches use __node_data rather than
>>> node_data as most other architectures? Would it be acceptable to do the
>>> renaming? It would help to cover the above compilation problem because
>>> arch_refresh_nodedata could keep using node_data directly.
>>
>> I've just checked history and I don't see a reason for __node_data.
>> So I'm fine with changing it to node_data.
> 
> Thanks a lot for double checking Thomas! This is a dump&simple sed over
> mips file. 0-day guys, could you give it a try please?


Hi Michal,

It returns another error:

$ mkdir -p build_dir && wget 
https://download.01.org/0day-ci/archive/20220323/202203232042.AS9SV1zv-lkp@intel.com/config 
-O build_dir/.config
$ COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross 
O=build_dir ARCH=mips SHELL=/bin/bash
Compiler will be installed in /home/nfs/0day
make --keep-going CONFIG_OF_ALL_DTBS=y CONFIG_DTC=y 
CROSS_COMPILE=/home/nfs/0day/gcc-11.2.0-nolibc/mips-linux/bin/mips-linux- --jobs=72 
O=build_dir ARCH=mips SHELL=/bin/bash
...
In file included from ../arch/mips/include/asm/mmzone.h:12,
                  from ../include/linux/mmzone.h:1116,
                  from ../include/linux/gfp.h:6,
                  from ../include/linux/xarray.h:14,
                  from ../include/linux/list_lru.h:14,
                  from ../include/linux/fs.h:13,
                  from ../include/linux/compat.h:17,
                  from ../arch/mips/kernel/asm-offsets.c:12:
../arch/mips/include/asm/mach-ip27/mmzone.h:23:26: error: conflicting 
types for 'node_data'; have 'struct node_data *[]'
    23 | extern struct node_data *node_data[];
       |                          ^~~~~~~~~
In file included from ../include/linux/mmzone.h:952,
                  from ../include/linux/gfp.h:6,
                  from ../include/linux/xarray.h:14,
                  from ../include/linux/list_lru.h:14,
                  from ../include/linux/fs.h:13,
                  from ../include/linux/compat.h:17,
                  from ../arch/mips/kernel/asm-offsets.c:12:
../include/linux/memory_hotplug.h:55:19: note: previous declaration of 
'node_data' with type 'pg_data_t *[]' {aka 'struct pglist_data *[]'}
    55 | extern pg_data_t *node_data[];
       |                   ^~~~~~~~~
make[2]: *** [../scripts/Makefile.build:121: 
arch/mips/kernel/asm-offsets.s] Error 1
make[2]: Target 'missing-syscalls' not remade because of errors.
make[1]: *** [../arch/mips/Makefile:413: archprepare] Error 2
make[1]: Target '__all' not remade because of errors.
make[1]: Leaving directory '/mnt/memdrive/linux/build_dir'
make: *** [Makefile:219: __sub-make] Error 2
make: Target '__all' not remade because of errors.

Best Regards,
Rong Chen

> ---
> diff --git a/arch/mips/include/asm/mach-ip27/mmzone.h b/arch/mips/include/asm/mach-ip27/mmzone.h
> index 08c36e50a860..a798ad379da1 100644
> --- a/arch/mips/include/asm/mach-ip27/mmzone.h
> +++ b/arch/mips/include/asm/mach-ip27/mmzone.h
> @@ -20,9 +20,9 @@ struct node_data {
>   	struct hub_data hub;
>   };
>   
> -extern struct node_data *__node_data[];
> +extern struct node_data *node_data[];
>   
> -#define NODE_DATA(n)		(&__node_data[(n)]->pglist)
> -#define hub_data(n)		(&__node_data[(n)]->hub)
> +#define NODE_DATA(n)		(&node_data[(n)]->pglist)
> +#define hub_data(n)		(&node_data[(n)]->hub)
>   
>   #endif /* _ASM_MACH_MMZONE_H */
> diff --git a/arch/mips/include/asm/mach-loongson64/mmzone.h b/arch/mips/include/asm/mach-loongson64/mmzone.h
> index ebb1deaa77b9..14e2b860ad65 100644
> --- a/arch/mips/include/asm/mach-loongson64/mmzone.h
> +++ b/arch/mips/include/asm/mach-loongson64/mmzone.h
> @@ -14,9 +14,9 @@
>   #define pa_to_nid(addr)  (((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
>   #define nid_to_addrbase(nid) ((unsigned long)(nid) << NODE_ADDRSPACE_SHIFT)
>   
> -extern struct pglist_data *__node_data[];
> +extern struct pglist_data *node_data[];
>   
> -#define NODE_DATA(n)		(__node_data[n])
> +#define NODE_DATA(n)		(node_data[n])
>   
>   extern void setup_zero_pages(void);
>   extern void __init prom_init_numa_memory(void);
> diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
> index e8e3e48c5333..abbbc70ce980 100644
> --- a/arch/mips/loongson64/numa.c
> +++ b/arch/mips/loongson64/numa.c
> @@ -29,8 +29,8 @@
>   
>   unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
>   EXPORT_SYMBOL(__node_distances);
> -struct pglist_data *__node_data[MAX_NUMNODES];
> -EXPORT_SYMBOL(__node_data);
> +struct pglist_data *node_data[MAX_NUMNODES];
> +EXPORT_SYMBOL(node_data);
>   
>   cpumask_t __node_cpumask[MAX_NUMNODES];
>   EXPORT_SYMBOL(__node_cpumask);
> @@ -107,7 +107,7 @@ static void __init node_mem_init(unsigned int node)
>   	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
>   	if (tnid != node)
>   		pr_info("NODE_DATA(%d) on node %d\n", node, tnid);
> -	__node_data[node] = nd;
> +	node_data[node] = nd;
>   	NODE_DATA(node)->node_start_pfn = start_pfn;
>   	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
>   
> diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
> index adc2faeecf7c..1c3a0b92d134 100644
> --- a/arch/mips/sgi-ip27/ip27-memory.c
> +++ b/arch/mips/sgi-ip27/ip27-memory.c
> @@ -33,9 +33,9 @@
>   #define SLOT_PFNSHIFT		(SLOT_SHIFT - PAGE_SHIFT)
>   #define PFN_NASIDSHFT		(NASID_SHFT - PAGE_SHIFT)
>   
> -struct node_data *__node_data[MAX_NUMNODES];
> +struct node_data *node_data[MAX_NUMNODES];
>   
> -EXPORT_SYMBOL(__node_data);
> +EXPORT_SYMBOL(node_data);
>   
>   static u64 gen_region_mask(void)
>   {
> @@ -358,8 +358,8 @@ static void __init node_mem_init(nasid_t node)
>   	/*
>   	 * Allocate the node data structures on the node first.
>   	 */
> -	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
> -	memset(__node_data[node], 0, PAGE_SIZE);
> +	node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
> +	memset(node_data[node], 0, PAGE_SIZE);
>   
>   	NODE_DATA(node)->node_start_pfn = start_pfn;
>   	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
> @@ -401,7 +401,7 @@ void __init prom_meminit(void)
>   			node_mem_init(node);
>   			continue;
>   		}
> -		__node_data[node] = &null_node;
> +		node_data[node] = &null_node;
>   	}
>   }
> 
