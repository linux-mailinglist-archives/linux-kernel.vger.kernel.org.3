Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524B24FCF43
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 08:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241487AbiDLGGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 02:06:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbiDLGGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 02:06:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8306B21A0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 23:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649743468; x=1681279468;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=A1EycYEFUamWp4+tkv/siN4klCeExrRkBTnQD/V9PCc=;
  b=DYWPcP0hVvotJVrMLcGLZOxJwnhzAYmohkcztZRnx5eNDpvVKDwP/6UA
   JJvp1sfv+Af2Hn4tHk2Rwr+ktS37OC2fexfzv4kmiiBmzkDDQ14uLLtsn
   MnlK6v0l6L727eBrp6e6iKtVh4eQClPhdWK2pZcRROpdDMjzmlniyUAPZ
   c6GAtOznLHlX7mCDOo+7OSANt065P+FGcKFj6/eIwkJv6cccqIkWFFiy0
   6Vt9afl2pXUKYKT45hhY/o3RAJFSt8paG+taHO8SEi/JCdoy9hCcAUYxq
   t3bnpIR+6o36dK8uQXNrQRSytopYtJZ0aAbU2e9jI96D4BvY71TmWsOQS
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261132501"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261132501"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 23:03:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="724300461"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 11 Apr 2022 23:03:38 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne9cn-0002Ya-Mx;
        Tue, 12 Apr 2022 06:03:37 +0000
Date:   Tue, 12 Apr 2022 14:03:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpoimboe:objtool-run 5/5] Error: unknown option `vmlinux'
Message-ID: <202204121322.tAAxdXfr-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-run
head:   0060ff03f4882dcb7911b968e5d1f31aaf840c33
commit: 0060ff03f4882dcb7911b968e5d1f31aaf840c33 [5/5] todo
config: x86_64-randconfig-r034-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121322.tAAxdXfr-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=0060ff03f4882dcb7911b968e5d1f31aaf840c33
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-run
        git checkout 0060ff03f4882dcb7911b968e5d1f31aaf840c33
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: unknown option `vmlinux'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
