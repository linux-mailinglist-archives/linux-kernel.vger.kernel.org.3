Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5177C4851DC
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 12:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239720AbiAELdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 06:33:40 -0500
Received: from mga09.intel.com ([134.134.136.24]:22771 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233838AbiAELdj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 06:33:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641382419; x=1672918419;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xiBMRhVAQ4Ell4PWcWtU9difwueOsYT63odFwpowbJw=;
  b=BgEE/RYkEHt/YPCGhJ9jCNfx7f2gOOCfs2bNOoKuEmG05H4TRskH/W6n
   W6T6i3cYEuXh+ImfCkWx44o9CbD8vtz7biXNw2fUdwz+AOTGIsUnFeO08
   6KdvYKINLJpyrQtHwPEag+XCgHTKGmHR+Dfc/+4ORbnpA1HxU4JC6cFl+
   dH0BdtKgv45omd/NTxaHle88NTEgC6YXBnS81Y455Ho1N3CsOXDpJ3/kX
   gzlDL8PIAy7kv3MT70vgoObYhY2KswArNEmCRgqPOjeqbxa7LX1vi2+kp
   U5NepjL9nkt2sPVdNB49if+3ApIGx+9FUPU3z3u05NncKDwPeps4R+m2W
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242219493"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="242219493"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 03:33:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="470534341"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2022 03:33:37 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n54Xx-000GYI-5i; Wed, 05 Jan 2022 11:33:37 +0000
Date:   Wed, 5 Jan 2022 19:33:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/remoteproc/remoteproc_debugfs.c:395:31: sparse: sparse:
 incorrect type in return expression (different base types)
Message-ID: <202201051942.CihtR2Ia-lkp@intel.com>
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
date:   5 hours ago
config: powerpc-randconfig-s031-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051942.CihtR2Ia-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/e2c26738760efa9568ce3fef6180fb4311e28d08
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220105-144328/Miaoqian-Lin/remoteproc-Fix-NULL-vs-IS_ERR-checking-in-rproc_create_trace_file/20211227-170725
        git checkout e2c26738760efa9568ce3fef6180fb4311e28d08
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=powerpc SHELL=/bin/bash drivers/input/touchscreen/ drivers/remoteproc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/remoteproc/remoteproc_debugfs.c:395:31: sparse: sparse: incorrect type in return expression (different base types) @@     expected struct dentry * @@     got long @@
   drivers/remoteproc/remoteproc_debugfs.c:395:31: sparse:     expected struct dentry *
   drivers/remoteproc/remoteproc_debugfs.c:395:31: sparse:     got long

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
