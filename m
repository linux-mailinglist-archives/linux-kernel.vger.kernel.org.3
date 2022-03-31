Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1067A4ED2AC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230294AbiCaE2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiCaE1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:27:39 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72A4164D0A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 21:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648700399; x=1680236399;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=VqZ0Y0rgQ6VRFYb0w71r6LMrB9Iyp+z62mYQtGEy4F8=;
  b=iIuR+TxGAT2MF8VQOmm2c3ewnS4Gw686/s7Gck31lymqZN1o3Ilxi1Iu
   roC0Wt09mQIKID5gHv958244ah+SqSgBpRTQfGRWFJVr29/a5FL5pczvo
   c0J1tAQlI0gk1n0nPmrnNFdhLhTGD4FXIkMlxQNFN3kExUV3E47VW42va
   lEnkDpD4gkg5bBGdSl5rlpbs3uc4QF1rJQ1AmsVn0cB6B9TsFLl6gexx3
   DelPVj+LoEs7y4Ugg+6HR9yR5ly+AQnqyi6Cs2wYQjJMWs9EGc/An6hAf
   9P07gAecHRhaMiO74AX4ZkouMVHJIgIbnIJZimqfwYflM+Xzbbzc/9rug
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259690896"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="259690896"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 21:19:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="547135512"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 30 Mar 2022 21:19:58 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZmHt-0000sG-KQ;
        Thu, 31 Mar 2022 04:19:57 +0000
Date:   Thu, 31 Mar 2022 12:19:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     kbuild-all@lists.01.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: [djwong-xfs:djwong-wtf 378/379] hppa-linux-ld:
 fs/xfs/xfs_trace.o(.text+0x3fee8): cannot reach
 00005b1d___trace_trigger_soft_disabled+0, recompile with -ffunction-sections
Message-ID: <202203311211.g7lf3Tlf-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git djwong-wtf
head:   cce0b7ef56c157aa9dcaf9a217dc49770c1543bb
commit: 666d0463a875e18984d6dc5841c6f7b4214d32d3 [378/379] xfs: fallocate free space into a file
config: parisc-allyesconfig (https://download.01.org/0day-ci/archive/20220331/202203311211.g7lf3Tlf-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/commit/?id=666d0463a875e18984d6dc5841c6f7b4214d32d3
        git remote add djwong-xfs https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git
        git fetch --no-tags djwong-xfs djwong-wtf
        git checkout 666d0463a875e18984d6dc5841c6f7b4214d32d3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x3fee8): cannot reach 00005b1d___trace_trigger_soft_disabled+0, recompile with -ffunction-sections
   hppa-linux-ld: fs/xfs/xfs_trace.o(.text+0x3fee8): cannot handle R_PARISC_PCREL17F for __trace_trigger_soft_disabled
   hppa-linux-ld: final link failed: bad value

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
