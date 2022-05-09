Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA735207A6
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 00:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbiEIWeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 18:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiEIWd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 18:33:58 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7792F27E3ED
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:30:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652135403; x=1683671403;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=X6YQX9EJhkXQ6TWgrs2UI2N4QPzHPeDrTpIoqmNMk2o=;
  b=W2CmOYLuV35eP5qRBzrELrzJPRoeOTUtiVxG/TjYvXPm5FECPbJhGRfe
   fS4/3SJz/LZGCbWMck+wiLhkytYybHxcGNFI2Oo5lgq+EThx8aFb54lYT
   sx/0IpSyVFYm/KF4SyKySCk8b4+BV1jW6Vg4H0nWUKeDli5fJneKOW93L
   h0Fup5bUNaSIHDbrWhr127x1GTkwN+r+E3m9TVIVzPwX88yDh3AbI1MhZ
   tH4CU1cxReXuI9enuuRZbvwMSCg2cUsUy7zAgQDwTkSnsvQlwumLWF4h3
   IIvYyrx+gpMYWqMRl/Trrz5W5U3LR/ujVD6b+nSkxa3u+BycEaTVog+Nj
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="268851901"
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="268851901"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 15:30:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,212,1647327600"; 
   d="scan'208";a="894568286"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 09 May 2022 15:30:00 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noBt9-000Gxu-Aq;
        Mon, 09 May 2022 22:29:59 +0000
Date:   Tue, 10 May 2022 06:29:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Xiaoming Ni <nixiaoming@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: [linux-next:master 8682/10218] kernel/stackleak.c:142:25: sparse:
 sparse: symbol 'stackleak_erase_off_task_stack' was not declared. Should it
 be static?
Message-ID: <202205100617.5UUm3Uet-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   ab38272e99730375c5db3db1c4cebf691a0550ab
commit: 96c59349a56cea71b3fce1f6d9c30d11bc01a548 [8682/10218] stackleak: add on/off stack variants
config: i386-randconfig-s001-20220509 (https://download.01.org/0day-ci/archive/20220510/202205100617.5UUm3Uet-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=96c59349a56cea71b3fce1f6d9c30d11bc01a548
        git remote add linux-next https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
        git fetch --no-tags linux-next master
        git checkout 96c59349a56cea71b3fce1f6d9c30d11bc01a548
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/stackleak.c:130:25: sparse: sparse: symbol 'stackleak_erase_on_task_stack' was not declared. Should it be static?
>> kernel/stackleak.c:142:25: sparse: sparse: symbol 'stackleak_erase_off_task_stack' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
