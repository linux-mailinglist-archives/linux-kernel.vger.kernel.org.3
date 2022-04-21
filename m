Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707A250A0BD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbiDUN0e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:26:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356512AbiDUN0I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:26:08 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF83936E21
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 06:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650547397; x=1682083397;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=khceue8ltpZUkmKSPCe9vVKCZ2uvDXMdW5xRg6SPaGQ=;
  b=WAZF7tFWrGTpDP/n4J2IxE46a81RPQyZEQNsXU3xrsnk+/OAba5+4BIb
   W3IJzgDMb5NgkSaB7Ly2b0A/kohLdUyqX/n+el3igqra27jhIjDyWsWMf
   q+entKGN0dmpN3mT4bwvpLcRLVtB+s8840ew+/4I7w+Cjrm3AE71qzXLO
   niX4O96KXz4nbmO5hKRdprvEwRTaYmyccLOTJdGeRL+ZEDZiroZy2T7Ts
   S0PL1OFNgUWXJzntLi9dBhIGbD92725CuW9pIMMoAsECDyA/66LFgh+Kh
   AvEVJFyQJqJu1zglJLU8y7mlln2zhX2GkmWDQunyu+9n/xb9S19K4527L
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="261948931"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="261948931"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 06:23:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="648131319"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Apr 2022 06:23:15 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhWmB-0008Qr-B2;
        Thu, 21 Apr 2022 13:23:15 +0000
Date:   Thu, 21 Apr 2022 21:22:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jean-Marc Eurin <jmeurin@google.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [mtd:mtd/next 10/11] drivers/mtd/mtdoops.c:244:39: warning: format
 specifies type 'long' but the argument has type 'unsigned int'
Message-ID: <202204212106.9R1ylUB7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
head:   f812679fab605b3d5b853ed24a81dabb222ea23a
commit: 0629fcef16d703d384f76cb2c2c3a119a9149a34 [10/11] mtd: mtdoops: Create a header structure for the saved mtdoops.
config: hexagon-randconfig-r045-20220420 (https://download.01.org/0day-ci/archive/20220421/202204212106.9R1ylUB7-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bac6cd5bf85669e3376610cfc4c4f9ca015e7b9b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?id=0629fcef16d703d384f76cb2c2c3a119a9149a34
        git remote add mtd https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git
        git fetch --no-tags mtd mtd/next
        git checkout 0629fcef16d703d384f76cb2c2c3a119a9149a34
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/mtd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mtd/mtdoops.c:244:39: warning: format specifies type 'long' but the argument has type 'unsigned int' [-Wformat]
                                  page * record_size, retlen, sizeof(hdr), ret);
                                                              ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   1 warning generated.


vim +244 drivers/mtd/mtdoops.c

   225	
   226	static void find_next_position(struct mtdoops_context *cxt)
   227	{
   228		struct mtd_info *mtd = cxt->mtd;
   229		struct mtdoops_hdr hdr;
   230		int ret, page, maxpos = 0;
   231		u32 maxcount = 0xffffffff;
   232		size_t retlen;
   233	
   234		for (page = 0; page < cxt->oops_pages; page++) {
   235			if (mtd_block_isbad(mtd, page * record_size))
   236				continue;
   237			/* Assume the page is used */
   238			mark_page_used(cxt, page);
   239			ret = mtd_read(mtd, page * record_size, sizeof(hdr),
   240				       &retlen, (u_char *)&hdr);
   241			if (retlen != sizeof(hdr) ||
   242					(ret < 0 && !mtd_is_bitflip(ret))) {
   243				printk(KERN_ERR "mtdoops: read failure at %ld (%td of %ld read), err %d\n",
 > 244				       page * record_size, retlen, sizeof(hdr), ret);
   245				continue;
   246			}
   247	
   248			if (hdr.seq == 0xffffffff && hdr.magic == 0xffffffff)
   249				mark_page_unused(cxt, page);
   250			if (hdr.seq == 0xffffffff || hdr.magic != MTDOOPS_KERNMSG_MAGIC)
   251				continue;
   252			if (maxcount == 0xffffffff) {
   253				maxcount = hdr.seq;
   254				maxpos = page;
   255			} else if (hdr.seq < 0x40000000 && maxcount > 0xc0000000) {
   256				maxcount = hdr.seq;
   257				maxpos = page;
   258			} else if (hdr.seq > maxcount && hdr.seq < 0xc0000000) {
   259				maxcount = hdr.seq;
   260				maxpos = page;
   261			} else if (hdr.seq > maxcount && hdr.seq > 0xc0000000
   262						&& maxcount > 0x80000000) {
   263				maxcount = hdr.seq;
   264				maxpos = page;
   265			}
   266		}
   267		if (maxcount == 0xffffffff) {
   268			cxt->nextpage = cxt->oops_pages - 1;
   269			cxt->nextcount = 0;
   270		}
   271		else {
   272			cxt->nextpage = maxpos;
   273			cxt->nextcount = maxcount;
   274		}
   275	
   276		mtdoops_inc_counter(cxt);
   277	}
   278	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
