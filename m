Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB595842BD
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiG1PO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbiG1PO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:14:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 235BF54C9F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659021266; x=1690557266;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=D5T4iNk/5/mXkLBQhHNrAfYAyN1jd045F1LF9D/9fcI=;
  b=gfZWRSqjOlUq9om705mP2J12egF8XrhQGSBWqZiq6x6G8ovvQTpzQ9ME
   TbSRqY7k/RFShFQPc15wm2k/nImYNfqVImkDucIS63GFYXdQ6KnFnvD7R
   gF3KGWRvfVHLRvEDiROZYAuPJodwhcaUUqy4KyrwNhUEj7YzfvziciiIe
   PWQQvZFz1Bartj8S2MOijRDQGsYQHU6yXCldzzVDR3imsUKuMHK41nJpA
   t9qIuLAWBEJm35J9UgS+q2JPphd5yumdIOWCXPcAYnBcc4lDHZ1RmDsAw
   RdSzPFiAuSae/QD3tqk9s7LZ9yTY6O0/cODrYmCn+FkTqLAIKB8qxIhpO
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10422"; a="288548029"
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="288548029"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2022 08:14:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="576515152"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 28 Jul 2022 08:14:23 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oH5DT-000AFW-0X;
        Thu, 28 Jul 2022 15:14:23 +0000
Date:   Thu, 28 Jul 2022 23:14:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>
Subject: powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data48' from
 `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data48'
Message-ID: <202207282314.3Tt0twgo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6e7765cb477a9753670d4351d14de93f1e9dbbd4
commit: bc70682a497c4f3c968c552e465d1d9948b1ff4c ovl: support idmapped layers
date:   3 months ago
config: powerpc-randconfig-r013-20220728 (https://download.01.org/0day-ci/archive/20220728/202207282314.3Tt0twgo-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=bc70682a497c4f3c968c552e465d1d9948b1ff4c
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout bc70682a497c4f3c968c552e465d1d9948b1ff4c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data48' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data48'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data48' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data48'
>> powerpc-linux-ld: warning: orphan section `.bss..Lubsan_data48' from `fs/overlayfs/copy_up.o' being placed in section `.bss..Lubsan_data48'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
