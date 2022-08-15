Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF12592E4A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 13:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbiHOLkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 07:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241568AbiHOLkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 07:40:39 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED6110FC1;
        Mon, 15 Aug 2022 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660563636; x=1692099636;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E+o2e7xDZrWkCt8WFcYoOrHP5fqayr1RiDjBJDwgBxM=;
  b=dPPkjTo4q7Lj4o+/hcMXR7SOve+hFEu+eKt5ta83C4OFj/lkhuVTKryW
   nU5tCMBiVssv/UVpHGejdnVJughCadiFtDxFmprgP7bomptOAIG46QzMs
   VLT3mV1NzQNVM1/e842JjCVN3avbqfJydGTUVnoLf5n53rjGQvgNCuoHE
   kfF4dsiq/PlLFjs3WYgdqKwIKh6dG9/NlDRUbYTGPNkaIF/xHj9GKaE2T
   rzIWfKZMFmAbDJUw5GxrrKDCXlISmXRKfrDkFjHW8zWKYvpeFI8ApprpF
   oJGcsD/VaRbf6gJ4XlHeEoOqF6JLDfXlRHObVLNbKSJKl7kvFvu+8YZYd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="290694125"
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="290694125"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 04:40:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,238,1654585200"; 
   d="scan'208";a="582850048"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Aug 2022 04:40:33 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNYSO-0000yb-1o;
        Mon, 15 Aug 2022 11:40:32 +0000
Date:   Mon, 15 Aug 2022 19:39:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     lewis.hanly@microchip.com, linux-gpio@vger.kernel.org,
        linux-riscv@lists.infradead.org, linus.walleij@linaro.org,
        brgl@bgdev.pl, linux-kernel@vger.kernel.org, palmer@dabbelt.com,
        maz@kernel.org
Cc:     kbuild-all@lists.01.org, conor.dooley@microchip.com,
        daire.mcnamara@microchip.com, lewis.hanly@microchip.com
Subject: Re: [PATCH v5 1/1] gpio: mpfs: add polarfire soc gpio support
Message-ID: <202208151906.8v7FxH3X-lkp@intel.com>
References: <20220815070606.1298421-2-lewis.hanly@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220815070606.1298421-2-lewis.hanly@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on brgl/gpio/for-next]
[also build test WARNING on linus/master v6.0-rc1 next-20220815]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/lewis-hanly-microchip-com/Add-Polarfire-SoC-GPIO-support/20220815-150808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git gpio/for-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220815/202208151906.8v7FxH3X-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0458963d9f39d68b20ed88e71d20ca69d835e7fe
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review lewis-hanly-microchip-com/Add-Polarfire-SoC-GPIO-support/20220815-150808
        git checkout 0458963d9f39d68b20ed88e71d20ca69d835e7fe
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpio/gpio-mpfs.c: In function 'mpfs_gpio_irq_handler':
   drivers/gpio/gpio-mpfs.c:203:9: error: 'unisgned' undeclared (first use in this function)
     203 |         unisgned long status;
         |         ^~~~~~~~
   drivers/gpio/gpio-mpfs.c:203:9: note: each undeclared identifier is reported only once for each function it appears in
   drivers/gpio/gpio-mpfs.c:203:17: error: expected ';' before 'long'
     203 |         unisgned long status;
         |                 ^~~~~
         |                 ;
>> drivers/gpio/gpio-mpfs.c:204:9: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     204 |         int offset;
         |         ^~~
   drivers/gpio/gpio-mpfs.c:208:9: error: 'status' undeclared (first use in this function); did you mean 'kstatfs'?
     208 |         status = readl(mpfs_gpio->base + MPFS_IRQ_REG);
         |         ^~~~~~
         |         kstatfs
   drivers/gpio/gpio-mpfs.c: In function 'mpfs_gpio_probe':
   drivers/gpio/gpio-mpfs.c:268:19: error: 'struct irq_chip' has no member named 'parent_device'
     268 |         girq->chip->parent_device = dev;
         |                   ^~


vim +204 drivers/gpio/gpio-mpfs.c

   197	
   198	static void mpfs_gpio_irq_handler(struct irq_desc *desc)
   199	{
   200		struct irq_chip *irqchip = irq_desc_get_chip(desc);
   201		struct mpfs_gpio_chip *mpfs_gpio =
   202			gpiochip_get_data(irq_desc_get_handler_data(desc));
 > 203		unisgned long status;
 > 204		int offset;
   205	
   206		chained_irq_enter(irqchip, desc);
   207	
   208		status = readl(mpfs_gpio->base + MPFS_IRQ_REG);
   209		for_each_set_bit(offset, &status, mpfs_gpio->gc.ngpio) {
   210			mpfs_gpio_assign_bit(mpfs_gpio->base + MPFS_IRQ_REG, offset, 1);
   211			generic_handle_irq(irq_find_mapping(mpfs_gpio->gc.irq.domain, offset));
   212		}
   213	
   214		chained_irq_exit(irqchip, desc);
   215	}
   216	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
