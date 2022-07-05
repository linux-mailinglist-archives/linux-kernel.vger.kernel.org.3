Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9524E5665E8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 11:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231553AbiGEJMd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 05:12:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231332AbiGEJMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 05:12:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F2AB4BC;
        Tue,  5 Jul 2022 02:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657012350; x=1688548350;
  h=subject:references:to:cc:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=+BIkT67U0tYL71jpeHcqtdf3r8BVdcqZJ/iTdKgspno=;
  b=lp23EeON4kkFpDDd7R541A+G9bJwVJ8ssN7dGKfoBbiDGp2Tj2Zb9Xsm
   WgUFggHalrOH6i3eeE0L2MRxj2RGMT5n2kuIrOI0mATpM+tebOpmCA/fG
   oOEUorOW/i5ojEhbjByfK+Dv5UoDwi5ekUvEmJNi6+Wv9DL/Ya9SfqCHJ
   5dr8J4E2XQVXfePd6SvkddaKFldKMC44Jg2pqLvnolEw0kooROZVBLdCY
   fODM/RhJDFtqTmxoEnhve93ivCGdYo9VUHXOhH6BILtWDY1wTFPvC3nb/
   wvnU1L3xeM7WjQYRJ/qxiSBgWQWq0QrrreRCnP/oEV8Yl4/AcPecA85pF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283328324"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="283328324"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 02:12:30 -0700
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="650029231"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.249.174.209]) ([10.249.174.209])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 02:12:28 -0700
Subject: htmldocs: Documentation/filesystems/ext4/blockmap.rst:3: WARNING:
 Malformed table.
References: <202207050619.COGgejv5-lkp@intel.com>
To:     Wang Jianjian <wangjianjian3@huawei.com>
Cc:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
From:   kernel test robot <rong.a.chen@intel.com>
X-Forwarded-Message-Id: <202207050619.COGgejv5-lkp@intel.com>
Message-ID: <c79c6d1f-5a72-7633-4fcb-e859225b49b4@intel.com>
Date:   Tue, 5 Jul 2022 17:12:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <202207050619.COGgejv5-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


tree: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   c1084b6c5620a743f86947caca66d90f24060f56
commit: 3103084afcf2341e12b0ee2c7b2ed570164f44a2 ext4, doc: remove 
unnecessary escaping
date:   3 weeks ago
:::::: branch date: 4 hours ago
:::::: commit date: 3 weeks ago
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/filesystems/ext4/blockmap.rst:3: WARNING: Malformed table.
>> Documentation/filesystems/ext4/dynamic.rst:5: WARNING: Malformed table.
>> Documentation/filesystems/ext4/ifork.rst:5: WARNING: Malformed table.

vim +3 Documentation/filesystems/ext4/blockmap.rst

b4becd48b7b548f Documentation/filesystems/ext4/ondisk/blockmap.rst 
Darrick J. Wong 2018-07-29  2  b4becd48b7b548f 
Documentation/filesystems/ext4/ondisk/blockmap.rst Darrick J. Wong 
2018-07-29 @3 
+---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

:::::: The code at line 3 was first introduced by commit
:::::: b4becd48b7b548f564533a41e1cdeb8ae3bd1c70 ext4: import inode data 
fork chapter from wiki page

:::::: TO: Darrick J. Wong <darrick.wong@oracle.com>
:::::: CC: Theodore Ts'o <tytso@mit.edu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
