Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770694B7C82
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 02:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245474AbiBPBdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 20:33:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234468AbiBPBdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 20:33:33 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90FFD66FA0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 17:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644975202; x=1676511202;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=AiIXLQZu8+D8R2OVvFhAZ74QjGlHT0Agn4x8wR/GemA=;
  b=AU3zAKeReLb+66fJRCBewLZzanaOZUDOvoO42Uo4AsU8fcUaW5KOKYkT
   ZO1VxpFswhtEv37tcqjuHTeJbboXsyqxBiR6HTejYHntO8uyuurKO6SN1
   uqvEtQdeND0S+yg2o65HaZA7Dq+/0bfQc/obEll+3YyLUAaAs/h9j+ZJz
   2JDsT/ExSjum1l7ygvx+w8bY1w3nFHiPg29CZG6Ulj4ZZqx54aMnvxiio
   5zyUET7UbXnYzmu0bn6bVXQVWyIcR2687/HLx6YWSIGqcRdxbgkqhGIdZ
   EXG2mbIdATOGPl+tU2Tm4TqyZRiNZGpKLzIWMvuPSCYEjhcN0ZTlq3lAv
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="250699572"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="250699572"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 17:33:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="571080002"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 15 Feb 2022 17:33:19 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nK9C1-000AFV-Kw; Wed, 16 Feb 2022 01:33:17 +0000
Date:   Wed, 16 Feb 2022 09:32:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 34/43] undefined
 reference to `xa_store_range'
Message-ID: <202202160932.EILzLWJZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   d40df0841e9f8de3713a19dd3f0ba283c860cb93
commit: 4cfd40116179da8d60f57d8e8c0d19a7514bcc66 [34/43] netfs: Generate a buffered writeback from ->writepages()
config: parisc-buildonly-randconfig-r006-20220214 (https://download.01.org/0day-ci/archive/20220216/202202160932.EILzLWJZ-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4cfd40116179da8d60f57d8e8c0d19a7514bcc66
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 4cfd40116179da8d60f57d8e8c0d19a7514bcc66
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   hppa-linux-ld: fs/netfs/flush.o: in function `netfs_flush_get_pages':
>> (.text+0xfc): undefined reference to `xa_store_range'
>> hppa-linux-ld: (.text+0x290): undefined reference to `xa_store_range'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
