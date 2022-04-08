Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0A314F9573
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiDHMSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbiDHMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:18:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DF1C387B2;
        Fri,  8 Apr 2022 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649420186; x=1680956186;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=87eTft+Sz6HSGuTjM5rCbkbXzq5J5qvbYbVHefQuSh8=;
  b=hopl63wquftlW/mSaMB/NgCQt/23VzAxrJ8LLKpyRDHW+EgxxtrWg6pB
   f9GSz2B3Q8uJ1IrdioHgUw4gYM9nq4ILbUH/oHicZYdjogaj1me7oCVGV
   PXYeuAiQvnwxbB0hOzCKCrhiSaeTpRA5Ugu+dDGVuMhi6co03h9xwxiMN
   a8XbLR04pnFSZgpMJg9pkPqgGBvQnbkjRbVkEWUqv+I0DyC8M5N7lM1eN
   BVuqWArQfydqZIoGu1PJcPV4fwHTxylDQzprbmcYKtAFKs++oUDOZXXCB
   Ey+bY7EucBApUEVXrh1UAX6NiFMTnMGdmIFapDkkNe8sqcYD/pqcbZEGh
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="241513046"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="241513046"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 05:16:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="506538079"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 08 Apr 2022 05:16:23 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncnXK-0000FP-Na;
        Fri, 08 Apr 2022 12:16:22 +0000
Date:   Fri, 8 Apr 2022 20:15:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luke Wren <wren6991@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        linux-doc@vger.kernel.org
Subject: [l1k:smsc95xx_5.17 66/887] drivers/misc/bcm2835_smi.c:2: warning:
 This comment starts with '/**', but isn't a kernel-doc comment. Refer
 Documentation/doc-guide/kernel-doc.rst
Message-ID: <202204082010.UUsMvtdZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 205736282d70963710608138c17b64717470161c [66/887] Add SMI driver
config: arm-multi_v7_defconfig (https://download.01.org/0day-ci/archive/20220408/202204082010.UUsMvtdZ-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/205736282d70963710608138c17b64717470161c
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 205736282d70963710608138c17b64717470161c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash drivers/dma/ drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/misc/bcm2835_smi.c:2: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Broadcom Secondary Memory Interface driver


vim +2 drivers/misc/bcm2835_smi.c

   > 2	 * Broadcom Secondary Memory Interface driver
     3	 *
     4	 * Written by Luke Wren <luke@raspberrypi.org>
     5	 * Copyright (c) 2015, Raspberry Pi (Trading) Ltd.
     6	 *
     7	 * Redistribution and use in source and binary forms, with or without
     8	 * modification, are permitted provided that the following conditions
     9	 * are met:
    10	 * 1. Redistributions of source code must retain the above copyright
    11	 *    notice, this list of conditions, and the following disclaimer,
    12	 *    without modification.
    13	 * 2. Redistributions in binary form must reproduce the above copyright
    14	 *    notice, this list of conditions and the following disclaimer in the
    15	 *    documentation and/or other materials provided with the distribution.
    16	 * 3. The names of the above-listed copyright holders may not be used
    17	 *    to endorse or promote products derived from this software without
    18	 *    specific prior written permission.
    19	 *
    20	 * ALTERNATIVELY, this software may be distributed under the terms of the
    21	 * GNU General Public License ("GPL") version 2, as published by the Free
    22	 * Software Foundation.
    23	 *
    24	 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS
    25	 * IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
    26	 * THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
    27	 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
    28	 * CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
    29	 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
    30	 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
    31	 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
    32	 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
    33	 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
    34	 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
    35	 */
    36	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
