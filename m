Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA4745063CB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 07:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348513AbiDSFRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 01:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348495AbiDSFRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 01:17:12 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30C7A220E4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 22:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650345271; x=1681881271;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=otNpyoS3BKNtN/Ot5HsPdSUury4brsstrCuslwlgNL0=;
  b=mk9wvDZi6AOzJZFEqVKY3p3llkEJL+gFdukm/M+E+NXdtRu4HbE49OT/
   laMVLS0XaymUpCt2ecnfMebldOv+E4TVz3YdDZFnI1H3Pot0xBpVgMrOi
   gSvqYPQ6cSOzId+QyLbtABdUPtD2L27ol/U71vSyFMPW6cjT/SIR/cvQh
   qglZIKODS6l3xB5iOL71QLLENYrx5uegSIDIAMzm6lTMa2DILqzsj5EB9
   opF53RBgC+BP4h4rRRBDOC+tJ/0JK46/yMFEmIIJCz7gHP/hfYyFSKwum
   Bqx10ps+Xcs8U5qxh77GZzw5dNIsQkrVbk81dRPOkRT1Thw4TlmSe8+ZS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="261280326"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="261280326"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 22:14:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="860619358"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 18 Apr 2022 22:14:27 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nggC2-0005Nq-I6;
        Tue, 19 Apr 2022 05:14:26 +0000
Date:   Tue, 19 Apr 2022 13:14:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 412/2356] kernel/bpf/core.c:63:6: warning:
 no previous prototype for 'bpf_jit_dump'
Message-ID: <202204191314.hODCBp24-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   af93551cf39027d176f30b9beafc60a4c130998a
commit: 4957b437f054fb9fde9c6bc4a7dae4459ee37f13 [412/2356] headers/uninline: Uninline multi-use function: bpf_jit_dump()
config: x86_64-randconfig-a002-20220418 (https://download.01.org/0day-ci/archive/20220419/202204191314.hODCBp24-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=4957b437f054fb9fde9c6bc4a7dae4459ee37f13
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 4957b437f054fb9fde9c6bc4a7dae4459ee37f13
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/kernel/ arch/x86/pci/ crypto/ drivers/bus/mhi/host/ drivers/regulator/ fs/crypto/ kernel/bpf/ lib/crypto/ net/bpf/ sound/soc/codecs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/core.c:63:6: warning: no previous prototype for 'bpf_jit_dump' [-Wmissing-prototypes]
      63 | void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
         |      ^~~~~~~~~~~~
   kernel/bpf/core.c:1655:12: warning: no previous prototype for 'bpf_probe_read_kernel' [-Wmissing-prototypes]
    1655 | u64 __weak bpf_probe_read_kernel(void *dst, u32 size, const void *unsafe_ptr)
         |            ^~~~~~~~~~~~~~~~~~~~~


vim +/bpf_jit_dump +63 kernel/bpf/core.c

    62	
  > 63	void bpf_jit_dump(unsigned int flen, unsigned int proglen, u32 pass, void *image)
    64	{
    65		pr_err("flen=%u proglen=%u pass=%u image=%pK from=%s pid=%d\n", flen,
    66		       proglen, pass, image, current->comm, task_pid_nr(current));
    67	
    68		if (image)
    69			print_hex_dump(KERN_ERR, "JIT code: ", DUMP_PREFIX_OFFSET,
    70				       16, 1, image, proglen, false);
    71	}
    72	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
