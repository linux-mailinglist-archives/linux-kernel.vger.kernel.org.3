Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F094B3EA8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 01:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiBNAgc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 19:36:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238897AbiBNAgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 19:36:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D70751E7E
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 16:36:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644798983; x=1676334983;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uApdK/ykm7XqkAGabFWac1Vb+KwIVDyTf+4WkOioGvM=;
  b=MWFrwMhPJEyEmbHTYzuhOJJT/l4rr7S3sBPdYxdgtBONEXqqHL82XtHQ
   OaCePuCD+ZqorDDz1tygwFFAolv/8lb1nqiBwRtqS4/bovpGCHLvwD4Tf
   51qbwtSbN/7ia/tcuwh57CiSgmizFSBYvAS1uJqMZFurPvzg6c3xJ39t9
   HjiTD6QLCGnEhCqkdW3LxjuQXYstdsUFpqZ2FkUlGdOUvvp6OVHh0E7JV
   4JB4TJo7APXr6JlDedHOa1d70Cn4SVKCVvrk2V92pRaOHjIu7WttsuWfy
   iZtiNNYDcd7vYDUWmbh1CG3zRRcTsZCz1WZ7PWCjGqJffl0ehQnEVHO0Z
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249932180"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="249932180"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 16:36:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="501457581"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 13 Feb 2022 16:36:21 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJPLp-00082U-6n; Mon, 14 Feb 2022 00:36:21 +0000
Date:   Mon, 14 Feb 2022 08:35:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [jolsa-perf:bpf/fprobe_link_5 3/10] undefined reference to
 `bpf_fprobe_link_attach'
Message-ID: <202202140837.qnn8w3sP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fprobe_link_5
head:   9149abfa25286fdf715525babec5150939c9ac96
commit: 32adbf1760d4cccb9702863371d50b625ae7ee1d [3/10] bpf: Add support to attach kprobe program with fprobe
config: parisc-randconfig-r022-20220214 (https://download.01.org/0day-ci/archive/20220214/202202140837.qnn8w3sP-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=32adbf1760d4cccb9702863371d50b625ae7ee1d
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fprobe_link_5
        git checkout 32adbf1760d4cccb9702863371d50b625ae7ee1d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: kernel/bpf/syscall.o: in function `link_create':
>> (.text+0x7408): undefined reference to `bpf_fprobe_link_attach'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
