Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46184EE4DD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243139AbiCaXo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243114AbiCaXoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:44:25 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5D524A75D
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648770157; x=1680306157;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Su8T08BPFmuwBVfmvyC9fL6wg1aivHNZ0Jvs6Rp55tw=;
  b=gYfUDhNL5FSsyc4cUdjBKzh9eQd1kq03s5ctk56kCRW1nPebEuolQZP2
   WGP6daKrG5J9j4ylfUdV93Jvjy0iyNABhQFKd0q8H4JrqsWbh0LotqsiC
   M5JU70i7XzoBBtegDHUkWPLA5FXcod9gkM1gfPC/WSBGos1E7CiDMmbig
   S765nyi/uPBR4ZNvJnyJnyYMgDwoBY2udDcyWjEPC6U0kO2tJK93z7Fc0
   T+X1DgYABYcq8NPSyQPDkZTHPa1t9Ho/Ayc/txnuClcf5rYNHQTxm0v83
   XgxmX1KlrO9LYYMQBMHN+fN+zyO7mo7ftHwdh39WAX7LWy9VEJHeUyYq8
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="284916092"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="284916092"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 16:42:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="522551364"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 31 Mar 2022 16:42:35 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1na4R0-0000lE-VN;
        Thu, 31 Mar 2022 23:42:34 +0000
Date:   Fri, 1 Apr 2022 07:42:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/sock-nolock 7/9]
 net/socket.c:1571:9-16: WARNING: ERR_CAST can be used with sock
Message-ID: <202204010757.kWpiiHMi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/sock-nolock
head:   8698873371093e22f708c2cf3a31f4dc2caab84f
commit: 3af464ccde389a5df95af3e221d098ac34d4606f [7/9] net: add __sys_socket_file()
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20220401/202204010757.kWpiiHMi-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> net/socket.c:1571:9-16: WARNING: ERR_CAST can be used with sock

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
