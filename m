Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E38F529EA3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244828AbiEQKAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240213AbiEQKAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:00:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4AA138181
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 03:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652781619; x=1684317619;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F2+NXD/aW4xt/uExC7MtNoUKzDWRGFyOvhW+PDBUJss=;
  b=hgoH0svPpnFxZrMGEx8hg9t7roLZYaUQT1Xsz9eaQ7tyoUMeYUx21AQf
   Qce/NVHJeOzUTPvu3VJ0kaWkvZ6dKnpmAAD+/eh/Giy/Sszusbb+G5W0P
   lc4kgYf70HPw4eeN5DnCwzlXeRjuoju8zkAkWnc89oXmGTrSluoU6F/wS
   mq7IHPw1YNrIkfK6Eaxi5Y7uF6VBvpj+S6Mp1hjYH4M/mGskFq2lp9BHH
   zkz6DzN2JVm9KU9ql1WLJjmwsMZWcBf3hhZ2D5Iw67FYJtlM8r4C4qAb/
   wjp6g8fQwynL0F32Q7MiNP3THfIBkslxASf4Sph1D2DgafcOircDpeTxK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="253182551"
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="253182551"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 03:00:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,232,1647327600"; 
   d="scan'208";a="555705943"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2022 03:00:18 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nqu01-0000q5-Jp;
        Tue, 17 May 2022 10:00:17 +0000
Date:   Tue, 17 May 2022 17:59:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:linux-5.17.y 1443/2373] fs/io_uring.o: warning:
 objtool: io_req_prep()+0x4f: unreachable instruction
Message-ID: <202205171702.ifM3QFjG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   e1382731ef4e5e1634896596ebe74e48b9ed2b73
commit: 0e76afd78907c78bb7f5c0cce17a4afecd2b126f [1443/2373] io_uring: defer splice/tee file validity check until command issue
config: x86_64-randconfig-c022-20220516 (https://download.01.org/0day-ci/archive/20220517/202205171702.ifM3QFjG-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=0e76afd78907c78bb7f5c0cce17a4afecd2b126f
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.17.y
        git checkout 0e76afd78907c78bb7f5c0cce17a4afecd2b126f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/io_uring.c: In function '__io_submit_flush_completions':
   fs/io_uring.c:2515:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    2515 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
>> fs/io_uring.o: warning: objtool: io_req_prep()+0x4f: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
