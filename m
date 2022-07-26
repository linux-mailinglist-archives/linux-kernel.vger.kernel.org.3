Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76D7A581923
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239807AbiGZRvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239796AbiGZRuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:50:54 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE8BE3123E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658857848; x=1690393848;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vSbdmjT9LbX1plGERgwJfPBA1jyD+pUvPFiediiw5TQ=;
  b=QZXdPY1ia4o542WmiuwaKoqQbH7X3XdHGaDqHTgwg3+bilZbdAc5uYis
   O+I21WNJqlQjHDCsPc3PnvRkMMhZfoMgdhZg+qZesgOI5jwDSpc2wi41g
   thp50SB5tM37z1uo8n27MuNs6O6Cvr4u7Tmhu2k/ZR1DHsGDW0ewyMKnF
   KjBUwB5BKJ2t4NXYTH4+AOQXjKqD9oao9iS0k3vZB/efUhx4hRyIZ2bOV
   r0+MewC0rJ4WREV4mqtiWa8b1cUy3iYn7CrH98ltcTh/iFN0QO5YT20gV
   PqJkVYVcd1kx2svUeK++Rfek7EkUngQjZzmfe3xAXn3+CTy4wYqBE1fJl
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="271055955"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="271055955"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 10:48:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="575588734"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2022 10:48:49 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGOfo-0007Nu-31;
        Tue, 26 Jul 2022 17:48:48 +0000
Date:   Wed, 27 Jul 2022 01:47:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vadim Fedorenko <vadfed@fb.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Lemon <jonathan.lemon@gmail.com>
Subject: ERROR: modpost: "crc16" [drivers/ptp/ptp_ocp.ko] undefined!
Message-ID: <202207270138.suzGpzQF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   e0dccc3b76fb35bb257b4118367a883073d7390e
commit: 3c3673bde50c31d1f5ab0b39e9eeb555285786bb ptp: ocp: Add firmware header checks
date:   9 weeks ago
config: csky-buildonly-randconfig-r003-20220724 (https://download.01.org/0day-ci/archive/20220727/202207270138.suzGpzQF-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c3673bde50c31d1f5ab0b39e9eeb555285786bb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3c3673bde50c31d1f5ab0b39e9eeb555285786bb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "crc16" [drivers/ptp/ptp_ocp.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
