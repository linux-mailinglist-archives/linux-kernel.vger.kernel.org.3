Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A4564395
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 03:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiGCBxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 21:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiGCBxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 21:53:30 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEA0AE78;
        Sat,  2 Jul 2022 18:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656813208; x=1688349208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FeCzh1lV5+YW3m3VQjD7k6MVEVciEB1YGGhWNqYpr0A=;
  b=OFFUc0K5wjfzRrxiI6rCEtSkuUjxat/i5ANy67+j/OdtlKRLTzNyT1uS
   nS5bM+7sJp0tWnO6Jfa5gr/NlDJM2FK25GutZ/YRb/IOHpei1yCispTNW
   wpSSOkUnuLTOw9z0GTvWrO97UN+E49a+wDqN8QJL+x4Ip3n5mgpcf7sGP
   2O1A4mg/0Tn4eRHtHZCcg+EJQcirqdBO0nsN+FpCM1hyWq37GMjtXlYpa
   CGLohMp/VHpHLlnDu1/rTGIgF1qV1qkNnP0j+ar8uQ+1ZZH6pGoQ65tBh
   tGupiOM98Po3E4f+ve6EebtKWqYCcnxlh6cteuWvvfQv6jFAaKaJSM9CF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10396"; a="369213301"
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="369213301"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2022 18:53:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,241,1650956400"; 
   d="scan'208";a="768867606"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Jul 2022 18:53:24 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7onc-000Fwf-38;
        Sun, 03 Jul 2022 01:53:24 +0000
Date:   Sun, 3 Jul 2022 09:52:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     andrea.merello@iit.it, jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, lars@metafoo.de,
        robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v6 12/14] iio: imu: add BNO055 serdev driver
Message-ID: <202207030922.GDkeqL76-lkp@intel.com>
References: <20220613120534.36991-13-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613120534.36991-13-andrea.merello@iit.it>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v5.19-rc4 next-20220701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/andrea-merello-iit-it/Add-support-for-Bosch-BNO055-IMU/20220614-203754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220703/202207030922.GDkeqL76-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project bcd153485ebf07fe79e2b843ed5f1cb74997df1b)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f37504a206ca4b342e184a1fc137f6c47f3960e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review andrea-merello-iit-it/Add-support-for-Bosch-BNO055-IMU/20220614-203754
        git checkout f37504a206ca4b342e184a1fc137f6c47f3960e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/iio/imu/bno055/bno055_ser_trace.c:13:
   In file included from drivers/iio/imu/bno055/./bno055_ser_trace.h:104:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
>> drivers/iio/imu/bno055/./bno055_ser_trace.h:92:9: warning: format specifies type 'int' but the argument has type 'size_t' (aka 'unsigned long') [-Wformat]
                         __entry->len, __entry->len, __get_dynamic_array(buf)
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/trace/stages/stage3_trace_output.h:6:17: note: expanded from macro '__entry'
   #define __entry field
                   ^
   include/trace/stages/stage3_trace_output.h:9:43: note: expanded from macro 'TP_printk'
   #define TP_printk(fmt, args...) fmt "\n", args
                                   ~~~       ^
   include/trace/trace_events.h:45:16: note: expanded from macro 'TRACE_EVENT'
                                PARAMS(print));                   \
                                ~~~~~~~^~~~~~~
   include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
   #define PARAMS(args...) args
                           ^~~~
   include/trace/trace_events.h:203:27: note: expanded from macro 'DECLARE_EVENT_CLASS'
           trace_event_printf(iter, print);                                \
                                    ^~~~~
   In file included from drivers/iio/imu/bno055/bno055_ser_trace.c:13:
   In file included from drivers/iio/imu/bno055/./bno055_ser_trace.h:104:
   In file included from include/trace/define_trace.h:102:
   In file included from include/trace/trace_events.h:237:
>> drivers/iio/imu/bno055/./bno055_ser_trace.h:91:36: warning: field width should have type 'int', but argument has type 'size_t' (aka 'unsigned long') [-Wformat]
               TP_printk("len: %d, data: = %*ph",
               ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~
   include/trace/stages/stage3_trace_output.h:9:33: note: expanded from macro 'TP_printk'
   #define TP_printk(fmt, args...) fmt "\n", args
                                   ^~~
   include/trace/trace_events.h:45:16: note: expanded from macro 'TRACE_EVENT'
                                PARAMS(print));                   \
                                ~~~~~~~^~~~~~~
   include/linux/tracepoint.h:107:25: note: expanded from macro 'PARAMS'
   #define PARAMS(args...) args
                           ^~~~
   include/trace/trace_events.h:203:27: note: expanded from macro 'DECLARE_EVENT_CLASS'
           trace_event_printf(iter, print);                                \
                                    ^~~~~
   2 warnings generated.


vim +92 drivers/iio/imu/bno055/./bno055_ser_trace.h

    78	
    79	TRACE_EVENT(recv,
    80		    TP_PROTO(size_t len, const unsigned char *buf),
    81		    TP_ARGS(len, buf),
    82		    TP_STRUCT__entry(
    83			    __field(size_t, len)
    84			    __dynamic_array(unsigned char, buf, len)
    85		    ),
    86		    TP_fast_assign(
    87			    __entry->len = len;
    88			    memcpy(__get_dynamic_array(buf),
    89				   buf, __entry->len);
    90		    ),
  > 91		    TP_printk("len: %d, data: = %*ph",
  > 92			      __entry->len, __entry->len, __get_dynamic_array(buf)
    93		    )
    94	);
    95	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
