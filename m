Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A18749FB9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349124AbiA1OYa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:24:30 -0500
Received: from mga01.intel.com ([192.55.52.88]:14015 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349109AbiA1OY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:24:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643379867; x=1674915867;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xChxVhzIhaTTa+OGJbz0k6Hw1HEJzyGMSh7aO2ZLbLw=;
  b=midQALOJ4nblaKcBD7NkkAl9gt2obN9cluZVgeJFN9lzETTzwzozCzoe
   mfM0XFAOMvZO/oxFbZnT6AJspsCJZJL6I17ML+wM31NPtD2oCOUHhFMZ/
   1JBHEs/lMSZ86/PyDRyYnhrO931Ff0uSPmbblD1OP0rbzd2u9JV9YYNho
   7mnmuS0b5x0leNr2ncYAtUzayvZGP+jtOc+h+4zsmcjl/aL+UlVluAk+2
   G3u9A34vH0w0J4uXSq4DqaPNIVqCce7t7dh7kPK4wcsObCfFzl3GMir88
   wJsskAr2M1B5jQEtUf9bbZBwUz2NFI2D4ZV4AmSdn+W8Ix3rh8fw6g+2R
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10240"; a="271589631"
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="271589631"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2022 06:24:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,324,1635231600"; 
   d="scan'208";a="536149392"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2022 06:24:25 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDSAr-000NyC-1Q; Fri, 28 Jan 2022 14:24:25 +0000
Date:   Fri, 28 Jan 2022 22:23:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Pirko <jiri@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:jiri_devel_linecards 37/58]
 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:344:39: error: passing
 argument 1 of 'mlxsw_linecard_provision_fail' from incompatible pointer type
Message-ID: <202201282226.T1KtFC5Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jpirko/linux_mlxsw jiri_devel_linecards
head:   e29aaaea5a4ec1a13a522a428fed7ce715a01d0d
commit: 73018c57f04b9844d72620e46dd767eb0fc1ad01 [37/58] mlxsw: core_linecards: Probe devices for provisioned line card and attach them
config: alpha-allmodconfig (https://download.01.org/0day-ci/archive/20220128/202201282226.T1KtFC5Q-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/73018c57f04b9844d72620e46dd767eb0fc1ad01
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw jiri_devel_linecards
        git checkout 73018c57f04b9844d72620e46dd767eb0fc1ad01
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/net/ethernet/mellanox/mlxsw/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c: In function 'mlxsw_linecard_status_event_to_work':
>> drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:344:39: error: passing argument 1 of 'mlxsw_linecard_provision_fail' from incompatible pointer type [-Werror=incompatible-pointer-types]
     344 |         mlxsw_linecard_provision_fail(linecard);
         |                                       ^~~~~~~~
         |                                       |
         |                                       struct mlxsw_linecard *
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:153:62: note: expected 'struct mlxsw_core *' but argument is of type 'struct mlxsw_linecard *'
     153 | static void mlxsw_linecard_provision_fail(struct mlxsw_core *mlxsw_core,
         |                                           ~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
>> drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:344:9: error: too few arguments to function 'mlxsw_linecard_provision_fail'
     344 |         mlxsw_linecard_provision_fail(linecard);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/net/ethernet/mellanox/mlxsw/core_linecards.c:153:13: note: declared here
     153 | static void mlxsw_linecard_provision_fail(struct mlxsw_core *mlxsw_core,
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/mlxsw_linecard_provision_fail +344 drivers/net/ethernet/mellanox/mlxsw/core_linecards.c

57299b50dc9224 Jiri Pirko 2022-01-28  334  
57299b50dc9224 Jiri Pirko 2022-01-28  335  static void mlxsw_linecard_status_event_to_work(struct work_struct *work)
57299b50dc9224 Jiri Pirko 2022-01-28  336  {
57299b50dc9224 Jiri Pirko 2022-01-28  337  	struct mlxsw_linecard *linecard =
57299b50dc9224 Jiri Pirko 2022-01-28  338  		container_of(work, struct mlxsw_linecard,
57299b50dc9224 Jiri Pirko 2022-01-28  339  			     status_event_to_dw.work);
57299b50dc9224 Jiri Pirko 2022-01-28  340  
57299b50dc9224 Jiri Pirko 2022-01-28  341  	dev_err(linecard->linecards->bus_info->dev, "linecard %u: Timeout reached waiting on %s status event",
57299b50dc9224 Jiri Pirko 2022-01-28  342  		linecard->slot_index,
57299b50dc9224 Jiri Pirko 2022-01-28  343  		mlxsw_linecard_status_event_type_name[linecard->status_event_type_to]);
57299b50dc9224 Jiri Pirko 2022-01-28 @344  	mlxsw_linecard_provision_fail(linecard);
57299b50dc9224 Jiri Pirko 2022-01-28  345  }
57299b50dc9224 Jiri Pirko 2022-01-28  346  

:::::: The code at line 344 was first introduced by commit
:::::: 57299b50dc9224b8512f83e641ae92cc128016cf TMP: event timeout

:::::: TO: Jiri Pirko <jiri@nvidia.com>
:::::: CC: Jiri Pirko <jiri@nvidia.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
