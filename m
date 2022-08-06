Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840AA58B3EA
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 07:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbiHFEyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 00:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbiHFEyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 00:54:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067EAA19B
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 21:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659761688; x=1691297688;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=b4l0DsuuJHukJaAUHLvjjWI5uVoJIhsbh/iVcEZZOiI=;
  b=HXa2zEKqHQHka48rVnGb0AEYwORH8NJ8GRW2L5tkkqXGtF0aKmBByTsV
   MbaeUJCepo6h9jjhDipF1nNovURd9wZ8+5uufwvF7cks6rmMIPqvcqzix
   XPceIJKJsv0JzvJfs022SHeYuJJlhDuynSCeFdtYslquGK1xRQJdYUTle
   YaEnXoUbzNk+109pWzAALPzqJ0E3FQfIZ0wA3cTGZQN15KjVwf3nYzuZx
   fux42wSXvSsFwdpUWWSNKp4B8mX1BtQKtHj+dpRuo532EXyT/rcRscyR9
   kX2m/1j18GA2Z3nwSc0CpfO+5MhwBP3pDr+Chx4rcHAAMyydfrfg2xf9C
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="316236983"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="316236983"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 21:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="730209068"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2022 21:54:45 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKBpk-000K3L-1v;
        Sat, 06 Aug 2022 04:54:44 +0000
Date:   Sat, 6 Aug 2022 12:54:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Subject: drivers/remoteproc/st_remoteproc.c:114:20: sparse: sparse: incorrect
 type in argument 1 (different address spaces)
Message-ID: <202208061233.oNJbslVu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6614a3c3164a5df2b54abb0b3559f51041cf705b
commit: d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee ARM: mm: kill unused runtime hook arch_iounmap()
date:   6 weeks ago
config: arm-randconfig-s051-20220805 (https://download.01.org/0day-ci/archive/20220806/202208061233.oNJbslVu-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout d803336abdbc1bfacdb32b2cf9f4fdbee072b8ee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/remoteproc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
   drivers/remoteproc/st_remoteproc.c:98:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *va @@     got void [noderef] __iomem * @@
   drivers/remoteproc/st_remoteproc.c:98:12: sparse:     expected void *va
   drivers/remoteproc/st_remoteproc.c:98:12: sparse:     got void [noderef] __iomem *
>> drivers/remoteproc/st_remoteproc.c:114:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *io_addr @@     got void *va @@
   drivers/remoteproc/st_remoteproc.c:114:20: sparse:     expected void volatile [noderef] __iomem *io_addr
   drivers/remoteproc/st_remoteproc.c:114:20: sparse:     got void *va

vim +114 drivers/remoteproc/st_remoteproc.c

3df52ed7f269a2 Loic Pallardy 2019-01-10  110  
3df52ed7f269a2 Loic Pallardy 2019-01-10  111  static int st_rproc_mem_release(struct rproc *rproc,
3df52ed7f269a2 Loic Pallardy 2019-01-10  112  				struct rproc_mem_entry *mem)
3df52ed7f269a2 Loic Pallardy 2019-01-10  113  {
3df52ed7f269a2 Loic Pallardy 2019-01-10 @114  	iounmap(mem->va);
3df52ed7f269a2 Loic Pallardy 2019-01-10  115  
3df52ed7f269a2 Loic Pallardy 2019-01-10  116  	return 0;
3df52ed7f269a2 Loic Pallardy 2019-01-10  117  }
3df52ed7f269a2 Loic Pallardy 2019-01-10  118  

:::::: The code at line 114 was first introduced by commit
:::::: 3df52ed7f269a25a5f97d6c03887c3ad3d012816 remoteproc: st: add reserved memory support

:::::: TO: Loic Pallardy <loic.pallardy@st.com>
:::::: CC: Bjorn Andersson <bjorn.andersson@linaro.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
