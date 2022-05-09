Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 467BE51FB6D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 13:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbiEILlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 07:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232920AbiEILlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 07:41:06 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056F120790E
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 04:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652096230; x=1683632230;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=BTdze0j7Y7DYaHJ4hcIwyYPi09SBZVQyG+qJOqDK++g=;
  b=V18wMMvnQesZslYMg/koeilxWZFRcu+QUU8TVlPcMbd7cz6pXIkchvS+
   FV+I+EKRCU6hdQPLYB29b2GflFOV1M5YLY8+oNp8A/+eSwXTSCI0T2Aw8
   fIsq6Zot9De8QAIFXspPHEWxGLC5WMhRGQsnP9TODd2Nypvv7N8lvBTng
   3/c6o5KgJM8/Ac8kx746oFeszKYYh12nmaP1oD3mnWc5wnFShRi8lYV1P
   twrV/K+miFYdcB+HXY4n7DFFLf6/do1BGLMMQO/i7DQ/Cm6EbqxZPPiAb
   DL+FRtn0t8l+eSQ+nXs94Ij0DVoO2SN67oYNemjoye9ExQwf4AUUmK+lA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="329616994"
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="329616994"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 04:37:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,211,1647327600"; 
   d="scan'208";a="540544648"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 09 May 2022 04:37:09 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1no1hM-000GTe-UW;
        Mon, 09 May 2022 11:37:08 +0000
Date:   Mon, 9 May 2022 19:36:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 34/106] kernel/events/uprobes.c:793:22:
 error: 'struct address_space' has no member named 'ops'; did you mean
 'a_ops'?
Message-ID: <202205091929.FnbrVrc0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   aa4aa19cc518a24bec4de5ff7caaf212d0091805
commit: 0e03bd90d662c215ce99813a175df0e4fd074f5c [34/106] fs: Introduce aops->read_folio
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220509/202205091929.FnbrVrc0-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 0e03bd90d662c215ce99813a175df0e4fd074f5c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the willy-pagecache/for-next HEAD aa4aa19cc518a24bec4de5ff7caaf212d0091805 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   kernel/events/uprobes.c: In function '__copy_insn':
>> kernel/events/uprobes.c:793:22: error: 'struct address_space' has no member named 'ops'; did you mean 'a_ops'?
     793 |         if (mapping->ops->read_folio || mapping->a_ops->readpage)
         |                      ^~~
         |                      a_ops


vim +793 kernel/events/uprobes.c

   783	
   784	static int __copy_insn(struct address_space *mapping, struct file *filp,
   785				void *insn, int nbytes, loff_t offset)
   786	{
   787		struct page *page;
   788		/*
   789		 * Ensure that the page that has the original instruction is populated
   790		 * and in page-cache. If ->readpage == NULL it must be shmem_mapping(),
   791		 * see uprobe_register().
   792		 */
 > 793		if (mapping->ops->read_folio || mapping->a_ops->readpage)
   794			page = read_mapping_page(mapping, offset >> PAGE_SHIFT, filp);
   795		else
   796			page = shmem_read_mapping_page(mapping, offset >> PAGE_SHIFT);
   797		if (IS_ERR(page))
   798			return PTR_ERR(page);
   799	
   800		copy_from_page(page, offset, insn, nbytes);
   801		put_page(page);
   802	
   803		return 0;
   804	}
   805	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
