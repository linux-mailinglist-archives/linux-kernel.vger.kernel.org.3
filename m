Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 228F14A7CA5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348439AbiBCASj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:18:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:5723 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231139AbiBCASh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:18:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643847517; x=1675383517;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2V7WLsE4s918o+I//9rNfEzJ+J9+iEhI0GaFW6TGdDk=;
  b=GoAMik7OGtaJwStNj0lN0XmOtSdey3ipbNwH0odrNG62lCBNnRGPvHup
   TQcW66QBinBQIF0VZCv0smbGtEfr1dOiu8oyGFsSblLP55gTbbvpTlGQ6
   OGFIknxaUMl8cVOBKh/3AYc6m6RNpAt792UEkyNMForx98O2Vha9QQygC
   LWaf8W0MFv6DpOggxDsLh4dHjkavkfrG2pauGA9V76bVyng/Dd4vNJeHf
   sgtpkRQN53vb3e17IJ/FuIAaua9OViGG2lyEz2GjoxrUFL3qv+n7EelIf
   pyde+30t3oGyw31n5102/5blRacebUJ9HRIjFA1Yh7/iwl1VTT661tMow
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="311352324"
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="311352324"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 16:18:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,338,1635231600"; 
   d="scan'208";a="676614833"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Feb 2022 16:18:35 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFPpa-000VJV-CO; Thu, 03 Feb 2022 00:18:34 +0000
Date:   Thu, 3 Feb 2022 08:18:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kris Van Hees <kris.van.hees@oracle.com>,
        Tomas Jedlicka <tomas.jedlicka@oracle.com>,
        Eugene Loh <eugene.loh@oracle.com>,
        David Mc Lean <david.mclean@oracle.com>,
        Vincent Lim <vincent.lim@oracle.com>
Subject: [oracle-dtrace:v2/5.17-rc2 8/10] <stdin>:1565:2: warning: #warning
 syscall waitfd not implemented
Message-ID: <202202030843.Dam4hL3o-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/oracle/dtrace-linux-kernel v2/5.17-rc2
head:   28b391e36df8679828aedd18dae0ee5526512d4d
commit: 83f02cf9b0ce18b6a27d34c6a25933791779e807 [8/10] waitfd: new syscall implementing waitpid() over fds
config: s390-allyesconfig (https://download.01.org/0day-ci/archive/20220203/202202030843.Dam4hL3o-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/oracle/dtrace-linux-kernel/commit/83f02cf9b0ce18b6a27d34c6a25933791779e807
        git remote add oracle-dtrace https://github.com/oracle/dtrace-linux-kernel
        git fetch --no-tags oracle-dtrace v2/5.17-rc2
        git checkout 83f02cf9b0ce18b6a27d34c6a25933791779e807
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=s390 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> <stdin>:1565:2: warning: #warning syscall waitfd not implemented [-Wcpp]
--
>> <stdin>:1565:2: warning: #warning syscall waitfd not implemented [-Wcpp]
--
   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
>> <stdin>:1565:2: warning: #warning syscall waitfd not implemented [-Wcpp]

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
