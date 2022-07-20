Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFC5257B49D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 12:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238610AbiGTKke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 06:40:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238378AbiGTKk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 06:40:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42CDF2A72D
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 03:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658313628; x=1689849628;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2Be84nfHoamYk4O88e44NC5hzJgWZE5PhyB/bLBJjlk=;
  b=RyD31ClmJRN+JaDGGgvBDBGxa0ZEgPtBhCHH8X22B1Yn4eVOgJ+TT/Q0
   jDBKGJog54dwEnNeO/FUaSrw9FIqUy08ZzORIn7cmrbyCrUz1vG+IKMcT
   vW9SkjwGd8o5bVFyP2rK5zO4G/PIcdqyJQDUhN0dRBdH2figvdAzHboVy
   GXdyENRoSJUC5PUlym9bbObfbDMKQqpxt9zigDdFC4BZ6DcgDfiE/ggBq
   MVG6O3PJVDqzZwg/3uPAUwhygNuWXbpMtoNCKNj2t9qwOrIQefcTlRGOk
   tT8zuzoTh4mju5ovk2ZpR5v7g64JOM055O2nLimnBi2fEef4hMKHKejRV
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="312435317"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="312435317"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 03:40:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="665811561"
Received: from lkp-server01.sh.intel.com (HELO 7dfbdc7c7900) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Jul 2022 03:40:26 -0700
Received: from kbuild by 7dfbdc7c7900 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oE77x-0000Ol-DM;
        Wed, 20 Jul 2022 10:40:25 +0000
Date:   Wed, 20 Jul 2022 18:39:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [jpoimboe:lkdtm 3/3] <instantiation>:2:2: error: invalid instruction
 mnemonic 'annotate_unret_end'
Message-ID: <202207201802.x51rFnWQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git lkdtm
head:   52f6baa0ba22720e50aae086637b5b032fdea58a
commit: 52f6baa0ba22720e50aae086637b5b032fdea58a [3/3] objtool: move retpoline and unret annotations to objtool.h
config: i386-buildonly-randconfig-r004-20220718 (https://download.01.org/0day-ci/archive/20220720/202207201802.x51rFnWQ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fa0c7639e91fa1cd0cf2ff0445a1634a90fe850a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=52f6baa0ba22720e50aae086637b5b032fdea58a
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe lkdtm
        git checkout 52f6baa0ba22720e50aae086637b5b032fdea58a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> <instantiation>:2:2: error: invalid instruction mnemonic 'annotate_unret_end'
    ANNOTATE_UNRET_END
    ^~~~~~~~~~~~~~~~~~
   arch/x86/kvm/svm/vmenter.S:120:2: note: while in macro instantiation
    UNTRAIN_RET
    ^
>> <instantiation>:2:2: error: invalid instruction mnemonic 'annotate_unret_end'
    ANNOTATE_UNRET_END
    ^~~~~~~~~~~~~~~~~~
   arch/x86/kvm/svm/vmenter.S:209:2: note: while in macro instantiation
    UNTRAIN_RET
    ^

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
