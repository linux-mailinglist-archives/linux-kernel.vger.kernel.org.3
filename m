Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64074C250F
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:12:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbiBXILx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231604AbiBXILt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:11:49 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99F6120BCE1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 00:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645690279; x=1677226279;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GFwgXOGJpALs3zlAijjfYNw0pudkBtjVqmWxF3fSdRg=;
  b=ZMiZ7lAqm/VElOQ6aXFa7XO1P5WRtK6xccvOFSeW6teJZ0pCgFFHpd+B
   Dr/yaQRgE5Fhfdvegy8ngnYHREttWH6usRKcx263C49TdF3R/WnD/toWw
   YJG/Kge4sg7et5WPsgGyNUdx+8Ggudc5fiiMxUEXAS07sMLdddLACXVMv
   Qj8X97DnUTpjAT1bm7hSHrgV0/M8oP64aS9nSSqpDw/Sn4S5THoskWm1l
   +3jvN5s2Y8NRSEpEoyyd+mwcwUk15dLMTOnjOWsZ/g8SeGj+AUlvJ4EQh
   fip/RBBkp/zDmrsoi623hCVxp+qYybUMDeJGXwNdvh69yuDtsLcmJGQ6r
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251911588"
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="251911588"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2022 00:11:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,393,1635231600"; 
   d="scan'208";a="707367251"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 24 Feb 2022 00:11:16 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN9DX-0002tf-Gj; Thu, 24 Feb 2022 08:11:15 +0000
Date:   Thu, 24 Feb 2022 16:10:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 27/42] arch/x86/lib/retpoline.S:15:2:
 error: invalid instruction mnemonic 'annotate_noendbr'
Message-ID: <202202241631.ROFL064p-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   27b6438f414b6a37b60dcd90c8980397586d49db
commit: 894eca106331b66d8f1c261d40386c043da75ee2 [27/42] x86/ibt: Annotate text references
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220224/202202241631.ROFL064p-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=894eca106331b66d8f1c261d40386c043da75ee2
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 894eca106331b66d8f1c261d40386c043da75ee2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/lib/retpoline.S:15:2: error: invalid instruction mnemonic 'annotate_noendbr'
    ANNOTATE_NOENDBR
    ^~~~~~~~~~~~~~~~


vim +/annotate_noendbr +15 arch/x86/lib/retpoline.S

    12	
    13		.section .text.__x86.indirect_thunk
    14	
  > 15		ANNOTATE_NOENDBR // apply_retpolines
    16	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
