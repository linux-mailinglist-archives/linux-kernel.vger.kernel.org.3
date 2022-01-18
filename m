Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A97F64930AA
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 23:26:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349915AbiARW0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 17:26:12 -0500
Received: from mga06.intel.com ([134.134.136.31]:51665 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349010AbiARW0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 17:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642544771; x=1674080771;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Cjrw5Z+iymYtk4MMZO2oN6/rUOR0Diz7SeqyfSxZymk=;
  b=ldWJggYifhXtCwtlhFXi2qTE2FUeEauwYT+yOkB2KkDyYNfXbW8OEZ2e
   VBsigVlsSGX6L0AaII1+csEP1TMIMVHHSRbZMgdklhc1diobN6LjO5Bmq
   c3/3g8hZ6WJmIZ1Jj4Fb++i+EdmYlSyROfmNBfAfs0qaQuz7x6s7IDjQi
   DhCT2eDjM8gGQJJEIOLHtQu2ojVTdMVJ+KF9YCZvRj66lRmoyiAssPxXX
   3Usx2jV/nFted+n9yupL4Bnhx0ISOmZc4cFY6chNw58tKKSV1IG6yTVfn
   AOtz+qcS7rSO2XkXU0tKBvt7uh9QWiEFH87HaioGvD/K/Lnb7YVHXp8aI
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="305658919"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="305658919"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 14:26:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="517937471"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jan 2022 14:26:10 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9wvZ-000D0L-NA; Tue, 18 Jan 2022 22:26:09 +0000
Date:   Wed, 19 Jan 2022 06:25:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [jpoimboe:objtool-test 1/1] drivers/media/mc/mc-request.o: warning:
 objtool: media_request_object_complete()+0xa4: unreachable instruction
Message-ID: <202201190632.lhlaiCBk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git objtool-test
head:   14d7c68274f2a17d5734c87971f08cd08cf862c6
commit: 14d7c68274f2a17d5734c87971f08cd08cf862c6 [1/1] objtool: prefer memory clobber & %= to volatile & __COUNTER__
config: x86_64-rhel-8.3 (https://download.01.org/0day-ci/archive/20220119/202201190632.lhlaiCBk-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=14d7c68274f2a17d5734c87971f08cd08cf862c6
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-test
        git checkout 14d7c68274f2a17d5734c87971f08cd08cf862c6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/ mm//

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/mc/mc-request.o: warning: objtool: media_request_object_complete()+0xa4: unreachable instruction

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
