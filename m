Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DA14D93AF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 06:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343694AbiCOFWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 01:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243553AbiCOFWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 01:22:12 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3C49265
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 22:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647321660; x=1678857660;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hzXNELrBsTb5VJ3vRrTOSudUp0q/rcZWVdLbg7vSBRM=;
  b=VgqfTSNT3Q6WhDZThym6zTUvFv3MMvySUgZT8BjLdluUbJr3stFI2R7P
   NhuJu93cHG8kYx2TIoIN9vJjerplwyB7UOZz6TVgMHal9Cv15HJVVS/3V
   ahEa7x6Ygbp+cBy0YzV7KIq5cJR6HCU/9aUPrv5D9mAf12MRQ7qO0EJiw
   2IxHkbI4zDKxjwGB9fhUyHRfa4sBO4y5GP/oqbyRFLzSPG3PFEv0FC/3M
   AWnjr24Mmbst2Btk0iKDUgKW5Pmr+10pLNm3fJpj9/8J0JZvYEMbdcVT3
   MogomSzyOrnszfVZJSPIaSv1e5bT8DZ7Pna9+EPdRLNmdE5rxM+WNS5fS
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="316937388"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="316937388"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 22:20:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="515725820"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 22:20:52 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTzc3-000Aam-A4; Tue, 15 Mar 2022 05:20:51 +0000
Date:   Tue, 15 Mar 2022 13:20:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt.ud1 39/56] security/keys/process_keys.o:
 warning: objtool: .text: unexpected end of section
Message-ID: <202203151359.uzN2HcRc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt.ud1
head:   f86aacc74625dc1b2b1d2ae309d2a832dba4d4f4
commit: 4c90d8ae1079abe5849747099a8ba128a7a19d84 [39/56] x86: Mark __invalid_creds() __noreturn
config: x86_64-buildonly-randconfig-r006-20220314 (https://download.01.org/0day-ci/archive/20220315/202203151359.uzN2HcRc-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=4c90d8ae1079abe5849747099a8ba128a7a19d84
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt.ud1
        git checkout 4c90d8ae1079abe5849747099a8ba128a7a19d84
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/ fs// kernel// security/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> security/keys/process_keys.o: warning: objtool: .text: unexpected end of section
--
>> security/keys/request_key_auth.o: warning: objtool: free_request_key_auth() falls through to next function request_key_auth_rcu_disposal()
--
>> drivers/misc/vmw_vmci/vmci_context.o: warning: objtool: ctx_free_ctx() falls through to next function vmci_ctx_put()

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
