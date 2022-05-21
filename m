Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E7452FD0E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243206AbiEUOAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbiEUN77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 09:59:59 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78343EAB4
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 06:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653141598; x=1684677598;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nJrHbVAnwhCplJ8yJDycYC4XSOIr+JdJ0a7J+bkbb0k=;
  b=aGxQ9Ajc3WcaORyKEyALSJktP87VazejI7oWnHNyqNV+6XL7hVr3izcQ
   NZAhPiPPgsktd3A8cAJu29vZwDqKDcd8WKkX3dVF0NcmMHo85wTfKf6bu
   rQg3qvjT8uTSaOZHIeIV0mHwguJjM3XLX85awMATVZ3HcbhYA2wqLK2yn
   yQrfkrAt+dZQkVY0aDE8pdj25UoGZuBv8DZE3PmJRproKoRn1YT2Z7xz8
   xAz7j1K9UsHAB2MfisoULu+dl3+bDVHrv8H//Co97ZkZ4bOgFmiMN8s1B
   ynOLhEJDaPOV4oDd/otSzUs/IIRlhrMB4vZV5cj1sk9Zdy0qs5rTHII2d
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="270440802"
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="270440802"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 06:59:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,242,1647327600"; 
   d="scan'208";a="547135125"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 21 May 2022 06:59:41 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsPds-0006LO-PF;
        Sat, 21 May 2022 13:59:40 +0000
Date:   Sat, 21 May 2022 21:59:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [dhowells-fs:rxrpc-next 3/7] fs/seq_file.c:960:12: sparse: sparse:
 incorrect type in assignment (different address spaces)
Message-ID: <202205212138.PGuJkwT2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git rxrpc-next
head:   ff8a9d0bfd1189450a3048de45bcf4e4a2e95108
commit: 295f57b1849bfb1d838e611367f87479b2fb8959 [3/7] rxrpc: Fix locking issue
config: s390-randconfig-s032-20220519 (https://download.01.org/0day-ci/archive/20220521/202205212138.PGuJkwT2-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=295f57b1849bfb1d838e611367f87479b2fb8959
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs rxrpc-next
        git checkout 295f57b1849bfb1d838e611367f87479b2fb8959
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   fs/seq_file.c:938:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:938:9: sparse:    struct list_head [noderef] __rcu *
   fs/seq_file.c:938:9: sparse:    struct list_head *
   fs/seq_file.c:938:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:938:9: sparse:    struct list_head [noderef] __rcu *
   fs/seq_file.c:938:9: sparse:    struct list_head *
>> fs/seq_file.c:960:12: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct list_head *lh @@     got struct list_head [noderef] __rcu * @@
   fs/seq_file.c:960:12: sparse:     expected struct list_head *lh
   fs/seq_file.c:960:12: sparse:     got struct list_head [noderef] __rcu *
   fs/seq_file.c:1087:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:1087:24: sparse:    struct hlist_node [noderef] __rcu *
   fs/seq_file.c:1087:24: sparse:    struct hlist_node *
   fs/seq_file.c:1089:24: sparse: sparse: incompatible types in comparison expression (different address spaces):
   fs/seq_file.c:1089:24: sparse:    struct hlist_node [noderef] __rcu *
   fs/seq_file.c:1089:24: sparse:    struct hlist_node *

vim +960 fs/seq_file.c

   954	
   955	struct list_head *seq_list_next_rcu(void *v, struct list_head *head,
   956					    loff_t *ppos)
   957	{
   958		struct list_head *lh;
   959	
 > 960		lh = list_next_rcu((struct list_head *)v);
   961		++*ppos;
   962		return lh == head ? NULL : lh;
   963	}
   964	EXPORT_SYMBOL(seq_list_next_rcu);
   965	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
