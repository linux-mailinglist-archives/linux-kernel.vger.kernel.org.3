Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C93C48DD3B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237300AbiAMRyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:54:03 -0500
Received: from mga04.intel.com ([192.55.52.120]:56047 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237294AbiAMRyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:54:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642096441; x=1673632441;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=anwbGOwUqWm9dgBbc9TyuljhzmOu701hmgbce8U2ZsY=;
  b=c2Kg/mUi+clmZd6LFkKze0SD3HoA5bcnWRgJfDYvnGTOIf8HclgzDJFs
   bSDHKYawt5WYM8SXAJnTAo9+cfyc2wCQ3AkGwU3FsVA8GqSuGMTzQ9W99
   mGUoDM+D5pIxbKUWZjjdSf4NWWoBE6R1Oe25ELYDkPiyq60FHukArjHCW
   SjI6OMLCFMazAG2J7xx96H/CGFVPbTd9aastZu+dWf1UGbAS60v+fSDwC
   WbSCVSZRQKGuCz7Y+tcpvBgKPXSJqlLIO0r4PjlTPhEQtSg1HaDRapiAV
   RorsJM+SL82ZnuPWqKX1nvpsQ2xxNkXF8XmCzrzdGpY6N0ruJs+2vQYuO
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="242890488"
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="242890488"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 09:54:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,286,1635231600"; 
   d="scan'208";a="559187142"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jan 2022 09:53:59 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n84IQ-0007Vl-L6; Thu, 13 Jan 2022 17:53:58 +0000
Date:   Fri, 14 Jan 2022 01:53:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Maxim Kiselev <bigunclemax@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>, Maxim Kochetkov <fido_max@inbox.ru>
Subject: Error: arch/powerpc/boot/dts/fsl/t1040rdb.dts:112.1-9 syntax error
Message-ID: <202201140142.ayjm3jMQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220112-013848/Maxim-Kiselev/powerpc-dts-t1040rdb-fix-ports-names-for-Seville-Ethernet-switch/20211230-184411
head:   50f019b2ff409796f96cd749ecd816ff18575d8b
commit: 50f019b2ff409796f96cd749ecd816ff18575d8b powerpc: dts: t1040rdb: fix ports names for Seville Ethernet switch
date:   2 days ago
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220114/202201140142.ayjm3jMQ-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/50f019b2ff409796f96cd749ecd816ff18575d8b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220112-013848/Maxim-Kiselev/powerpc-dts-t1040rdb-fix-ports-names-for-Seville-Ethernet-switch/20211230-184411
        git checkout 50f019b2ff409796f96cd749ecd816ff18575d8b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> Error: arch/powerpc/boot/dts/fsl/t1040rdb.dts:112.1-9 syntax error
   FATAL ERROR: Unable to parse input tree

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
