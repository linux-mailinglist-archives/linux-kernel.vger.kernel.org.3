Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7774CAB82
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243805AbiCBR0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243797AbiCBR0F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:26:05 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCC56CA33C
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646241920; x=1677777920;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1VMG1C2ouDa5WnKOC2fSg8M+oQ7EiSj/Z+wUoDeUvpc=;
  b=db1ZIdF97BCbt7xDfpCSbWBJtghCD6oaXLZjzBc4RoP2eQTEMiI5lbGS
   EyeFpiaSP0F1eMX+PaIjeohVbVRdaH9TBksviX+T60vm9B8RaupwAvcRQ
   gRJnnjER6F0u+OH3ewPW4U+W79HmS7p2w5Zu+feZfQwt93880aYLGnSCD
   8vgFeoTAoGfPGCwziXGYA1PlwdOMYzM9ZFr0y0Y7Lz4J8UDFQCxbmn23G
   AvI9X6lmw+Inndc1AK7a/BqFpG7PKoEiJDXCDhYbOqF453e34BVmNio6M
   jgYvBXcpSlbGUcvI3zjOcsPspjO/61dxY0uJixHzGsSpKfiOjmBaIzJoc
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253189206"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="253189206"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 09:25:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="594078589"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 02 Mar 2022 09:25:18 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPSiz-0001eg-Ka; Wed, 02 Mar 2022 17:25:17 +0000
Date:   Thu, 3 Mar 2022 01:24:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 25/27] ERROR:
 modpost: "netfs_stats_show" [fs/fscache/fscache.ko] undefined!
Message-ID: <202203030104.MXTQtgvB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   b295237bb1a924ca0723d728bb5ff30e6461ad2b
commit: 4b3ff38b2fe2b2e490f513a7b71763ae3473cafa [25/27] netfs, fscache: Make netfslib depend on fscache
config: arm-randconfig-r035-20220302 (https://download.01.org/0day-ci/archive/20220303/202203030104.MXTQtgvB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/4b3ff38b2fe2b2e490f513a7b71763ae3473cafa
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout 4b3ff38b2fe2b2e490f513a7b71763ae3473cafa
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "netfs_stats_show" [fs/fscache/fscache.ko] undefined!

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
