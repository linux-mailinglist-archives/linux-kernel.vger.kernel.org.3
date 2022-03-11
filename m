Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2D54D619C
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 13:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348578AbiCKMcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 07:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347980AbiCKMcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 07:32:07 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BE7818A790
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 04:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647001864; x=1678537864;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FoD1JM/1D0JznHoPzQxU879H7hdslD8rGb6v2/pSS1o=;
  b=a0xnRAeArV6AcN4DLEfaP67aSjB4G88+oggdFnYCOQWFo/YnAkpLYxtu
   un0D3Qg2c1ctkdZWv3uIj2qttAhapPgK6NHxQdVOwF98xJbfK0eDSfWkS
   9qJwB3C8tBCMDI/02GsBQgdRO8kIzEFk4MXM0g1B/Sl1P0QsWT4R41POu
   Z0RXOVobCeyhLsHbYL4MRJvCGaOvGen/8QRK2mmyD/iucJDj7PEBRLv4e
   1nr2Q2QSZjKNWdOFMgVaNkhaoP/TQHcbCx6GrGoMzKnp1MHqjETJyxtt2
   nSCd6CBb/g2FbJ/TKmdsxmMwOs3gCoChSKuRyurJppQlssZYGXFr7Ac7s
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="253126549"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="253126549"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 04:31:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="579273474"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 11 Mar 2022 04:31:02 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSeQA-0006O5-6G; Fri, 11 Mar 2022 12:31:02 +0000
Date:   Fri, 11 Mar 2022 20:30:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [arm-integrator:kernel-in-vmalloc-v5.17-rc1 6/8]
 drivers/xen/xenfs/xenstored.c:42:20: warning: incompatible pointer to
 integer conversion passing 'struct xenstore_domain_interface *' to parameter
 of type 'unsigned long'
Message-ID: <202203112032.czFw7ztl-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git kernel-in-vmalloc-v5.17-rc1
head:   66e9038ef48dc66c07b12443b73e2d1f3f12cbab
commit: 5976b9fa0b76bace6d7b038a7e1941175da8f5c5 [6/8] ARM: Compile the kernel into VMALLOC
config: arm-randconfig-r036-20220310 (https://download.01.org/0day-ci/archive/20220311/202203112032.czFw7ztl-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 276ca87382b8f16a65bddac700202924228982f6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git/commit/?id=5976b9fa0b76bace6d7b038a7e1941175da8f5c5
        git remote add arm-integrator https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
        git fetch --no-tags arm-integrator kernel-in-vmalloc-v5.17-rc1
        git checkout 5976b9fa0b76bace6d7b038a7e1941175da8f5c5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/xen/xenfs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/xen/xenfs/xenstored.c:42:20: warning: incompatible pointer to integer conversion passing 'struct xenstore_domain_interface *' to parameter of type 'unsigned long' [-Wint-conversion]
                               virt_to_pfn(xen_store_interface),
                                           ^~~~~~~~~~~~~~~~~~~
   arch/arm/include/asm/memory.h:323:55: note: passing argument to parameter 'kaddr' here
   static inline unsigned long virt_to_pfn(unsigned long kaddr)
                                                         ^
   1 warning generated.


vim +42 drivers/xen/xenfs/xenstored.c

655d406a7c80bf Ian Campbell 2009-02-06  33  
655d406a7c80bf Ian Campbell 2009-02-06  34  static int xsd_kva_mmap(struct file *file, struct vm_area_struct *vma)
655d406a7c80bf Ian Campbell 2009-02-06  35  {
655d406a7c80bf Ian Campbell 2009-02-06  36  	size_t size = vma->vm_end - vma->vm_start;
655d406a7c80bf Ian Campbell 2009-02-06  37  
655d406a7c80bf Ian Campbell 2009-02-06  38  	if ((size > PAGE_SIZE) || (vma->vm_pgoff != 0))
655d406a7c80bf Ian Campbell 2009-02-06  39  		return -EINVAL;
655d406a7c80bf Ian Campbell 2009-02-06  40  
655d406a7c80bf Ian Campbell 2009-02-06  41  	if (remap_pfn_range(vma, vma->vm_start,
655d406a7c80bf Ian Campbell 2009-02-06 @42  			    virt_to_pfn(xen_store_interface),
655d406a7c80bf Ian Campbell 2009-02-06  43  			    size, vma->vm_page_prot))
655d406a7c80bf Ian Campbell 2009-02-06  44  		return -EAGAIN;
655d406a7c80bf Ian Campbell 2009-02-06  45  
655d406a7c80bf Ian Campbell 2009-02-06  46  	return 0;
655d406a7c80bf Ian Campbell 2009-02-06  47  }
655d406a7c80bf Ian Campbell 2009-02-06  48  

:::::: The code at line 42 was first introduced by commit
:::::: 655d406a7c80bffc03263d071b6ba1e0fcf548f9 xen: add /proc/xen/xsd_{kva,port} to xenfs

:::::: TO: Ian Campbell <ian.campbell@citrix.com>
:::::: CC: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
