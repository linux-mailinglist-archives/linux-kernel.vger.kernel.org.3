Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21252504C2C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 07:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236604AbiDRFOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 01:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233191AbiDRFOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 01:14:51 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4B5DEF6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 22:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650258733; x=1681794733;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Vtx0F6suCFWzeLbh3UqNdgDYvIA+/ozhpHGBkWKrtRk=;
  b=XkG4oeyT0/WPSRMT9SknJDPMY8YDQnxZ/kUS/zR+lFmXDy93GlxR5xIN
   X+t1zeAkCZP5V9HKkdS2Qp2jNmJbI4ZS6SfCmk3v7XsmsrX5ldvwiEPB7
   9d5tF4X1ewY9CiLIcMx/7vUktdhSbCPnFVUjjKeejh3t33cSZkgSBiQBh
   7snhO2bXJqYAV3fnjixsZ49Dx6diVwxHJAl8SqNS6VfSiqR/nQ9SXJRw2
   ksmzGEluKO8Tfv6M+ezqAczshaVANvHU43MmcPdWZ0ROAdU7Z8HgPiZkJ
   ujsHJqimdsyw846G/iYv2S1zKviVVKkgyq50rxvupLaE1Hrlp8l1nbFoA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="244035423"
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="244035423"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2022 22:12:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,267,1643702400"; 
   d="scan'208";a="529322571"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 17 Apr 2022 22:12:11 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngJgI-0004MD-Q6;
        Mon, 18 Apr 2022 05:12:10 +0000
Date:   Mon, 18 Apr 2022 13:11:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexander Fomichev <fomichev.ru@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-ntb@googlegroups.com,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>
Subject: [jonmason-ntb:ntb-next 2/2] ERROR: modpost: "__umoddi3"
 [drivers/ntb/test/ntb_perf.ko] undefined!
Message-ID: <202204181304.sU13hlUf-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

First bad commit (maybe != root cause):

tree:   https://github.com/jonmason/ntb ntb-next
head:   10003e852471b1214f4383d79592497b3f4c7b39
commit: 10003e852471b1214f4383d79592497b3f4c7b39 [2/2] ntb_perf: extend with burst/poll/doorbell latency measurement
config: arc-randconfig-r043-20220418 (https://download.01.org/0day-ci/archive/20220418/202204181304.sU13hlUf-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jonmason/ntb/commit/10003e852471b1214f4383d79592497b3f4c7b39
        git remote add jonmason-ntb https://github.com/jonmason/ntb
        git fetch --no-tags jonmason-ntb ntb-next
        git checkout 10003e852471b1214f4383d79592497b3f4c7b39
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "__umoddi3" [drivers/ntb/test/ntb_perf.ko] undefined!
ERROR: modpost: "__st_r13_to_r20" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r18" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r20_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r25_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r18_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r24_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r23" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r17_ret" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r24" [lib/zstd/zstd_decompress.ko] undefined!
WARNING: modpost: suppressed 5 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
