Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4349450C7BC
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 08:10:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiDWGMr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 02:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiDWGMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 02:12:45 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B27D1586FD
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 23:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650694189; x=1682230189;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UgTv5PXPB4AfZUTREm9BFr22Y0pkHmMp3+dStO1lnuA=;
  b=auIleVlZsq3kvWm9Blf2D1/QzKAjuWVRrQZYRNZt7SqdGnwxKIz0Csga
   +9M4aSA2VPlMknDCEapf1MeyY5i/g8cC8Afdh89T6c1BPupQ7ivQ/Ixtv
   lJZQ6kazKZ4xR2ZqjIqw5t21BxXifRx5ZvPe1rKgte6c0ckuav7FzlS5q
   lHtPNj+4QDnpewxWGLyJ2FHVtDFDFCeoUoVLJXpp0LrWCuhfnhnw4IHiF
   sc/ItHiYmLVYZYu6kZENtwGOn+Wnw6+FeOMyZtBpdeq6groj3KmXtFRfF
   o6EujTfBlC1bWVegDD7rDyzmAJZkSZkszUyQrEIRxgQ6N0yYDIOTL4gjQ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="263705920"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="263705920"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 23:09:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="535022328"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Apr 2022 23:09:47 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni8xm-000B4e-NR;
        Sat, 23 Apr 2022 06:09:46 +0000
Date:   Sat, 23 Apr 2022 14:08:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1709/2579]
 ./usr/include/linux/if_link.h:5:10: fatal error: uapi/linux/netlink.h: No
 such file or directory
Message-ID: <202204231403.WDNlJinR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: ef31699c9db911b16feefaf2b79c3afb211df67d [1709/2579] headers/deps: net: Optimize <uapi/linux/if_link.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220423/202204231403.WDNlJinR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=ef31699c9db911b16feefaf2b79c3afb211df67d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout ef31699c9db911b16feefaf2b79c3afb211df67d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/if_link.h:5:10: fatal error: uapi/linux/netlink.h: No such file or directory
       5 | #include <uapi/linux/netlink.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
