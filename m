Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 692D256AB1A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbiGGS5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236357AbiGGS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:57:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE442B630;
        Thu,  7 Jul 2022 11:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657220220; x=1688756220;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kHqtFBMY6Tn6eM/gP2+igQSJe/Rgt1sUEEGEuK+ZNpA=;
  b=OlIg0/mil2xVN2WaFZqS9tdfb8J5cnJxObWupARAsrm7v39mz9YSeHCn
   BHxT7I8bk7jgqfXzj39F5R8qLFVm9uDbciB6clkQyV/C+iqLkhCrHMZN3
   kNhcXnBbLT/PRTXzv+zRGNyjM+UmxDS9ib2V0Vr5gEsYJZLprkrALyRsA
   eMCUkVMTmFyoRBLq6NP2627UQ+amOmadRSRIdnShzPBCk7UiY+lBtkEKY
   miJkxXonu0m6Xd6CYvQyggbKLv1VisXWeKh9GhB+88H/irSwgkGJhXjRk
   +pLoDprxOUloA/9Quj6zXouRz9L/wWB1j+Orn/Zg0Hy9L4SHHmoJy/Tns
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="370415396"
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="370415396"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 11:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,253,1650956400"; 
   d="scan'208";a="736072664"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 07 Jul 2022 11:56:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9WgL-000MKq-8P;
        Thu, 07 Jul 2022 18:56:57 +0000
Date:   Fri, 8 Jul 2022 02:56:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Atif Ofluoglu <Atif.Ofluoglu@analog.com>, linux@roeck-us.net
Cc:     kbuild-all@lists.01.org, jdelvare@suse.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Atif Ofluoglu <atif.ofluoglu@analog.com>
Subject: Re: [PATCH 1/2] hwmon: (pmbus/max20754) Add support for MAX20754
Message-ID: <202207080255.fBmFH9Ry-lkp@intel.com>
References: <3659043f92b0ca9e538679e00f7dcc214525ff2e.1657204859.git.atif.ofluoglu@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3659043f92b0ca9e538679e00f7dcc214525ff2e.1657204859.git.atif.ofluoglu@analog.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Atif,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on groeck-staging/hwmon-next]
[also build test ERROR on linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Atif-Ofluoglu/Adding-MAX20754-support/20220707-233249
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: arc-randconfig-r043-20220707 (https://download.01.org/0day-ci/archive/20220708/202207080255.fBmFH9Ry-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/52ef0855bc74f95cd6c170b5475a3e957d7e1028
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Atif-Ofluoglu/Adding-MAX20754-support/20220707-233249
        git checkout 52ef0855bc74f95cd6c170b5475a3e957d7e1028
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/hwmon/pmbus/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hwmon/pmbus/max20754.c:381:19: error: 'pmbus_do_remove' undeclared here (not in a function); did you mean 'pmbus_do_probe'?
     381 |         .remove = pmbus_do_remove,
         |                   ^~~~~~~~~~~~~~~
         |                   pmbus_do_probe


vim +381 drivers/hwmon/pmbus/max20754.c

   375	
   376	static struct i2c_driver max20754_driver = {
   377		.driver = {
   378			   .name = "max20754",
   379			   },
   380		.probe_new = max20754_probe,
 > 381		.remove = pmbus_do_remove,
   382		.id_table = max20754_id,
   383	};
   384	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
