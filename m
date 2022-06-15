Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A7E54D323
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 22:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244918AbiFOU5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 16:57:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349526AbiFOU53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 16:57:29 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864CCEE;
        Wed, 15 Jun 2022 13:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655326647; x=1686862647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j32A2ln2a4HIS+edUjMgD5y4tolWGujNBMVnjAN23m0=;
  b=m2TtIfmUfHgZg8ZnlVdlfBLMpE29eLE+QVNkFhnWxhzTHnDLEpDM/vk2
   u8xT476Dx4vYLtXHQBbDZ7AxxLhYIGYgmXdTQQbLbcE8L1aWxYgHbAR8w
   2XUnUjqScYA9JVei74KESTddtZBbFJil/5+t6T1Y1Onfrg6FyvsRyByPu
   w1G3Q1mzHEgNwH5n5eskVgAz1xQj1iHVtNYKdgCFRki/qGbblBA8f6fEX
   mvOAYVVU27/i4ueYvKAVT6trf+xBxrUEJixqpncqauugRNXbAyLbzl4Kn
   dxoiBGsM4SVGQB04OWsvbM3YKsfj3DDhZzxr2gH+wr5mRhrKxDiPxvuuu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10379"; a="258954051"
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="258954051"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2022 13:57:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,302,1647327600"; 
   d="scan'208";a="652859560"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 15 Jun 2022 13:57:24 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1a4p-000NNP-E7;
        Wed, 15 Jun 2022 20:57:23 +0000
Date:   Thu, 16 Jun 2022 04:57:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     andrea.merello@iit.it, jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v6 12/14] iio: imu: add BNO055 serdev driver
Message-ID: <202206160409.GTDk9b3k-lkp@intel.com>
References: <20220613120534.36991-13-andrea.merello@iit.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613120534.36991-13-andrea.merello@iit.it>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master v5.19-rc2 next-20220615]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/andrea-merello-iit-it/Add-support-for-Bosch-BNO055-IMU/20220614-203754
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220616/202206160409.GTDk9b3k-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f37504a206ca4b342e184a1fc137f6c47f3960e9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review andrea-merello-iit-it/Add-support-for-Bosch-BNO055-IMU/20220614-203754
        git checkout f37504a206ca4b342e184a1fc137f6c47f3960e9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/gpu/ drivers/iio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/trace/define_trace.h:102,
                    from drivers/iio/imu/bno055/bno055_ser_trace.h:104,
                    from drivers/iio/imu/bno055/bno055_ser_trace.c:13:
   drivers/iio/imu/bno055/./bno055_ser_trace.h: In function 'trace_raw_output_recv':
>> drivers/iio/imu/bno055/./bno055_ser_trace.h:91:23: warning: format '%d' expects argument of type 'int', but argument 3 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
      91 |             TP_printk("len: %d, data: = %*ph",
         |                       ^~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
      45 |                              PARAMS(print));                   \
         |                              ^~~~~~
   drivers/iio/imu/bno055/./bno055_ser_trace.h:79:1: note: in expansion of macro 'TRACE_EVENT'
      79 | TRACE_EVENT(recv,
         | ^~~~~~~~~~~
   drivers/iio/imu/bno055/./bno055_ser_trace.h:91:13: note: in expansion of macro 'TP_printk'
      91 |             TP_printk("len: %d, data: = %*ph",
         |             ^~~~~~~~~
   In file included from include/trace/trace_events.h:237,
                    from include/trace/define_trace.h:102,
                    from drivers/iio/imu/bno055/bno055_ser_trace.h:104,
                    from drivers/iio/imu/bno055/bno055_ser_trace.c:13:
   drivers/iio/imu/bno055/./bno055_ser_trace.h:91:30: note: format string is defined here
      91 |             TP_printk("len: %d, data: = %*ph",
         |                             ~^
         |                              |
         |                              int
         |                             %ld
   In file included from include/trace/define_trace.h:102,
                    from drivers/iio/imu/bno055/bno055_ser_trace.h:104,
                    from drivers/iio/imu/bno055/bno055_ser_trace.c:13:
>> drivers/iio/imu/bno055/./bno055_ser_trace.h:91:23: warning: field width specifier '*' expects argument of type 'int', but argument 4 has type 'size_t' {aka 'long unsigned int'} [-Wformat=]
      91 |             TP_printk("len: %d, data: = %*ph",
         |                       ^~~~~~~~~~~~~~~~~~~~~~~
   include/trace/trace_events.h:203:34: note: in definition of macro 'DECLARE_EVENT_CLASS'
     203 |         trace_event_printf(iter, print);                                \
         |                                  ^~~~~
   include/trace/trace_events.h:45:30: note: in expansion of macro 'PARAMS'
      45 |                              PARAMS(print));                   \
         |                              ^~~~~~
   drivers/iio/imu/bno055/./bno055_ser_trace.h:79:1: note: in expansion of macro 'TRACE_EVENT'
      79 | TRACE_EVENT(recv,
         | ^~~~~~~~~~~
   drivers/iio/imu/bno055/./bno055_ser_trace.h:91:13: note: in expansion of macro 'TP_printk'
      91 |             TP_printk("len: %d, data: = %*ph",
         |             ^~~~~~~~~
   In file included from include/trace/trace_events.h:237,
                    from include/trace/define_trace.h:102,
                    from drivers/iio/imu/bno055/bno055_ser_trace.h:104,
                    from drivers/iio/imu/bno055/bno055_ser_trace.c:13:
   drivers/iio/imu/bno055/./bno055_ser_trace.h:91:42: note: format string is defined here
      91 |             TP_printk("len: %d, data: = %*ph",
         |                                         ~^~
         |                                          |
         |                                          int


vim +91 drivers/iio/imu/bno055/./bno055_ser_trace.h

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
    92			      __entry->len, __entry->len, __get_dynamic_array(buf)
    93		    )
    94	);
    95	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
