Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56F95A7350
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiHaBYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiHaBYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:24:47 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D73AC6F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661909085; x=1693445085;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FkIBsb2Ip4T6JggnftCE6hDxnF+ldLX60MiuOgGrmtA=;
  b=XTnjJuSNVZplKUWagEVA/6GlDHB+VoT8pNxxLsbhWoWH2+njkJduVWcq
   NNm6vow08Puf0cd8RTXG4eqpkFqvuEILpL+gTk0hf+JXO0ALTLZ4cU6Sv
   a09+Ce8Pr006JKoIHaNkwBr2+yfJMidCkJbzxGQPIwrlIuTG+6pILc7xM
   MKd0p4ai74Z6PXNKbGm4TrCp0+4S/Ub/vu/iRnIo1MY36WqnfKHjTI0LB
   fGj3320RfkdWrwkez7jfu48YzC1IBnWBDmjvhr/ImqX8LMDMnRkHt4HJw
   9N9P477r85WL7m4/p0YtkJQvPmLnBFhR4giEyWqo1mL6CLIsIsPdN8HwH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="296130345"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="296130345"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 18:24:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="754262670"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2022 18:24:43 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTCTC-0000pn-2o;
        Wed, 31 Aug 2022 01:24:42 +0000
Date:   Wed, 31 Aug 2022 09:24:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-fixes 1/5]
 peer_event.c:undefined reference to `icmpv6_err_convert'
Message-ID: <202208310955.MOpvq0aG-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-fixes
head:   5ba1502ed90c38548d56a41156440fa70aed70ed
commit: b445daa0f2ca96635e9620cef26a72619ce3644a [1/5] rxrpc: Fix ICMP/ICMP6 error handling
config: m68k-randconfig-r034-20220830 (https://download.01.org/0day-ci/archive/20220831/202208310955.MOpvq0aG-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b445daa0f2ca96635e9620cef26a72619ce3644a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-fixes
        git checkout b445daa0f2ca96635e9620cef26a72619ce3644a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: net/rxrpc/peer_event.o: in function `rxrpc_encap_err_rcv':
>> peer_event.c:(.text+0x848): undefined reference to `icmpv6_err_convert'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
