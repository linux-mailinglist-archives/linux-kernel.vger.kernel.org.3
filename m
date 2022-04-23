Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9876350C59D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 02:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbiDWAQ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 20:16:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDWAQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 20:16:23 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3468E63396
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 17:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650672809; x=1682208809;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3XhHEcMoII5/nzUs6nGDnfPsDeBcQbNn7EV4eDUD/Ag=;
  b=fk0oVSrMiAze04I7XxBQs7ukgJ6XrpQLfIYnro1HfoEGMlKuvquSsDEm
   kPRUTOJzOe5vnj+gEzd9eODzGtT/bM5rVSja+NJZPkC/SDxnLQYRr6yYO
   1ZEYkD6qPP2zJLZuMLIVbUpGaYAJdIwrCQN6Jjxj0AOEVa+x6ZN+Sa1b5
   0rLqCfYq0DWBot1UPHcZCI40+tRyxx8q9BB9bT6ijFCDZDeY3TegqNwSF
   gQUJObJgIxYiKYG75E2EbZu7gnZmG8DqMxi9XseeePbZHn/Ml13LK60Za
   gKi/84bhHfxIbEHWXEjaeXE0cbXPI4KniQwxnuv5TsZ6Xkb1k78xKbjae
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264990020"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264990020"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 17:13:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="648848884"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 22 Apr 2022 17:13:27 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni3Ox-000Ai6-AY;
        Sat, 23 Apr 2022 00:13:27 +0000
Date:   Sat, 23 Apr 2022 08:13:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 41/44] ERROR:
 modpost: "netfs_page_mkwrite" [fs/afs/kafs.ko] undefined!
Message-ID: <202204230857.dn8iQWG0-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   931e50676c6598d0eda1954ead465519ff91874d
commit: bd4ce8115969d3c18aef5998bb59625d4ff48991 [41/44] afs: Use the netfs write helpers
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220423/202204230857.dn8iQWG0-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/bd4ce8115969d3c18aef5998bb59625d4ff48991
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout bd4ce8115969d3c18aef5998bb59625d4ff48991
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>, old ones prefixed by <<):

ERROR: modpost: "netfs_put_subrequest" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "__tracepoint_netfs_sreq" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "netfs_page_mkwrite" [fs/afs/kafs.ko] undefined!
>> ERROR: modpost: "__SCT__tp_func_netfs_sreq" [fs/afs/kafs.ko] undefined!

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
