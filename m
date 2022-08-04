Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4EC258A2DF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 23:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235510AbiHDVtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 17:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiHDVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 17:49:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5EB15FE2
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 14:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659649777; x=1691185777;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7rt23PMPBzBSBIB2zxEb7Hv++9uljuJHhPCfAnJfZWQ=;
  b=bcsf/hV1JEdW9cISLAd94bVXJ6LIqw/UfUG0STLMiH/X5r8dFpP9iXgT
   Fr6NevmbS75AC3VnDWXV9qbxIyEpMxfPBcx06idv7bXx2V2Xk0uMZSAFI
   a1XxFFCaTPsmtSJ8WhVD84ro61Qm7fMP1/AMMSTosCk3kjSLroL9fH8CW
   M8VG+igziS5K2XOL7WC3/vUnQF5y5td2hjcf2f+W4JIjKyJrzzRgFzlQF
   Ija8wSoDljNFNCeaWP43Rt4nIpAcXpkNFiklPRbhMW+hqtpeh70bI9Xso
   59ebVWBNskx72JMd+xbiB04KLdh5884m0ynz4/6VjINSd1KX1aeP/s7FK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10429"; a="287615122"
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="287615122"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2022 14:49:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="671427889"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 04 Aug 2022 14:49:36 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJiil-000Isj-3D;
        Thu, 04 Aug 2022 21:49:35 +0000
Date:   Fri, 5 Aug 2022 05:48:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [mark:arm64/stacktrace/data-driven 4/4]
 arch/arm64/include/asm/stacktrace.h:153:13: error: cannot compile this GNU
 array range designator extension yet
Message-ID: <202208050544.mUKbvIhP-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git arm64/stacktrace/data-driven
head:   468d82fe55b7d215b8d1733a8b34a1fc94cd431b
commit: 468d82fe55b7d215b8d1733a8b34a1fc94cd431b [4/4] WIP: arm64: make stacktrace data-driven
config: arm64-randconfig-r003-20220803 (https://download.01.org/0day-ci/archive/20220805/202208050544.mUKbvIhP-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 26dd42705c2af0b8f6e5d6cdb32c9bd5ed9524eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/commit/?id=468d82fe55b7d215b8d1733a8b34a1fc94cd431b
        git remote add mark https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git
        git fetch --no-tags mark arm64/stacktrace/data-driven
        git checkout 468d82fe55b7d215b8d1733a8b34a1fc94cd431b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/arm64/kernel/stacktrace.c:19:
>> arch/arm64/include/asm/stacktrace.h:153:13: error: cannot compile this GNU array range designator extension yet
                   .stacks = {
                             ^
   1 error generated.


vim +153 arch/arm64/include/asm/stacktrace.h

   143	
   144	/*
   145	 * We can only safely access per-cpu stacks from current in a non-preemptible
   146	 * context.
   147	 */
   148	
   149	static __always_inline struct kernel_stack_info
   150	get_accessible_kernel_stacks(const struct task_struct *tsk)
   151	{
   152		struct kernel_stack_info info = {
 > 153			.stacks = {

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
