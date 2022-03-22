Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D203E4E3FC9
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 14:45:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235843AbiCVNq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 09:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235823AbiCVNq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 09:46:27 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275E82610E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647956700; x=1679492700;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xNjDnMgEHpCF2A25uwYP+Yv48qAIEF8LeOXaCc3uCd0=;
  b=WJ6iZ+MgXYxKGSVew7/9lVe/lBUlMVTCbaXIWURPONZ8SfztgTIjnRni
   2KaEo+rF/HyJBtjkYum/6uoLnBrqR90VvuPgud+aX4PLZ+Dsrqp9Xm21K
   bwG3KsXkwjjH+RJk8Ty5f1fq/cyA1LPS33wIcW2+c3sYPe3WuG2B4oEvX
   7J97caqryJgomRip3kfNprGJGu8nhL9HbggPyuv/FB30U0pV9YvAdTQ39
   0qQ9jVDYeP2GMpuGN0iwuskC4/5TsoykeggqOFT273gtUi4KgblKYn5GQ
   HiLNaFGEyTKAdzLuN1Hs+OVw08/yOJXw0ShD6R8BjXoPRw4UHZe3PVQnA
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="237761000"
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="237761000"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 06:44:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,201,1643702400"; 
   d="scan'208";a="518881444"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Mar 2022 06:44:49 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWeoa-000Irk-AU; Tue, 22 Mar 2022 13:44:48 +0000
Date:   Tue, 22 Mar 2022 21:44:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 421/2335] include/linux/huge_mm.h:168:6: error:
 implicit declaration of function 'vma_is_dax'
Message-ID: <202203222155.TlSyCe5J-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: f7a0205170ca096c85d224726dc7f9cfc5950de3 [421/2335] headers/uninline: Uninline multi-use function: vma_is_dax() and vma_is_fsdax()
config: i386-randconfig-a016-20220314 (https://download.01.org/0day-ci/archive/20220322/202203222155.TlSyCe5J-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=f7a0205170ca096c85d224726dc7f9cfc5950de3
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout f7a0205170ca096c85d224726dc7f9cfc5950de3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the mingo-tip/master HEAD 85293bf3fca6d85608cff1447ce3097583f15fab builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from fs/fuse/virtio_fs.c:8:
   In file included from include/linux/dax.h:6:
   In file included from include/linux/mm.h:689:
>> include/linux/huge_mm.h:168:6: error: implicit declaration of function 'vma_is_dax' [-Werror,-Wimplicit-function-declaration]
           if (vma_is_dax(vma))
               ^
   In file included from fs/fuse/virtio_fs.c:8:
   In file included from include/linux/dax.h:6:
>> include/linux/mm.h:3240:13: error: conflicting types for 'vma_is_dax'
   extern bool vma_is_dax(const struct vm_area_struct *vma);
               ^
   include/linux/huge_mm.h:168:6: note: previous implicit declaration is here
           if (vma_is_dax(vma))
               ^
   2 errors generated.


vim +/vma_is_dax +168 include/linux/huge_mm.h

bae84953815793 Aneesh Kumar K.V  2021-02-24  152  
bae84953815793 Aneesh Kumar K.V  2021-02-24  153  	/*
bae84953815793 Aneesh Kumar K.V  2021-02-24  154  	 * If the hardware/firmware marked hugepage support disabled.
bae84953815793 Aneesh Kumar K.V  2021-02-24  155  	 */
bae84953815793 Aneesh Kumar K.V  2021-02-24  156  	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_NEVER_DAX))
bae84953815793 Aneesh Kumar K.V  2021-02-24  157  		return false;
bae84953815793 Aneesh Kumar K.V  2021-02-24  158  
e6be37b2e7bddf Miaohe Lin        2021-06-30  159  	if (!transhuge_vma_enabled(vma, vma->vm_flags))
16981d763501c0 Dan Williams      2017-07-10  160  		return false;
16981d763501c0 Dan Williams      2017-07-10  161  
222100eed264ba Anshuman Khandual 2020-04-01  162  	if (vma_is_temporary_stack(vma))
16981d763501c0 Dan Williams      2017-07-10  163  		return false;
16981d763501c0 Dan Williams      2017-07-10  164  
16981d763501c0 Dan Williams      2017-07-10  165  	if (transparent_hugepage_flags & (1 << TRANSPARENT_HUGEPAGE_FLAG))
16981d763501c0 Dan Williams      2017-07-10  166  		return true;
bae84953815793 Aneesh Kumar K.V  2021-02-24  167  
baabda26142451 Dan Williams      2017-07-10 @168  	if (vma_is_dax(vma))
baabda26142451 Dan Williams      2017-07-10  169  		return true;
baabda26142451 Dan Williams      2017-07-10  170  
16981d763501c0 Dan Williams      2017-07-10  171  	if (transparent_hugepage_flags &
16981d763501c0 Dan Williams      2017-07-10  172  				(1 << TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG))
16981d763501c0 Dan Williams      2017-07-10  173  		return !!(vma->vm_flags & VM_HUGEPAGE);
16981d763501c0 Dan Williams      2017-07-10  174  
16981d763501c0 Dan Williams      2017-07-10  175  	return false;
16981d763501c0 Dan Williams      2017-07-10  176  }
16981d763501c0 Dan Williams      2017-07-10  177  

:::::: The code at line 168 was first introduced by commit
:::::: baabda261424517110ea98c6651f632ebf2561e3 mm: always enable thp for dax mappings

:::::: TO: Dan Williams <dan.j.williams@intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
