Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188CC4FDC42
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbiDLKQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356830AbiDLJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:55:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889186AA71
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649753932; x=1681289932;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=eNqPQ7J8Lt/MtFPDXnU5j6IVerjOGYZ3N5lnl4xJilM=;
  b=U0Taij5N7ViWH1NsWmNcZETenGKiUje2S+ikGYbZqFAK7zd8L8BS+R9n
   gGnmrX8sHY3QMC8tLkUOg2WH+Tapmigo15adPCviJgAP9BcTDC+38IbJo
   PInUNXFfw/BUAsd6V+uGnDKsrezoOeXACdboThwDRxlTYR16E73jnLGgd
   wGia+aSGopjB1lJ3iqPhJDfTrbImLmjcaYKuah91rRcBlPBnPXVEHpEv7
   p5SihUrK9oqJ5uvTCPIy/xb3Z7LSGDwz+9H7c0183AoedWwMlt6xcRC7u
   INGPVsgWSU+++b9dAVBNVpwaTw8P/pctiKYGqsXQAOLNoH03scUBbckHQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="348759222"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="348759222"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 01:58:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="507463453"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Apr 2022 01:58:46 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neCMI-0002gi-87;
        Tue, 12 Apr 2022 08:58:46 +0000
Date:   Tue, 12 Apr 2022 16:58:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [toke:xdp-queueing-04 3/12] nios2-linux-ld:
 kernel/bpf/syscall.o:undefined reference to `pifo_generic_map_ops'
Message-ID: <202204121642.Tq0D1BzD-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git xdp-queueing-04
head:   3ef13cb90d84cacaecd65fb853dc30cade943524
commit: 4198433a927809216d5fc4793eaa31d2883d1090 [3/12] bpf: Add a PIFO priority queue map type
config: nios2-randconfig-r032-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121642.Tq0D1BzD-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git/commit/?id=4198433a927809216d5fc4793eaa31d2883d1090
        git remote add toke https://git.kernel.org/pub/scm/linux/kernel/git/toke/linux.git
        git fetch --no-tags toke xdp-queueing-04
        git checkout 4198433a927809216d5fc4793eaa31d2883d1090
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> nios2-linux-ld: kernel/bpf/syscall.o:(.rodata+0x574): undefined reference to `pifo_generic_map_ops'
>> nios2-linux-ld: kernel/bpf/btf.o:(.rodata+0x1c0): undefined reference to `pifo_generic_map_ops'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
