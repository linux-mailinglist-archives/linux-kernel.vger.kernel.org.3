Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6144B504D9E
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbiDRITJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:19:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237162AbiDRIS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:18:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF16167D7
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650269780; x=1681805780;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=HhabDmKUYhR3M9i0ABzglswosSWuM51y/vywBMjtLh8=;
  b=cWqmFPTETiF5Q1/SbVC/WXYTqUG8+whGUl/1OLAZJG/zgjGEupMLwB1L
   wadPsSl+CfgxZRhPCnSWPi6KULlrc6WS9a9iMEauU7JCS8riauNyjQ8eB
   +ksYs4l5hpxIlMqpfUstI/+T8YDxtHr+hsXKUL+99ZBtBfEcFfd7WU/Eb
   /+P0qojjqloDKQHMEWZQAxagTxO91YWoFFJTFUit5i/HFKibH1EIJbbNZ
   OG8TqzKBw290qGK6ITRALJJ+UZwV5/zMhsPidTiZ3mkkXjyEq4DOfHV/m
   6/tZE+uS1n0HIuCpijZiT35qsiptleXFsCJDKv95Js/o57PD0jLzc2c+y
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10320"; a="326378389"
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="326378389"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 01:16:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,269,1643702400"; 
   d="scan'208";a="561266990"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 18 Apr 2022 01:16:18 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngMYT-0004TJ-E9;
        Mon, 18 Apr 2022 08:16:17 +0000
Date:   Mon, 18 Apr 2022 16:15:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.17.y 1421/1518] net/sunrpc/clnt.o: warning:
 objtool: call_status()+0x1ff: unreachable instruction
Message-ID: <202204181602.Rg1OlNQX-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   77b5472d00d158866e2e1d03c13862b428b65405
commit: 474acfab325817d190709a03db7df6abfe7972f8 [1421/1518] SUNRPC: Handle ENOMEM in call_transmit_status()
config: x86_64-randconfig-m031-20220418 (https://download.01.org/0day-ci/archive/20220418/202204181602.Rg1OlNQX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=474acfab325817d190709a03db7df6abfe7972f8
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.17.y
        git checkout 474acfab325817d190709a03db7df6abfe7972f8
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sunrpc/clnt.o: warning: objtool: call_status()+0x1ff: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
