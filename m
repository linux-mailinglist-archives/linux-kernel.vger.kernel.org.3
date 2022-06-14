Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8CB54B502
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236131AbiFNPpm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231560AbiFNPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:45:40 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0616B3EB86
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655221539; x=1686757539;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=aha0M2DBGkt3SwXwfkSyWyj964EiPGmfaZ4O8LS2g/o=;
  b=dZc2LUUXT1dEOmflg8Zkmc2GEAooXqjf8whNbyRZAPZpqA475FTXvSHb
   m1040nLB17vPbnmnWysrqFcUn1a8gQrA8s9SJqNOdyUpq/SKTn83YDxj5
   sVa0Bfe9x5qSn3GrUA40UUpn82RwGlKoh5ITVe7gH5RjU+3aev/vEl26t
   ETSG44zPA+djxnLjLtFRSM/cXfvSxcA1zQDX4yODgT22MveC2kIKhCY3G
   ZvtqYm5bgC1aq8uf4noJxTQ/XVnB2FoO4yRseeDxOYQ5aabKofkLoksOH
   netYjS2pzVxorPXhvRibdNKZeaDCP6XyjmkHvFqhP8GH3+qy1Zq0qKd5W
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10378"; a="259110447"
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="259110447"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2022 08:45:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,300,1647327600"; 
   d="scan'208";a="612284213"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 14 Jun 2022 08:45:37 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o18jY-000M3j-RO;
        Tue, 14 Jun 2022 15:45:36 +0000
Date:   Tue, 14 Jun 2022 23:45:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.17.y 2895/3797] fs/afs/write.o: warning:
 objtool: afs_write_back_from_locked_folio()+0x28f: unreachable instruction
Message-ID: <202206142343.4BdIt3Iq-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.17.y
head:   a554a1e2ef7fa48cebd9cc2349804974247c0958
commit: 38eb28cc267257accfe416845d6c98ccb1d5c61e [2895/3797] afs: Adjust ACK interpretation to try and cope with NAT
config: x86_64-randconfig-r026-20220613 (https://download.01.org/0day-ci/archive/20220614/202206142343.4BdIt3Iq-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=38eb28cc267257accfe416845d6c98ccb1d5c61e
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.17.y
        git checkout 38eb28cc267257accfe416845d6c98ccb1d5c61e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/afs/write.o: warning: objtool: afs_write_back_from_locked_folio()+0x28f: unreachable instruction

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
