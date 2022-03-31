Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7E84EDE82
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239681AbiCaQRo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234630AbiCaQRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:17:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87B5FDE0E
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648743355; x=1680279355;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BMNEgDNkwYYpQ+JgHSAi2O3cg08e/KgVF2OwNkQYFSo=;
  b=OdnPrNfirvowb9KvQ6qgM0i5ljSJOE21YH5hihKPG8EPMTu+vwUIr5uy
   4H7FIBephE0NVJc9+g9uFCHxz2PN+GVb6yAuBqw+DewhgXzpJYu0EaGCy
   siPH0Utcwx/MqU8QS3xct0m8n95FT0XBjUtsJtZNds7gGkZ1wuyzwV8nF
   qYjuuF9Wnuj0q0kchwa8ic7p9lsfolE1jiqRGTJQl04sKbZfYzusqjXEj
   41dlQANaed1Gaqz3g9CqFwg7cVtdEICnAeWe5KIKI0z0TiazvzQtTi8WQ
   SjkVYq0NM7xdscbmqoYd1cEhHeBcn09nnyz/IPi6ueHvi+gR5y4xsPW6o
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="260065875"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="260065875"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 09:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="503807517"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 31 Mar 2022 09:14:53 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZxRk-0000Qc-Lb;
        Thu, 31 Mar 2022 16:14:52 +0000
Date:   Fri, 1 Apr 2022 00:14:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Richard Weinberger <richard@nod.at>
Subject: drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:924:14: error:
 invalid use of undefined type 'struct cpuinfo_x86'
