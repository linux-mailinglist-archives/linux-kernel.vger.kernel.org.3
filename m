Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A4F4BAEB2
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 01:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbiBRA5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 19:57:46 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:33742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbiBRA5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 19:57:42 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2C140E5D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645145847; x=1676681847;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ztzUOW22oLnT0d2JO7N08+27j808mv5pBQ4SXPYWx7s=;
  b=YOaMtrC57a7WQpy+zIBGh3ZiwWSCLoGpWfKxZ/ep4wm0rbJKnAH7qxWs
   dr5frxiL8jqz3LfF41qmerni0W4b5JMiWSGIzY9P8NJMEkojlSfQ5cU2v
   KkI1XpDfK+tSszaBvvChSw1RWQ4YMB/kOAJby0zhPR/uWmZ9DePVToSlB
   ujcaimv8KgvmLDK52ChT+e1kTKiuDBjbrDrDJFaXLFmml4GRfXEohU9Th
   bjZdu1VAc5hMmJ8MwVkH8GWEScbTDhZtEoWFLxU6+JxKMdzHpONQF3bCV
   1uPI3dMuTPcqgOzM8SlKdkZ6eTvTqnspK0uYtTJYmKhzkqcEHWSDlsa3F
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234548335"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="234548335"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 16:55:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="705120840"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Feb 2022 16:55:08 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKrYB-0000mV-Bl; Fri, 18 Feb 2022 00:55:07 +0000
Date:   Fri, 18 Feb 2022 08:54:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 21/24]
 arch/x86/kernel/cpu/mce/mce-inject.lto.o: warning: objtool:
 raise_exception()+0x3a: relocation to !ENDBR: raise_exception+0x0
Message-ID: <202202180821.qTaKh9tL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   20f0cd68b8d42470e0a0459aa5db23d7dae8f83d
commit: 885519698e96a729a44a35f71f898d52b11704d7 [21/24] x86/alternative: Use .ibt_endbr_sites to seal indirect calls
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220218/202202180821.qTaKh9tL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=885519698e96a729a44a35f71f898d52b11704d7
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout 885519698e96a729a44a35f71f898d52b11704d7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/mce/mce-inject.lto.o: warning: objtool: raise_exception()+0x3a: relocation to !ENDBR: raise_exception+0x0
>> arch/x86/kernel/cpu/mce/mce-inject.lto.o: warning: objtool: toggle_hw_mce_inject()+0x36: relocation to !ENDBR: toggle_hw_mce_inject+0x0
>> arch/x86/kernel/cpu/mce/mce-inject.lto.o: warning: objtool: raise_poll.isra.0()+0x34: relocation to !ENDBR: raise_poll.isra.0+0x0
>> arch/x86/kernel/cpu/mce/mce-inject.lto.o: warning: objtool: setup_inj_struct.constprop.0()+0x2f: relocation to !ENDBR: setup_inj_struct.constprop.0+0x0

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
