Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF825001FD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 00:43:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238088AbiDMWp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 18:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234784AbiDMWp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 18:45:27 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B5457495
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 15:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649889785; x=1681425785;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OCogSq1Gggs1oQn4VK6cnJ5320FEvJO0kTYpTnXi0Qc=;
  b=Y5Q6pIjakdBNBs0eEZn5hKHBLoWiflbHV8nxceyXIG1hnRqPl0b3dKcR
   zKxWk8w60MkB/rXf00CCGBbzEfItW9v0xsjNiwplUix9U1gtArSvyXL1X
   1HuI0mr7yIOBgFuzVa52dx9qP/0xDs7DgZXdxcCwyrqagyfnOTivFpW7c
   TaWXnRtpDUgXTrXGBi+rqS2wTGYbQndTTxtw1xJp37V3LpXngYz4lXs6j
   zecd6YYkRxaECSs4kAgYcfwqZfk+pNe93rFcFdEgA6v2Otv9UP5hKYQmx
   dFaEG97yftoGIRyuHzDyU/8628kXuXCMRhf5NH8XKW/DHG3mV+N6ADvBR
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="261639413"
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="261639413"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 15:43:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,258,1643702400"; 
   d="scan'208";a="661112626"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Apr 2022 15:43:03 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nelhW-0000gK-LN;
        Wed, 13 Apr 2022 22:43:02 +0000
Date:   Thu, 14 Apr 2022 06:42:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yan Zhu <zhuyan34@huawei.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: [ammarfaizi2-block:bpf/bpf-next/pr/bpf-sysctl 1/1]
 kernel/bpf/syscall.c:4944:13: warning: no previous prototype for
 'unpriv_ebpf_notify'
Message-ID: <202204140614.Tt9e1fIt-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block bpf/bpf-next/pr/bpf-sysctl
head:   2900005ea287b11dcc8c1b9fcf24893b7ff41d6d
commit: 2900005ea287b11dcc8c1b9fcf24893b7ff41d6d [1/1] bpf: Move BPF sysctls from kernel/sysctl.c to BPF core
config: sh-buildonly-randconfig-r001-20220413 (https://download.01.org/0day-ci/archive/20220414/202204140614.Tt9e1fIt-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2900005ea287b11dcc8c1b9fcf24893b7ff41d6d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bpf/bpf-next/pr/bpf-sysctl
        git checkout 2900005ea287b11dcc8c1b9fcf24893b7ff41d6d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   sh4-linux-ld: arch/sh/lib/mcount.o: in function `stack_panic':
>> (.text+0x50): undefined reference to `dump_stack'
--
>> kernel/bpf/syscall.c:4944:13: warning: no previous prototype for 'unpriv_ebpf_notify' [-Wmissing-prototypes]
    4944 | void __weak unpriv_ebpf_notify(int new_state)
         |             ^~~~~~~~~~~~~~~~~~


vim +/unpriv_ebpf_notify +4944 kernel/bpf/syscall.c

  4943	
> 4944	void __weak unpriv_ebpf_notify(int new_state)
  4945	{
  4946	}
  4947	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
