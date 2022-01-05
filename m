Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E626F485352
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 14:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237006AbiAENPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 08:15:50 -0500
Received: from mga09.intel.com ([134.134.136.24]:10282 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237019AbiAENPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 08:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641388549; x=1672924549;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tf3VjKdx5lZUJulujJQfWa3C1zHWAeUFsoR64Ph5AAA=;
  b=iTwGRBZ9DT/B+OudgZlsFemg8I/Bt0sB54GuyCCE+AdofcBl7TWQaY1Y
   ygd0P+b4bCQVUFIorr3JpXuJres4h5pjGBA/P9/+/JXxgB9o01T9wS2vD
   yYNjtrVquEOwt9lSxW/UbIxWFTLOXlB4nIACkvjj97UVsP/lbNPc1H7zy
   X4hVXO+v9qpB8noMbZCbFRi4vSv0xjhumCkOpgHhKXXvcOtosF0l5K+bU
   094GTMV2w403MpK/DdEbNaEwvMkN99GPr7ZctlZ2QXtTE68DrYyY8F7ie
   /1fv6lGEU9V3Uf7gDRFYitx/5xgbA4CIKyAEAeBl5xvrrordxmG1zgmqI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242231889"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="242231889"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 05:15:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="488563397"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 05 Jan 2022 05:15:41 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n568i-000Geh-Tz; Wed, 05 Jan 2022 13:15:40 +0000
Date:   Wed, 5 Jan 2022 21:15:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, 0day robot <lkp@intel.com>
Subject: drivers/remoteproc/remoteproc_debugfs.c:395:10: warning:
 incompatible integer to pointer conversion returning 'long' from a function
 with result type 'struct dentry *'
Message-ID: <202201052108.jYZEx2yr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220105-144328/Miaoqian-Lin/remoteproc-Fix-NULL-vs-IS_ERR-checking-in-rproc_create_trace_file/20211227-170725
head:   e2c26738760efa9568ce3fef6180fb4311e28d08
commit: e2c26738760efa9568ce3fef6180fb4311e28d08 remoteproc: Fix NULL vs IS_ERR() checking in rproc_create_trace_file
date:   6 hours ago
config: i386-randconfig-a016-20220105 (https://download.01.org/0day-ci/archive/20220105/202201052108.jYZEx2yr-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e2c26738760efa9568ce3fef6180fb4311e28d08
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220105-144328/Miaoqian-Lin/remoteproc-Fix-NULL-vs-IS_ERR-checking-in-rproc_create_trace_file/20211227-170725
        git checkout e2c26738760efa9568ce3fef6180fb4311e28d08
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/remoteproc_debugfs.c:395:10: warning: incompatible integer to pointer conversion returning 'long' from a function with result type 'struct dentry *' [-Wint-conversion]
                   return PTR_ERR(tfile);
                          ^~~~~~~~~~~~~~
   1 warning generated.


vim +395 drivers/remoteproc/remoteproc_debugfs.c

   385	
   386	struct dentry *rproc_create_trace_file(const char *name, struct rproc *rproc,
   387					       struct rproc_debug_trace *trace)
   388	{
   389		struct dentry *tfile;
   390	
   391		tfile = debugfs_create_file(name, 0400, rproc->dbg_dir, trace,
   392					    &trace_rproc_ops);
   393		if (IS_ERR(tfile)) {
   394			dev_err(&rproc->dev, "failed to create debugfs trace entry\n");
 > 395			return PTR_ERR(tfile);
   396		}
   397	
   398		return tfile;
   399	}
   400	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
