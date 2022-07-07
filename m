Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCAC56AB1D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236599AbiGGS5E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236503AbiGGS5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:57:01 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F922C676
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657220220; x=1688756220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LcZZRvy8+Gv5ome0QZnwsPgoMphmJXtBO7K/+rZX4c4=;
  b=mtMBPekUe872IRjWtLxUbS51/7jl6odKt6zakT/FuKuuhKzvqng28g+j
   Yi3TldE+jtROJmnJUXHWJVKLOq3l9K13TWMAMwtBbU7POHfl4a4vAoYyf
   F3bFaAa60gtlFPdPGanIFkFv8EpMBmbCNFRyASrYGgi6oIaijbXY3Ir5u
   ZWucOCq7h4wHrUZ5plifvtgXhaLuhlWDcT4rf2kHsoW274TZko7WWOOVb
   uoRmv31GqW1tQqXfHxNZ2FjcB4AW+hZckKvP5RDLRbN04z80meOQjpZPT
   aKpVEo1ataQoZPkPvgjkklsVkthKBCN+2BA5eWyeU2GMEIAVJdtRQDR4H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284841500"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="284841500"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 11:57:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="651252244"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Jul 2022 11:56:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9WgL-000MKo-7A;
        Thu, 07 Jul 2022 18:56:57 +0000
Date:   Fri, 8 Jul 2022 02:56:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     kbuild-all@lists.01.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] powerpc: Remove asm/prom.h from asm/mpc52xx.h and
 asm/pci.h
Message-ID: <202207080212.NBrIIaUw-lkp@intel.com>
References: <22ac0b64b6c6ef6cc6a74739eb213a81372835ed.1657204012.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22ac0b64b6c6ef6cc6a74739eb213a81372835ed.1657204012.git.christophe.leroy@csgroup.eu>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220708/202207080212.NBrIIaUw-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0e553b9abdcfd7c1f63b072e9d9280ce759c0c3c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christophe-Leroy/video-fbdev-offb-Include-missing-linux-platform_device-h/20220707-222906
        git checkout 0e553b9abdcfd7c1f63b072e9d9280ce759c0c3c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash arch/powerpc/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/prom.c:891:5: error: no previous prototype for 'of_get_ibm_chip_id' [-Werror=missing-prototypes]
     891 | int of_get_ibm_chip_id(struct device_node *np)
         |     ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


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
