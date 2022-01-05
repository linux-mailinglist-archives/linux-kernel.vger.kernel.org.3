Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBA23485010
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:32:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbiAEJce (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:32:34 -0500
Received: from mga06.intel.com ([134.134.136.31]:22607 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232161AbiAEJcd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:32:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641375153; x=1672911153;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dXkbW8pDy5r75UZSOjtNAX7d7huj8uoS+4RCrYoLXDg=;
  b=N19P+t4FYvGTS4AXyATBDGsbyNhZOwOYSD4GY98T/6WQMf62Viqjx/+6
   /5KL50gCsp4RsrILVMbowbtlSCh+oy4PM9AJlSi8TPiKI0rCrwqD2zPuM
   lzJ0kFzfj/T0H2I7iDnYJSgh/9oajKF3kWrmODx/okxbtfSXtNfZpbWrN
   yYyldzE3iO030azVEpISbNzI8v4pXg983/RM2yssE0vi0qGq49JT8IZla
   26ZpkhAfV0ZtXD+GsuV03r2NOTxGZJ8cR+OwQmYGJKfTtm3E8b0nY2etF
   2MhIm44AEnpbK9Gcdw5vLnHhYapplPQvrdOExONk7HISiob05LWhXazZ+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="303158620"
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="303158620"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 01:32:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,263,1635231600"; 
   d="scan'208";a="470490909"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jan 2022 01:32:31 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n52el-000GT1-7E; Wed, 05 Jan 2022 09:32:31 +0000
Date:   Wed, 5 Jan 2022 17:31:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: drivers/remoteproc/remoteproc_debugfs.c:395:24: warning: returning
 'long int' from a function with return type 'struct dentry *' makes pointer
 from integer without a cast
Message-ID: <202201051750.E7q77hPA-lkp@intel.com>
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
date:   3 hours ago
config: arm-buildonly-randconfig-r006-20220105 (https://download.01.org/0day-ci/archive/20220105/202201051750.E7q77hPA-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e2c26738760efa9568ce3fef6180fb4311e28d08
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220105-144328/Miaoqian-Lin/remoteproc-Fix-NULL-vs-IS_ERR-checking-in-rproc_create_trace_file/20211227-170725
        git checkout e2c26738760efa9568ce3fef6180fb4311e28d08
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/remoteproc/remoteproc_debugfs.c: In function 'rproc_create_trace_file':
>> drivers/remoteproc/remoteproc_debugfs.c:395:24: warning: returning 'long int' from a function with return type 'struct dentry *' makes pointer from integer without a cast [-Wint-conversion]
     395 |                 return PTR_ERR(tfile);
         |                        ^~~~~~~~~~~~~~


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
