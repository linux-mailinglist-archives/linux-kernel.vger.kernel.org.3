Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A614656AEBF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 00:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236089AbiGGWwN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 18:52:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiGGWwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 18:52:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D48EC1EED1
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 15:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657234330; x=1688770330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RqOyH4OpElwmJB95WX5zUtiWglFHWEWEhm8kjhWZIyw=;
  b=FxvS1d3NEkzCkGGQtR3cESb6yEcr12qfL1NaY1/VVjqimnVc3h7yyx7g
   M35a97xmGxVzly1xW6UEeoquW8hXNBcpmLF/GaWR1yeGd/je+1iwQclPS
   zIJHf5VKChwZj/+xdrCBuUWVd8rU1205ztEFhhfadk0hxtEeZ1QcY5El6
   1GzwyBz2r+nBMJmlw2+ey0g3Y2B3CA+OfQqA3B1Xc7UnkcpEcKgOtlahI
   Yu7l1fdRRbjlci7Wi2MzaKuXsk1NPZyJqLI1F2lTblk/HtX4tTXzq/c/j
   8nZeXoq14zgPjwQfmu5bE1wjpWOiPKYte2xNHXew4ieHembgghpfULmnO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="285265671"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="285265671"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 15:52:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="651320616"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2022 15:52:08 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9aLv-000MZ2-LN;
        Thu, 07 Jul 2022 22:52:07 +0000
Date:   Fri, 8 Jul 2022 06:51:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] powerpc: Remove asm/prom.h from asm/mpc52xx.h and
 asm/pci.h
Message-ID: <202207080653.Rru2i2Nn-lkp@intel.com>
References: <22ac0b64b6c6ef6cc6a74739eb213a81372835ed.1657204012.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ac0b64b6c6ef6cc6a74739eb213a81372835ed.1657204012.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on mkp-scsi/for-next jejb-scsi/for-next linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christophe-Leroy/video-fbdev-offb-Include-missing-linux-platform_device-h/20220707-222906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: powerpc-mpc8313_rdb_defconfig (https://download.01.org/0day-ci/archive/20220708/202207080653.Rru2i2Nn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 66ae1d60bb278793fd651cece264699d522bab84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install powerpc cross compiling tool for clang build
        # apt-get install binutils-powerpc-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/0e553b9abdcfd7c1f63b072e9d9280ce759c0c3c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christophe-Leroy/video-fbdev-offb-Include-missing-linux-platform_device-h/20220707-222906
        git checkout 0e553b9abdcfd7c1f63b072e9d9280ce759c0c3c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/prom.c:891:5: error: no previous prototype for function 'of_get_ibm_chip_id' [-Werror,-Wmissing-prototypes]
   int of_get_ibm_chip_id(struct device_node *np)
       ^
   arch/powerpc/kernel/prom.c:891:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int of_get_ibm_chip_id(struct device_node *np)
   ^
   static 
   1 error generated.


vim +/of_get_ibm_chip_id +891 arch/powerpc/kernel/prom.c

b27652dd2174df1 Kevin Hao              2013-12-24  871  
9b6b563c0d2d25e Paul Mackerras         2005-10-06  872  /*******
9b6b563c0d2d25e Paul Mackerras         2005-10-06  873   *
9b6b563c0d2d25e Paul Mackerras         2005-10-06  874   * New implementation of the OF "find" APIs, return a refcounted
9b6b563c0d2d25e Paul Mackerras         2005-10-06  875   * object, call of_node_put() when done.  The device tree and list
9b6b563c0d2d25e Paul Mackerras         2005-10-06  876   * are protected by a rw_lock.
9b6b563c0d2d25e Paul Mackerras         2005-10-06  877   *
9b6b563c0d2d25e Paul Mackerras         2005-10-06  878   * Note that property management will need some locking as well,
9b6b563c0d2d25e Paul Mackerras         2005-10-06  879   * this isn't dealt with yet.
9b6b563c0d2d25e Paul Mackerras         2005-10-06  880   *
9b6b563c0d2d25e Paul Mackerras         2005-10-06  881   *******/
9b6b563c0d2d25e Paul Mackerras         2005-10-06  882  
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  883  /**
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  884   * of_get_ibm_chip_id - Returns the IBM "chip-id" of a device
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  885   * @np: device node of the device
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  886   *
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  887   * This looks for a property "ibm,chip-id" in the node or any
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  888   * of its parents and returns its content, or -1 if it cannot
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  889   * be found.
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  890   */
b37193b71846858 Benjamin Herrenschmidt 2013-07-15 @891  int of_get_ibm_chip_id(struct device_node *np)
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  892  {
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  893  	of_node_get(np);
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  894  	while (np) {
1856f50c66dff0a Christophe Jaillet     2015-10-16  895  		u32 chip_id;
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  896  
1856f50c66dff0a Christophe Jaillet     2015-10-16  897  		/*
1856f50c66dff0a Christophe Jaillet     2015-10-16  898  		 * Skiboot may produce memory nodes that contain more than one
1856f50c66dff0a Christophe Jaillet     2015-10-16  899  		 * cell in chip-id, we only read the first one here.
1856f50c66dff0a Christophe Jaillet     2015-10-16  900  		 */
1856f50c66dff0a Christophe Jaillet     2015-10-16  901  		if (!of_property_read_u32(np, "ibm,chip-id", &chip_id)) {
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  902  			of_node_put(np);
1856f50c66dff0a Christophe Jaillet     2015-10-16  903  			return chip_id;
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  904  		}
16c1d606263ea37 Michael Ellerman       2015-10-26  905  
16c1d606263ea37 Michael Ellerman       2015-10-26  906  		np = of_get_next_parent(np);
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  907  	}
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  908  	return -1;
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  909  }
b130e7c04f1130f Dan Streetman          2015-05-07  910  EXPORT_SYMBOL(of_get_ibm_chip_id);
b37193b71846858 Benjamin Herrenschmidt 2013-07-15  911  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
