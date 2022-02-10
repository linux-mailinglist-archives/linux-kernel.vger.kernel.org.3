Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293AC4B075B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:40:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236188AbiBJHke (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:40:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbiBJHkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:40:32 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18965C58
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:40:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644478834; x=1676014834;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=n//t7XZMeuDZe62L24ZMaPvnh63qMME96jGLOtXKSJo=;
  b=j7q005oK6LtJdl7dmsZFpFnoE+xKlGJ0wZu9lz3zPmqbqtcMwgVF/Py+
   OY+2e6/lMe+iyoGTOVppJ9rar+K+C16WkiMlI+O28U70+kdQ1Vyb3tPfV
   E49BYzzoUqWWcuSMlNX9q58vLuIriT20ffp+JN3/MKwNcWwV8Re/JmeCM
   yS6m9EPTI19heUCRJmILaxqoKYu75/X8afeU4uH7/Y+JhOoS0iLh9lQzo
   QGy7l77EYnoh590XfAdtsrIcSwtHHaA+7dzp0AfbAwO60NN5/vi5hrsl1
   OLZ+URujm4rAU5eB2IqLLiKS/YkJmciQ4GaYW0J0XWkfLtniGHRtggK9b
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10253"; a="236835974"
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="236835974"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 23:40:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,358,1635231600"; 
   d="scan'208";a="568550587"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 09 Feb 2022 23:40:32 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nI447-0002tb-SN; Thu, 10 Feb 2022 07:40:31 +0000
Date:   Thu, 10 Feb 2022 15:39:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: ERROR: start_text address is c000000000000200, should be
 c000000000000100
Message-ID: <202202101513.Vx63VlKa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   f4bc5bbb5fef3cf421ba3485d6d383c27ec473ed
commit: 3091f5fc5f1df7741ddf326561384e0997eca2a1 powerpc: Mark .opd section read-only
date:   4 months ago
config: powerpc64-randconfig-r026-20220210 (https://download.01.org/0day-ci/archive/20220210/202202101513.Vx63VlKa-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3091f5fc5f1df7741ddf326561384e0997eca2a1
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3091f5fc5f1df7741ddf326561384e0997eca2a1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ERROR: start_text address is c000000000000200, should be c000000000000100
   ERROR: try to enable LD_HEAD_STUB_CATCH config option
   ERROR: see comments in arch/powerpc/tools/head_check.sh

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
