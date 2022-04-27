Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726E9510D34
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 02:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356415AbiD0Af1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 20:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356411AbiD0AfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 20:35:24 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB66535242
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 17:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651019535; x=1682555535;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ptfKrLnVuU2OSDNjTi2bjmU6itXz67ikz9DWuBPUtFM=;
  b=oJpU5IeQMr+BpEm1g2A9MJ5gLeGOCQ6zGAQP9mkkUJyj4OoQIdnsmATO
   pJ5xFkNMvlin6Lfx6kTWxD4VPzk2WW/oFavGCv7YU/lLLDY6tYMX/3XKx
   6z63nMVj8xSiyx/4NlYWpK5YUDMQfoikYGpdagdJ1NgCrcCSHrZE/uguw
   6u3p059gSTgU+4e9WixeGCsLH5iCc7gPHFLU5SRp2kM/htzKBH/tvRxwT
   1pjFFxteG70CmzEL5DT/5Gz/c3RR+QH9mIneUmSeqUAPWL6nrLi6MbsGx
   eiItbDSB7tIUPKEtxjmvi/K4/CpFrJjDXT+1A2GS6zzn+fxdfzPq/jCf4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265928517"
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="265928517"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 17:32:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,292,1643702400"; 
   d="scan'208";a="532935265"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Apr 2022 17:32:14 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njVbJ-00047C-LI;
        Wed, 27 Apr 2022 00:32:13 +0000
Date:   Wed, 27 Apr 2022 08:31:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jolsa-perf:bpf/fixes 1/5] hid-picolcd_debugfs.c:(.text+0xa58):
 multiple definition of `kallsyms_on_each_symbol';
 drivers/hid/hid-picolcd_core.o:hid-picolcd_core.c:(.text+0x3b0): first
 defined here
Message-ID: <202204270811.rnkThsA1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git bpf/fixes
head:   5630c6957e15ef4902c8635147b35092efd08a0a
commit: 1776d7631a9bec5d7b3f08779be196875fb4eb62 [1/5] kallsyms: Fully export kallsyms_on_each_symbol function
config: sparc-randconfig-r016-20220425 (https://download.01.org/0day-ci/archive/20220427/202204270811.rnkThsA1-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git/commit/?id=1776d7631a9bec5d7b3f08779be196875fb4eb62
        git remote add jolsa-perf https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
        git fetch --no-tags jolsa-perf bpf/fixes
        git checkout 1776d7631a9bec5d7b3f08779be196875fb4eb62
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sparc-linux-ld: drivers/hid/hid-picolcd_debugfs.o: in function `kallsyms_on_each_symbol':
>> hid-picolcd_debugfs.c:(.text+0xa58): multiple definition of `kallsyms_on_each_symbol'; drivers/hid/hid-picolcd_core.o:hid-picolcd_core.c:(.text+0x3b0): first defined here

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
