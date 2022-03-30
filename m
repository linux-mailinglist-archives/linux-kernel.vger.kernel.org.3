Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5CF4EB9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242649AbiC3Ev2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236198AbiC3Ev1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:51:27 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E6C21E08
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 21:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648615782; x=1680151782;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QkOzsmCZKcLJNDErhXd1TS7XNjyQSLSieo/gpsxySE4=;
  b=Nt0NWBdxtJ8JyiwdnpXmhNODO72/PlDo7zQhxwUDequQeXs6a4V4B+oi
   qGJMNVr6IHO8q3Qpu1qRecOE5rIsaJDNEOJO4J0k/CJpUu3faeRR6iM1p
   bHKCueA5MqMbjQFvhMdWU1nC1dMc+QHRz9N5Bs7dzzfln3r2rzryCTlce
   aqQb52flGPaWslmpJnBS9v29vk8mOEiDcKz1ZjJKfn+zhLQjMGndYKiZi
   67rOVIw8NX87x9e9TzPD7eMp85RFgmgCom1xkF7mwYk4PIWU4Z+2CEEio
   0LxfXmgu+IrSBih2iWOr8rb3nhN6w5oiCoMRfupaR22wmNxbKgGFZaCZu
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="322627125"
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="322627125"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2022 21:49:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,221,1643702400"; 
   d="scan'208";a="719825054"
Received: from lkp-server01.sh.intel.com (HELO 3965e2759b93) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2022 21:49:40 -0700
Received: from kbuild by 3965e2759b93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZQH6-0000zk-02; Wed, 30 Mar 2022 04:49:40 +0000
Date:   Wed, 30 Mar 2022 12:49:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Baisong Zhong <zhongbaisong@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: [mcgrof:sysctl-next 6/18] core.c:undefined reference to
 `sched_rt_can_attach'
Message-ID: <202203301258.O8GJygB7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git sysctl-next
head:   84053cc7ef2f2f86caeea6a8c0944b2f0b3f33ca
commit: d82a599294a1c50168a2177d49fe0a9a791275c3 [6/18] sched/rt: fix build error when CONFIG_SYSCTL is disable
config: arm64-randconfig-r023-20220329 (https://download.01.org/0day-ci/archive/20220330/202203301258.O8GJygB7-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?id=d82a599294a1c50168a2177d49fe0a9a791275c3
        git remote add mcgrof https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git
        git fetch --no-tags mcgrof sysctl-next
        git checkout d82a599294a1c50168a2177d49fe0a9a791275c3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: kernel/sched/core.o: in function `cpu_cgroup_can_attach':
>> core.c:(.text+0x28c4): undefined reference to `sched_rt_can_attach'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
