Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28F54593B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 02:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239915AbiFJAnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 20:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233015AbiFJAm6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 20:42:58 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184BB16A257
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 17:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654821777; x=1686357777;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=rWhfylLhTdHfECz+Smvw4/j6KhgdNpNaJiiJ/Dah9kw=;
  b=kuUxfNPCNY2jLkxwBn3/iCxik24V44HFh2Mx1Q6tHWev96YJKFTKjUMN
   wDp83XYNpKqc9e9yBbnlhqfrFH2UG44lEoKADVeYkyz3o+6Pgb0bcjDEI
   Sc8MS+VT13yndRqDaUm/4PbGYItqu3KsFop0bGBH1TLFR3zDhNnI4VpAl
   PMhnzp19FVRlkl8F+PUeLbanmVUo7W5Te4a0UFNCH41eC7JckRyyHEcyf
   l05b1jh03Azbn6XTzPrQDJo/SqqFTRTlOwwZyibOmSrQjVW5xUjEHJtD4
   p72/roSLJVzGWksZR19DNLmZmsOTzOIu6AuFQJ1ubjvoMVsyXIA8Z6Awj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="302841480"
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="302841480"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 17:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="684256660"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 Jun 2022 17:42:54 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzSjl-000GX3-R0;
        Fri, 10 Jun 2022 00:42:53 +0000
Date:   Fri, 10 Jun 2022 08:42:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sumit Saxena <sumit.saxena@broadcom.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>
Subject: {standard input}:3978: Error: value 178 out of range
Message-ID: <202206100855.uY63FJUH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   6bfb56e93bcef41859c2d5ab234ffd80b691be35
commit: 43ca110050988c7a0e581d24ce212ef34a4cdf29 scsi: mpi3mr: Add support for PEL commands
date:   5 weeks ago
config: m68k-randconfig-r036-20220608 (https://download.01.org/0day-ci/archive/20220610/202206100855.uY63FJUH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=43ca110050988c7a0e581d24ce212ef34a4cdf29
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 43ca110050988c7a0e581d24ce212ef34a4cdf29
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   {standard input}: Assembler messages:
>> {standard input}:3978: Error: value 178 out of range
>> {standard input}:3978: Error: value of 178 too large for field of 1 byte at 00000fdb

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
