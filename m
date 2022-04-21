Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3BB50984B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385356AbiDUGzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385393AbiDUGwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:52:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08ED8140C4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650523592; x=1682059592;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=2yM4GzsFW1IPsfsA1vpIAvtsv1rmpaYAvK5Qr5jSk6U=;
  b=bq077l02amZyG0cllnVtDjeIwX+UMgeC3uSec2ZCoXAJQjDd+4kK5ThO
   mJ2IdGKvtNpfLdml8Th8QN07QOSd761lbQnT9y7X704zcf72Ne6x0eeLZ
   H6yX4D2NFCYe8wrr8vAQAnSOhprRTGxq7NV0PA+P1ziEF99ynpsyKSJLK
   vHxO/C2bAMhDLf3+W0xe7jdBZTwvxzlqy83WhMcwpqLWgzcVeQSJlmV0D
   INUBFfAKyGzpTYBOMA/pjJ/APRK2Q53nVtwh7F/BkyjYdDS4M1//JqhSp
   Pdn16DJf7tA3FeybguKxuWfALuPyYvieA2kSl1Lr/xyD8CF0/iiRKeT9x
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="263109840"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="263109840"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:45:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="626388364"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 20 Apr 2022 23:45:52 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQZb-00082a-OC;
        Thu, 21 Apr 2022 06:45:51 +0000
Date:   Thu, 21 Apr 2022 14:45:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1618/2579]
 ./usr/include/asm-generic/bpf_perf_event.h:4:10: fatal error:
 uapi/linux/ptrace.h: No such file or directory
Message-ID: <202204211202.g0tdwto1-lkp@intel.com>
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
commit: 99a1c22406cedc8935477f457b75225ca4ba5e70 [1618/2579] headers/deps: bpf: Use <uapi/linux/ptrace.h> in <uapi/asm-generic/bpf_perf_event.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220421/202204211202.g0tdwto1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=99a1c22406cedc8935477f457b75225ca4ba5e70
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 99a1c22406cedc8935477f457b75225ca4ba5e70
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/asm/bpf_perf_event.h:1,
                    from <command-line>:
>> ./usr/include/asm-generic/bpf_perf_event.h:4:10: fatal error: uapi/linux/ptrace.h: No such file or directory
       4 | #include <uapi/linux/ptrace.h>
         |          ^~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
