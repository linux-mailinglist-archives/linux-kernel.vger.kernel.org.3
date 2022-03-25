Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E30FE4E7906
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 17:37:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376503AbiCYQi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 12:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239020AbiCYQi1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 12:38:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88DE6210D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648226212; x=1679762212;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=8u6M+Dp7AiifeVlYkXZK/xg5RToRNGkPuFZ6N1+i/dc=;
  b=ddvSHFAwpntmHQ9GwTdvfjaUymv9WMMErbZPj6oRJL626sCiJJqYUpGE
   CQzERsZHYuFUS9SEHAcABZpusPOajLTrk99Bzgui5/T8oG+Unor6RCJDy
   1NhV5b7oZ0URVJZApfshb2eLNjoG2pHf39+qqql3SMgfEvzKmDLMwY7OB
   Q7cnqCUFZF6N/qB8yqEmMzj3pCgw5c07Jz455b/i+BL0rMu9U4NYiswYa
   yTNKf3GOiAbjZvgxLI86mEd0uG44l0bff/+pO2ry0xChmciDTvaxaWovf
   dwhV27E/lofriplh8MMvnNQYxRXeac75YIr1HY20gH+xDu/ZXhmXAYI/P
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="283547287"
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="283547287"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 09:35:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,209,1643702400"; 
   d="scan'208";a="520257175"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Mar 2022 09:35:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXmuV-000MNu-P0; Fri, 25 Mar 2022 16:35:35 +0000
Date:   Sat, 26 Mar 2022 00:35:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcello Sylvester Bauer <sylv@sylv.io>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>
Subject: drivers/hwmon/pmbus/xdpe12284.c:127:36: warning: unused variable
 'xdpe122_reg_desc'
Message-ID: <202203260059.nMMU6fdT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34af78c4e616c359ed428d79fe4758a35d2c5473
commit: f53bfe4d698430bd602c37042db4021dc2603b8d hwmon: (xdpe12284) Add regulator support
date:   3 weeks ago
config: hexagon-randconfig-r041-20220325 (https://download.01.org/0day-ci/archive/20220326/202203260059.nMMU6fdT-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f53bfe4d698430bd602c37042db4021dc2603b8d
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout f53bfe4d698430bd602c37042db4021dc2603b8d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/hwmon/pmbus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pmbus/xdpe12284.c:127:36: warning: unused variable 'xdpe122_reg_desc' [-Wunused-const-variable]
   static const struct regulator_desc xdpe122_reg_desc[] = {
                                      ^
   1 warning generated.


vim +/xdpe122_reg_desc +127 drivers/hwmon/pmbus/xdpe12284.c

   126	
 > 127	static const struct regulator_desc xdpe122_reg_desc[] = {
   128		PMBUS_REGULATOR("vout", 0),
   129		PMBUS_REGULATOR("vout", 1),
   130	};
   131	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
