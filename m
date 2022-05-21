Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57B352F6DB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 02:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354348AbiEUAgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 20:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354244AbiEUAgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 20:36:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15E58BD25
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 17:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653093381; x=1684629381;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DrGZASB678Ii7Ej/Ng9qBe5LTl0Mi+D7mv7VkFILyvI=;
  b=ic93pLQM7PmObEue2PQNGvAaQVCcjK/w49zQFUHtP9EM4uKZ9XqGo1Qi
   SnYlIAzGo+EExs9FdgdZH3NjqRaAzMUVGK5dkrtMySAW3002qxNThRjTR
   xAk6assLzwQz9D0l9QgnAudIhzZ3IpWtfcpKveBilollzaYtQIzXQ1o1C
   i85FlUHMGUrvk4f1SNkJt30D1DvBc5SLBfk2ji7WkSguVWeYdws4PJy3I
   VSx30sAOJY0Nmr5/DgZhK82IAJ4yaLdIgkxnbPRutlLAxxJ/2exlvCliq
   +D6nokqSfTrMWPIbR3FrIS4b6W9RsRpXMzDcDpxxitOZY9IzR73H2kmJC
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="298094085"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="298094085"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 17:36:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="899583390"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 20 May 2022 17:36:20 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsD6S-0005fg-5L;
        Sat, 21 May 2022 00:36:20 +0000
Date:   Sat, 21 May 2022 08:36:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [congwang:sch_bpf 1/2] skb_map.c:undefined reference to
 `kfree_skb_reason'
Message-ID: <202205210854.2gB8rO6D-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/congwang/linux.git sch_bpf
head:   b03bbda26c041cf6e7593eadce50ef2fa4853a0c
commit: eed3a0d4dabd4f8015c5d37232438c3176470a58 [1/2] bpf: introduce skb map
config: openrisc-randconfig-r035-20220519 (https://download.01.org/0day-ci/archive/20220521/202205210854.2gB8rO6D-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/congwang/linux/commit/eed3a0d4dabd4f8015c5d37232438c3176470a58
        git remote add congwang https://github.com/congwang/linux.git
        git fetch --no-tags congwang sch_bpf
        git checkout eed3a0d4dabd4f8015c5d37232438c3176470a58
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   or1k-linux-ld: kernel/bpf/skb_map.o: in function `skb_map_delete_elem':
>> skb_map.c:(.text+0x52c): undefined reference to `kfree_skb_reason'
   skb_map.c:(.text+0x52c): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `kfree_skb_reason'
   or1k-linux-ld: kernel/bpf/skb_map.o: in function `skb_map_notification':
   skb_map.c:(.text+0x634): undefined reference to `kfree_skb_reason'
   skb_map.c:(.text+0x634): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `kfree_skb_reason'
   or1k-linux-ld: kernel/bpf/skb_map.o: in function `skb_map_free':
>> skb_map.c:(.text+0x704): undefined reference to `skb_rbtree_purge'
   skb_map.c:(.text+0x704): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `skb_rbtree_purge'
   or1k-linux-ld: kernel/bpf/skb_map.o: in function `bpf_skb_map_pop':
   skb_map.c:(.text+0xa90): undefined reference to `kfree_skb_reason'
   skb_map.c:(.text+0xa90): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `kfree_skb_reason'
   or1k-linux-ld: kernel/bpf/skb_map.o: in function `skb_map_init':
>> skb_map.c:(.init.text+0x18): undefined reference to `register_netdevice_notifier'
   skb_map.c:(.init.text+0x18): relocation truncated to fit: R_OR1K_INSN_REL_26 against undefined symbol `register_netdevice_notifier'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
