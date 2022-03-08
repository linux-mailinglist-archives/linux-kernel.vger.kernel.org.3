Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AE94D1567
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 12:02:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346111AbiCHLDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 06:03:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346192AbiCHLDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 06:03:18 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0712843AED
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 03:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646737342; x=1678273342;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yGk3VWwzO+DOKWQWFeM4kTZHzMtinuGmDIkTdG8JKZY=;
  b=TWDB26ga3MO/Gon3SC76ee7QECZ6jwm5QEoIVl4MSdbdrOCH/4z1Va9z
   05svRcVurvlq1CYOUhdWMIgncdejE+6jjA0Q0vr7JuZ85biWjBgkY4GqF
   sT3xaxzCQQSV3kE50orFD/55PQBe8zcHo7uZbjiLAeYXGAZPGVduPdiRT
   3nzaA/I4Dpz+uK6DLJmv+NeH4gL5X2zggUpCCs/ermLrsJJE8lblPOGNY
   8e0JcYh/JrSRmHS+hEe7xzm6+YjXIMuy0O3yNm6frEHUtr4RHHGfNtwAL
   VlVcqgSCQm41Pq7TUzfPKs0oLEjg/FYdioPIsuZcpRnu8DHPIBf5P9r/Y
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10279"; a="254846918"
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="254846918"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 03:02:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,164,1643702400"; 
   d="scan'208";a="495414133"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Mar 2022 03:02:19 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRXbf-0001Ib-25; Tue, 08 Mar 2022 11:02:19 +0000
Date:   Tue, 8 Mar 2022 19:02:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-lib 50/54] or1k-linux-ld:
 fs/cifs/file.o:undefined reference to `netfs_invalidatepage'
Message-ID: <202203081815.sMaYyDI2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-lib
head:   0a76f6b7563134f15673a1cd5a2ccc2fd6b4c1d0
commit: a80918300e1cb9538bea4a225c7a45fe75f4678a [50/54] netfs: Provide invalidatepage and releasepage calls
config: openrisc-randconfig-r023-20220308 (https://download.01.org/0day-ci/archive/20220308/202203081815.sMaYyDI2-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/a80918300e1cb9538bea4a225c7a45fe75f4678a
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-lib
        git checkout a80918300e1cb9538bea4a225c7a45fe75f4678a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> or1k-linux-ld: fs/cifs/file.o:(.rodata+0x318c): undefined reference to `netfs_invalidatepage'
>> or1k-linux-ld: fs/cifs/file.o:(.rodata+0x3190): undefined reference to `netfs_releasepage'
   or1k-linux-ld: fs/cifs/file.o:(.rodata+0x31e4): undefined reference to `netfs_invalidatepage'
   or1k-linux-ld: fs/cifs/file.o:(.rodata+0x31e8): undefined reference to `netfs_releasepage'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
