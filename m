Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B163D4ECF96
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346200AbiC3WZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244671AbiC3WZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:25:31 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC2F48383
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648679026; x=1680215026;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cdyV6ni5B0R2HoQiSpWxTiLJCHRmm/nefjUnGqeXvcU=;
  b=JzVsoxFOPh/s09VZx0cblv+yocUTzv4hKesfgD/IGtwXgUCnbLyKmFzH
   N+LEl/g9l45CuoJPF21Qczko5tYTzpgGMFVWYW4aA3qyuWoiMnaNl949C
   YWXSUeodB0/64UruDTdY6LoxDzCU94dy/FM2Fr9vPWfoL3uLguF0AtDvA
   XTwimLJUp5wVcA2lW7BEzkiGxRWwowD2n8UaiqwXkVBj77L+H7LiJk+6o
   tqSVjo9z3YPjTpD9QRo0vnxeQMsTjHBc0xFG8+uydkwbS61pi2RKekDi3
   qXC2YXJfjH79N/J4y7MrKcX+RMyvzOwR+K3q/qXPVNJBAdB5rqC8G5scM
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259844109"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259844109"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="586168694"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 30 Mar 2022 15:23:44 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZgj9-0000Zo-LY;
        Wed, 30 Mar 2022 22:23:43 +0000
Date:   Thu, 31 Mar 2022 06:22:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:rostedt/linux-trace/ftrace/core 1/5]
 include/trace/trace_custom_events.h:38:10: fatal error:
 'stages/stage1_defines.h' file not found
Message-ID: <202203310653.AMWJCqi6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/ftrace/core
head:   025833e54d2b7b031c44642a14df39a67a524b9a
commit: 7ebdde13050a7d880ef7403fd10c30f5167b6f0b [1/5] tracing: Rename the staging files for trace_events
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220331/202203310653.AMWJCqi6-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/7ebdde13050a7d880ef7403fd10c30f5167b6f0b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/ftrace/core
        git checkout 7ebdde13050a7d880ef7403fd10c30f5167b6f0b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash samples/trace_events/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from samples/trace_events/trace_custom_sched.c:24:
   In file included from samples/trace_events/./trace_custom_sched.h:96:
   In file included from include/trace/define_custom_trace.h:55:
>> include/trace/trace_custom_events.h:38:10: fatal error: 'stages/stage1_defines.h' file not found
   #include "stages/stage1_defines.h"
            ^~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +38 include/trace/trace_custom_events.h

3a73333fb370f7 Steven Rostedt (Google  2022-03-03  37) 
3a73333fb370f7 Steven Rostedt (Google  2022-03-03 @38) #include "stages/stage1_defines.h"
3a73333fb370f7 Steven Rostedt (Google  2022-03-03  39) 

:::::: The code at line 38 was first introduced by commit
:::::: 3a73333fb370f7b65de9d94c53df503642bda789 tracing: Add TRACE_CUSTOM_EVENT() macro

:::::: TO: Steven Rostedt (Google) <rostedt@goodmis.org>
:::::: CC: Steven Rostedt (Google) <rostedt@goodmis.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
