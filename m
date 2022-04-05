Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1AE94F228F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 07:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiDEFXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 01:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbiDEFXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 01:23:30 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A3252AC2
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 22:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649136048; x=1680672048;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=I2cqu9zR8Hvr659S+cqTNexV0FQBHlsrbXNoITWNdLk=;
  b=mQBS467zBuKQWUvYMHOpO/kp3P7YVj1asB//+8O8nzsZTXQH56lnxmTT
   L8viGekoeHdad1TCd/6Yk7Sm+i4mw0tLk8sFUAWrIghzc5pHw9dVNgGJF
   ftajBa6UMYii38yRIstJs9UPrefhwPkFOZ/yCZGoYDRLSgcvt3n6EM/HM
   //BCnj8rezmgAnRr+GLjAOj7QTEuKlQH6hbzOzm6x3FsLWmOhfclOpowv
   X2nSGJ/rbz2WveO3CHX+3hemuJF+1AZ1Zw5TOGOgdaek3F2NhjhiAICLm
   9uToALJTzu4MRpidcM7dfQ13CU8xL899zWmd4L4V6q0k7Tu7bfGuafMQx
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10307"; a="240603567"
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="240603567"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2022 22:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,235,1643702400"; 
   d="scan'208";a="721912208"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 04 Apr 2022 22:20:46 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbbcT-0002ft-CR;
        Tue, 05 Apr 2022 05:20:45 +0000
Date:   Tue, 5 Apr 2022 13:19:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 33/40] ERROR:
 modpost: "mas_walk" [fs/netfs/netfs.ko] undefined!
Message-ID: <202204051321.rd4HYoy6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   674eea41fc70a740ff83ec590f9833f805852464
commit: 073b0ba90614945b31bccfede6e00102b7eb460e [33/40] netfs: Implement buffered writes through netfs_file_write_iter()
config: x86_64-randconfig-c001 (https://download.01.org/0day-ci/archive/20220405/202204051321.rd4HYoy6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/073b0ba90614945b31bccfede6e00102b7eb460e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout 073b0ba90614945b31bccfede6e00102b7eb460e
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

>> ERROR: modpost: "mas_walk" [fs/netfs/netfs.ko] undefined!
>> ERROR: modpost: "mas_destroy" [fs/netfs/netfs.ko] undefined!
>> ERROR: modpost: "mas_expected_entries" [fs/netfs/netfs.ko] undefined!
>> ERROR: modpost: "mas_store" [fs/netfs/netfs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
