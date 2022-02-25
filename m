Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43E3A4C3A51
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 01:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiBYA1T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 19:27:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236057AbiBYA1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 19:27:17 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B1363BD4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645748806; x=1677284806;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2+fDZyyIUmE9PVSmEaK6H8QZcOb4pTExTFlK0Pcv5hc=;
  b=ITXkCj/nTGVWMYq4dolh2e00LHLr2pDMEg3hWg/zmtCGgeSwgGo+g+dQ
   fuYe05ircwGeQkofzk2xy4Qe2+wV40EbMue9OR8UgeAZ+2SMgNPagsAV/
   R4EehhjUynkGjqrZQVX5YoQwkb3sHzHxPAZ2pXI10YVZoOzZTMzMxLyEv
   QImlh5wk/Q1vkkh250U7T268sUB2i1YTAZXLb3JnnMVmm9CNifKEz77Wz
   JHtPrV2AXZoLz4ebjAn/O4R9VPPk8C7vhOGI5c8xr9fKYScoXy+e11LVu
   vn6+eiYvkJ2uNDvKT43GNuA9CJvE8MJQZeNFdM7H0X9MXd71J/w9/uce5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="315602577"
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="315602577"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 16:26:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,134,1643702400"; 
   d="scan'208";a="707671548"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2022 16:26:38 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nNORR-0003bw-Ci; Fri, 25 Feb 2022 00:26:37 +0000
Date:   Fri, 25 Feb 2022 08:26:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [netfilter-nf:master 47/47] undefined reference to `sock_gen_put'
Message-ID: <202202250819.DzmYOyKL-lkp@intel.com>
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

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git master
head:   661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd
commit: 661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd [47/47] netfilter: nf_queue: don't assume sk is full socket
config: nios2-randconfig-r021-20220224 (https://download.01.org/0day-ci/archive/20220225/202202250819.DzmYOyKL-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git/commit/?id=661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd
        git remote add netfilter-nf git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf.git
        git fetch --no-tags netfilter-nf master
        git checkout 661c8ec0381915e9a2b0f9dcc03a5bd70ba5e3dd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: net/netfilter/nf_queue.o: in function `nf_queue_entry_free':
>> (.text+0x1d0): undefined reference to `sock_gen_put'
   (.text+0x1d0): relocation truncated to fit: R_NIOS2_CALL26 against `sock_gen_put'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
