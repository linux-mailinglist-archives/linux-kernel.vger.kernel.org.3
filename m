Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3CD048232C
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 11:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhLaKOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 05:14:53 -0500
Received: from mga05.intel.com ([192.55.52.43]:55695 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229817AbhLaKOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 05:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640945692; x=1672481692;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9SVjFtwpFH3eE3tW553DPJvfT99G2uhL/beuIf3vfuY=;
  b=CD6lmexWRVDj9q708+SEbgAxJmKSzu8jjnIXbXdXZvrep2eafDvmrn4/
   YlqxxwKGpuFW7yHd434T27JP5jyDtQeVBQBGZ5V/Nupxk/qB3tk7x+4t7
   WsQIfxGGZrZAp2+aXXenwCjaJx5BrAdx0nScV0pEOrFSSWLzLczKHvbpn
   +peLoSbq8dC3JlrLM00p/w7fWy+JVenLcegSX+pNqytIbnTVBICe7AX//
   s+5VLN+MCP3tJLaldT98LpUc6bEzZyayCPb1uthjSWMOk+g63gNQ31JXC
   c32dduuW427EUo21YiXT3xJqJGznZutYfgL6ltdPY1fdh34zsBSJiAMEy
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10213"; a="328131149"
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="328131149"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2021 02:14:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,251,1635231600"; 
   d="scan'208";a="470915852"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 31 Dec 2021 02:14:50 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n3Evy-000B9o-3o; Fri, 31 Dec 2021 10:14:50 +0000
Date:   Fri, 31 Dec 2021 18:14:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: [mchehab-experimental:master 115/390]
 drivers/staging/media/atomisp//pci/isp2400_input_system_local.h:32:40:
 warning: redefinition of typedef 'input_system_cfg2400_t' is a C11 feature
Message-ID: <202112311809.bEKUPkjh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

FYI, the error/warning still remains.

tree:   https://git.linuxtv.org/mchehab/experimental.git master
head:   68b9bcc8a534cd11fe55f8bc82f948aae7d81b3c
commit: 4005ecee616a51cb0305d8e3664af45376e7cf65 [115/390] media: atomisp: shift some structs from input_system_local
config: x86_64-randconfig-a014-20211231 (https://download.01.org/0day-ci/archive/20211231/202112311809.bEKUPkjh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 7cd109b92c72855937273a6c8ab19016fbe27d33)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add mchehab-experimental https://git.linuxtv.org/mchehab/experimental.git
        git fetch --no-tags mchehab-experimental master
        git checkout 4005ecee616a51cb0305d8e3664af45376e7cf65
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/staging/media/atomisp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/staging/media/atomisp/pci/atomisp_cmd.c:44:
   In file included from drivers/staging/media/atomisp//pci/atomisp_tables.h:23:
   In file included from drivers/staging/media/atomisp//pci/sh_css_params.h:30:
   In file included from drivers/staging/media/atomisp//pci/runtime/pipeline/interface/ia_css_pipeline.h:19:
   In file included from drivers/staging/media/atomisp//pci/sh_css_internal.h:28:
   In file included from drivers/staging/media/atomisp//pci/hive_isp_css_include/input_system.h:34:
   In file included from drivers/staging/media/atomisp//pci/input_system_local.h:144:
>> drivers/staging/media/atomisp//pci/isp2400_input_system_local.h:32:40: warning: redefinition of typedef 'input_system_cfg2400_t' is a C11 feature [-Wtypedef-redefinition]
   typedef struct input_system_cfg2400_s           input_system_cfg2400_t;
                                                   ^
   drivers/staging/media/atomisp//pci/input_system_local.h:22:40: note: previous definition is here
   typedef struct input_system_cfg2400_s           input_system_cfg2400_t;
                                                   ^
   1 warning generated.


vim +/input_system_cfg2400_t +32 drivers/staging/media/atomisp//pci/isp2400_input_system_local.h

ad85094b293e40 drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_common/host/input_system_local.h Mauro Carvalho Chehab 2020-04-19  31  
ad85094b293e40 drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_common/host/input_system_local.h Mauro Carvalho Chehab 2020-04-19 @32  typedef struct input_system_cfg2400_s		input_system_cfg2400_t;
ad85094b293e40 drivers/staging/media/atomisp/pci/atomisp2/css2400/hive_isp_css_common/host/input_system_local.h Mauro Carvalho Chehab 2020-04-19  33  

:::::: The code at line 32 was first introduced by commit
:::::: ad85094b293e40e7a2f831b0311a389d952ebd5e Revert "media: staging: atomisp: Remove driver"

:::::: TO: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
