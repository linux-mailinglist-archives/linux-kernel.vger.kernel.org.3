Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB553DD70
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 19:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346637AbiFERw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 13:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231337AbiFERwz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 13:52:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9865C2B191
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654451574; x=1685987574;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f1IAhTNnrLjpk+JVKGh1EwYLh/qYtaez5uh18Mm+jYQ=;
  b=U6eQ+TpnieB65imp/MtqYG5cQ19HVilmPV0ZflKxWiTSv8lFavUNkFXo
   C9wwpWQxYyVBvoMQr89OkAfZJCSvnqvW8LYMLVKhIuxiVhdBuRALyVh9/
   PvKNVB99LPQOXgbwVOiYl58fsVqLMUwKIeBh+lFn5uFIzBm8aPO4+7899
   6RFKq5CwVC229T1vIPV0TweKmgjO5WHkjFbZiS7svq/5TZKsr9YBYWjUS
   tdJDFF7F2uS9s0Pg31cljVVaqgyYgdvX25yEovA7Dh0DHGRxNnFlNHFAr
   5dByS11MKJAgrM2ECXmYG0HmkV2MdhUXOOwiRmhMpTJwLmiPix0xj83O9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10369"; a="337290486"
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="337290486"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2022 10:52:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,279,1647327600"; 
   d="scan'208";a="635228247"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 05 Jun 2022 10:52:52 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nxuQm-000C7f-1b;
        Sun, 05 Jun 2022 17:52:52 +0000
Date:   Mon, 6 Jun 2022 01:52:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: ERROR: modpost: "__ld_r13_to_r20_ret" [lib/zstd/zstd_decompress.ko]
 undefined!
Message-ID: <202206060104.EfejFWJu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   952923ddc01120190dcf671e7b354364ce1d1362
commit: a2a9d67a26ec94a99ed29efbd61cf5be0a575678 bootconfig: Support embedding a bootconfig file in kernel
date:   6 weeks ago
config: arc-randconfig-r001-20220605 (https://download.01.org/0day-ci/archive/20220606/202206060104.EfejFWJu-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a2a9d67a26ec94a99ed29efbd61cf5be0a575678
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a2a9d67a26ec94a99ed29efbd61cf5be0a575678
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "__st_r13_to_r20" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__st_r13_to_r18" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r20_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r18_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r24_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r23" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__ld_r13_to_r17_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r24" [lib/zstd/zstd_decompress.ko] undefined!
ERROR: modpost: "__ld_r13_to_r22_ret" [lib/zstd/zstd_decompress.ko] undefined!
>> ERROR: modpost: "__st_r13_to_r17" [lib/zstd/zstd_decompress.ko] undefined!
WARNING: modpost: suppressed 2 unresolved symbol warnings because there were too many)

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
