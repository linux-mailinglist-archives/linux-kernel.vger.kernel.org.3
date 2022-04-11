Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BB74FC3B4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 19:53:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349029AbiDKRz5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 13:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349000AbiDKRzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 13:55:45 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E3235244
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 10:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649699609; x=1681235609;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Jkn38CH+TLuRx2bS/MDc8mvYYyTgqgM3nTnRqd60oAk=;
  b=SWpVMpsCTcEGUAeQHT2L/2t8CaQvod685rY7SXxBZSwlsnnJfx0KO+0l
   pgxyTsxFaVOBhRsx2MF/sfgF51yb0KoQTc+mCsZsq83sqhqmHA/Hwyg+H
   CydyXP1nmdLrxZdPMnoF1jc/tk1UC6rw3L+HGA30vjnLmICsl8i5NpvfY
   dVItCb8DmJhCPZJdq94/mZguw6amlXRhLFwJbK60kGiSw1YiHPH0Wxlv4
   GrLAxhKFKOFUtZ6T8GSO8bXgy6ink2pPL2SUcroaYF+WTbjm8UaddECSz
   98L9ymagqETWj9PlSSjr7n+zV7lI7VdwcfnikItNMpJ+f4I2cHGmTOxpp
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="262357268"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="262357268"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 10:53:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="854018585"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 11 Apr 2022 10:53:26 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndyEA-00022A-3i;
        Mon, 11 Apr 2022 17:53:26 +0000
Date:   Tue, 12 Apr 2022 01:52:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Greg Hackmann <ghackmann@android.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tri Vo <trong@android.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Yu Zhao <yuzhao@google.com>, Sean Paul <seanpaul@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 9206/9999]
 kernel/gcov/gcc_4_7.c:162:16: error: implicit declaration of function
 'within_module'; did you mean 'init_module'?
Message-ID: <202204120122.ULP2Vs6G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

FYI, the error/warning still remains.

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: 35be48648a6552869bd5d6c9a0d278102d23d46c [9206/9999] UPSTREAM: gcov: clang support
config: openrisc-randconfig-s032-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120122.ULP2Vs6G-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/jsarha/linux/commit/35be48648a6552869bd5d6c9a0d278102d23d46c
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout 35be48648a6552869bd5d6c9a0d278102d23d46c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=openrisc SHELL=/bin/bash M=kernel/gcov

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/gcov/gcc_4_7.c: In function 'gcov_info_within_module':
>> kernel/gcov/gcc_4_7.c:162:16: error: implicit declaration of function 'within_module'; did you mean 'init_module'? [-Werror=implicit-function-declaration]
     162 |         return within_module((unsigned long)info, mod);
         |                ^~~~~~~~~~~~~
         |                init_module
   cc1: some warnings being treated as errors


vim +162 kernel/gcov/gcc_4_7.c

   152	
   153	/**
   154	 * gcov_info_within_module - check if a profiling data set belongs to a module
   155	 * @info: profiling data set
   156	 * @mod: module
   157	 *
   158	 * Returns true if profiling data belongs module, false otherwise.
   159	 */
   160	bool gcov_info_within_module(struct gcov_info *info, struct module *mod)
   161	{
 > 162		return within_module((unsigned long)info, mod);
   163	}
   164	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
