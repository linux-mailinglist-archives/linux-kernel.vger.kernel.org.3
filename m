Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A23E6509854
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385330AbiDUGuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385168AbiDUGrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:47:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C86B15706
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523433; x=1682059433;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=t6EX66T85u1c5LDaK5D+bJxZGki09xbXVSxRqkTFzEw=;
  b=U6Qxkat70JdTzKBsbpP7tEV7UHuEyp41gWxBp2gELT1WQCVdcWP8d/Bx
   z4UVt3G2xXIXX9QpTnV4MiLW8lQxAm9jQPI4IBBgNgHkl0n5Te4/Qpo+7
   NBdI8qc+xVhhL5BmH3oCBTGe/gL3s87q2rZRMlHHsdEvqU/cBn4M7p8kh
   nVA8s3A2UoWBlmF33j7+ERG7BlUFyjpqsS4X5quSmSbUOhq6yEI/tynyc
   PtetstNkKws3bqYX1AqdZ6uodT9B+xjFibGzMmoorShOBZ8IXvX1u6rbf
   JEfNGgQt1TIqLGmQZsE5zxzZfVbZYQ4CJVIeF2BKTC2TQoHcXdPCZyHxF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264022261"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="264022261"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:43:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="532792899"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2022 23:43:51 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQXe-00080X-TW;
        Thu, 21 Apr 2022 06:43:50 +0000
Date:   Thu, 21 Apr 2022 14:43:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 909/2579] ./usr/include/linux/rds.h:38:10:
 fatal error: uapi/linux/sockios.h: No such file or directory
Message-ID: <202204210658.9lRMw5Y6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 94cfca12ab9e9b8b05b4baec60d6450f80682d91 [909/2579] headers/deps: Add header dependencies to .h files: <uapi/linux/sockios.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220421/202204210658.9lRMw5Y6-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=94cfca12ab9e9b8b05b4baec60d6450f80682d91
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 94cfca12ab9e9b8b05b4baec60d6450f80682d91
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/linux/rds.h:38:10: fatal error: uapi/linux/sockios.h: No such file or directory
      38 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from <command-line>:
>> ./usr/include/linux/if_tunnel.h:5:10: fatal error: uapi/linux/sockios.h: No such file or directory
       5 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from <command-line>:
>> ./usr/include/linux/kcm.h:18:10: fatal error: uapi/linux/sockios.h: No such file or directory
      18 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.
--
   In file included from <command-line>:
>> ./usr/include/linux/x25.h:15:10: fatal error: uapi/linux/sockios.h: No such file or directory
      15 | #include <uapi/linux/sockios.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
