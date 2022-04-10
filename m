Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBDC4FAC8E
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 09:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbiDJHcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 03:32:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiDJHb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 03:31:57 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBF565EB
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 00:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649575786; x=1681111786;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7acdqeNYB2mQbesxSUxPXsF/SJMG5dV5Al5NEqwCNfw=;
  b=NmVeb2sK5y5EIAAiHIQA9WVy6D87+aDNXrYArHOchykqYJn9uR35iNdI
   e4H7gAJDQ4EQgQPtM6EP4GSzeHilW+M1v3/s82TkeOXuNUqAR/1YSM8GW
   CdZIhwwC8KnGWTYYOYN9/llKcuFk57vqAb5qpK0eLihhv4ulQb+L17jUs
   svUL3V6ZFjtQRthd+7UnSJM5sL70Mbjus3IlhxVV7SM9g9GmIY9nz1ml7
   fALhcZzECK/ner9ZHk6HQ30QCbpq8y1J/ROHRkOnBumuz8UXWS1Ab3tHE
   9H0S5XB+Z6RdMlt7sDUX9ae5GS6F+XkOTuj8fP+Lg5aVHwDF6qww348WV
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10312"; a="243834135"
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="243834135"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2022 00:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,249,1643702400"; 
   d="scan'208";a="506734254"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 10 Apr 2022 00:29:44 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndS11-0000mn-PL;
        Sun, 10 Apr 2022 07:29:43 +0000
Date:   Sun, 10 Apr 2022 15:28:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: arch/x86/kernel/cpu/bugs.c:657:6: error: no previous prototype for
 'unpriv_ebpf_notify'
Message-ID: <202204101514.YEhzsZ1Q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e1f700ebd6bea293abe3c7e2807b252018efde01
commit: 44a3918c8245ab10c6c9719dd12e7a8d291980d8 x86/speculation: Include unprivileged eBPF status in Spectre v2 mitigation reporting
date:   7 weeks ago
config: x86_64-sof-customedconfig-bpf-defconfig (https://download.01.org/0day-ci/archive/20220410/202204101514.YEhzsZ1Q-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44a3918c8245ab10c6c9719dd12e7a8d291980d8
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 44a3918c8245ab10c6c9719dd12e7a8d291980d8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/bugs.c:657:6: error: no previous prototype for 'unpriv_ebpf_notify' [-Werror=missing-prototypes]
     657 | void unpriv_ebpf_notify(int new_state)
         |      ^~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/unpriv_ebpf_notify +657 arch/x86/kernel/cpu/bugs.c

   655	
   656	#ifdef CONFIG_BPF_SYSCALL
 > 657	void unpriv_ebpf_notify(int new_state)
   658	{
   659		if (spectre_v2_enabled == SPECTRE_V2_EIBRS && !new_state)
   660			pr_err(SPECTRE_V2_EIBRS_EBPF_MSG);
   661	}
   662	#endif
   663	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
