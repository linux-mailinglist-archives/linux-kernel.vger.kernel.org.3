Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76F14DAF10
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 12:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355172AbiCPLpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 07:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234182AbiCPLpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 07:45:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22407631A
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 04:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647431046; x=1678967046;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TjHSq7qvFumBqiO3rkcvDarW0hT9OOL4EOBhnFPeSLY=;
  b=kQ1XKFnPLpK/aUMdvPgoLEvbjXvWcXIUf9gcYdo3qz13bJ1A9uqLU7XL
   EmBc5b7OyxEyb/JCesVXLQCESlDjppadJbnGzwOEnKKzXbtknrvQXv+LE
   Xso47v9pp8P/b/FqIExGOyDCjDky6C9zO2ksYFHcVoYjqvK+tj3Nip0bz
   iWvrPqhnhm53+Xb9W4B+AhAvcnS08vh6Hgx+kkYQLiEj1A4JkJzsZXuah
   sPe1rOZq/k3x1rl6csHhRi7R5UcnQaUEK6p4jDy02+xSeLSYssxC6xEUt
   f3eW0BR+l7HrbtmEE7LRRyCZAzaO3TOGnIR7tr+w0wD3HXg9ur6sVPlsI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="238723735"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="238723735"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 04:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="714562619"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2022 04:44:04 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUS4R-000CLS-VZ; Wed, 16 Mar 2022 11:44:03 +0000
Date:   Wed, 16 Mar 2022 19:43:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/kprobe_multi 6/13] kernel/trace/bpf_trace.c:1058:57:
 error: no member named 'ip' in 'struct pt_regs'
Message-ID: <202203161933.KSScXEmp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/kprobe_multi
head:   9ef3ebdfd199decf414614d0de32df0484090275
commit: acf299442762d7b680bfb3b6ca545d9c12bc640f [6/13] bpf: Add cookie support to programs attached with kprobe multi link
config: arm64-randconfig-r031-20220313 (https://download.01.org/0day-ci/archive/20220316/202203161933.KSScXEmp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=acf299442762d7b680bfb3b6ca545d9c12bc640f
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/kprobe_multi
        git checkout acf299442762d7b680bfb3b6ca545d9c12bc640f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/trace/bpf_trace.c:1058:57: error: no member named 'ip' in 'struct pt_regs'
           return bpf_kprobe_multi_cookie(current->bpf_ctx, regs->ip);
                                                            ~~~~  ^
   1 error generated.


vim +1058 kernel/trace/bpf_trace.c

  1055	
  1056	BPF_CALL_1(bpf_get_attach_cookie_kprobe_multi, struct pt_regs *, regs)
  1057	{
> 1058		return bpf_kprobe_multi_cookie(current->bpf_ctx, regs->ip);
  1059	}
  1060	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
