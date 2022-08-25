Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D5D5A11B0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242416AbiHYNQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:16:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240415AbiHYNQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:16:00 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76B489C52E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661433359; x=1692969359;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=vvc2h5LMlKQZGALRbfJv5QjEsKRukAP9iNiiDGmIH5Q=;
  b=WXaGAzP4MLEi8d+bH9oFOikNbvJKckY+gd3PuHlyhyUXCUNQLqxrc8lQ
   6gPe2nYuZ7GoZCFmjqPALvl/SxOS900H9H+mrSPplspHeuRnWtL7JDZXN
   VJ7bG0pLXBXDzO7cjM5XEn02FAsMjA9ked2GOucnZf8sw5uZx2Pn/w5Pq
   jIJMBrqE8iodXjeONtqGp7Ecmtv37os2r4MB44XG/aENukPCFgNc8SsOz
   BswgluTqrRA4uFEG20ZITcMiygvQb3fXWzCIHgkePzFKCOsjxrc8BUafV
   QM/AFDLxQ8So/rd8hIpLzoo26fyqotfjXv2o6FFvI7cjhzWCRpPcQUzjx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10450"; a="295010620"
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="295010620"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2022 06:15:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,263,1654585200"; 
   d="scan'208";a="586868634"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 25 Aug 2022 06:15:58 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oRCiD-0002Hq-11;
        Thu, 25 Aug 2022 13:15:57 +0000
Date:   Thu, 25 Aug 2022 21:15:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:tracing 2/2] include/linux/compiler.h:246:47: error:
 ordered comparison of pointer with null pointer
Message-ID: <202208252159.T4WiCecR-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux tracing
head:   e50691460d5ea5a49b903e0ea50276e942b6f34f
commit: e50691460d5ea5a49b903e0ea50276e942b6f34f [2/2] tracing: Define is_signed_type() once
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220825/202208252159.T4WiCecR-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-5) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/bvanassche/linux/commit/e50691460d5ea5a49b903e0ea50276e942b6f34f
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche tracing
        git checkout e50691460d5ea5a49b903e0ea50276e942b6f34f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/gpu/drm/i915/gvt/trace.h:383,
                    from drivers/gpu/drm/i915/gvt/trace_points.c:33:
>> include/linux/compiler.h:246:47: error: ordered comparison of pointer with null pointer [-Werror=extra]
     246 | #define is_signed_type(type)    (((type)(-1)) <= (type)0)
         |                                               ^~
   include/trace/trace_events.h:244:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     244 |         tstruct                                                         \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   include/trace/../../drivers/gpu/drm/i915/gvt/trace.h:42:1: note: in expansion of macro 'TRACE_EVENT'
      42 | TRACE_EVENT(spt_alloc,
         | ^~~~~~~~~~~
   include/trace/../../drivers/gpu/drm/i915/gvt/trace.h:48:9: note: in expansion of macro 'TP_STRUCT__entry'
      48 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/stages/stage4_event_fields.h:11:22: note: in expansion of macro 'is_signed_type'
      11 |         .is_signed = is_signed_type(_type), .filter_type = _filter_type },
         |                      ^~~~~~~~~~~~~~
   include/trace/stages/stage4_event_fields.h:20:33: note: in expansion of macro '__field_ext'
      20 | #define __field(type, item)     __field_ext(type, item, FILTER_OTHER)
         |                                 ^~~~~~~~~~~
   include/trace/../../drivers/gpu/drm/i915/gvt/trace.h:50:17: note: in expansion of macro '__field'
      50 |                 __field(void *, spt)
         |                 ^~~~~~~
>> include/linux/compiler.h:246:47: error: ordered comparison of pointer with null pointer [-Werror=extra]
     246 | #define is_signed_type(type)    (((type)(-1)) <= (type)0)
         |                                               ^~
   include/trace/trace_events.h:244:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     244 |         tstruct                                                         \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   include/trace/../../drivers/gpu/drm/i915/gvt/trace.h:72:1: note: in expansion of macro 'TRACE_EVENT'
      72 | TRACE_EVENT(spt_free,
         | ^~~~~~~~~~~
   include/trace/../../drivers/gpu/drm/i915/gvt/trace.h:77:9: note: in expansion of macro 'TP_STRUCT__entry'
      77 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/stages/stage4_event_fields.h:11:22: note: in expansion of macro 'is_signed_type'
      11 |         .is_signed = is_signed_type(_type), .filter_type = _filter_type },
         |                      ^~~~~~~~~~~~~~
   include/trace/stages/stage4_event_fields.h:20:33: note: in expansion of macro '__field_ext'
      20 | #define __field(type, item)     __field_ext(type, item, FILTER_OTHER)
         |                                 ^~~~~~~~~~~
   include/trace/../../drivers/gpu/drm/i915/gvt/trace.h:79:17: note: in expansion of macro '__field'
      79 |                 __field(void *, spt)
         |                 ^~~~~~~
>> include/linux/compiler.h:246:47: error: ordered comparison of pointer with null pointer [-Werror=extra]
     246 | #define is_signed_type(type)    (((type)(-1)) <= (type)0)
         |                                               ^~
   include/trace/trace_events.h:244:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     244 |         tstruct                                                         \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   include/trace/../../drivers/gpu/drm/i915/gvt/trace.h:228:1: note: in expansion of macro 'TRACE_EVENT'
     228 | TRACE_EVENT(gvt_command,
         | ^~~~~~~~~~~
   include/trace/../../drivers/gpu/drm/i915/gvt/trace.h:236:9: note: in expansion of macro 'TP_STRUCT__entry'
     236 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/stages/stage4_event_fields.h:11:22: note: in expansion of macro 'is_signed_type'
      11 |         .is_signed = is_signed_type(_type), .filter_type = _filter_type },
         |                      ^~~~~~~~~~~~~~
   include/trace/stages/stage4_event_fields.h:20:33: note: in expansion of macro '__field_ext'
      20 | #define __field(type, item)     __field_ext(type, item, FILTER_OTHER)
         |                                 ^~~~~~~~~~~
   include/trace/../../drivers/gpu/drm/i915/gvt/trace.h:243:17: note: in expansion of macro '__field'
     243 |                 __field(void*, workload)
         |                 ^~~~~~~
   cc1: all warnings being treated as errors


vim +246 include/linux/compiler.h

   241	
   242	/*
   243	 * Whether 'type' is a signed type or an unsigned type. Supports scalar types,
   244	 * bool and also pointer types.
   245	 */
 > 246	#define is_signed_type(type)	(((type)(-1)) <= (type)0)
   247	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
