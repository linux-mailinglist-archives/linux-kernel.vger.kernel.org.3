Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1603F563D07
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 02:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbiGBAXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 20:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230483AbiGBAXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 20:23:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 544BA109E;
        Fri,  1 Jul 2022 17:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656721393; x=1688257393;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=3MYgZyegdLh56+9c/svUS5g9teTfjtFubk1JPzVyR0s=;
  b=mwO8DyTCmpuqZ7tf3x5RlJwyB0yEgJXl37ajFkzCWObqQOo2T7IKt+Hg
   dovm0L8h5yPVawOdZHFlczgwmdRcsM5Gj4eFJHUnR1+XLsiEfoLMxOCEy
   ZI8PGl2E8j886vcSluWHiGU9kJPG0h9x7oXS4vPp9AxYSgmC/B6hOQn96
   ztdVfR2PcZENlJl4OC39B/+yKRjViQJ+fW6hAArRm47CgjqK7+5MwLY+S
   9WsJMrrKbDV+ZudIE/hecekJGJP0ghj74obWEWyEHrVGhVcip1CqL0VT/
   9FiUfx2inI3m5anKBvKSGu4u2vsT5mOo8uKFoBVQAoDt+17lt8EjCXbTb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10395"; a="346753712"
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="346753712"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 17:23:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,238,1650956400"; 
   d="scan'208";a="596446508"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Jul 2022 17:23:11 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7Quk-000EVY-MC;
        Sat, 02 Jul 2022 00:23:10 +0000
Date:   Sat, 2 Jul 2022 08:22:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mike Snitzer <snitzer@redhat.com>, linux-doc@vger.kernel.org
Subject: htmldocs: Documentation/admin-guide/device-mapper/writecache.rst:23:
 WARNING: Unexpected indentation.
Message-ID: <202207020824.oMJMSB8R-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1ce8c443e95698cecc32cc8ed5ff4b72da61eed4
commit: 5c0de3d72f8c05678ed769bea24e98128f7ab570 dm writecache: make writeback pause configurable
date:   1 year ago
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/admin-guide/device-mapper/writecache.rst:23: WARNING: Unexpected indentation.

vim +23 Documentation/admin-guide/device-mapper/writecache.rst

f0ba43774cea3fc Documentation/device-mapper/writecache.rst Mauro Carvalho Chehab 2019-06-12  13  
48debafe4f2feab Documentation/device-mapper/writecache.txt Mikulas Patocka       2018-03-08  14  1. type of the cache device - "p" or "s"
f0ba43774cea3fc Documentation/device-mapper/writecache.rst Mauro Carvalho Chehab 2019-06-12  15  	- p - persistent memory
f0ba43774cea3fc Documentation/device-mapper/writecache.rst Mauro Carvalho Chehab 2019-06-12  16  	- s - SSD
48debafe4f2feab Documentation/device-mapper/writecache.txt Mikulas Patocka       2018-03-08  17  2. the underlying device that will be cached
48debafe4f2feab Documentation/device-mapper/writecache.txt Mikulas Patocka       2018-03-08  18  3. the cache device
48debafe4f2feab Documentation/device-mapper/writecache.txt Mikulas Patocka       2018-03-08  19  4. block size (4096 is recommended; the maximum block size is the page
48debafe4f2feab Documentation/device-mapper/writecache.txt Mikulas Patocka       2018-03-08  20     size)
48debafe4f2feab Documentation/device-mapper/writecache.txt Mikulas Patocka       2018-03-08  21  5. the number of optional parameters (the parameters with an argument
48debafe4f2feab Documentation/device-mapper/writecache.txt Mikulas Patocka       2018-03-08  22     count as two)
d284f8248c72d0c Documentation/device-mapper/writecache.txt Mikulas Patocka       2018-06-28 @23  	start_sector n		(default: 0)

:::::: The code at line 23 was first introduced by commit
:::::: d284f8248c72d0cb36a930920e60592eb455cd0d dm writecache: support optional offset for start of device

:::::: TO: Mikulas Patocka <mpatocka@redhat.com>
:::::: CC: Mike Snitzer <snitzer@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
