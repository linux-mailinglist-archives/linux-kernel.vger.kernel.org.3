Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3584C1D40
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 21:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241420AbiBWUjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 15:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBWUjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 15:39:16 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E34747AD9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 12:38:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645648728; x=1677184728;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qxFtbjyZUFdMOJwr/SJELnPxdUNykssEMShYDlFHvlw=;
  b=k6YfIt04ZorVX/EeeXWLg9mdQpq+RsaIIECLU9O2Wr1PuRgf1wIBuB36
   u55Q8pyYPz2T1SwvrPkZXnthH9SsGtrM47rfumYiKmMTb5k9+DigM1Xax
   qQQemCWVTFSUYFuNLSTstAQskZomJa+oqgEen/RKHJIp+mJblIixkPSym
   sI8Byq7izTt4uV5HOrSJTgXH6bFuhtEkUU9kA7MOpEvnsNa9Rp2rNJWqt
   ZpVFVx5DLDeSl35TKXS0UroT1gURHklSEJ7fdILu+8RPdbC7wQHw+DZ7y
   XFK19nRWmBhV+c/tM187v1wXJsSZjwtdSb+EkqdL6j64X1lve466HpHM+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232696893"
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="232696893"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 12:38:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,391,1635231600"; 
   d="scan'208";a="684036559"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 Feb 2022 12:38:47 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMyPO-0001oG-Rn; Wed, 23 Feb 2022 20:38:46 +0000
Date:   Thu, 24 Feb 2022 04:38:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v2 51/67] include/net/tls.h:363:1:
 error: unknown type name 'key_ref_t'; did you mean 'key_ref_put'?
Message-ID: <202202240430.qhweZYwe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v2
head:   ac729ea3c52bda460616c71d5f5fc47b2e64da6d
commit: 5cfffd00ff4be23f0447069eb31ce2301a83d974 [51/67] net/tls: Add tls_key_lookup() and tls_key_refresh()
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220224/202202240430.qhweZYwe-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=5cfffd00ff4be23f0447069eb31ce2301a83d974
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v2
        git checkout 5cfffd00ff4be23f0447069eb31ce2301a83d974
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/core/filter.c:79:
>> include/net/tls.h:363:1: error: unknown type name 'key_ref_t'; did you mean 'key_ref_put'?
     363 | key_ref_t tls_key_refresh(char *identity, u8 *data, size_t data_len);
         | ^~~~~~~~~
         | key_ref_put
   include/net/tls.h:364:1: error: unknown type name 'key_ref_t'; did you mean 'key_ref_put'?
     364 | key_ref_t tls_key_lookup(char *identity);
         | ^~~~~~~~~
         | key_ref_put


vim +363 include/net/tls.h

   362	
 > 363	key_ref_t tls_key_refresh(char *identity, u8 *data, size_t data_len);
   364	key_ref_t tls_key_lookup(char *identity);
   365	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
