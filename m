Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A275053B8A0
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 14:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234708AbiFBMCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 08:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234532AbiFBMC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 08:02:29 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F61D9A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 05:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654171346; x=1685707346;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qma6xf320+arM6S2q7IzORXTsQ0x0B76TRLAJMzAjf4=;
  b=HfWU+53cniQiVeZ18nvKKagv5cejv/6XiLYAXVpc3ZyC+EbLLHwaqRaj
   IEweLBLaqZIwkeBj5d85hEgRxyjRspJy367jRspxBDot8P7+32WuknDE6
   VekxxVecUPpGEcOutlMay39nA6caP0dcTOraT3dTEUi7xPqcW561z7D3V
   Ul5uxuOyUIxVyuOdU/6wpdeb+ZF8KkW6wTqHHQIA1t1y8gI9tcfrfkvcP
   Nus64kOvq12vDho1kGlkm/4PAaTJoOltoeDdaX2l9O47HnWLonhjpTQzP
   cNPxL3XCmy56j5ESYIg9jnUKhbLYSxnmPU0XkuArtb/eWPixk0HgEpW99
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="276000833"
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="276000833"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2022 05:02:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,271,1647327600"; 
   d="scan'208";a="530547468"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Jun 2022 05:02:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwjWy-00052b-5g;
        Thu, 02 Jun 2022 12:02:24 +0000
Date:   Thu, 2 Jun 2022 20:02:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [axboe-block:for-5.20/io_uring 61/69] io_uring/io_uring.c:3795:6:
 warning: no previous prototype for 'io_assign_file'
Message-ID: <202206021948.3N7DAXYa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
config: um-x86_64_defconfig (https://download.01.org/0day-ci/archive/20220602/202206021948.3N7DAXYa-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=7d8795a4e662b005b70330c8038f486f4465e4de
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block for-5.20/io_uring
        git checkout 7d8795a4e662b005b70330c8038f486f4465e4de
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   io_uring/io_uring.c: In function '__io_submit_flush_completions':
   io_uring/io_uring.c:1743:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    1743 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   io_uring/io_uring.c: At top level:
>> io_uring/io_uring.c:3795:6: warning: no previous prototype for 'io_assign_file' [-Wmissing-prototypes]
    3795 | bool io_assign_file(struct io_kiocb *req, unsigned int issue_flags)
         |      ^~~~~~~~~~~~~~


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
