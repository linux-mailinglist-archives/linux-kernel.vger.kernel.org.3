Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC7453B904
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235003AbiFBMdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:33:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234029AbiFBMdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:33:44 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53477227345
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654173222; x=1685709222;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vrWWBee5O4ifRLN4PYOkj7/HILLNXclmDbcGW/+bYzo=;
  b=CNehCGZ8iyhUqRQ/A4AFfjncoqJER94bD9pATTGFWCelarz2bb4OEpYM
   pNnjvA9YSDc+THwbMGEZSI1oRJTpj92AAaJjkYD+hoQz5/LCTzxL4urcx
   Yl/U6JNDSf7lI5JgzK3WcY6UhnLNlvy5Dw9jwbayQ48z91XlcvC+pEL6/
   LhDBRxJIiP7TrIHnecGAptGGi0irP9uC5CzeZFLuSWHIwgb68qdsywFaH
   Ew/XeeGRjqZ1FfNefa3mLVFK+NvU/p+U0IqA9Fj3bclnAVCvhDjFCHICq
   IhGesTUxYPGqhvKaKB4/f97P+TJJTWCJ2GMIw4HtuG6A95a8xQypvweYu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275941632"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="275941632"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="612802181"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 02 Jun 2022 05:33:26 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwk0z-00054h-De;
        Thu, 02 Jun 2022 12:33:25 +0000
Date:   Thu, 2 Jun 2022 20:32:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [axboe-block:for-5.20/io_uring 61/69] io_uring/io_uring.c:3795:6:
 warning: no previous prototype for function 'io_assign_file'
Message-ID: <202206022034.TQhzh79T-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-5.20/io_uring
head:   35527d1da9a7caedd07ab1b0a2176ea80bbdf692
commit: 7d8795a4e662b005b70330c8038f486f4465e4de [61/69] io_uring: move poll handling into its own file
config: arm-buildonly-randconfig-r004-20220531 (https://download.01.org/0day-ci/archive/20220602/202206022034.TQhzh79T-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b364c76683f8ef241025a9556300778c07b590c2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=7d8795a4e662b005b70330c8038f486f4465e4de
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block for-5.20/io_uring
        git checkout 7d8795a4e662b005b70330c8038f486f4465e4de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> io_uring/io_uring.c:3795:6: warning: no previous prototype for function 'io_assign_file' [-Wmissing-prototypes]
   bool io_assign_file(struct io_kiocb *req, unsigned int issue_flags)
        ^
   io_uring/io_uring.c:3795:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   bool io_assign_file(struct io_kiocb *req, unsigned int issue_flags)
   ^
   static 
   1 warning generated.


vim +/io_assign_file +3795 io_uring/io_uring.c

  3794	
> 3795	bool io_assign_file(struct io_kiocb *req, unsigned int issue_flags)
  3796	{
  3797		if (req->file || !io_op_defs[req->opcode].needs_file)
  3798			return true;
  3799	
  3800		if (req->flags & REQ_F_FIXED_FILE)
  3801			req->file = io_file_get_fixed(req, req->cqe.fd, issue_flags);
  3802		else
  3803			req->file = io_file_get_normal(req, req->cqe.fd);
  3804	
  3805		return !!req->file;
  3806	}
  3807	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
