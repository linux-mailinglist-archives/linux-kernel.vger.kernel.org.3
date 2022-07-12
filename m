Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFC75726F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 22:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233944AbiGLUIN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 16:08:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234527AbiGLUHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 16:07:46 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F5BB8E84
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657656454; x=1689192454;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I4PtPocbbHJsmVqeSdj0j+ww60VTiKmwmGpsonHY+Qs=;
  b=KhlrctMK0SzW9opETbQH2dF2pgG9aACUNpgGlusXXHarmCKRR+AQb/ct
   bfJ5LlR4nJeEJw/MspbSTODurJ7QUJntz5Se9kYOPMMveDO/zsUYw/Lup
   EAg3hljc2z6pKXUdQ1Eb8ArCVYZNRhEROjowlNQferm8pXmuom7d26vhS
   6xerM9wl0wsaHQ8cyisu52TkzcNs/GyGOdm2cWslHAsPMFDBRxIuC8ZZu
   /WEPGObnzSbySbIVAEXvw11r4B11beEfbR6zRx0B71TlsSikXJ1Oor4dj
   N86ltPAw/L7WXOBCO5S7O4adifo/eb5wUEUeRoZmPPdR9kNPDmiB8STP2
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285058342"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="285058342"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 13:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="737608261"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2022 13:07:32 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oBMAN-0002ei-HF;
        Tue, 12 Jul 2022 20:07:31 +0000
Date:   Wed, 13 Jul 2022 04:07:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Ben Hutchings <bwh@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 7109/7120]
 arch/x86/kernel/cpu/bugs.c:57:21: warning: section attribute is specified on
 redeclared variable
Message-ID: <202207130344.AUqExE4E-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   ba398a0e54049bb6a1c102245ae84103f103ff2c
commit: 855b78ccf1c8c952e148bdbd234cde117b098060 [7109/7120] KVM: VMX: Prevent guest RSB poisoning attacks with eIBRS
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220713/202207130344.AUqExE4E-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project badda4ac3c489a8c8cccdad1f74b9308c350a9e0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=855b78ccf1c8c952e148bdbd234cde117b098060
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout 855b78ccf1c8c952e148bdbd234cde117b098060
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/kernel/cpu/bugs.c:57:21: warning: section attribute is specified on redeclared variable [-Wsection]
   DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
                       ^
   arch/x86/include/asm/nospec-branch.h:278:12: note: previous declaration is here
   extern u64 x86_spec_ctrl_current;
              ^
   1 warning generated.


vim +57 arch/x86/kernel/cpu/bugs.c

c40221c4c496c5 Peter Zijlstra 2022-06-14  55  
c40221c4c496c5 Peter Zijlstra 2022-06-14  56  /* The current value of the SPEC_CTRL MSR with task-specific bits set */
c40221c4c496c5 Peter Zijlstra 2022-06-14 @57  DEFINE_PER_CPU(u64, x86_spec_ctrl_current);
c40221c4c496c5 Peter Zijlstra 2022-06-14  58  EXPORT_SYMBOL_GPL(x86_spec_ctrl_current);
c40221c4c496c5 Peter Zijlstra 2022-06-14  59  

:::::: The code at line 57 was first introduced by commit
:::::: c40221c4c496c5c026ede111094a96f292875d88 x86/bugs: Keep a per-CPU IA32_SPEC_CTRL value

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
