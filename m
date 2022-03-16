Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D154E4DB9FB
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358120AbiCPVNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358128AbiCPVMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:12:53 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09883113E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647465098; x=1679001098;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=33tgrV5JYKLeAOwA4Nu2CwWba5e0y4cmLUG0e9EdJRs=;
  b=nR+LhQM2MeZOwGpOablF6GXWDl0oFI/rdA/JGQTHmjbVs1oUjfW5OgFl
   8WVfO+WMninTdgcia71ryCr8IzRY1d87zjrr4sotrEJIUxOjvdHjLaCZk
   0gJzF1z63/G+nvzUucyNh5GEd4wO+khrj0KSIRTOpyBGl2LtGCDkWgktp
   oIEWG2+p9wUKD5uq3x+I/R1eHLZpNLdLEBBN3wtqmZ/ub7wMPHwEHDn8O
   HOALUFjPfOMufL6hd1xfKmvoH3Qyf8vzVAKKMp0r0+qIoG0T9V9mqZVTw
   kkQx6eSZmzIyEhS/QDmantVd+dDePPA8Xr2HcaVhdzKKMTqmqhkG4ju+2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317431872"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317431872"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 14:11:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="581067076"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 16 Mar 2022 14:11:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUavf-000Cwl-O4; Wed, 16 Mar 2022 21:11:35 +0000
Date:   Thu, 17 Mar 2022 05:10:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1561/2335] ./usr/include/linux/if_bonding.h:47:10:
 fatal error: uapi/linux/sockios.h: No such file or directory
Message-ID: <202203170538.YucL98mt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 8277ec1f350dcb24941cddc0df58fa978de30f91 [1561/2335] headers/deps: net: Optimize the header dependencies of <uapi/linux/if_bonding.h>
config: i386-randconfig-a006-20220314 (https://download.01.org/0day-ci/archive/20220317/202203170538.YucL98mt-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=8277ec1f350dcb24941cddc0df58fa978de30f91
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 8277ec1f350dcb24941cddc0df58fa978de30f91
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/linux/if_bonding.h:47:10: fatal error: uapi/linux/sockios.h: No such file or directory
      47 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
