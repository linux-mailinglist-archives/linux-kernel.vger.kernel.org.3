Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FCDF4BFF9B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234498AbiBVREe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:04:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbiBVREc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:04:32 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC98E527D9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645549447; x=1677085447;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=sx7ZDd4yve8/hycQpnhPyjjsrJ5wn74yFs7QKPdiHTE=;
  b=UhDZOj5wWvyqGgg9ZAExxY7cHygqDJn1JE9n33fGMY6R8WM0183LB4AD
   Tvb7hEH4n2nK51rryqRJllJHY2b7S3wDlz9UuRZbYL5OnUSxi5ekD/mhR
   +7U1sMQbxNMTy/TmhWshZEPGsbzqjxdN1Mk0/Snfp1KvkKlnm2l0aHwuB
   8yqtSbhLnTAjCO0dta/FDOdRu5K4hUIDXYHarzqAUNPkDRCjnHG3mzpXO
   5nsOFVKD8r68bUt5DrRpMq/J+vUEv9NJosqotCZVrzqpbjXSSHRVKTgtl
   MwtDAxNjcvau7YgHCICdm/BgTM+CflaA5LwdBhz/ujDaLLquFWThfV/TJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="314988916"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="314988916"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 09:03:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="508063290"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 22 Feb 2022 09:03:46 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMYZm-0000Pp-6R; Tue, 22 Feb 2022 17:03:46 +0000
Date:   Wed, 23 Feb 2022 01:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 39/39]
 arch/x86/crypto/chacha-x86_64.lto.o: warning: objtool:
 chacha_2block_xor_avx512vl() falls through to next function
 chacha_8block_xor_avx512vl()
Message-ID: <202202230017.1CJQVqhv-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   1436dce5f32d577e8cef693e09f4bb1faa0e2692
commit: 1436dce5f32d577e8cef693e09f4bb1faa0e2692 [39/39] x86/alternative: Use .ibt_endbr_sites to seal indirect calls
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220223/202202230017.1CJQVqhv-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=1436dce5f32d577e8cef693e09f4bb1faa0e2692
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 1436dce5f32d577e8cef693e09f4bb1faa0e2692
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/crypto/chacha-x86_64.lto.o: warning: objtool: chacha_2block_xor_avx512vl() falls through to next function chacha_8block_xor_avx512vl()
>> arch/x86/crypto/chacha-x86_64.lto.o: warning: objtool: chacha_4block_xor_avx512vl() falls through to next function chacha_8block_xor_avx512vl()

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
