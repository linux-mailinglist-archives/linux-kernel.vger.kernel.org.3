Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0675A733B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbiHaBOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiHaBOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:14:47 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B59E2E7
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661908485; x=1693444485;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xREdqX5Rgk+d9GMM+tts+tDRkRFSmHg/dgvGGKgFczg=;
  b=MQEph7cpjOMCwoNMIVEmCP505eV5qoz2QbLn8h2AqG3ZRPn6QRRmacOc
   VQvOruHkZdLcAbwbgyoy6hxmWdUbYrItnaCe39i4jJloPOcNEDZ8Z1aPY
   N2ItWNOCwGAJmUrzn4IxJuL9HX7gMKojaBagCAZOpE9a71dkb3YFMGrIr
   TOUH/6vwRvNwo07WbWoXr/rnPbwIEJJFtvBeMDA9IdhQpST5oD4nE+65O
   N1GhAqtig/L+R6MLMmQfLOUDcFan9D3fEzrMlsKm5Ib6OyKNgY0YS1NoV
   WFZTTJ56kjr5sfBSZ7NCTpphGhl3ubzhgKh4NmNQ/SgVokA9Mp7u5XY/W
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="294085201"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="294085201"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 18:14:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="562872970"
Received: from lkp-server02.sh.intel.com (HELO 77b6d4e16fc5) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Aug 2022 18:14:43 -0700
Received: from kbuild by 77b6d4e16fc5 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oTCJW-0000pP-1A;
        Wed, 31 Aug 2022 01:14:42 +0000
Date:   Wed, 31 Aug 2022 09:13:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-fixes 1/5] ld.lld: error:
 undefined symbol: icmpv6_err_convert
Message-ID: <202208310959.v4cyfQBy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-fixes
head:   5ba1502ed90c38548d56a41156440fa70aed70ed
commit: b445daa0f2ca96635e9620cef26a72619ce3644a [1/5] rxrpc: Fix ICMP/ICMP6 error handling
config: x86_64-randconfig-a005 (https://download.01.org/0day-ci/archive/20220831/202208310959.v4cyfQBy-lkp@intel.com/config)
compiler: clang version 14.0.6 (https://github.com/llvm/llvm-project f28c006a5895fc0e329fe15fead81e37457cb1d1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/b445daa0f2ca96635e9620cef26a72619ce3644a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-fixes
        git checkout b445daa0f2ca96635e9620cef26a72619ce3644a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: undefined symbol: icmpv6_err_convert
   >>> referenced by peer_event.c
   >>>               rxrpc/peer_event.o:(rxrpc_encap_err_rcv) in archive net/built-in.a

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
