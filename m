Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD04588832
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbiHCHrB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235774AbiHCHq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 03:46:58 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBB31A07A
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 00:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659512817; x=1691048817;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/7yiVIZ/eNTs32/hZKE0mUwCtUBTSnNfc124NTOUsmk=;
  b=RvtljYYGmTCvUwMTi2CbF6tW/cZWUkZXvFAaAUI3OP1TVOvNPJQ17rjf
   4vPWcee4+zcMty0Xr+mv0hUQ7w5dfR6XpE83qCBHvIm4V//O+R58fqiqn
   +nM5akY7Zb3Mo4x06xEPsuvrbVJVMkHpZcj4QUztq/DMxDMok4e/OCv43
   RxXCpNmU5Er3LbTUTuTYgIUvYE0vEbxK8pQfv74Np+UkNGsXVLSAbw5dL
   kidaWYprgnP/TzGiadPRmfHCfB71V7ZEG/cZKhhQecNKdrd3JfwhKoSZk
   NKSoAAsIweat+NwC+R6VLSav8hF8nCDD6gQ+jWoHTIjDka1myi1zpH2cl
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="272659585"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="272659585"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 00:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="599558522"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2022 00:46:55 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ95i-000H0F-33;
        Wed, 03 Aug 2022 07:46:54 +0000
Date:   Wed, 3 Aug 2022 15:46:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuanchu Xie <yuanchu@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        SeongJae Park <sj@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [linux-stable-rc:linux-5.18.y 467/2461]
 huge_count_read_write.c:23:9: warning: 'write' reading 4294967295 bytes from
 a region of size 1
Message-ID: <202208031525.w6ang25V-lkp@intel.com>
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

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.18.y
head:   7e8a7b1c98057a3014222a505c28c6bd43ed5666
commit: e1ea40d9d6fc3d408390cb42d8f3c9d1466a62f3 [467/2461] selftests/damon: add damon to selftests root Makefile
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=e1ea40d9d6fc3d408390cb42d8f3c9d1466a62f3
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.18.y
        git checkout e1ea40d9d6fc3d408390cb42d8f3c9d1466a62f3
        make O=/tmp/kselftest headers
        make O=/tmp/kselftest -C tools/testing/selftests

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
