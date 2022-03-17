Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21AA84DBF2B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 07:17:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiCQGS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 02:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiCQGSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 02:18:49 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C2C17586B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 22:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647496554; x=1679032554;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NxbwI92yI+pL93u2hlCxc/xo3yfiTLVhuDA8944/m48=;
  b=ebYENT614gnv1DIFWjMbjoVGai5ttz2/3/eqcoD5qmrQCCrYdNuACrz+
   pULt65OFm3g+ZkS8tCBNaRFZNJfe7dkRvsuODKnxD1sfaLk0b2N1qWIhU
   b2SCGmD1URAIbiIJQ+VS3Z1jLWdKyVTc/6RdQpkL23b0lJXZqMr69+5RE
   +P4Rqz6FYkbs7lWF5/tvSwm6+8GdnTOquXOTuoZIbpRtxxxM72AbFGjJP
   5ynKf6QxCKuwCFiXpBfoAdfHtHJWaRobQixgNCVe6Mhap/AWKt5Y2AChZ
   qGX6EZNyHG8/g5xTiSObYfkIjcaNYRw6DHpo+2++DdrHwJVKUPMBDmxJE
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="236719466"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236719466"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 20:46:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="516606116"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 20:46:29 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUh5p-000DGB-2e; Thu, 17 Mar 2022 03:46:29 +0000
Date:   Thu, 17 Mar 2022 11:46:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 1564/2335] ./usr/include/linux/netdevice.h:29:10:
 fatal error: uapi/linux/if.h: No such file or directory
Message-ID: <202203171122.ZrWJABIg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 928b32ae19a729802c77e9754fb7b9d4fe05bf0a [1564/2335] headers/deps: net: Optimize <uapi/linux/netdevice.h>
config: i386-randconfig-a006-20220314 (https://download.01.org/0day-ci/archive/20220317/202203171122.ZrWJABIg-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=928b32ae19a729802c77e9754fb7b9d4fe05bf0a
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip master
        git checkout 928b32ae19a729802c77e9754fb7b9d4fe05bf0a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/linux/if_arp.h:27,
                    from <command-line>:32:
>> ./usr/include/linux/netdevice.h:29:10: fatal error: uapi/linux/if.h: No such file or directory
      29 | #include <uapi/linux/if.h>
         |          ^~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
