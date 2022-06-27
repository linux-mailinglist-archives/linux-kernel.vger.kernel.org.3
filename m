Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F76655D18C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240972AbiF0VKA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 17:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbiF0VJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 17:09:59 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB54BB4A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656364197; x=1687900197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k0KBPpzGxryM7uyarOJAt/4Vi6g0J5jx85T9jZkMlwo=;
  b=fjfAMeqIMSWBdvF3R8VAbHvO+rRA+2WH66CCsTa09R+g1FuSGXOOwH8W
   6/EH2AcV6F/S7iecvg0t61pSKdrDFTQmm66iGknjQE2wK2l2jaPUExDs9
   zqXn02pEM4Zi5fp4yXWVHg1KXDIcA1936osCVXIviTGlZDWUv7fMc2iYM
   pnlO8SIxaY12Fl+ahrDb7NNltb62r+GCaBCHH8xRmeNp9OA7JiS3g3Uli
   tcGbcbFqfHHM4n1HxmhJsLrBAYeUGyFGIqtTrC3kUdjTKw9vsy2tenUNI
   i658VH1I1jc7NcfUXkb9tF/9FVl9+oMWvS6mwEppUBAd6VGq/0hzQUhoC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="307041044"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="307041044"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 14:09:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="657850442"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2022 14:09:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o5vzT-00092T-0B;
        Mon, 27 Jun 2022 21:09:51 +0000
Date:   Tue, 28 Jun 2022 05:08:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>
Subject: [intel-tdx:kvm-upstream-workaround 327/442]
 include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
Message-ID: <202206280512.4xQqv7zC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   8af973ebaf30642129fc1ca63f155a469f9615ed
commit: 8cb35e95129306dc6d56e230b2f2fec40189a78c [327/442] mm/shmem: Support memfile_notifier
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220628/202206280512.4xQqv7zC-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/8cb35e95129306dc6d56e230b2f2fec40189a78c
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx kvm-upstream-workaround
        git checkout 8cb35e95129306dc6d56e230b2f2fec40189a78c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the intel-tdx/kvm-upstream-workaround HEAD 8af973ebaf30642129fc1ca63f155a469f9615ed builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from include/linux/shmem_fs.h:12,
                    from init/main.c:80:
>> include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
      87 | static int memfile_register_notifier(struct file *file, flags,
         |                                                         ^~~~~
   init/main.c:769:20: warning: no previous prototype for 'arch_post_acpi_subsys_init' [-Wmissing-prototypes]
     769 | void __init __weak arch_post_acpi_subsys_init(void) { }
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:781:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     781 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~
   init/main.c:783:20: warning: no previous prototype for 'poking_init' [-Wmissing-prototypes]
     783 | void __init __weak poking_init(void) { }
         |                    ^~~~~~~~~~~
   In file included from include/linux/shmem_fs.h:12,
                    from init/main.c:80:
   include/linux/memfile_notifier.h:93:13: warning: 'memfile_unregister_notifier' defined but not used [-Wunused-function]
      93 | static void memfile_unregister_notifier(struct memfile_notifier *notifier)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:82:13: warning: 'memfile_notifier_invalidate' defined but not used [-Wunused-function]
      82 | static void memfile_notifier_invalidate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:77:13: warning: 'memfile_notifier_populate' defined but not used [-Wunused-function]
      77 | static void memfile_notifier_populate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:72:12: warning: 'memfile_node_set_flags' defined but not used [-Wunused-function]
      72 | static int memfile_node_set_flags(struct file *file, unsigned long flags)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:68:13: warning: 'memfile_register_backing_store' defined but not used [-Wunused-function]
      68 | static void memfile_register_backing_store(struct memfile_backing_store *bs)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/shmem_fs.h:12,
                    from init/do_mounts.c:20:
>> include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
      87 | static int memfile_register_notifier(struct file *file, flags,
         |                                                         ^~~~~
   In file included from include/linux/shmem_fs.h:12,
                    from init/do_mounts.c:20:
   include/linux/memfile_notifier.h:93:13: warning: 'memfile_unregister_notifier' defined but not used [-Wunused-function]
      93 | static void memfile_unregister_notifier(struct memfile_notifier *notifier)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:82:13: warning: 'memfile_notifier_invalidate' defined but not used [-Wunused-function]
      82 | static void memfile_notifier_invalidate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:77:13: warning: 'memfile_notifier_populate' defined but not used [-Wunused-function]
      77 | static void memfile_notifier_populate(struct memfile_node *node,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:72:12: warning: 'memfile_node_set_flags' defined but not used [-Wunused-function]
      72 | static int memfile_node_set_flags(struct file *file, unsigned long flags)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:68:13: warning: 'memfile_register_backing_store' defined but not used [-Wunused-function]
      68 | static void memfile_register_backing_store(struct memfile_backing_store *bs)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/shmem_fs.h:12,
                    from mm/shmem.c:59:
>> include/linux/memfile_notifier.h:87:57: error: unknown type name 'flags'
      87 | static int memfile_register_notifier(struct file *file, flags,
         |                                                         ^~~~~
   include/linux/memfile_notifier.h:93:13: warning: 'memfile_unregister_notifier' defined but not used [-Wunused-function]
      93 | static void memfile_unregister_notifier(struct memfile_notifier *notifier)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:72:12: warning: 'memfile_node_set_flags' defined but not used [-Wunused-function]
      72 | static int memfile_node_set_flags(struct file *file, unsigned long flags)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/memfile_notifier.h:68:13: warning: 'memfile_register_backing_store' defined but not used [-Wunused-function]
      68 | static void memfile_register_backing_store(struct memfile_backing_store *bs)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/flags +87 include/linux/memfile_notifier.h

0c030fb62c136d Chao Peng 2022-01-12  86  
0c030fb62c136d Chao Peng 2022-01-12 @87  static int memfile_register_notifier(struct file *file, flags,
0c030fb62c136d Chao Peng 2022-01-12  88  				     struct memfile_notifier *notifier)
0c030fb62c136d Chao Peng 2022-01-12  89  {
0c030fb62c136d Chao Peng 2022-01-12  90  	return -EOPNOTSUPP;
0c030fb62c136d Chao Peng 2022-01-12  91  }
0c030fb62c136d Chao Peng 2022-01-12  92  

:::::: The code at line 87 was first introduced by commit
:::::: 0c030fb62c136d9d0ac4e83e0872134f2a9ea896 mm: Introduce memfile_notifier

:::::: TO: Chao Peng <chao.p.peng@linux.intel.com>
:::::: CC: Isaku Yamahata <isaku.yamahata@intel.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