Message-ID: <202204010015.xWpO2OCt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Johannes,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   787af64d05cd528aac9ad16752d11bb1c6061bb9
commit: 68f5d3f3b6543266b29e047cfaf9842333019b4c um: add PCI over virtio emulation driver
date:   10 months ago
config: um-allyesconfig (https://download.01.org/0day-ci/archive/20220401/202204010015.xWpO2OCt-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=68f5d3f3b6543266b29e047cfaf9842333019b4c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 68f5d3f3b6543266b29e047cfaf9842333019b4c
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:12,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:23:
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c: In function 'kfd_fill_iolink_info_for_cpu':
   arch/um/include/asm/processor-generic.h:97:19: error: called object is not a function or function pointer
      97 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:921:34: note: in expansion of macro 'cpu_data'
     921 |         struct cpuinfo_x86 *c = &cpu_data(0);
         |                                  ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:924:14: error: invalid use of undefined type 'struct cpuinfo_x86'
     924 |         if (c->x86_vendor == X86_VENDOR_AMD)
         |              ^~
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:924:30: error: 'X86_VENDOR_AMD' undeclared (first use in this function); did you mean 'X86_VENDOR_ANY'?
     924 |         if (c->x86_vendor == X86_VENDOR_AMD)
         |                              ^~~~~~~~~~~~~~
         |                              X86_VENDOR_ANY
   drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c:924:30: note: each undeclared identifier is reported only once for each function it appears in


vim +924 drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_crat.c

520b8fb755ccfb Felix Kuehling    2017-12-08  914  
6d3d8065bb14dc Nathan Chancellor 2019-01-21  915  #ifdef CONFIG_X86_64
520b8fb755ccfb Felix Kuehling    2017-12-08  916  static int kfd_fill_iolink_info_for_cpu(int numa_node_id, int *avail_size,
520b8fb755ccfb Felix Kuehling    2017-12-08  917  				uint32_t *num_entries,
520b8fb755ccfb Felix Kuehling    2017-12-08  918  				struct crat_subtype_iolink *sub_type_hdr)
520b8fb755ccfb Felix Kuehling    2017-12-08  919  {
520b8fb755ccfb Felix Kuehling    2017-12-08  920  	int nid;
520b8fb755ccfb Felix Kuehling    2017-12-08  921  	struct cpuinfo_x86 *c = &cpu_data(0);
520b8fb755ccfb Felix Kuehling    2017-12-08  922  	uint8_t link_type;
520b8fb755ccfb Felix Kuehling    2017-12-08  923  
520b8fb755ccfb Felix Kuehling    2017-12-08 @924  	if (c->x86_vendor == X86_VENDOR_AMD)
520b8fb755ccfb Felix Kuehling    2017-12-08  925  		link_type = CRAT_IOLINK_TYPE_HYPERTRANSPORT;
520b8fb755ccfb Felix Kuehling    2017-12-08  926  	else
520b8fb755ccfb Felix Kuehling    2017-12-08  927  		link_type = CRAT_IOLINK_TYPE_QPI_1_1;
520b8fb755ccfb Felix Kuehling    2017-12-08  928  
520b8fb755ccfb Felix Kuehling    2017-12-08  929  	*num_entries = 0;
520b8fb755ccfb Felix Kuehling    2017-12-08  930  
520b8fb755ccfb Felix Kuehling    2017-12-08  931  	/* Create IO links from this node to other CPU nodes */
520b8fb755ccfb Felix Kuehling    2017-12-08  932  	for_each_online_node(nid) {
520b8fb755ccfb Felix Kuehling    2017-12-08  933  		if (nid == numa_node_id) /* node itself */
520b8fb755ccfb Felix Kuehling    2017-12-08  934  			continue;
520b8fb755ccfb Felix Kuehling    2017-12-08  935  
520b8fb755ccfb Felix Kuehling    2017-12-08  936  		*avail_size -= sizeof(struct crat_subtype_iolink);
520b8fb755ccfb Felix Kuehling    2017-12-08  937  		if (*avail_size < 0)
520b8fb755ccfb Felix Kuehling    2017-12-08  938  			return -ENOMEM;
520b8fb755ccfb Felix Kuehling    2017-12-08  939  
520b8fb755ccfb Felix Kuehling    2017-12-08  940  		memset(sub_type_hdr, 0, sizeof(struct crat_subtype_iolink));
520b8fb755ccfb Felix Kuehling    2017-12-08  941  
520b8fb755ccfb Felix Kuehling    2017-12-08  942  		/* Fill in subtype header data */
520b8fb755ccfb Felix Kuehling    2017-12-08  943  		sub_type_hdr->type = CRAT_SUBTYPE_IOLINK_AFFINITY;
520b8fb755ccfb Felix Kuehling    2017-12-08  944  		sub_type_hdr->length = sizeof(struct crat_subtype_iolink);
520b8fb755ccfb Felix Kuehling    2017-12-08  945  		sub_type_hdr->flags = CRAT_SUBTYPE_FLAGS_ENABLED;
520b8fb755ccfb Felix Kuehling    2017-12-08  946  
520b8fb755ccfb Felix Kuehling    2017-12-08  947  		/* Fill in IO link data */
520b8fb755ccfb Felix Kuehling    2017-12-08  948  		sub_type_hdr->proximity_domain_from = numa_node_id;
520b8fb755ccfb Felix Kuehling    2017-12-08  949  		sub_type_hdr->proximity_domain_to = nid;
520b8fb755ccfb Felix Kuehling    2017-12-08  950  		sub_type_hdr->io_interface_type = link_type;
520b8fb755ccfb Felix Kuehling    2017-12-08  951  
520b8fb755ccfb Felix Kuehling    2017-12-08  952  		(*num_entries)++;
520b8fb755ccfb Felix Kuehling    2017-12-08  953  		sub_type_hdr++;
520b8fb755ccfb Felix Kuehling    2017-12-08  954  	}
520b8fb755ccfb Felix Kuehling    2017-12-08  955  
520b8fb755ccfb Felix Kuehling    2017-12-08  956  	return 0;
520b8fb755ccfb Felix Kuehling    2017-12-08  957  }
d1c234e2cd1091 Felix Kuehling    2019-01-02  958  #endif
520b8fb755ccfb Felix Kuehling    2017-12-08  959  

:::::: The code at line 924 was first introduced by commit
:::::: 520b8fb755ccfb07d8d743da5753cff1fcb74b9f drm/amdkfd: Add topology support for CPUs

:::::: TO: Felix Kuehling <Felix.Kuehling@amd.com>
:::::: CC: Oded Gabbay <oded.gabbay@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
