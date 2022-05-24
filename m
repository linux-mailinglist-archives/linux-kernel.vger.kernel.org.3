Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC6B753203B
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 03:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbiEXBT7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 21:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbiEXBT4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 21:19:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3322B9729C
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 18:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653355195; x=1684891195;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DaByjJMFPKzxowusLTZLq6+cLWEriYehixqOOltgv50=;
  b=ICuhQoilPthIVL5B9MHwcWF7dFCWTqiaQHTB+SGrEL+o4AxaRXujcsf1
   iwwym4Svf/Ny2vNw9oOcMVfNNc9o1iy2fe8hk86E9Gm37IMLyjyt9MrbG
   7akpFyHA6jOhOE5D3byTLHvD5L8Xjhe1MuW86tSFgsU6fo6hpxmJnzipC
   Xjf4bX1yPr0+xRqZa5Cg9iQuD15pD90EE6IeK1uXpEaqXZcNHvHwMuRzr
   ZBWc5RjbZZRP0b468RvUWcmpyx7bOdzNoK0NdOX9Yj0WSKuIhjnpb9zoT
   zllGq+tPx3MT/YI3BTcqRjyiUjXnmMRCjAlVAOIkUikwRPZo5MQRW8FVp
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273514851"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="273514851"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 18:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="577676883"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 23 May 2022 18:19:53 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntJDF-0001a4-AD;
        Tue, 24 May 2022 01:19:53 +0000
Date:   Tue, 24 May 2022 09:19:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Nicolas Schier <nicolas@fjasle.eu>
Subject: [masahiroy:kbuild 54/64] <command-line>: warning: missing
 terminating " character
Message-ID: <202205240952.93aQKXmM-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git kbuild
head:   193ce6b16e10632abf21c2d756c1c181d6ecdf40
commit: 5255bb025ec27c5fa9acbfb079544920426313ec [54/64] kbuild: link symbol CRCs at final link, removing CONFIG_MODULE_REL_CRCS
config: m68k-randconfig-r021-20220522 (https://download.01.org/0day-ci/archive/20220524/202205240952.93aQKXmM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?id=5255bb025ec27c5fa9acbfb079544920426313ec
        git remote add masahiroy https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git
        git fetch --no-tags masahiroy kbuild
        git checkout 5255bb025ec27c5fa9acbfb079544920426313ec
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> <command-line>: warning: missing terminating " character

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
