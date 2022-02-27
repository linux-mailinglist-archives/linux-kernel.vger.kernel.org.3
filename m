Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 642D64C5B4B
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 14:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbiB0NQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 08:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbiB0NQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 08:16:12 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1EB4C42E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 05:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645967736; x=1677503736;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=fwOc11DsVbHb4Y+Ju6WJAm9+uFYLJ46Kq9tr0IIxlsQ=;
  b=YPC12xQrGZk2jY+xJSWHopi0lN3aTmN4MfNr1olVaYJf435VlwsRji9u
   s/R4mUyDpK0XKouBxpUUeaBWGOw4Am9sibULf9iFX6g8Wh4Ub39qzcs4h
   vvGnAAjT+wAP1I61OUM1RZ8Mct9i5P+U/EQhI3U2+06VKVwO2FWpQkzQA
   feJSdkltZ5IN+/RCzwV3H9wTzVwx9pz5UgCYeegOTw3DhhuftDs4cjE98
   gBlms68rzsxpSOzDhQ/tvC0EmhlK/rUprwEXunrH6oF6J4TJuwpBtTVg0
   TLJDQHv+v9N5JgytBA1kCKeMxQf7+tUgfeRPkHaRFKRaawQp3eNSOE7D+
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="339170051"
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="339170051"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 05:15:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,141,1643702400"; 
   d="scan'208";a="544463785"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 27 Feb 2022 05:15:34 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nOJOf-0006Wg-E3; Sun, 27 Feb 2022 13:15:33 +0000
Date:   Sun, 27 Feb 2022 21:14:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:next/linux-next/master 114/370] ERROR: modpost:
 "vm_get_page_prot" [vmlinux] is a static EXPORT_SYMBOL
Message-ID: <202202272123.cI2ny1O3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block next/linux-next/master
head:   06aeb1495c39c86ccfaf1adadc1d2200179f16eb
commit: 8d8d82a114a972cf7b5f2f4154aafbb338f33fb7 [114/370] m68k/mm: enable ARCH_HAS_VM_GET_PAGE_PROT
config: m68k-randconfig-r026-20220227 (https://download.01.org/0day-ci/archive/20220227/202202272123.cI2ny1O3-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/8d8d82a114a972cf7b5f2f4154aafbb338f33fb7
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block next/linux-next/master
        git checkout 8d8d82a114a972cf7b5f2f4154aafbb338f33fb7
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "vm_get_page_prot" [vmlinux] is a static EXPORT_SYMBOL

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
