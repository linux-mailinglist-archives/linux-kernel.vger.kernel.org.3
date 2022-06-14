Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F41554A77B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349148AbiFNDTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350410AbiFNDTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:19:15 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36D12E69B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 20:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655176754; x=1686712754;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TJReoOj8nE5W5agtQe+sD6ww44oVbp+1qTl06dZ7JY4=;
  b=PG/zFe9UMzkCy9I+sYMjILIJn1QvzS3ZdpGAwQhshvv0YNVusFsZVVeS
   oc/O4opAYs4P21r/GpJFL7hVUdnZs4Ws4fWX01v65rHxfDG0crPstf/nm
   FBm1gitj4/vEp3CzYxzQOE/Rfs2E1RJZ3XYDK4xObVQB9QrXAGaZsJCEU
   tG5FjtXXok+uqXXf05ZdYHIFCiVU7Ni9I0dHi379lS+J9t7E8w7mqTS9s
   XHQLxaGiDOZXnKg41VQa03QgtjsyxkUaJ4WfiPRitysfUeyyLy2ruAF1f
   y25kqOjlFqoi+O29mTriBY8va978xMJsKw72QhIs7nhxqIq6I0dajxlDn
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258318638"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="258318638"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 20:19:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="535388451"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2022 20:19:12 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0x5D-000LQD-0h;
        Tue, 14 Jun 2022 03:19:11 +0000
Date:   Tue, 14 Jun 2022 11:18:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-unaccepted-memory 6/17] fs/proc/meminfo.c:156:5:
 warning: "CONFIG_UNACCEPTED_MEMORY" is not defined, evaluates to 0
Message-ID: <202206141126.wBfKM00X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-unaccepted-memory
head:   7a902d05477ac272558ba731d903c6b0c9d72903
commit: e4fbeb9c5cb4aa02fcd17388eef920f389fc83ea [6/17] mm: Report unaccepted memory in meminfo
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220614/202206141126.wBfKM00X-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/e4fbeb9c5cb4aa02fcd17388eef920f389fc83ea
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-unaccepted-memory
        git checkout e4fbeb9c5cb4aa02fcd17388eef920f389fc83ea
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash fs/proc/ mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/proc/meminfo.c:22:28: warning: no previous prototype for 'arch_report_meminfo' [-Wmissing-prototypes]
      22 | void __attribute__((weak)) arch_report_meminfo(struct seq_file *m)
         |                            ^~~~~~~~~~~~~~~~~~~
   fs/proc/meminfo.c: In function 'meminfo_proc_show':
>> fs/proc/meminfo.c:156:5: warning: "CONFIG_UNACCEPTED_MEMORY" is not defined, evaluates to 0 [-Wundef]
     156 | #if CONFIG_UNACCEPTED_MEMORY
         |     ^~~~~~~~~~~~~~~~~~~~~~~~


vim +/CONFIG_UNACCEPTED_MEMORY +156 fs/proc/meminfo.c

   155	
 > 156	#if CONFIG_UNACCEPTED_MEMORY
   157		show_val_kb(m, "UnacceptedPages:",
   158			    global_node_page_state(NR_UNACCEPTED));
   159	#endif
   160	
   161		hugetlb_report_meminfo(m);
   162	
   163		arch_report_meminfo(m);
   164	
   165		return 0;
   166	}
   167	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
