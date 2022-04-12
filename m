Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9374B4FDE59
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245692AbiDLLlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 07:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356307AbiDLLkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:40:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A059B506CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649758861; x=1681294861;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=w0qqzuPg6fre0pLykL1SiwIqyX/9przAgXnZ0xEkhnI=;
  b=cRo+g183uBDtmtSiEW3ppgB5MNVeLQah1fzj6MlIuwP9o7Y5qvFojtDu
   O5/EVh+ZHaBjYdMmBUSAvooSZw5JRr7OzbNRSe6cq0BtrNeLDDvjmb2y9
   GVoF17y4KpHIx/56gjH7zk2QppMWOKugx+Lit4oWxDY6WEs5EfOG+hp8l
   pGXx3gv601swgZObGyUYGWyO+tzRMmcmRexJHWjznRaLqPdq0nVZXtu9a
   a7nXGXBMjESZKUCXGw4SIgWEsnTDzB9LUJoQBJf1GcU8+giNjHUFOwATy
   QcIuRcFMmhd13csKSOGzXTKhc4mHwXTQ+gXIShLIyTGHqJGxxNLSDy0aK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242925939"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242925939"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 03:21:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="559271710"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2022 03:21:00 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neDdr-0002kx-Lb;
        Tue, 12 Apr 2022 10:20:59 +0000
Date:   Tue, 12 Apr 2022 18:20:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpoimboe:objtool-run 14/14] ld.lld: error: unknown argument '--link'
Message-ID: <202204121858.7ox6amp1-lkp@intel.com>
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
config: i386-randconfig-a003-20220411 (https://download.01.org/0day-ci/archive/20220412/202204121858.7ox6amp1-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: unknown argument '--link'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
