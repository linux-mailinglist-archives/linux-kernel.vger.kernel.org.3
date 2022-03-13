Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC44D74ED
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 12:11:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbiCMLMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 07:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbiCMLMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 07:12:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E6A85BCC
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 04:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647169858; x=1678705858;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Pzs/usXMcYypWNyIUpEyaVO35AAgV7hIvMC2b2+c2Hs=;
  b=jS2tBkCNJSAUfx7fjQMtBuUrc2emoWTCo+nNEMp8KMu7VEmAMoOuOTAI
   sP2pXwNoAdj0USD5uZXohLwc0Lyz71cXWD3ARW6fQ9BFk9tIoUCyFKSGI
   VR7I3WpYSBFoTtfr66LUwSIoxYsSKjNXcdYAlXnyJYOtIax4hjxnYAxR8
   7++HK4jiJuQwbr2vO2XBqAfDuwJ2Eq3YhQnGtrdjJ8RnLBq8UcOMKRaMx
   epwut2cHQbNoNrEUQUFsytfYn876jVtKzPoQLtaMq4/J0NtWblxaPIW8+
   AJhsqO2MssEQXfpjBOQzUucDJfBItuh4XJ7+voxRE3vaBtIKkDZl4wSlT
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10284"; a="235809075"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="235809075"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 04:10:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="515078687"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 13 Mar 2022 04:10:56 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTM7j-0008tb-O4; Sun, 13 Mar 2022 11:10:55 +0000
Date:   Sun, 13 Mar 2022 19:09:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mhiramat:bootconfig/core 1/3] init/main.c:471:2: error: too many
 arguments to function 'get_boot_config_from_initrd'
Message-ID: <202203131908.aXBM1YuK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git bootconfig/core
head:   851eb04a13868ed61bd973f38e4fa9d741eef92e
commit: 5698b97b8004472839e402af5b4abbbf73755772 [1/3] bootconfig: Check the checksum before removing the bootconfig from initrd
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220313/202203131908.aXBM1YuK-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/commit/?id=5698b97b8004472839e402af5b4abbbf73755772
        git remote add mhiramat https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git
        git fetch --no-tags mhiramat bootconfig/core
        git checkout 5698b97b8004472839e402af5b4abbbf73755772
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   init/main.c: In function 'setup_boot_config':
>> init/main.c:471:2: error: too many arguments to function 'get_boot_config_from_initrd'
     471 |  get_boot_config_from_initrd(NULL, NULL);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c:268:22: note: declared here
     268 | static void * __init get_boot_config_from_initrd(u32 *_size)
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   init/main.c: At top level:
   init/main.c:778:20: warning: no previous prototype for 'mem_encrypt_init' [-Wmissing-prototypes]
     778 | void __init __weak mem_encrypt_init(void) { }
         |                    ^~~~~~~~~~~~~~~~


vim +/get_boot_config_from_initrd +471 init/main.c

de462e5f1071851 Masami Hiramatsu 2020-04-26  467  
2b7d2fe76f9c844 Cao jin          2021-03-11  468  static void __init setup_boot_config(void)
de462e5f1071851 Masami Hiramatsu 2020-04-26  469  {
de462e5f1071851 Masami Hiramatsu 2020-04-26  470  	/* Remove bootconfig data from initrd */
de462e5f1071851 Masami Hiramatsu 2020-04-26 @471  	get_boot_config_from_initrd(NULL, NULL);
de462e5f1071851 Masami Hiramatsu 2020-04-26  472  }
d8a953ddde5ec30 Masami Hiramatsu 2020-02-20  473  

:::::: The code at line 471 was first introduced by commit
:::::: de462e5f10718517bacf2f84c8aa2804567ef7df bootconfig: Fix to remove bootconfig data from initrd while boot

:::::: TO: Masami Hiramatsu <mhiramat@kernel.org>
:::::: CC: Steven Rostedt (VMware) <rostedt@goodmis.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
