Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5245768D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 23:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiGOVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiGOVZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 17:25:49 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 242FD79EE1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657920348; x=1689456348;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=i/NqHHUPChz71d1eUdhTF3fyGYMSAAXKmMdx88AVbwc=;
  b=nU5uObqvedY/rrbvm4yJRdn1/6Ai8JNd2BsOaaudeGJ0iu13b028WpFx
   yjAoscLA9YSTFsrK+hWqe/hAYhDABFmi2pfc963coFs6cZ9SNzdiy2KA6
   rPseX6Z85PjR5NCzhBmIvUAbZjG4RWKB+QOC2CoaX+z93Ph2QwmOdtgh7
   CN1GNtJEsEC6KNTYZgwBI4xRcmulSETOtuuBJDGXQv060U6g6zqtOdMva
   hljNhNdgn2qQ8oF8Acb9/BBpjOqlbmL3nkhaguD3907EVPR+73s7keP2v
   19MnYHKQf5Gkfg6ES7Y8280Cn/Sk6GISKzOJv6IstvhE7nT6jYgMPn2K3
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="268923849"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="268923849"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 14:25:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="546802535"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Jul 2022 14:25:45 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCSoj-0000m0-6D;
        Fri, 15 Jul 2022 21:25:45 +0000
Date:   Sat, 16 Jul 2022 05:25:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Beau Belgrave <beaub@linux.microsoft.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: kernel/trace/trace_events_user.c:811:13: sparse: sparse: cast
 removes address space '__user' of expression
Message-ID: <202207160536.yQsO3FQC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9b59ec8d50a1f28747ceff9a4f39af5deba9540e
commit: 7f5a08c79df35e68f1a43033450c5050f12bc155 user_events: Add minimal support for trace_event into ftrace
date:   5 months ago
config: sparc64-randconfig-s031-20220716 (https://download.01.org/0day-ci/archive/20220716/202207160536.yQsO3FQC-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7f5a08c79df35e68f1a43033450c5050f12bc155
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 7f5a08c79df35e68f1a43033450c5050f12bc155
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/usb/gadget/function/ drivers/virtio/ kernel/trace/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/trace/trace_events_user.c:747:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:747:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:747:16: sparse:    void *
>> kernel/trace/trace_events_user.c:811:13: sparse: sparse: cast removes address space '__user' of expression
>> kernel/trace/trace_events_user.c:811:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *buf @@     got char * @@
   kernel/trace/trace_events_user.c:811:13: sparse:     expected void [noderef] __user *buf
   kernel/trace/trace_events_user.c:811:13: sparse:     got char *
   kernel/trace/trace_events_user.c:827:16: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:827:16: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:827:16: sparse:    void *
   kernel/trace/trace_events_user.c:854:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/trace/trace_events_user.c:854:9: sparse:    void [noderef] __rcu *
   kernel/trace/trace_events_user.c:854:9: sparse:    void *

vim +/__user +811 kernel/trace/trace_events_user.c

   801	
   802	static ssize_t user_events_write(struct file *file, const char __user *ubuf,
   803					 size_t count, loff_t *ppos)
   804	{
   805		struct iovec iov;
   806		struct iov_iter i;
   807	
   808		if (unlikely(*ppos != 0))
   809			return -EFAULT;
   810	
 > 811		if (unlikely(import_single_range(READ, (char *)ubuf, count, &iov, &i)))
   812			return -EFAULT;
   813	
   814		return user_events_write_core(file, &i);
   815	}
   816	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
