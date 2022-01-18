Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A0549312E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 00:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350210AbiARXGO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 18:06:14 -0500
Received: from mga11.intel.com ([192.55.52.93]:49456 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350213AbiARXGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 18:06:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642547173; x=1674083173;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=iijlZoQHVdR8sorfGuiRd8FaFRL2pIM3YpLo49cDPpc=;
  b=DEayYNI/NS2GGyche1MbvE8JeKTfM+pzr8tWkbnR3BnbuxX80rrsxNhR
   FXu7E4Y0dtAtZFJuWv77jYaQ6W8g58cmKC9Pi9Y7dbW8QgH+KF3WWbOOU
   YC9mDrVthuTxHhwE1WiRHdThEIFfzAZwQXBApCJXgg7iyc8tJxpFKYkHY
   1MJZ5kdYNkIII5BMbaRYJ3WZ/TlCBi04zn2ywEBTVD6kT8fczvLxtsu81
   pfUcq8OF+edTzIy2o9F5m23XK2k3K4tyFSx22JMQfbCQzduM03BZJSUuk
   N1KhTTsWf3AtJcE9+BX5Sun1RJLBQ3qFWo7f85JnfDjDQSiY5XyHj3G0Z
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10231"; a="242497168"
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="242497168"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2022 15:06:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,298,1635231600"; 
   d="scan'208";a="693563062"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Jan 2022 15:06:11 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9xYI-000D1c-Fh; Tue, 18 Jan 2022 23:06:10 +0000
Date:   Wed, 19 Jan 2022 07:05:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [jpoimboe:objtool-test 1/1] drivers/net/wireless/mac80211_hwsim.o:
 warning: objtool: mac80211_hwsim_tx()+0xbe2: unreachable instruction
Message-ID: <202201190702.XNSXrMTK-lkp@intel.com>
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
config: x86_64-rhel-8.3-func (https://download.01.org/0day-ci/archive/20220119/202201190702.XNSXrMTK-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git/commit/?id=14d7c68274f2a17d5734c87971f08cd08cf862c6
        git remote add jpoimboe https://git.kernel.org/pub/scm/linux/kernel/git/jpoimboe/linux.git
        git fetch --no-tags jpoimboe objtool-test
        git checkout 14d7c68274f2a17d5734c87971f08cd08cf862c6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/net/wireless/mac80211_hwsim.o: warning: objtool: mac80211_hwsim_tx()+0xbe2: unreachable instruction

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
