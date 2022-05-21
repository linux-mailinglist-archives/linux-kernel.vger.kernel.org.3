Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ECF52F7F2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 05:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354432AbiEUDTd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 23:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232435AbiEUDT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 23:19:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FAA185421
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 20:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653103168; x=1684639168;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9c9L42cRhsFy+sI4JgX4qlagCOalIdDvsTA7PM413oc=;
  b=FNFyKtDD67uKV1fvPNhPwBz3MiiwcsFbqz+68hg7M13da2IGtg7MIf47
   INhrzot86KLilI2ANB1LOVAmq/VUtNkord1bR8A9MyW0urGykISDpAxNg
   EaFdwLcQVbJM2SD935yp183sWYKlrJPpA0+Ivm2/88bCCsl+dcGHz76rF
   KMd6G2Y3YW51WINHkfvpUbX+FkmwJKQEf7ezf8k6yM2w64to/y5fa+aQY
   iclmnwSY02xadpzBVSKBF4XOlqd4xQ8Xu+I45OOwbtutIwoAqibeWkt9p
   BdlgxJZyMZeOKHzBac1t0T1FlkAOrTjU+I5rH2aqUnacCx1t3ujRlEuMi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="253313055"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="253313055"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 20:19:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="674907929"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 20 May 2022 20:19:27 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsFeJ-0005rU-3O;
        Sat, 21 May 2022 03:19:27 +0000
Date:   Sat, 21 May 2022 11:18:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 1/2] skb_map.c:undefined reference to
 `kfree_skb_reason'
Message-ID: <202205211111.evh04B2H-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   b03bbda26c041cf6e7593eadce50ef2fa4853a0c
commit: eed3a0d4dabd4f8015c5d37232438c3176470a58 [1/2] bpf: introduce skb map
config: arc-randconfig-r043-20220519 (https://download.01.org/0day-ci/archive/20220521/202205211111.evh04B2H-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/eed3a0d4dabd4f8015c5d37232438c3176470a58
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout eed3a0d4dabd4f8015c5d37232438c3176470a58
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arceb-elf-ld: kernel/bpf/skb_map.o: in function `kfree_skb':
>> skb_map.c:(.text+0x11a): undefined reference to `kfree_skb_reason'
>> arceb-elf-ld: skb_map.c:(.text+0x11a): undefined reference to `kfree_skb_reason'
   arceb-elf-ld: kernel/bpf/skb_map.o: in function `skb_map_free':
>> skb_map.c:(.text+0x2e8): undefined reference to `skb_rbtree_purge'
>> arceb-elf-ld: skb_map.c:(.text+0x2e8): undefined reference to `skb_rbtree_purge'
   arceb-elf-ld: kernel/bpf/skb_map.o: in function `skb_map_init':
>> skb_map.c:(.init.text+0x6): undefined reference to `register_netdevice_notifier'
>> arceb-elf-ld: skb_map.c:(.init.text+0x6): undefined reference to `register_netdevice_notifier'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
