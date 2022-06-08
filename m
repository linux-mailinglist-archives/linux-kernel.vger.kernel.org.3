Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45799543155
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 15:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240309AbiFHN26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 09:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbiFHN2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 09:28:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33D41AF30C
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 06:28:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654694930; x=1686230930;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=XHjhaEq1nsnHOtvtGyMCsb8Pv4C5aqnH/jKo30LIa2s=;
  b=dUl8fPYWbD9NB2Yu1kZA5QjXZ8OYsanwALZ3j+FjD0id1e2P4CZtxtiu
   juJJa4G4+515exF71hpSaeIYmeSV7MbBjDk7qNB/UIuS/WivXqu590iEm
   P6hUKtyQKGsFY8bNAWiuiT5zEOZOXZuvGQuvJokDfXs8LVFztqlgYlr/4
   f02hnY18vUZ8F30OsjNxX8IB1hfvmgeANTgYlLX6Dy9ruBznJvr6x04Tw
   P7R71gQODRa3RDvtqu6uZCnEo0dXv4qItV3x2Z3RAFUtISG8qS1NmRI59
   943rj6TX8+opD5Os9FF4blXqD3Ok/ZidGBt7AvpZwomazbQgwNAhDqIva
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="256726984"
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="256726984"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 06:28:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,286,1647327600"; 
   d="scan'208";a="609663729"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 08 Jun 2022 06:28:33 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyvjc-000Eeh-Kg;
        Wed, 08 Jun 2022 13:28:32 +0000
Date:   Wed, 8 Jun 2022 21:27:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        SeongJae Park <sj@kernel.org>
Subject: huge_count_read_write.c:23:9: warning: 'write' reading 4294967295
 bytes from a region of size 1
Message-ID: <202206082155.7ppW1i62-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9886142c7a2226439c1e3f7d9b69f9c7094c3ef6
commit: 678f0cdc572c5fda940cb038d70eebb8d818adc8 selftests/damon: add damon to selftests root Makefile
date:   6 weeks ago
reproduce: make O=/tmp/kselftest -C tools/testing/selftests

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   huge_count_read_write.c: In function 'write_read_with_huge_count':
>> huge_count_read_write.c:23:9: warning: 'write' reading 4294967295 bytes from a region of size 1 [-Wstringop-overread]
      23 |         write(filedesc, "", 0xfffffffful);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from huge_count_read_write.c:8:
   /usr/include/unistd.h:367:16: note: in a call to function 'write' declared with attribute 'access (read_only, 2, 3)'
     367 | extern ssize_t write (int __fd, const void *__buf, size_t __n) __wur
         |                ^~~~~
>> huge_count_read_write.c:25:15: warning: 'read' writing 4294967295 bytes into a region of size 25 overflows the destination [-Wstringop-overflow=]
      25 |         ret = read(filedesc, buf, 0xfffffffful);
         |               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   huge_count_read_write.c:14:14: note: destination object 'buf' of size 25
      14 |         char buf[25];
         |              ^~~
   In file included from huge_count_read_write.c:8:
   /usr/include/unistd.h:360:16: note: in a call to function 'read' declared with attribute 'access (write_only, 2, 3)'
     360 | extern ssize_t read (int __fd, void *__buf, size_t __nbytes) __wur
         |                ^~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
