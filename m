Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83BFF4FE3EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 16:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351867AbiDLOiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 10:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244461AbiDLOha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 10:37:30 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B2B5AECC
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 07:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649774113; x=1681310113;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HHsgRkFWikOLC0+eUkqw7b7yg2tukWfTOUQdrXgfpyE=;
  b=cMEao/8pYoSmlSVxRduXWpJEdU1gzcwOsWCXJv5Y1zugpA/Evr/Q7cBI
   siP3slCbsQiB9eOsEVhv/sR/ou4zalKsGnkRya6ztp1OjvzPrvrAWGBEO
   r7qqQQClXbk8VHgkinva5qNqOis+HcusiQsw9eV81VdOJxvuJVdnBRcFV
   VifFjO1c5weczs2L1sFxVllPviYBQN7WDtAp9gLB9QcfEAqoZHlWyP5nk
   b8T5iZ0m/OH+bkHPAWr44lGiHpa9+v8f2R1XcoM5CgE4KAFF4leChXti5
   Ukj8EhQs5MIW/Yzvh4TZEo0o+8F0zY1SMu9iTCKO+3mq6buLDHMlSwwgb
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="261236903"
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="261236903"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 07:35:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,254,1643702400"; 
   d="scan'208";a="724471172"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Apr 2022 07:35:11 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neHbq-0002uS-Ko;
        Tue, 12 Apr 2022 14:35:10 +0000
Date:   Tue, 12 Apr 2022 22:34:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpoimboe:objtool-run 14/14] Error: unknown option `link'
Message-ID: <202204122219.oMEWJFBW-lkp@intel.com>
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
head:   7f408460a07320dc0da22915e82ec3b444fef8c8
commit: 7f408460a07320dc0da22915e82ec3b444fef8c8 [14/14] todo
config: x86_64-randconfig-a001-20220411 (https://download.01.org/0day-ci/archive/20220412/202204122219.oMEWJFBW-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=7f408460a07320dc0da22915e82ec3b444fef8c8
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-run
        git checkout 7f408460a07320dc0da22915e82ec3b444fef8c8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: unknown option `link'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
