Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87AEE595220
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 07:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiHPFi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 01:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiHPFic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 01:38:32 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20F97246B45
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 15:23:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660602238; x=1692138238;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=FXryyt/DzXagtUJjqOEw7kVEiJDuLF8vDTAnQ7k6dQg=;
  b=Mss68K53KUEfrIXC640dEG2yxqXCEPBN+WDzwoYTyQxct6Kl5w50mmm6
   4qmHdSO7jKMTF2j753H/vqFjzAVuMiUIEiW5UPs+oLuoGlWCph0b9Q08y
   ZT2I4WRdYLbphyizwkzks195HF1uEx1rcUa5XaLLm7Wz0fWj3RTpa0+ZO
   GpIoJBjwmJl8oym4jwNjK9YP56PWYixDe9Xq26QTKpGVlah7ITEO9FT2Y
   LE69sKVurGdXEupvvZpnVRVtrXVOFNPa+aSfVajqKSe2wpfM4eZdnoeDw
   dJRPvjX2acRTA8LHX8kiOP+nMZySkrb4JzBpOothG/0WJYSFczU7Ppgdz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="272461929"
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="272461929"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2022 15:23:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,239,1654585200"; 
   d="scan'208";a="557461170"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 15 Aug 2022 15:23:40 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNiUm-0001Fh-0D;
        Mon, 15 Aug 2022 22:23:40 +0000
Date:   Tue, 16 Aug 2022 06:23:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [kuba:gnl-gen-dpll 4/133] make[2]: *** No rule to make target
 'samples/test.o', needed by 'samples/built-in.a'.
Message-ID: <202208160654.5mUqH9OO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakub,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git gnl-gen-dpll
head:   fe9b39bc400264b4403591191c918670b7766de9
commit: 251874fe8b49d1a25d613ac8ecf34b249ce3e573 [4/133]  === samples hook in for build test
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220816/202208160654.5mUqH9OO-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git/commit/?id=251874fe8b49d1a25d613ac8ecf34b249ce3e573
        git remote add kuba https://git.kernel.org/pub/scm/linux/kernel/git/kuba/linux.git
        git fetch --no-tags kuba gnl-gen-dpll
        git checkout 251874fe8b49d1a25d613ac8ecf34b249ce3e573
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> make[2]: *** No rule to make target 'samples/test.o', needed by 'samples/built-in.a'.
   make[2]: Target '__build' not remade because of errors.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
