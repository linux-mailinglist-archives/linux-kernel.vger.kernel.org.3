Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFA750A889
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 20:55:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391612AbiDUS5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 14:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380232AbiDUS5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 14:57:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0299E4C7BA
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 11:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650567281; x=1682103281;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rnJ8AOQ+F107nQufb8ck2W0XHYKcNKoRr+IZqyjKpwg=;
  b=MT0dhvE+FBbTyj4c8xafwBsN8cUDEMbKQz6sk0zhxj28Oeefq3WVz5MD
   s1Ls9cj8TlI9ixnYpqvuMoCr1km8mvw1rJOUxEiqhmgPAxyg6S2TkRF84
   Xju72U81fgxoOKEydZ3x5SOGKL/b67HfHc8N/L1bWmTW5cWiiwm5kLJ3z
   UDDVNILOntx+a7I2L8bY1U7jT847OOdit10Y2+/rQ2ZvR9JGU0NwHOHM6
   bc2eJlx9b4cr6CflY+m9fq9wNTcSe+jFh5Knc7SVQnsiNk92Z7g0ESwQL
   wO3n6fCGTyqrDGHZgS9oqcTFnQKigz4v4F8uIj1c3zKVbV3dsBCyzmzsh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="262049276"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="262049276"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 11:54:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="615041508"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 21 Apr 2022 11:54:33 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhbwm-0008gD-Uh;
        Thu, 21 Apr 2022 18:54:32 +0000
Date:   Fri, 22 Apr 2022 02:53:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dhowells-fs:rxrpc-ringless 17/21] ld.lld: error: undefined symbol:
 udpv6_sendmsg
Message-ID: <202204220240.iPx7FQgd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git rxrpc-ringless
head:   c388a8388ad238ffbe0cd204c3eacaf200055751
commit: d24f75894c69b625aaa8f2b937072e750a5787df [17/21] rxrpc: Call udp_sendmsg() directly
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220422/202204220240.iPx7FQgd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5bd87350a5ae429baf8f373cb226a57b62f87280)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=d24f75894c69b625aaa8f2b937072e750a5787df
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs rxrpc-ringless
        git checkout d24f75894c69b625aaa8f2b937072e750a5787df
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: udpv6_sendmsg
   >>> referenced by output.c
   >>>               rxrpc/output.o:(rxrpc_send_abort_packet) in archive net/built-in.a
   >>> referenced by output.c
   >>>               rxrpc/output.o:(rxrpc_reject_packets) in archive net/built-in.a
   >>> referenced by output.c
   >>>               rxrpc/output.o:(rxrpc_send_keepalive) in archive net/built-in.a
   >>> referenced 3 more times

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
