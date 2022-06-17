Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0A554FF8A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 23:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235559AbiFQVyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 17:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236762AbiFQVx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 17:53:59 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF70590AF
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 14:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655502839; x=1687038839;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OEVj7qRYcWdYOKZdoaxbP+KqpdA0+bCSlrK2QBOmGcI=;
  b=LDYllqFiOyvO5BndqI5uUC/5iJOa2v+n6F0Xzo4CNovNHjfEgCk9nWVn
   /mZPRpU8TCegJeW8N6TN9lluWthS0LOA8nHpM66T5trj0nVUQJ0crxvN9
   hvRNJfPwo0C+0WNot496wUwywfFJQNogOkGdC7edSYmjJVv9m7EypowF7
   FN8hgKRRzUyaxg6dS6ObDGk9JNieh+fJ9UghvHNsBQw+sFGFgQX4H3im6
   gZ54gKKioiO73u6YDeAMSXd+3kTRfOudXAwqtOCSo6HHBO/jbiN3OL7mQ
   bsi57BJ/A6KxwYm9JEx/PI/8ocyY2sMo95hDDJcrdVRqmbGp+cR1mlw0b
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268309289"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268309289"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 14:53:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="675647089"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Jun 2022 14:53:57 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2Jue-000PnL-Ff;
        Fri, 17 Jun 2022 21:53:56 +0000
Date:   Sat, 18 Jun 2022 05:53:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: [peterz-queue:locking/core 2/4] ld.lld: error: undefined symbol:
 jump_label_apply_nops
Message-ID: <202206180532.mOqwM8Wu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git locking/core
head:   c4e2db802ebbc639960404b97c9b8a6284634428
commit: 74c632a2a5738bd18864610e34f6b6d2db664bb7 [2/4] jump_label: mips: move module NOP patching into arch code
config: mips-randconfig-r026-20220617 (https://download.01.org/0day-ci/archive/20220618/202206180532.mOqwM8Wu-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d764aa7fc6b9cc3fbe960019018f5f9e941eb0a6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mipsel-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=74c632a2a5738bd18864610e34f6b6d2db664bb7
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue locking/core
        git checkout 74c632a2a5738bd18864610e34f6b6d2db664bb7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: jump_label_apply_nops
   >>> referenced by module.c
   >>>               kernel/module.o:(module_finalize) in archive arch/mips/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
