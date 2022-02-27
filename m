Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FCDD4C5F35
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 22:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231950AbiB0Vy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 16:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231897AbiB0VyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 16:54:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36EDE3EBB3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 13:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645998827; x=1677534827;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=obWvSGCHBlQvp0m44jQyMhXbjuyu7QsBw25S8nIBpBk=;
  b=CEcSWW9TkPFebqliD8H4hSGT2bhbidmaWHHY0BMYGIuVO/gN9vtPR0aO
   miQp5mxBB0d9zkChCVtHy3WeC1mR9ZnGkpjCkwUb6pt6OjwcNOTXpqqDX
   VCUV9BSas2S5YQtapM8XZhMbnz62x70jt994UuRkgih98RsmLqJ+J8n2l
   7wgp7nDjDDLMkHb7TmN+QJLqH5yviURosS7JdY1TEEGcTIjVFqPSyanaI
   4cAfH3ihPFOL29CmBHsFjNXNG7ZcNc30PYIkOpyVJOZugDpyS8N6K6Qnu
   XN/awcIWn65EVndC8k0OS1rH3FNUuyT8Ln6jwwPjN+0TG5LKoBSvZnP9L
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10271"; a="315979454"
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="315979454"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2022 13:53:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,142,1643702400"; 
   d="scan'208";a="549984166"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 27 Feb 2022 13:53:44 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nORU7-0006p9-BX; Sun, 27 Feb 2022 21:53:43 +0000
Date:   Mon, 28 Feb 2022 05:52:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kees:for-next/overflow 9/9] ./usr/include/misc/kunit.h:22:15:
 error: no macro name given in #define directive
Message-ID: <202202280550.gcosQL9r-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git for-next/overflow
head:   6a00c01f84e41b5cf50a312488cd72b5cd4e3d35
commit: 6a00c01f84e41b5cf50a312488cd72b5cd4e3d35 [9/9] UAPI: Introduce KUnit userspace compatibility
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220228/202202280550.gcosQL9r-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/commit/?id=6a00c01f84e41b5cf50a312488cd72b5cd4e3d35
        git remote add kees https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git
        git fetch --no-tags kees for-next/overflow
        git checkout 6a00c01f84e41b5cf50a312488cd72b5cd4e3d35
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/misc/kunit.h:22:15: error: no macro name given in #define directive
      22 | #define   /**/
         |               ^
   ./usr/include/misc/kunit.h:144:12: warning: 'run_suites' defined but not used [-Wunused-function]
     144 | static int run_suites(char *name, struct kunit_suite *suites[], size_t count)
         |            ^~~~~~~~~~

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
