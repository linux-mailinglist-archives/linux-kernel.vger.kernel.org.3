Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9F7B4B629F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 06:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233954AbiBOFZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 00:25:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiBOFZr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 00:25:47 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 545BAF4063
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 21:25:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644902738; x=1676438738;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cw4TetNv3N2tD+9bymft95SLeG5cAflhjhjH1Ojnysk=;
  b=AWhnhuwDVnIoZ82H++9xZsySv3fBG1SoMAWF2tWbecAo31NALWaJw2fQ
   PuETtfyjBZGUbZgmse9e/tL57FecnvIz8YrhaQwIxM4srbs3MfhlP8mCa
   eaSRdGfPUzi2g+Q6drqVoMvPlq8ic0KV2xFBtTbnVDeuDX4yBBEUZqAqn
   FqWeeaUWSJXQ/08yXki62YoH0FnxE4BJJOUQon2EGMDh87IPegU8EUXKr
   SZ5yaUPBGKmX8cW/YtC7DXoIcqjd/WUY7IoqrODI93LbF8IVoNdTFDLbH
   zypZJ12cNv8bntFsdTHVO7UpbXSXwYlf+8WrJbmzjrbC9dD3vtyqjo82L
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="250199102"
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="250199102"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2022 21:25:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,369,1635231600"; 
   d="scan'208";a="635628477"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 14 Feb 2022 21:25:34 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJqLF-0009Ih-Jy; Tue, 15 Feb 2022 05:25:33 +0000
Date:   Tue, 15 Feb 2022 13:24:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 35/39]
 aarch64-linux-ld: flush.c:undefined reference to `xa_store_range'
Message-ID: <202202151333.6N0HuNNm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   b995bc7182f60aa2b4d8930a7446f10dfbcebcc2
commit: e73334c9144cee0fd83afee287d7e5950e5d256d [35/39] netfs: Generate a buffered writeback from ->writepages()
config: arm64-randconfig-r024-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151333.6N0HuNNm-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e73334c9144cee0fd83afee287d7e5950e5d256d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout e73334c9144cee0fd83afee287d7e5950e5d256d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: fs/netfs/flush.o: in function `netfs_flush_get_pages':
   flush.c:(.text.unlikely+0x178): undefined reference to `xa_store_range'
>> aarch64-linux-ld: flush.c:(.text.unlikely+0x2a4): undefined reference to `xa_store_range'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
