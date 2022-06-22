Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2E84554705
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242705AbiFVJhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 05:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235328AbiFVJho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:37:44 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E99A03526C
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 02:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655890663; x=1687426663;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lNOiUYFMSmBTQPC4ZUYGORLMEPsA3fg4/q5UVd8n91g=;
  b=S1bh9MhCC3pejsEyRvUZY2JHfTo1SDLP1D2OBg1eoxLXwcuhfqKOXteK
   Qkj1R5iBE3wDzIMiGnVevoRN6i9c8gIhy7K/XYAAxylbyMbMCzX3HIrCt
   0iH6t6w6BS2Y9aIWOr4RtOrLQvE2NlOYhW7I8kuGeQAexmrkHm+qHt0K7
   Hn3qvLljpHEyxbA3P12wGJcMHlKtK4S5zhMDYJNEmjJCpBEWVOw8nyXd/
   IfxKCfIo2ufUeMRvuArIJBnKyUZlWIMxJbFr4OIL7feY5LtJRAvPwxSPX
   AtaCwbrYEYB09TG0oHoIwHGOXLUGOnbq+KF+A6tjT6N6uOTEme6umqgGc
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10385"; a="263404206"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="263404206"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 02:37:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="834024140"
Received: from lkp-server02.sh.intel.com (HELO a67cc04a5eeb) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 22 Jun 2022 02:37:41 -0700
Received: from kbuild by a67cc04a5eeb with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3wnt-000165-33;
        Wed, 22 Jun 2022 09:37:41 +0000
Date:   Wed, 22 Jun 2022 17:36:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Borislav Petkov <bp@suse.de>
Subject: vmlinux.o: warning: objtool: pv_ops[23]: xen_read_msr
Message-ID: <202206221714.98EtuqRm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   ca1fdab7fd27eb069df1384b2850dcd0c2bebe8d
commit: 027bbb884be006b05d9c577d6401686053aa789e KVM: x86/speculation: Disable Fill buffer clear within guests
date:   5 weeks ago
config: x86_64-randconfig-a011-20211126 (https://download.01.org/0day-ci/archive/20220622/202206221714.98EtuqRm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=027bbb884be006b05d9c577d6401686053aa789e
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 027bbb884be006b05d9c577d6401686053aa789e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> vmlinux.o: warning: objtool: pv_ops[23]: xen_read_msr
>> vmlinux.o: warning: objtool: pv_ops[23]: native_read_msr
   vmlinux.o: warning: objtool: vmx_vcpu_enter_exit()+0x5c: call to pv_ops[22]() leaves .noinstr.text section

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
