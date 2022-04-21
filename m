Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F83509D0D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388068AbiDUKGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349121AbiDUKGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:06:40 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 142E827B25
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650535432; x=1682071432;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=m+iabvTTK/fqCwg3tbBUcihgtcYmP51Oyr0Pm+DwX2k=;
  b=DmbghU7DrTk073ylxkVY19xadVgvJYMLHI2K4LUY2LjILWFypG5jODxj
   KBZGJ4Xg0EhSuFVUZBycEwayDDN6WoHvKIe+ZAnjrkyVTg4Nb9TVKmQIv
   qAj5F06oPfYL6lF2mUb4fUwdTU2XOP2F9ya8DdPpxrg3htLnNTQpYiyK+
   lJG8fD0FIgWdRvB6egmQAHArMHWnpzLHxVZqVL908I8yxQ0CMWFC2Qajw
   wPnUB49kajdhAIkOqPEtzZz3wPUKZq7cBTpZHNCsFQ+g+U6V05FAQI3mj
   Ko9xuv1o4/0PJislfk4cVjru9nVl2AimAI0vDv6G4xZw5sv1ZM7fJ98JA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="261905303"
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="261905303"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 03:03:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,278,1643702400"; 
   d="scan'208";a="703024554"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Apr 2022 03:03:50 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhTfC-0008CB-7n;
        Thu, 21 Apr 2022 10:03:50 +0000
Date:   Thu, 21 Apr 2022 18:03:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 1673/2579]
 ./usr/include/linux/socket.h:5:10: fatal error: uapi/linux/socket_types.h:
 No such file or directory
Message-ID: <202204211809.Nim6Okt4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   49e1ec6c70a6eb4b7de9250a455b8b63eb42afbe
commit: 700c335789263a7a7021dad9bbb7accdd5834357 [1673/2579] headers/deps: net: Split <linux/socket_types.h> out of <linux/socket.h>
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220421/202204211809.Nim6Okt4-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=700c335789263a7a7021dad9bbb7accdd5834357
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 700c335789263a7a7021dad9bbb7accdd5834357
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from ./usr/include/linux/ax25.h:10,
                    from ./usr/include/linux/netrom.h:11,
                    from <command-line>:
>> ./usr/include/linux/socket.h:5:10: fatal error: uapi/linux/socket_types.h: No such file or directory
       5 | #include <uapi/linux/socket_types.h>
         |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   compilation terminated.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
