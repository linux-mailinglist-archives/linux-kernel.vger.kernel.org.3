Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13DAC4C5948
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 05:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbiB0ErC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 23:47:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiB0Eq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 23:46:58 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA0D438B1
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 20:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645937182; x=1677473182;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J9brR3dWfvc9iONLNJEvKXN5ZkVjBrVepT4rUMLkVDE=;
  b=VL9YQyZZDzRIlINruybCziapWaNzcMI5CvbJFIwyysBy7siROj3JDNtV
   A+gISk+2b6LeAPXiJTj8DIvIM6RFevnnF4j7LBcZzVIc5+WN03ACGxhit
   Ha9nuz2M4r105DQpmb72chjJA0+NgTOv66o8WRTgDFFdA5FN6FDiPPRhj
   OmzR9HqvHdhpRVg8aSyXFlWb6l8Zcdxj8szilaEZKCdCfWePNmaskdzZ7
   NsIK02fm3GJDexrQ/R35HnjeVYTlBUZDOrq+jws3Xis3AObH1RVJ1Z0Nl
   d+JvbC331KHEGrAHJyJ14gZUozVgNC9KS0S4dZNJG1C4q4h/eh41iuduk
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="277348500"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="277348500"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 20:46:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="492361226"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 26 Feb 2022 20:46:20 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOBRs-0006DI-8s; Sun, 27 Feb 2022 04:46:20 +0000
Date:   Sun, 27 Feb 2022 12:45:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [hare-scsi-devel:tls-upcall.v2 135/159] af_tlsh.c:undefined
 reference to `inet6_recvmsg'
Message-ID: <202202271243.bF63bqM0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   21b520ae0b338bd30496feb1ca90a2820dab7a65
commit: 49f638e40e8a12b036a9943b76baa0c54c14d504 [135/159] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: riscv-randconfig-r014-20220226 (https://download.01.org/0day-ci/archive/20220227/202202271243.bF63bqM0-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=49f638e40e8a12b036a9943b76baa0c54c14d504
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 49f638e40e8a12b036a9943b76baa0c54c14d504
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv32-linux-ld: net/tls/af_tlsh.o: in function `.L36':
>> af_tlsh.c:(.text+0xce): undefined reference to `inet6_recvmsg'
   riscv32-linux-ld: net/tls/af_tlsh.o: in function `.L41':
>> af_tlsh.c:(.text+0xfa): undefined reference to `inet6_sendmsg'
   riscv32-linux-ld: net/tls/af_tlsh.o: in function `tlsh_getname':
>> af_tlsh.c:(.text+0x1dc): undefined reference to `inet6_getname'
   riscv32-linux-ld: net/tls/af_tlsh.o: in function `.L166':
>> af_tlsh.c:(.text+0x7e6): undefined reference to `inet6_release'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
