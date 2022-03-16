Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8504DA8CE
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 04:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353239AbiCPDRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 23:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234584AbiCPDRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 23:17:13 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECB5E15C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 20:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647400560; x=1678936560;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aflBzv2aSbEXMnmeQqtRJe2jg/7+cFg5nd+jV5vAdKc=;
  b=Q7LtS/IUVfNhgokICBRfCmtvpmsDRcOcilJtNEvgs60E056FQPDkNpct
   jNhXLE90ymIfm7laD7Iz9CYbqxxuQLSstFI6xvzO9Sb2Tlydicp6BfJzj
   amtStVjp/foEWofBJOy0JLKVho4muJekvPB0YBFZo7CYi/zU2x3e0aub5
   g0+aJnz/V2fh2g2tPkAUB5JUtYdhYmsX/6W2FrDR84rYBTIwMWNriHenN
   XuaIFlwLoT3M/XshNdvS2KWtu0tnampQzjncU+ALOLAgrLZfzKObC0og3
   2zFf4VFpHpfAaVRReq3dJ8zOYHxqmzyoN7SrmCPklw3+bGxZLdL6j2ueY
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256203549"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256203549"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 20:15:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="516145365"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 15 Mar 2022 20:15:43 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUK8U-000BrK-L6; Wed, 16 Mar 2022 03:15:42 +0000
Date:   Wed, 16 Mar 2022 11:14:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 105/2308]
 ./usr/include/asm-generic/shmbuf.h:7:10: fatal error:
 uapi/asm-generic/ipcbuf.h: No such file or directory
Message-ID: <202203161151.VtI7Uoa7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   ef90a8d1de7ff54bfd0fcfe6371c20f544b14d6d
commit: 74e007195c2ad2051418f06d922524829a22d1b8 [105/2308] headers/deps: Remove <linux/sem.h> from <linux/sched.h>
config: i386-randconfig-a006-20220314 (https://download.01.org/0day-ci/archive/20220316/202203161151.VtI7Uoa7-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=74e007195c2ad2051418f06d922524829a22d1b8
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 74e007195c2ad2051418f06d922524829a22d1b8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/asm/shmbuf.h:6,
                    from ./usr/include/linux/shm.h:26,
                    from <command-line>:32:
>> ./usr/include/asm-generic/shmbuf.h:7:10: fatal error: uapi/asm-generic/ipcbuf.h: No such file or directory
       7 | #include <uapi/asm-generic/ipcbuf.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
