Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14622504E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237372AbiDRJE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbiDRJE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:04:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC3F13D13;
        Mon, 18 Apr 2022 02:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650272540; x=1681808540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2jdWEdOPV9FfJIsbXus10b/k80baSt0ouNesijcKIPg=;
  b=DQ4EZN88jSyrQG7bJwQ+U/dqLG96ZpxQANr0MM4xDmSPzTv4K2kxvjox
   tcM0wf0V9yI52B3971AZsaR2WVX75Ss9DrTBr7vasgOivW5sy9pJkNc5p
   YEu0GdMlIUSMpYQHXClqtS4givymUYWCsrJUgokhBC4GygpXxPs9MxlX6
   pjgnJ11h4kyIWUlQY1q5a6tjXKjUk+7EYYwJeOvytOOj3Wd6PcBueGLni
   5+qaRQLE/e4d7jlMk17k66lMh8o/Bl3RzmAcyKzMx2olDWuMlLtJEd1oS
   rYnPc1zLks9CzU7mMG/K8idn/A/FFJETFeRMdRFS08csrlrXGDjuU/6ns
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="288570713"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="288570713"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 02:02:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="657185625"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 18 Apr 2022 02:02:19 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngNH0-0004Uu-Jn;
        Mon, 18 Apr 2022 09:02:18 +0000
Date:   Mon, 18 Apr 2022 17:01:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Subject: drivers/media/v4l2-core/v4l2-ctrls-request.o: warning: objtool:
 v4l2_ctrl_request_complete()+0xace: stack state mismatch: reg1[14]=-2-32
 reg2[14]=-1+0
Message-ID: <202204181650.mPKQyrSo-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b2d229d4ddb17db541098b83524d901257e93845
commit: 71c689dc2e732d4cb190aaf0edea73116b1611bd media: v4l2-ctrls: split up into four source files
date:   11 months ago
config: x86_64-randconfig-s022-20220418 (https://download.01.org/0day-ci/archive/20220418/202204181650.mPKQyrSo-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=71c689dc2e732d4cb190aaf0edea73116b1611bd
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 71c689dc2e732d4cb190aaf0edea73116b1611bd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/v4l2-core/v4l2-ctrls-request.o: warning: objtool: v4l2_ctrl_request_complete()+0xace: stack state mismatch: reg1[14]=-2-32 reg2[14]=-1+0

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
