Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B7758F377
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233118AbiHJUWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbiHJUWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 16:22:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5BD25C79
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660162927; x=1691698927;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mn31Ly6w4U+2LUKtUn3Ca6HRlas2AGr0uA6OzH8UfHE=;
  b=RKhpvLQNUk6MGgPxI5DmawWHiRGRFX0KHLap5i/iZvgxrmiZRoiRQIFK
   5rwrj0qEaOZ6ARuuh3/vkf14IWlYwuUY/r92ZV+h+RjjmGuzY8ynfxGeE
   rRf53dRzWT6P31pZuaW4TGFGr6nI/6Sx2+/x6Yo9D2YmSw6qguQB2SRjT
   BTSuEzFC3J53EhbRDz2Y4xNc994Gch7DmMlARXfQzYByybtIpRr3/hPKC
   btKxs4WZxUR8JpTwi5bTjUrRwOkJdBKEGZchiM7f9fbxTDyeSW0T87cSN
   Rt3NW4XX9J1dDunhfZKRnUKCjvtYVLaN/48xWJgyWuBA65JvXEK2Pelep
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10435"; a="377474261"
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="377474261"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2022 13:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,228,1654585200"; 
   d="scan'208";a="633920614"
Received: from lkp-server02.sh.intel.com (HELO 5d6b42aa80b8) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2022 13:22:05 -0700
Received: from kbuild by 5d6b42aa80b8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oLsDN-0000gR-0h;
        Wed, 10 Aug 2022 20:22:05 +0000
Date:   Thu, 11 Aug 2022 04:21:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alexei Starovoitov <ast@kernel.org>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:bpf/bpf/master 1/2] kernel/bpf/syscall.c:5089:5:
 warning: no previous prototype for 'kern_sys_bpf'
Message-ID: <202208110432.CI0a5IwF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block bpf/bpf/master
head:   86f44fcec22ce2979507742bc53db8400e454f46
commit: 86f44fcec22ce2979507742bc53db8400e454f46 [1/2] bpf: Disallow bpf programs call prog_run command.
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220811/202208110432.CI0a5IwF-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/86f44fcec22ce2979507742bc53db8400e454f46
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block bpf/bpf/master
        git checkout 86f44fcec22ce2979507742bc53db8400e454f46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash kernel/bpf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/bpf/syscall.c:5089:5: warning: no previous prototype for 'kern_sys_bpf' [-Wmissing-prototypes]
    5089 | int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
         |     ^~~~~~~~~~~~


vim +/kern_sys_bpf +5089 kernel/bpf/syscall.c

  5088	
> 5089	int kern_sys_bpf(int cmd, union bpf_attr *attr, unsigned int size)
  5090	{
  5091		struct bpf_prog * __maybe_unused prog;
  5092		struct bpf_tramp_run_ctx __maybe_unused run_ctx;
  5093	
  5094		switch (cmd) {
  5095	#ifdef CONFIG_BPF_JIT /* __bpf_prog_enter_sleepable used by trampoline and JIT */
  5096		case BPF_PROG_TEST_RUN:
  5097			if (attr->test.data_in || attr->test.data_out ||
  5098			    attr->test.ctx_out || attr->test.duration ||
  5099			    attr->test.repeat || attr->test.flags)
  5100				return -EINVAL;
  5101	
  5102			prog = bpf_prog_get_type(attr->test.prog_fd, BPF_PROG_TYPE_SYSCALL);
  5103			if (IS_ERR(prog))
  5104				return PTR_ERR(prog);
  5105	
  5106			if (attr->test.ctx_size_in < prog->aux->max_ctx_offset ||
  5107			    attr->test.ctx_size_in > U16_MAX) {
  5108				bpf_prog_put(prog);
  5109				return -EINVAL;
  5110			}
  5111	
  5112			run_ctx.bpf_cookie = 0;
  5113			run_ctx.saved_run_ctx = NULL;
  5114			if (!__bpf_prog_enter_sleepable(prog, &run_ctx)) {
  5115				/* recursion detected */
  5116				bpf_prog_put(prog);
  5117				return -EBUSY;
  5118			}
  5119			attr->test.retval = bpf_prog_run(prog, (void *) (long) attr->test.ctx_in);
  5120			__bpf_prog_exit_sleepable(prog, 0 /* bpf_prog_run does runtime stats */, &run_ctx);
  5121			bpf_prog_put(prog);
  5122			return 0;
  5123	#endif
  5124		default:
  5125			return ____bpf_sys_bpf(cmd, attr, size);
  5126		}
  5127	}
  5128	EXPORT_SYMBOL(kern_sys_bpf);
  5129	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
