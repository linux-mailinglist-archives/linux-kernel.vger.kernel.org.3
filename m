Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1D745A0305
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 22:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240540AbiHXUu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 16:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240529AbiHXUuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 16:50:46 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A57E786C5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 13:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661374245; x=1692910245;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qTQyDimqLczvXe7qOc2XYZAeqDkH+iES8idreQ3skn8=;
  b=J5w/vCG4D0XLeh9bhcntiYDX51T+yCIIfGw7RPHV9hyCl7lHi0vyPKSW
   rfiGYLlMaSIDBDvBHFyuLysA3yp2aAacmQP7swheAgykq0F+MQuL69TGr
   9ytT2T+S3MiekASNT+kAUBlI7hdGjfnmT1MaH4m9mvu7FlYpgY5rMqSRj
   qxceJWAvF1/TLqGF+8cDO4jm2mB1mZsHo+JOteca3IvaKAP4Y17KvNmnS
   C5tYN8O56bG35YPdiIevZru2U6Sy3mIv+vnLAJlEouXPVJbt3z2CyXdNh
   B4k+0jRH7bSFQfzk8zaYnCf6g6Fv9lWW2FUGM+sbBGM3t0+VnGr/OyMzH
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10449"; a="274462333"
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="274462333"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 13:50:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,261,1654585200"; 
   d="scan'208";a="752225118"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 24 Aug 2022 13:50:43 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQxKl-0001Ar-0S;
        Wed, 24 Aug 2022 20:50:43 +0000
Date:   Thu, 25 Aug 2022 04:50:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:tracing 2/2] include/linux/compiler.h:246:47: warning:
 ordered comparison of pointer with null pointer
Message-ID: <202208250433.EVz5pZkB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux tracing
head:   e50691460d5ea5a49b903e0ea50276e942b6f34f
commit: e50691460d5ea5a49b903e0ea50276e942b6f34f [2/2] tracing: Define is_signed_type() once
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220825/202208250433.EVz5pZkB-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/bvanassche/linux/commit/e50691460d5ea5a49b903e0ea50276e942b6f34f
        git remote add bvanassche https://github.com/bvanassche/linux
        git fetch --no-tags bvanassche tracing
        git checkout e50691460d5ea5a49b903e0ea50276e942b6f34f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/net/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/net/wireless/mediatek/mt7601u/trace.h:392,
                    from drivers/net/wireless/mediatek/mt7601u/trace.c:11:
>> include/linux/compiler.h:246:47: warning: ordered comparison of pointer with null pointer [-Wextra]
     246 | #define is_signed_type(type)    (((type)(-1)) <= (type)0)
         |                                               ^~
   include/trace/trace_events.h:244:9: note: in definition of macro 'DECLARE_EVENT_CLASS'
     244 |         tstruct                                                         \
         |         ^~~~~~~
   include/trace/trace_events.h:43:30: note: in expansion of macro 'PARAMS'
      43 |                              PARAMS(tstruct),                  \
         |                              ^~~~~~
   drivers/net/wireless/mediatek/mt7601u/./trace.h:98:1: note: in expansion of macro 'TRACE_EVENT'
      98 | TRACE_EVENT(mt_vend_req,
         | ^~~~~~~~~~~
   drivers/net/wireless/mediatek/mt7601u/./trace.h:102:9: note: in expansion of macro 'TP_STRUCT__entry'
     102 |         TP_STRUCT__entry(
         |         ^~~~~~~~~~~~~~~~
   include/trace/stages/stage4_event_fields.h:11:22: note: in expansion of macro 'is_signed_type'
      11 |         .is_signed = is_signed_type(_type), .filter_type = _filter_type },
         |                      ^~~~~~~~~~~~~~
   include/trace/stages/stage4_event_fields.h:20:33: note: in expansion of macro '__field_ext'
      20 | #define __field(type, item)     __field_ext(type, item, FILTER_OTHER)
         |                                 ^~~~~~~~~~~
   drivers/net/wireless/mediatek/mt7601u/./trace.h:105:56: note: in expansion of macro '__field'
     105 |                 __field(u16, val) __field(u16, offset) __field(void*, buf)
         |                                                        ^~~~~~~


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
