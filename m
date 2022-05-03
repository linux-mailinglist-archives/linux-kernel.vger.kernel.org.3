Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4122518340
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 13:27:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234678AbiECLbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 07:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234304AbiECLbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 07:31:14 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B002BB17
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 04:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651577262; x=1683113262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=k5RUg84TUBdlu3zGS+l5yBOMgpcD0Nl/EHhX7lT8LCc=;
  b=nku2pusx2p9YBETeYoOV8/PdWPaXtZAox8DPi+3YsdQcgh9vJTzjJSEx
   X702/pQtG4U7MLYF7mXaH9XjHu+B6mci/EX+3uAlQIZrDXe/mXBDU+FsK
   hVtmaiXk7dq0KHagNkqACawPcsCZf+QicgbivWrTm9X64ahlMeJ74rX4a
   AEMaEeXseTxfXEZMTy2rda3houtN0djjUjs3QZ+wEBX9dcZqfWnWu3nR6
   EdFQUQ0HdOLvLYeuYkSPchUjVNxkIJsXX66ed1uKX9AnLSEMKhcfjnXBM
   Mh/ic0qK/h2imJfwxBQMZXciyC/+flcmhgnvOxjDVJPsYHLM8jr3LaRS/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10335"; a="327996101"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="327996101"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 04:27:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="663942942"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 03 May 2022 04:27:40 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlqgt-000APj-Te;
        Tue, 03 May 2022 11:27:39 +0000
Date:   Tue, 3 May 2022 19:27:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [pdx86-platform-drivers-x86:review-hans 30/32]
 drivers/platform/x86/thinkpad_acpi.c:317:20: sparse: sparse: symbol
 'quirk_btusb_bug' was not declared. Should it be static?
Message-ID: <202205031944.EP1ElC1B-lkp@intel.com>
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
commit: 25eecc2ff6ccf1115b348983a6c306517727b67a [30/32] platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220503/202205031944.EP1ElC1B-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/commit/?id=25eecc2ff6ccf1115b348983a6c306517727b67a
        git remote add pdx86-platform-drivers-x86 https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git
        git fetch --no-tags pdx86-platform-drivers-x86 review-hans
        git checkout 25eecc2ff6ccf1115b348983a6c306517727b67a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/platform/x86/thinkpad_acpi.c:317:20: sparse: sparse: symbol 'quirk_btusb_bug' was not declared. Should it be static?

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
