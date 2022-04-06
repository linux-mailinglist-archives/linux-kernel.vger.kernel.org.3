Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB1F4F5B3A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 12:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386167AbiDFJdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 05:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244925AbiDFJPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 05:15:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7505918CD12
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 18:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649208106; x=1680744106;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lDmiDQtEEmXB0cb1YjRoZl6xlM1hhF0n4UWVWcsiDiw=;
  b=ZQHwRL102EmfnE0+ZmTc3sTeexzVbDwRw9OCKqK4MQ/1XpAawCwq0TiS
   HWQaG0IA/5lzAiXnlAh8Dd35B3nyC86SffT9lkQ/JIx/qN3zZpcFNnz1C
   IBHksCIEDYuzpxXpNxd9azQlDdSkztgLW4YgzlXQheKUErQvnPfREdS+d
   dtIlRIrDYrNgeFCPFPsmkS87EEL5Png2gLUX8CgEoDi5f3f/DHLRZSTZn
   DoHDjSNs3z06GtcETpb7eoKwkc60ZtET96AMBFnXtqsLJ8AzlJcIyEGcM
   TClKLRZ0AqHJAKWKRIfmt45ZfcwywZps/9M2XGQiSc4LOdm2HTz33xbbI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="240847686"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="240847686"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 18:21:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="505516591"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 05 Apr 2022 18:21:43 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbuMh-0003wi-6q;
        Wed, 06 Apr 2022 01:21:43 +0000
Date:   Wed, 6 Apr 2022 09:20:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 38/40] ERROR:
 modpost: "__tracepoint_netfs_sreq" [fs/afs/kafs.ko] undefined!
Message-ID: <202204060951.AmHlbl9O-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

First bad commit (maybe != root cause):

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: 2726127983997dfb5bb1bc83d69cec5baeea5694 [38/40] afs: Use the netfs write helpers
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220406/202204060951.AmHlbl9O-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/2726127983997dfb5bb1bc83d69cec5baeea5694
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 2726127983997dfb5bb1bc83d69cec5baeea5694
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "netfs_put_subrequest" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "__tracepoint_netfs_sreq" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "__traceiter_netfs_sreq" [fs/afs/kafs.ko] undefined!
ERROR: modpost: "netfs_page_mkwrite" [fs/afs/kafs.ko] undefined!
ERROR: modpost: "mas_walk" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "mas_destroy" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "mas_expected_entries" [fs/netfs/netfs.ko] undefined!
ERROR: modpost: "mas_store" [fs/netfs/netfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
