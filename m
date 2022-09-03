Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072895ABCA1
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 05:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbiICDrv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 23:47:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiICDrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 23:47:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48ADE3408
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 20:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662176865; x=1693712865;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VytJkr2Us+omk6fHRS/qKuslrK2rhsh1ait7dpI2zbY=;
  b=k/FeWRvmIFVfv5B04b010FwF1VWq3sv9umg0NW7R7OKLME5wc2XJxQB0
   IsYKk59kw+ejtO1Gx28SuZh1J6AYTOMj5MRarW5yUVQ/pQQYSkSlIGbsh
   DJ9ep9q2wYA+Kl87aF9lX1q4IIHFWYDynEiZjtN+PilP/aRmGqC9+LWwL
   MnenOoR4SwvWF+16M3ywGrSuzkpwbzv0pZQF+bbUQKjqobM3icPW8Kw4e
   Sk3HJHS5rSjLh09BJiyGxN7H8/EeqWLQBisVb52csI6CpbGEFfF8JMLz/
   qFE5g0qL3gGkfW3gHcF3ZYSD40NzMCgQ3Wf7kJ+qfSbNGM9KKu2Y2o/f+
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="276526490"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="276526490"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 20:47:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="564173464"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 02 Sep 2022 20:47:44 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUK8F-0000zF-1h;
        Sat, 03 Sep 2022 03:47:43 +0000
Date:   Sat, 3 Sep 2022 11:46:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 12/16] drivers/dax/mapping.c:345:17:
 error: implicit declaration of function 'get_dev_pagemap_many'; did you mean
 'put_dev_pagemap_many'?
Message-ID: <202209031128.VXHDkr70-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   ac9d6b3ba0a537b67bdc8e525308dc371da91e1b
commit: fd2e18c05d353b59283b4cb5508bafecd766b304 [12/16] devdax: Move address_space helpers to the DAX core
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220903/202209031128.VXHDkr70-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=fd2e18c05d353b59283b4cb5508bafecd766b304
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout fd2e18c05d353b59283b4cb5508bafecd766b304
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dax/mapping.c: In function 'dax_associate_entry':
>> drivers/dax/mapping.c:345:17: error: implicit declaration of function 'get_dev_pagemap_many'; did you mean 'put_dev_pagemap_many'? [-Werror=implicit-function-declaration]
     345 |         pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 put_dev_pagemap_many
   drivers/dax/mapping.c:345:15: warning: assignment to 'struct dev_pagemap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     345 |         pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
         |               ^
   cc1: some warnings being treated as errors


vim +345 drivers/dax/mapping.c

   324	
   325	/*
   326	 * When it is called in dax_insert_entry(), the cow flag will indicate that
   327	 * whether this entry is shared by multiple files.  If so, set the page->mapping
   328	 * FS_DAX_MAPPING_COW, and use page->index as refcount.
   329	 */
   330	static vm_fault_t dax_associate_entry(void *entry,
   331					      struct address_space *mapping,
   332					      struct vm_fault *vmf, unsigned long flags)
   333	{
   334		unsigned long size = dax_entry_size(entry), pfn, index;
   335		struct dev_pagemap *pgmap;
   336		int i = 0;
   337	
   338		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
   339			return 0;
   340	
   341		if (!size)
   342			return 0;
   343	
   344		pfn = dax_to_pfn(entry);
 > 345		pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
   346		if (!pgmap)
   347			return VM_FAULT_SIGBUS;
   348	
   349		index = linear_page_index(vmf->vma, ALIGN(vmf->address, size));
   350		for_each_mapped_pfn(entry, pfn) {
   351			struct page *page = pfn_to_page(pfn);
   352	
   353			if (flags & DAX_COW) {
   354				dax_mapping_set_cow(page);
   355			} else {
   356				WARN_ON_ONCE(page->mapping);
   357				page->mapping = mapping;
   358				page->index = index + i++;
   359			}
   360		}
   361	
   362		return 0;
   363	}
   364	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
