Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08488522BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 07:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbiEKFyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 01:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiEKFyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 01:54:33 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E856815E63B
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 22:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652248470; x=1683784470;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kH+FIA2U7mKZG7uzbkrYnU9KpnPco/57lpdqv6tp6gY=;
  b=ZhVIlVapVZcWGiPOC+ygt/CAf+LjAmNRVYaAgu+NQTNHmJOfSVq7naBP
   voEv1mlIjOzggj0VcwYLl+grLgPatahrZEjlSXLYMMOxppOXm0YvDqYb+
   9cTBs2tfeQlv5+ilzHh0ZOETd2pyLKiQUCXCHXXHRnqGrWxXSChaCCsLj
   or0XDmz54qujui3c4q0V7gp+BfsXLmkXY5MRLavUohLnCkRsmLaF0R8gg
   +5cEPyYp22o7j0qjL8kocWVsRmT1gGu1DPyvLScg8GCxE2/gUOOr1CpDr
   M+KrCr6eX57luWmHBTj93RfLWIsNySs5V4Y9bzeH2zKYzjmcCfFmG01gl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="249494093"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="249494093"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 22:54:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="542146891"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 10 May 2022 22:54:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nofIq-000ImI-8E;
        Wed, 11 May 2022 05:54:28 +0000
Date:   Wed, 11 May 2022 13:53:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Xu <howeyxu@tencent.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/fastpoll-mshot 89/98]
 fs/io_uring.c:6075:9: error: implicit declaration of function
 '__io_poll_clean'; did you mean '__io_fill_cqe'?
Message-ID: <202205111354.aZRUoOl7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/fastpoll-mshot
head:   e721cdc172fd3aa845e4a0850cb5f9aefd8f3591
commit: e2959ad0f1aa6081772c3d9c703497c15d9c6039 [89/98] io_uring: add a helper for poll clean
config: m68k-randconfig-m031-20220509 (https://download.01.org/0day-ci/archive/20220511/202205111354.aZRUoOl7-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e2959ad0f1aa6081772c3d9c703497c15d9c6039
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/fastpoll-mshot
        git checkout e2959ad0f1aa6081772c3d9c703497c15d9c6039
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/io_uring.c: In function '__io_submit_flush_completions':
   fs/io_uring.c:2806:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    2806 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   fs/io_uring.c: In function 'io_apoll_task_func':
>> fs/io_uring.c:6075:9: error: implicit declaration of function '__io_poll_clean'; did you mean '__io_fill_cqe'? [-Werror=implicit-function-declaration]
    6075 |         __io_poll_clean(req);
         |         ^~~~~~~~~~~~~~~
         |         __io_fill_cqe
   cc1: some warnings being treated as errors


vim +6075 fs/io_uring.c

  6066	
  6067	static void io_apoll_task_func(struct io_kiocb *req, bool *locked)
  6068	{
  6069		int ret;
  6070	
  6071		ret = io_poll_check_events(req, locked);
  6072		if (ret > 0)
  6073			return;
  6074	
> 6075		__io_poll_clean(req);
  6076	
  6077		if (!ret)
  6078			io_req_task_submit(req, locked);
  6079		else
  6080			io_req_complete_failed(req, ret);
  6081	}
  6082	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
