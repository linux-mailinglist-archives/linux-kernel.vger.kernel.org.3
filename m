Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49312536625
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 18:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351331AbiE0Qus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 12:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236944AbiE0Quq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 12:50:46 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20D7527E0
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653670245; x=1685206245;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qpWiG3NiBbmtu2hD6PE0bR9/x5uj6GZCYEk7d1gVS50=;
  b=f4pR1ixOIbH/P2OmIGFYsKjunBHZFgZOJgiWlKi31iHOuCCMNhNTbImV
   pgXN+FxHc4Yd3qDfsNM7vYMBwZW5z4w9txtkpm2rHhEBktjJX9a810zq/
   6xcZAB+CdneM2jrEx3iD2f4fk9hKdes28tbgRA1HjTH6YhrYhPDqZAYOD
   f4QLqp7St1b3fP587sYlXZoGcg89ogpo2An0KOBrdztR8ggOKrXI61s2G
   1w3JpLtAVM6iuyB9YKOTl4NLdzR95aNij3+agOeY1GRKb7tR8GWfKXc9B
   JcnxTBX/tNaEjFZTFWx1sf40WCvhjaK8Iin9gjfyupDmm6Ub40wfgEV22
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="299871383"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="299871383"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 09:50:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="643467034"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 27 May 2022 09:50:43 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nudAh-0004wJ-83;
        Fri, 27 May 2022 16:50:43 +0000
Date:   Sat, 28 May 2022 00:50:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.10.y 2383/5950] ld.lld: error: assignment
 to symbol __pecoff_data_size does not converge
Message-ID: <202205280026.wqsKvLJI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
head:   d318333bd3dbc483b4d566521dc6486ef9f6ba04
commit: e3509feb46fa15680a9c8afbcb760e962349c1e2 [2383/5950] tls: fix replacing proto_ops
config: arm64-randconfig-r023-20220527 (https://download.01.org/0day-ci/archive/20220528/202205280026.wqsKvLJI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=e3509feb46fa15680a9c8afbcb760e962349c1e2
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.10.y
        git checkout e3509feb46fa15680a9c8afbcb760e962349c1e2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> ld.lld: error: assignment to symbol __pecoff_data_size does not converge

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
