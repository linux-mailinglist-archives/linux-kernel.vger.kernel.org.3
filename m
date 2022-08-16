Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003725954D2
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:18:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiHPISI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbiHPIRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:17:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85F72118DD9
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660630370; x=1692166370;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=OCTurReto08p/Yn/8a5qxxlFZM8SnUJ15m3nnDnfQIc=;
  b=L3Omw0Anz9TjUKqLKkKvTimpUILsANCgFBnPRyMUxZGqsLZ8/+gfxdQv
   rUY72/weQ53GstGe6RP3xCD/04n0bwGX+br04SQ/fi1Hw/LPM7BGbmcYc
   pjJSqatD3ItaByBUmSYPxOZ9P4KRSMkXeufjHW5rBsGY1Sj6UEkyMlvr/
   0ho50eQqw3Q/mbIU1h6OgNdOpcPjpSSTfuWPrEqHyfJfUYdkaN4MFFUyn
   S3gVgt6Pp7xFS+aGqqt4TYCtmOLf5dXu0sXckIkfBnNzcE5OlFEHA0Qrm
   Nwubwa4zf+jHKQWBEF2jyUr9eH4D8kE47EOUFcQ51NS3UT05gFXgSYBwC
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="292131839"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="292131839"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 23:12:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="639909154"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2022 23:12:48 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNpol-0001YP-2v;
        Tue, 16 Aug 2022 06:12:47 +0000
Date:   Tue, 16 Aug 2022 14:12:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianpeng Ma <jianpeng.ma@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Coly Li <colyli@suse.de>, Qiaowei Ren <qiaowei.ren@intel.com>
Subject: [colyli-bcache:nvdimm-meta 2/16]
 drivers/md/bcache/nvmpg_format.h:132:19: warning: 'bch_nvmpg_recs_magic'
 defined but not used
Message-ID: <202208161410.TIsjGMiZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git nvdimm-meta
head:   b3a2634cd2ac86de5e7ac607104db6866b1b9f6b
commit: 08ce6a36470047a30ac9db26714a566280adddde [2/16] bcache: initialize the nvm pages allocator
config: i386-randconfig-a003-20220815 (https://download.01.org/0day-ci/archive/20220816/202208161410.TIsjGMiZ-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git/commit/?id=08ce6a36470047a30ac9db26714a566280adddde
        git remote add colyli-bcache https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git
        git fetch --no-tags colyli-bcache nvdimm-meta
        git checkout 08ce6a36470047a30ac9db26714a566280adddde
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/md/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/md/bcache/nvmpg.h:8,
                    from drivers/md/bcache/super.c:17:
>> drivers/md/bcache/nvmpg_format.h:132:19: warning: 'bch_nvmpg_recs_magic' defined but not used [-Wunused-const-variable=]
     132 | static const __u8 bch_nvmpg_recs_magic[] = {
         |                   ^~~~~~~~~~~~~~~~~~~~
>> drivers/md/bcache/nvmpg_format.h:129:19: warning: 'bch_nvmpg_magic' defined but not used [-Wunused-const-variable=]
     129 | static const __u8 bch_nvmpg_magic[] = {
         |                   ^~~~~~~~~~~~~~~


vim +/bch_nvmpg_recs_magic +132 drivers/md/bcache/nvmpg_format.h

e9147021c67818 Coly Li 2021-07-26  128  
e9147021c67818 Coly Li 2021-07-26 @129  static const __u8 bch_nvmpg_magic[] = {
e9147021c67818 Coly Li 2021-07-26  130  	0x17, 0xbd, 0x53, 0x7f, 0x1b, 0x23, 0xd6, 0x83,
e9147021c67818 Coly Li 2021-07-26  131  	0x46, 0xa4, 0xf8, 0x28, 0x17, 0xda, 0xec, 0xa9 };
e9147021c67818 Coly Li 2021-07-26 @132  static const __u8 bch_nvmpg_recs_magic[] = {
e9147021c67818 Coly Li 2021-07-26  133  	0x39, 0x25, 0x3f, 0xf7, 0x27, 0x17, 0xd0, 0xb9,
e9147021c67818 Coly Li 2021-07-26  134  	0x10, 0xe6, 0xd2, 0xda, 0x38, 0x68, 0x26, 0xae };
e9147021c67818 Coly Li 2021-07-26  135  

:::::: The code at line 132 was first introduced by commit
:::::: e9147021c678184512de1776d163b5a994a209a3 bcache: add initial data structures for nvm pages

:::::: TO: Coly Li <colyli@suse.de>
:::::: CC: Coly Li <colyli@suse.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
