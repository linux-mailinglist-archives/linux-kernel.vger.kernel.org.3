Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FF850987D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:06:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385191AbiDUGsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385405AbiDUGrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27FE5F71
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523494; x=1682059494;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L3BomUbahSMPZzmxaKoJr9l1taXJtzFxAxh5XsF74Ig=;
  b=QXPz696pGIg1dBXeqC37jb5verqYKdE2aIghuKQTGokXqIhMFCZnNKfr
   Q3jhKebOxCTGxEwXtpNHSYVMB9Ifes7KMYNN2rhlsgM/TpmTfnioYCodT
   T6keDoe1YtTTeXE9XcJrZuhY56E7SYk+G4m0QV8LXAR/xnjsop86feRcA
   GJ9cxQzf+PVr3f+WqD4E9bUtl9z8nDNUCj32SDJvBZd1qg6ty3mw43+Wr
   pkleGGDXYcjTTxlnAE4N5rdkTKD4AcOAvcLeFju5FLDcVNYHBRLcdewAG
   aPEWUwpdY/pTmVSoMf7UBWWK/nGVkG3rTJPekuAXvz6k50kKnezG+IRdH
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264022421"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264022421"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:44:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="532793801"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2022 23:44:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQYd-000825-I8;
        Thu, 21 Apr 2022 06:44:51 +0000
Date:   Thu, 21 Apr 2022 14:44:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1933/2579] lib/memcat_p.c:10:8: warning: no
 previous prototype for '__memcat_p'
Message-ID: <202204210956.Xu01pPZP-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: b17c57b9f326f544a10178f2be4c886c4b02b4f3 [1933/2579] headers/deps: smp: Optimize <linux/smp.h> dependencies, remove <linux/smp_api.h> inclusion
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220421/202204210956.Xu01pPZP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=b17c57b9f326f544a10178f2be4c886c4b02b4f3
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout b17c57b9f326f544a10178f2be4c886c4b02b4f3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> lib/memcat_p.c:10:8: warning: no previous prototype for '__memcat_p' [-Wmissing-prototypes]
      10 | void **__memcat_p(void **a, void **b)
         |        ^~~~~~~~~~


vim +/__memcat_p +10 lib/memcat_p.c

93048c0944150b3 Alexander Shishkin 2018-10-16   4  
93048c0944150b3 Alexander Shishkin 2018-10-16   5  /*
93048c0944150b3 Alexander Shishkin 2018-10-16   6   * Merge two NULL-terminated pointer arrays into a newly allocated
93048c0944150b3 Alexander Shishkin 2018-10-16   7   * array, which is also NULL-terminated. Nomenclature is inspired by
93048c0944150b3 Alexander Shishkin 2018-10-16   8   * memset_p() and memcat() found elsewhere in the kernel source tree.
93048c0944150b3 Alexander Shishkin 2018-10-16   9   */
93048c0944150b3 Alexander Shishkin 2018-10-16 @10  void **__memcat_p(void **a, void **b)

:::::: The code at line 10 was first introduced by commit
:::::: 93048c0944150b316a15f92c41a4d626c8df37fd lib: Fix ia64 bootloader linkage

:::::: TO: Alexander Shishkin <alexander.shishkin@linux.intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
