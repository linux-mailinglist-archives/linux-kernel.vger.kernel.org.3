Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5BAF543F79
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233820AbiFHWzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231620AbiFHWya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:54:30 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748AF625A
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654728862; x=1686264862;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=hi7TghKYdYkjm4GjlEn/LxQ5ri3t6qc1FEgYaMhqY6E=;
  b=RfAbIhS263aipRCauLfY1irhYCsxo5D8Ic3Ye7oB+dVBZ59qdT+XWxEn
   pF38cq1KcO8N/YKWs6rZ++0hTBoWzD9xanKXSnwruHRvD3h+cQ8GPIi77
   ck/BodQa6o5NnwN7ZVWiW8b7dmKRDwVuuHoowtwLXJZ+on1eq/fhWNVOY
   3hFVEGZ1keGVRehAC1QwO1r3y6G8Yl7X0y2dpDBepxtfF58ybVR2E69j8
   sFj/w3Bywui+d953ABpu5kzzW0uiXcwrZJ4cAsEosqsl/DmGIT6pCotmT
   iA/nuNomNYy/DhN9CcYUNh674O2S4kj5V52RqcEGAp4pYlHoMT1EGzT6H
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="277898598"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="277898598"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 15:54:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="615605908"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 08 Jun 2022 15:54:06 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz4Yv-000FCL-JB;
        Wed, 08 Jun 2022 22:54:05 +0000
Date:   Thu, 9 Jun 2022 06:53:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpoimboe:reserve-brk-2 1/1] ld.lld: warning: section type mismatch
 for .brk_reservation
Message-ID: <202206090620.HpoizvXw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git reserve-brk-2
head:   a802eefebee4d2c01f479a7d3f2008fdd32ce270
commit: a802eefebee4d2c01f479a7d3f2008fdd32ce270 [1/1] x86/mm: Fix RESERVE_BRK() for older binutils
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220609/202206090620.HpoizvXw-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=a802eefebee4d2c01f479a7d3f2008fdd32ce270
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe reserve-brk-2
        git checkout a802eefebee4d2c01f479a7d3f2008fdd32ce270
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> ld.lld: warning: section type mismatch for .brk_reservation
   >>> arch/x86/built-in.a(kernel/setup.o):(.brk_reservation): SHT_PROGBITS
   >>> output section .brk: SHT_NOBITS
--
>> ld.lld: warning: section type mismatch for .brk_reservation
   >>> arch/x86/built-in.a(mm/init.o):(.brk_reservation): SHT_PROGBITS
   >>> output section .brk: SHT_NOBITS
>> ld.lld: warning: section type mismatch for .brk_reservation
   >>> arch/x86/built-in.a(kernel/setup.o):(.brk_reservation): SHT_PROGBITS
   >>> output section .brk: SHT_NOBITS
--
>> ld.lld: warning: section type mismatch for .brk_reservation
   >>> arch/x86/built-in.a(mm/init.o):(.brk_reservation): SHT_PROGBITS
   >>> output section .brk: SHT_NOBITS

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
