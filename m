Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7749A4EC4EB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345165AbiC3MvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 08:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344806AbiC3MvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 08:51:12 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A747015E8BF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 05:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648644566; x=1680180566;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GKh3TB5IeP3GVL0TdmWg6yllvBDir0N5PLH7xzCm6AQ=;
  b=OTvd2e+lYKTrgc+tuC3+iOUH4Dy8Zoqy5CB3iY2uaPDeZx8FUyu46RpM
   El4/0hCi9WuEybFNgvG1bcRKGxIr2xst8HzhNdEgtqR92damWcY0Wl4Ry
   4IcRANkIFfsXu4wmhhmJho51nmnxvglQnnWtXOsJMBh66e+Hxq+TxG5qZ
   G5MheMC8pgxWL61al6CoHEgJACSRm+fdhj9RUvS1Gv8B1WJPSu1xAvNvn
   7I0edGgch0WN6DXkycZWy7r4Sq8tbrM4cdPPJfa7rpjHh9x3LliaWJNIk
   FyNylz115iRCex5Xz4WfySFL5EoYWvv6snLxIlwjXtWm9IzyIK9H78ap2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10301"; a="258364183"
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="258364183"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 05:49:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,222,1643702400"; 
   d="scan'208";a="565522397"
Received: from lkp-server02.sh.intel.com (HELO 1905232cd9fb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Mar 2022 05:49:24 -0700
Received: from kbuild by 1905232cd9fb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZXlL-00002K-PS;
        Wed, 30 Mar 2022 12:49:23 +0000
Date:   Wed, 30 Mar 2022 20:49:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tri Vo <trong@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5870/5872] aarch64-linux-ld: trusty-ipc.c:undefined reference to
 `trusty_dma_buf_get_shared_mem_id'
Message-ID: <202203302026.RQKx7sLs-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tri,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
commit: 629a4d3318cc1234675f62b69fba8791592e8a83 [5870/5872] ANDROID: trusty: Support setting trusty_shared_mem_id_t
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220330/202203302026.RQKx7sLs-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/629a4d3318cc1234675f62b69fba8791592e8a83
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout 629a4d3318cc1234675f62b69fba8791592e8a83
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: drivers/trusty/trusty-ipc.o: in function `dn_share_fd':
   trusty-ipc.c:(.text+0x337c): undefined reference to `trusty_dma_buf_get_ffa_tag'
>> aarch64-linux-ld: trusty-ipc.c:(.text+0x3398): undefined reference to `trusty_dma_buf_get_shared_mem_id'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
