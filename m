Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B45FE515725
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 23:44:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238799AbiD2Vrq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 17:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238675AbiD2Vro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 17:47:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1157D8924
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 14:44:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651268664; x=1682804664;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=09lnGlVLymWzCZyo5zqJBHCin6DOOY6zUy5xa+ucc2Q=;
  b=KIOPbN1hdSAZldH2D4Pm3GJ2Faw8c7yjUxewva4H9QrsUMd68YGCYGWK
   dL6j4v4IPx8GUpJBRNfjoJs2cY07obPKL8ySbLinpdIzL4/645+aGoq1S
   4CZInn1RPTkNAIf5vo8QSwU+RBhWDTSgRX0SIGLdHmRHABN5CTwWWyHcz
   Hu+76EIqubzps+yKOcAp9e5MxO5t61Djmm5zVs3ioom9Qo5wl75uR7yWq
   KqcH3YngrIDGSncngVojKZdLmv/v/RLZ4hlb95PysyDGMNa60ecAs3CLW
   slVx9tmRCVGd93Lsek6R3RT8mvgPJH0J8mL89DORgmNScAXXvQkmOgTTX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="264364354"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="264364354"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 14:44:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="597538400"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 Apr 2022 14:44:23 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkYPW-0006cx-Cb;
        Fri, 29 Apr 2022 21:44:22 +0000
Date:   Sat, 30 Apr 2022 05:43:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless 19/24]
 output.c:undefined reference to `udpv6_sendmsg'
Message-ID: <202204300550.TUJ17Y0y-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless
head:   14d1ef9d0da567ca88d30b4c79706079cc997e9f
commit: fdcaaadfeb4a8eec32fe3855be0e5e3c3add5592 [19/24] rxrpc: Call udp_sendmsg() directly
config: riscv-randconfig-r042-20220429 (https://download.01.org/0day-ci/archive/20220430/202204300550.TUJ17Y0y-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/fdcaaadfeb4a8eec32fe3855be0e5e3c3add5592
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless
        git checkout fdcaaadfeb4a8eec32fe3855be0e5e3c3add5592
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   riscv32-linux-ld: net/rxrpc/output.o: in function `.L220':
>> output.c:(.text+0x1142): undefined reference to `udpv6_sendmsg'
   riscv32-linux-ld: net/rxrpc/output.o: in function `.L388':
   output.c:(.text+0x1d4e): undefined reference to `udpv6_sendmsg'
   riscv32-linux-ld: output.c:(.text+0x1d68): undefined reference to `udpv6_sendmsg'
   riscv32-linux-ld: net/rxrpc/output.o: in function `.L407':
   output.c:(.text+0x2066): undefined reference to `udpv6_sendmsg'
   riscv32-linux-ld: net/rxrpc/output.o: in function `.L434':
   output.c:(.text+0x22f8): undefined reference to `udpv6_sendmsg'
   riscv32-linux-ld: net/rxrpc/output.o:output.c:(.text+0x2436): more undefined references to `udpv6_sendmsg' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
