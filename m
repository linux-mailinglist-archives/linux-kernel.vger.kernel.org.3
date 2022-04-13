Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E504FF8F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 16:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbiDMOeJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 10:34:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233309AbiDMOeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 10:34:08 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4784B1C0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 07:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649860306; x=1681396306;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Y/7YzmTOCuS8W/C5XNlxHah8vs65pb+CWzux7/MAFp8=;
  b=Ufga/wZJlnRe2eWcUSo2dstgXn31fK5LYGuJqCMRcabOrtaVoOYO6Ptl
   0kew92jDXjQim88ZrMg/H5sXbcIags7HASdxukwSYINNSiw0zFj7RGMcf
   HpWcg38ixGSzXE+WNmXkSRvFEYlt98WBo1halgEaQB7i+5hTBmsPqPrbZ
   kJQRMHXYSjrJL5UztGGwfA+ObrJ3Y5GqFrEPJvRHQNm5QO7viyzu61LTc
   jGINnMYFZ0T29dcGvIQyMSWzMsc3PecKrJh4GRUpBinoqpXROzHVBL7KI
   2Cb9wodQmUfGfGCbzNczCvUqIzLkVK9atBnje2bBuLcbDgsPqNnaQrynp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="249970259"
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="249970259"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 07:23:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,257,1643702400"; 
   d="scan'208";a="854807017"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Apr 2022 07:23:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nedtu-0000NA-Ja;
        Wed, 13 Apr 2022 14:23:18 +0000
Date:   Wed, 13 Apr 2022 22:23:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mark:stacktrace/testing 1/1] lib/test_stacktrace/kunit.c:35:26:
 error: implicit declaration of function 'stack_trace_save'; did you mean
 'stack_depot_save'?
Message-ID: <202204132247.0dgxogvX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git stacktrace/testing
head:   a8e8825116626f8c3e8be3bb889b6442a7465cb8
commit: a8e8825116626f8c3e8be3bb889b6442a7465cb8 [1/1] WIP: stacktrace tests
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220413/202204132247.0dgxogvX-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=a8e8825116626f8c3e8be3bb889b6442a7465cb8
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark stacktrace/testing
        git checkout a8e8825116626f8c3e8be3bb889b6442a7465cb8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   lib/test_stacktrace/kunit.c: In function 'callback_st_save':
>> lib/test_stacktrace/kunit.c:35:26: error: implicit declaration of function 'stack_trace_save'; did you mean 'stack_depot_save'? [-Werror=implicit-function-declaration]
      35 |         st->nr_entries = stack_trace_save(st->store, MAX_STACK_ENTRIES, 0);
         |                          ^~~~~~~~~~~~~~~~
         |                          stack_depot_save
   lib/test_stacktrace/kunit.c: At top level:
   lib/test_stacktrace/kunit.c:54:5: warning: no previous prototype for 'st_find_func_idx' [-Wmissing-prototypes]
      54 | int st_find_func_idx(struct st_data *st, void *func, int start)
         |     ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +35 lib/test_stacktrace/kunit.c

    30	
    31	static void *callback_st_save(void *arg)
    32	{
    33		struct st_data *st = arg;
    34	
  > 35		st->nr_entries = stack_trace_save(st->store, MAX_STACK_ENTRIES, 0);
    36	
    37		return st;
    38	}
    39	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
