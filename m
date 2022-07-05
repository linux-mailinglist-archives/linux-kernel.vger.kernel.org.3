Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C0D5679D4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiGEWCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:02:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGEWB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:01:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE3119281
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657058518; x=1688594518;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1e2IMeE5kxwpwwtMoEumnSAn18EzevRBYEqGYl/Zlto=;
  b=GgrKPVKowc+YPdLLRmLhPCxks+1FbToRTGZGJlrbCPWDueehMqBEdTGe
   rGmxMmIRgj6b/RZAG3ve2/X8AUw+pZQF5k2MYCE4x1yLkGvtPB9KCNgEh
   ZyuGwSCAwzNckGYdjPsv11EYzrKQifnaPvoB0RbXa3eX9ezh//BqbIYuo
   Tlm0kvBHrYgOl/mMzcQwUQVYzn8yqBswriUxTb5DT0JXQyZ0/xgF0XVWD
   FRQfZilKVmYB1muyfCG2jLe/dyEaqKqN4A400v1OC1CGuA0VGad/0NG58
   3zXUrDMpvgqGgA1RZ4BwS/3g+TrEZkuzPhOxTW829YKlWfHl1D79nLWCG
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="284647604"
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="284647604"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 15:01:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,248,1650956400"; 
   d="scan'208";a="543127022"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 05 Jul 2022 15:01:57 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8qcG-000Jd7-Sd;
        Tue, 05 Jul 2022 22:01:56 +0000
Date:   Wed, 6 Jul 2022 06:01:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Coly Li <colyli@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [colyli-bcache:nvdimm-meta 14/16] drivers/md/bcache/nvmpg.c:103:5:
 warning: no previous prototype for 'bkey_offset_to_nvmpg_ns_id'
Message-ID: <202207060515.oVvT5Qjx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git nvdimm-meta
head:   5c8259ab2129816fc49fd6d060206ba61b0594d1
commit: 1a39b34e981ca6086a904c5522d700e149240c3f [14/16] bcache: add helper routines to convert bkey and nvmpg offset
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220706/202207060515.oVvT5Qjx-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git/commit/?id=1a39b34e981ca6086a904c5522d700e149240c3f
        git remote add colyli-bcache https://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache.git
        git fetch --no-tags colyli-bcache nvdimm-meta
        git checkout 1a39b34e981ca6086a904c5522d700e149240c3f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/md/bcache/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/md/bcache/nvmpg.c:103:5: warning: no previous prototype for 'bkey_offset_to_nvmpg_ns_id' [-Wmissing-prototypes]
     103 | int bkey_offset_to_nvmpg_ns_id(unsigned long bkey_offset)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bkey_offset_to_nvmpg_ns_id +103 drivers/md/bcache/nvmpg.c

   102	
 > 103	int bkey_offset_to_nvmpg_ns_id(unsigned long bkey_offset)
   104	{
   105		return (bkey_offset >> BCH_BKEY_OFFSET_BITS) &
   106			BCH_BKEY_OFFSET_NS_ID_MASK;
   107	}
   108	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
