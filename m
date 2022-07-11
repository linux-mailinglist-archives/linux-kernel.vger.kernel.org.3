Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A155707B5
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbiGKPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbiGKPzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:55:36 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FDB27CD2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657554935; x=1689090935;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/lBUXvFbuDKqJhn10UzZd1HkLo026hUSTaL1EnIl+pM=;
  b=AcRHI/u/7w7JZzS4wfHiATI/mf4KjAqaYY1RzfO8UeIHrNaw20ld8Rwb
   WRzIZM+2l7nevAyvsUCV3JAdoouMfKE9d3n2oZLi1xAJfdx2/tiu5oXYi
   w2rh9gI6CqtiBIxyYU0EL4SNArJH/qrzPe2rwN9YzSoPpjZnWn2OatSuj
   NzIoRIHD3zPq495xWOuGC/oJQB0bCl6mL2o3l43VlHT69SrnhX26dMmXy
   7f7P8nGQrOxjM0UTaekKqiRT74Ot3Ed8kri+mLk4JEZV1CPBKpn+i27ge
   19KvGxre75IyGffqMxEKKVGyVq37JtYLaOwZTZujU75s84lQMdPj/NpXI
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="283449251"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="283449251"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 08:55:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="622126872"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 11 Jul 2022 08:55:33 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oAvky-0000wb-NO;
        Mon, 11 Jul 2022 15:55:32 +0000
Date:   Mon, 11 Jul 2022 23:54:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yishai Hadas <yishaih@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Leon Romanovsky <leon@kernel.org>
Subject: [leon-rdma:rdma-next 19/27] ERROR: modpost:
 "interval_tree_iter_first" [drivers/vfio/vfio.ko] undefined!
Message-ID: <202207112353.TpyzFpSc-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git rdma-next
head:   325f0cb55fe7505ffc12020edf66e91f1bdbe021
commit: de08f6b555c0b4687890265b2f2358f69f28512a [19/27] vfio: Introduce the DMA logging feature support
config: m68k-randconfig-r032-20220710 (https://download.01.org/0day-ci/archive/20220711/202207112353.TpyzFpSc-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/commit/?id=de08f6b555c0b4687890265b2f2358f69f28512a
        git remote add leon-rdma https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git
        git fetch --no-tags leon-rdma rdma-next
        git checkout de08f6b555c0b4687890265b2f2358f69f28512a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "interval_tree_iter_first" [drivers/vfio/vfio.ko] undefined!
>> ERROR: modpost: "interval_tree_insert" [drivers/vfio/vfio.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
