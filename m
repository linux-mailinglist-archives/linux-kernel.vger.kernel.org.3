Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B17D517A01
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 00:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241604AbiEBWgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 18:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiEBWf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 18:35:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABBEFA1B2
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 15:32:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651530748; x=1683066748;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YlaDj/iYhMm/6LNBaHJL/0fPCODKjiNytW/Jy8TwmLs=;
  b=Do4s9IeIprkHCh1TZyfdy8ENY0mnHod1F5lrQvaPH1UHGxUZCnVuOuKB
   YsG7pwwWCHU22kBFt27sn55MrnZvQ13XY1IIAjbE8VS+8AB+2nZSFoc3q
   hG+wOFmr1SmbUAdrpVsv/cvYZHkbM8xv3xw3cxADu9XKuNGCdCYQA6IN3
   YvPxriQd/x6pl6oEGAdAO+eBjkwzRyNNouSOv1+AHrKx/0rVGWeMqBHoS
   6f+V5ZSht7lrKrfMf/hNQtgBeQT1ignCl15ZdLrPUSNyXbozMowzfrpXa
   P84f2VnH7LAVOZLRGgZQ/0oA+jGWHeTTxh/q6OQBDlFpBEDGwmI7/otS6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="327888460"
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="327888460"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2022 15:32:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,193,1647327600"; 
   d="scan'208";a="516315405"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 May 2022 15:32:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nleag-0009w3-9U;
        Mon, 02 May 2022 22:32:26 +0000
Date:   Tue, 3 May 2022 06:31:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 31/32]
 thinkpad_acpi.c:undefined reference to `acpi_unregister_lps0_dev'
Message-ID: <202205030623.pq4pdZmb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git review-hans
head:   acbb6b34258ea867c21d47ab53934ef9dbc442a0
commit: a50dfa903391d542025a92c92606425fbccc8323 [31/32] platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of laptops
config: i386-randconfig-a014 (https://download.01.org/0day-ci/archive/20220503/202205030623.pq4pdZmb-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=a50dfa903391d542025a92c92606425fbccc8323
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout a50dfa903391d542025a92c92606425fbccc8323
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: drivers/platform/x86/thinkpad_acpi.o: in function `thinkpad_acpi_module_exit':
>> thinkpad_acpi.c:(.text+0x2722): undefined reference to `acpi_unregister_lps0_dev'
   ld: drivers/platform/x86/thinkpad_acpi.o: in function `thinkpad_acpi_module_init':
>> thinkpad_acpi.c:(.init.text+0x1afd): undefined reference to `acpi_register_lps0_dev'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
