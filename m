Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60DAC54B24B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 15:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243865AbiFNN3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 09:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbiFNN3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 09:29:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D55FE2AE39
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655213373; x=1686749373;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jTqFsXRfitKtKnuAkwXzxEPVoLVF4jMu1V8Kw1EFBbI=;
  b=LCPIifIX5o5JVyra5sSZTi4cpkSuON+eMGcGK2dkGTaK/tkKjpXruLHC
   EKoRvmuA6NcrPrydHUKOVbeki+6amqkfcUUv7hhZmanpcSLfjOsKiL6GY
   tStDqJ1MkB8TK1TpK8reg6VsvWYb1ynpeyV9dzulGnRpjCf7TNNoE8tan
   C4oIS+JuB7ezsSvtkqUg6RG369+g3QHuxDn+nXr5CDnfN9oitsGmm0hrT
   b3znQ0VUHBLKmfceDpphaq3gEmjGjmubRToVDHF8bvfGGZ95kG6jVgjBJ
   Mf6SNUfgsJMF5tuSoKwKsM/VqCkXvo3KP7mVZC+55cMMc0fcDyTj48/rV
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="277400922"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="277400922"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 06:29:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="830420337"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2022 06:29:32 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o16br-000Lvp-Lw;
        Tue, 14 Jun 2022 13:29:31 +0000
Date:   Tue, 14 Jun 2022 21:28:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.17.y 1421/3797] net/sunrpc/clnt.o: warning:
 objtool: call_status()+0xb4: unreachable instruction
Message-ID: <202206142140.F2fOdQ8W-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trond,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   a554a1e2ef7fa48cebd9cc2349804974247c0958
commit: 474acfab325817d190709a03db7df6abfe7972f8 [1421/3797] SUNRPC: Handle ENOMEM in call_transmit_status()
config: x86_64-randconfig-r026-20220613 (https://download.01.org/0day-ci/archive/20220614/202206142140.F2fOdQ8W-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=474acfab325817d190709a03db7df6abfe7972f8
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.17.y
        git checkout 474acfab325817d190709a03db7df6abfe7972f8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/ net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sunrpc/clnt.o: warning: objtool: call_status()+0xb4: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
