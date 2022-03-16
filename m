Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59A894DAD3E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 10:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344868AbiCPJL5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 05:11:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiCPJLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 05:11:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 086ED5BD2D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 02:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647421842; x=1678957842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=GYVmQOhcdFAbfwKEexCd/VecqMoIgeWrILdw6jh/jwk=;
  b=XavaRW41d9dirvc7jz3DBDme/m35wcdKpotUNBtH/zIC06pp11xeRShR
   DjcMou6EpOpqzjv9Jow1ojp2WQT686aTYDPmxWbo3Gl+eIWtwmDNnTEl0
   2H6Ip/4DTYstJvzW4kIyJeFn+1N/SsE6wxCaBW+9j7fiu4n1wfWEeW0Jt
   hyVYkCU3Jkac5/0tFayQjG7rmo16QXsXyb+Jww5kbSN4cxoSmAD6Mjdkz
   rPy926fOTBa80HUXEoulqMtBOqvuE9H5pYFxMW8QrgkZKAAeaKtpK+GT9
   LG/jLMLIxWZeUNrz18nJIma5A4vNq30czr/xdmdrLTe1Ahgl8+IcgqYzK
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256482956"
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="256482956"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 02:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,186,1643702400"; 
   d="scan'208";a="714519679"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 16 Mar 2022 02:10:40 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUPfz-000CCQ-NF; Wed, 16 Mar 2022 09:10:39 +0000
Date:   Wed, 16 Mar 2022 17:09:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Quentin Perret <qperret@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.10-2022-02
 1555/9999] kernel/tracepoint.c:720:5: warning: no previous prototype for
 'android_rvh_probe_register'
Message-ID: <202203161700.WbV8553N-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Quentin,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.10-2022-02
head:   32c0a362f1a90ddf603ecd83a47a5b8e2b7a12fb
commit: cc6eed90a467a413b9c62fdd76e8f06347266a88 [1555/9999] ANDROID: vendor_hooks: Allow multiple attachments to restricted hooks
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220316/202203161700.WbV8553N-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/cc6eed90a467a413b9c62fdd76e8f06347266a88
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-5.10-2022-02
        git checkout cc6eed90a467a413b9c62fdd76e8f06347266a88
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/tracepoint.c:720:5: warning: no previous prototype for 'android_rvh_probe_register' [-Wmissing-prototypes]
     720 | int android_rvh_probe_register(struct tracepoint *tp, void *probe, void *data)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/android_rvh_probe_register +720 kernel/tracepoint.c

   719	
 > 720	int android_rvh_probe_register(struct tracepoint *tp, void *probe, void *data)

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
