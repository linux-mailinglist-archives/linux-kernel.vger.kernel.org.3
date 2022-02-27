Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 554914C58EE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 03:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiB0Bx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 20:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiB0Bxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 20:53:51 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C070252E36
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 17:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645926796; x=1677462796;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bE4VIKgBw3KUTe6gb/Ux3bw6tp20+o5UM0Bc15Qd8Dc=;
  b=XflOipTbvKybnPKyyensjNbAJeYcqaH8RNd0RGvYQsdtKH90e1BSReho
   Nl7Y5CWnHgAB3Cvowx3yEkju74GkyzoMW/PHzjLYlxQsoJM30GPZ8fXPB
   pADX0ywVxZO62Qufrexk5Sp8VMo9Rm5f+KTzxp9FH/RZNCs1lV+ZbhSqq
   MNuLUa3frSm9loPBq9okVryeTl8QAJT4kDoPDqa3NxqNn1+0lvXIW5vjb
   9RrLofxBJTxyq40w4qst+YLbM7gTFMOx10AvKf/IMsjFGjblqSE1J2m26
   UCqz4B3Zy8o+OWMP0nmX6Y/7svsKX3lMx+7Vo2x+Ug0+1IO9+bg1JCx/H
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="236201816"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="236201816"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 17:53:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="534021377"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 26 Feb 2022 17:53:14 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nO8kL-00068E-P8; Sun, 27 Feb 2022 01:53:13 +0000
Date:   Sun, 27 Feb 2022 09:52:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:next/linux-next/master 210/370] mips64-linux-ld:
 undefined reference to `node_data'
Message-ID: <202202270950.3wI5UHsb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block next/linux-next/master
head:   06aeb1495c39c86ccfaf1adadc1d2200179f16eb
commit: e2ad74daf436b686b3c8456ea277bfdc94188c8e [210/370] mm: handle uninitialized numa nodes gracefully
config: mips-randconfig-r011-20220227 (https://download.01.org/0day-ci/archive/20220227/202202270950.3wI5UHsb-lkp@intel.com/config)
compiler: mips64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e2ad74daf436b686b3c8456ea277bfdc94188c8e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block next/linux-next/master
        git checkout e2ad74daf436b686b3c8456ea277bfdc94188c8e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mips64-linux-ld: mm/page_alloc.o: in function `free_area_init':
   (.init.text+0x1d94): undefined reference to `node_data'
>> mips64-linux-ld: (.init.text+0x1dac): undefined reference to `node_data'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
