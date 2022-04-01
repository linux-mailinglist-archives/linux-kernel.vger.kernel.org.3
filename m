Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC54EE5E3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 04:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243938AbiDACGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 22:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243936AbiDACGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 22:06:39 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B0D1C6ED4
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 19:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648778690; x=1680314690;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HzK1MMfJoMOf9bbpzJWarOeRxa/1dSYPnYhJ4sTbEaY=;
  b=mkwBhUTIoafD0kTDvx/yJBOxPW+g+C4uHoncfmcZN17uj1Cf4Ux/Jkf6
   /sXu4dJ3ld1Ra5rDnXgVIKLTzg75sIFSJgk9wbCGcXMZ5GOf/7Ow8aFK6
   J+phvHCbmZrUJCJic7Yb3SaQQfhFd7rdPOJFj8LERAlc3Tyc0XksTmnQF
   2MBNO6GEHQiG7jYqzMAuAVEqwi3fiJ/OL9HBBz3ottZEiDoFhAYpnT1Qj
   XncUnEts997fXuvU+kt4FSpNGR2rfBdoHE+ocwzu1GT9ZN+PahFasvgHN
   YW40kUGSfROUOrOmxyedyu+t/52z6AGCmYJx1a81HcaBRtwMdyHvCPIEk
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="257601780"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="257601780"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 19:04:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="655283555"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2022 19:04:47 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na6ed-0000qN-5x;
        Fri, 01 Apr 2022 02:04:47 +0000
Date:   Fri, 1 Apr 2022 10:04:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-attest 5/6] ./usr/include/misc/tdx.h:39:2: error:
 unknown type name 'size_t'
Message-ID: <202204011037.5M42EV06-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-attest
head:   9247fade9db5ae6eb183b2f92fdedb898282376a
commit: 054b22e81e88379a5a8459c19e89a335531c1bdd [5/6] platform/x86: intel_tdx_attest: Add TDX Guest attestation interface driver
config: x86_64-randconfig-a016 (https://download.01.org/0day-ci/archive/20220401/202204011037.5M42EV06-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 881350a92d821d4f8e4fa648443ed1d17e251188)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel/tdx/commit/054b22e81e88379a5a8459c19e89a335531c1bdd
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-attest
        git checkout 054b22e81e88379a5a8459c19e89a335531c1bdd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <built-in>:1:
>> ./usr/include/misc/tdx.h:38:11: error: expected ';' at end of declaration list
           void *buf __user;
                    ^
                    ;
>> ./usr/include/misc/tdx.h:39:2: error: unknown type name 'size_t'
           size_t len;
           ^
   2 errors generated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
