Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843AD59B0D8
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 00:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232243AbiHTWv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiHTWvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 18:51:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD4B25280
        for <linux-kernel@vger.kernel.org>; Sat, 20 Aug 2022 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661035912; x=1692571912;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t4tzbo4+8HLrYmz8hi3iCDZQ0UQ20jJ0F9wgnUo/Mxs=;
  b=M6F/VbSoNNixBHMVmPIsD1QF1fXZjHF2zdzzHYl4BIB27b2btuZ+shqc
   n+l/3atihAjy/ezk0DJNzkUjMn6Gmttg+6inq1mr+O+IVmETZMGTKvXaX
   Q+9asNCRaFqoyCkArCHFK9MhCa2wgfYt4uu6Hx6nqPeySHJnaptPMwR1f
   UMmYQCD9PXD47FNmEBoCXZmRj4603hsagPAMry1NW4CINdP98Z1y1c7EG
   BC6SCmevskcytYl6SoOV/QbsBZaIFpeC+2F8JkUDv1Es0FysbUz+uPJQs
   Da2VeozkJOBg7YuvuaaumP5yfSI03NzALxcQtKTz7hNn+1lDHoTNHRiO7
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10445"; a="290765990"
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="290765990"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2022 15:51:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,251,1654585200"; 
   d="scan'208";a="641610349"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 20 Aug 2022 15:51:18 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPXJF-0003JH-2N;
        Sat, 20 Aug 2022 22:51:17 +0000
Date:   Sun, 21 Aug 2022 06:50:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/4.14 13/175] Makefile:877: *** Recursive
 variable 'LDFLAGS' references itself (eventually).  Stop.
Message-ID: <202208210645.72NkUj0g-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.14
head:   ed8a2f4d20af62ebd64e4092d988d4ae6b54657c
commit: 17c47886b521ae64a733f41364def799797e45ef [13/175] Makefile: link with -z noexecstack --no-warn-rwx-segments
config: arc-randconfig-r043-20220821 (https://download.01.org/0day-ci/archive/20220821/202208210645.72NkUj0g-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=17c47886b521ae64a733f41364def799797e45ef
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.14
        git checkout 17c47886b521ae64a733f41364def799797e45ef
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Makefile:877: *** Recursive variable 'LDFLAGS' references itself (eventually).  Stop.


vim +/LDFLAGS +877 Makefile

   875	
   876	LDFLAGS	+= -z noexecstack
 > 877	LDFLAGS	+= $(call ld-option,--no-warn-rwx-segments)
   878	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
