Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019844BF191
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 06:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiBVFkf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 00:40:35 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:58778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiBVFkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:40:20 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09C69AE5F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 21:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645508394; x=1677044394;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=5/6SIRNOGPV2Mhs94kecYmWyXpNguhmOKvN0q9VUa6E=;
  b=mpTdRQlJFRn0st5W4VDmPRa5tc/tQoYrmrtj2i/BH1f50XfSJfklumAG
   3bymltNeIj1I1aQOQjTdURB/PMNNEHPY1VnRI9Q3hTCaRhjWquzBkK2Dx
   Dny/2hKCP/yNUwGiSCBUL5UEg+bjuI/+H1hMggRNgZRvdF/D1yQgJ3/d6
   0xWKLIN7y/Il/+17+QWxmPrOEeXF7kVtPyJeEq6zBvkRSrO6v6qWSHarl
   iSz/Xyy1g0rgAvQmamOudrGeDSDn4UvI2UM2fZPSM1V+tSuU8lfP8jzAu
   aE5thujks2jgAbwYibxhpf9sZDT7nOHM6FKXOkcyj0VRbuy22LaX1jFJg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="338048629"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="338048629"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 21:39:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="573308830"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 21 Feb 2022 21:39:53 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMNtw-0002NP-Kg; Tue, 22 Feb 2022 05:39:52 +0000
Date:   Tue, 22 Feb 2022 13:39:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2011/2541]
 drivers/infiniband/ulp/srp/ib_srp.c:75: warning:
 "DEFINE_DYNAMIC_DEBUG_METADATA" redefined
Message-ID: <202202221338.VBCHmMJr-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   601144c0da5edfa67a9654158370da19c67e17e2
commit: 851f9d758cf215ebf131c634c6ec7bf12e91f19f [2011/2541] headers/deps: Optimize <linux/jump_label.h>, remove the <linux/atomic_api.h> inclusion in the CONFIG_JUMP_LABEL=y case
config: i386-randconfig-a006-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221338.VBCHmMJr-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=851f9d758cf215ebf131c634c6ec7bf12e91f19f
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout 851f9d758cf215ebf131c634c6ec7bf12e91f19f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/infiniband/ulp/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/infiniband/ulp/srp/ib_srp.c:75: warning: "DEFINE_DYNAMIC_DEBUG_METADATA" redefined
      75 | #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
         | 
   In file included from include/linux/dev_printk.h:16,
                    from include/linux/device_types.h:19,
                    from include/linux/device_api.h:15,
                    from include/linux/device_api_lock.h:5,
                    from include/linux/fwnode.h:12,
                    from include/linux/logic_pio.h:11,
                    from include/asm-generic/io.h:526,
                    from arch/x86/include/asm/io.h:363,
                    from include/linux/scatterlist_api.h:12,
                    from drivers/infiniband/ulp/srp/ib_srp.c:38:
   include/linux/dynamic_debug.h:90: note: this is the location of the previous definition
      90 | #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)  \
         | 
>> drivers/infiniband/ulp/srp/ib_srp.c:76: warning: "DYNAMIC_DEBUG_BRANCH" redefined
      76 | #define DYNAMIC_DEBUG_BRANCH(descriptor) false
         | 
   In file included from include/linux/dev_printk.h:16,
                    from include/linux/device_types.h:19,
                    from include/linux/device_api.h:15,
                    from include/linux/device_api_lock.h:5,
                    from include/linux/fwnode.h:12,
                    from include/linux/logic_pio.h:11,
                    from include/asm-generic/io.h:526,
                    from arch/x86/include/asm/io.h:363,
                    from include/linux/scatterlist_api.h:12,
                    from drivers/infiniband/ulp/srp/ib_srp.c:38:
   include/linux/dynamic_debug.h:125: note: this is the location of the previous definition
     125 | #define DYNAMIC_DEBUG_BRANCH(descriptor) \
         | 


vim +/DEFINE_DYNAMIC_DEBUG_METADATA +75 drivers/infiniband/ulp/srp/ib_srp.c

e0bda7d8c33e60f Bart Van Assche 2012-01-14  34  
39b7930ffcd9482 Ingo Molnar     2022-02-10  35  #include <linux/workqueue_api.h>
71340bbb4ef4d34 Ingo Molnar     2022-02-10  36  #include <linux/sysfs.h>
b5bebb042abcc08 Ingo Molnar     2022-02-10  37  #include <linux/spinlock_api.h>
b95b81156f20922 Ingo Molnar     2022-02-10 @38  #include <linux/scatterlist_api.h>
be6d52829da1be8 Ingo Molnar     2022-02-10  39  #include <linux/nodemask.h>
55f2261aa49417c Ingo Molnar     2022-02-10  40  #include <linux/mutex_api.h>
0c135d6371d0a8c Ingo Molnar     2022-02-10  41  #include <linux/lockdep_api.h>
143796d5082e822 Ingo Molnar     2022-02-10  42  #include <linux/device_api_lock.h>
c333421486810d6 Ingo Molnar     2022-02-10  43  #include <linux/cpumask_api.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  44  #include <linux/module.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  45  #include <linux/init.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  46  #include <linux/slab.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  47  #include <linux/err.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  48  #include <linux/string.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  49  #include <linux/parser.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  50  #include <linux/random.h>
de25968cc87cc5b Tim Schmielau   2006-01-08  51  #include <linux/jiffies.h>
93c76dbb749eb0c Bart Van Assche 2017-02-14  52  #include <linux/lockdep.h>
19f313438c7754e Bart Van Assche 2018-01-22  53  #include <linux/inet.h>
56b5390caf73694 Bart Van Assche 2014-07-09  54  #include <rdma/ib_cache.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  55  
60063497a95e716 Arun Sharma     2011-07-26  56  #include <linux/atomic.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  57  
aef9ec39c47f0ce Roland Dreier   2005-11-02  58  #include <scsi/scsi.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  59  #include <scsi/scsi_device.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  60  #include <scsi/scsi_dbg.h>
71444b97816ae08 Jack Wang       2013-11-07  61  #include <scsi/scsi_tcq.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  62  #include <scsi/srp.h>
3236822b1c9b67a FUJITA Tomonori 2007-06-27  63  #include <scsi/scsi_transport_srp.h>
aef9ec39c47f0ce Roland Dreier   2005-11-02  64  
aef9ec39c47f0ce Roland Dreier   2005-11-02  65  #include "ib_srp.h"
aef9ec39c47f0ce Roland Dreier   2005-11-02  66  
aef9ec39c47f0ce Roland Dreier   2005-11-02  67  #define DRV_NAME	"ib_srp"
aef9ec39c47f0ce Roland Dreier   2005-11-02  68  #define PFX		DRV_NAME ": "
aef9ec39c47f0ce Roland Dreier   2005-11-02  69  
aef9ec39c47f0ce Roland Dreier   2005-11-02  70  MODULE_AUTHOR("Roland Dreier");
33ab3e5ba2f7d64 Bart Van Assche 2015-05-18  71  MODULE_DESCRIPTION("InfiniBand SCSI RDMA Protocol initiator");
aef9ec39c47f0ce Roland Dreier   2005-11-02  72  MODULE_LICENSE("Dual BSD/GPL");
aef9ec39c47f0ce Roland Dreier   2005-11-02  73  
1a1faf7a8a251d1 Bart Van Assche 2016-11-21  74  #if !defined(CONFIG_DYNAMIC_DEBUG)
1a1faf7a8a251d1 Bart Van Assche 2016-11-21 @75  #define DEFINE_DYNAMIC_DEBUG_METADATA(name, fmt)
1a1faf7a8a251d1 Bart Van Assche 2016-11-21 @76  #define DYNAMIC_DEBUG_BRANCH(descriptor) false
1a1faf7a8a251d1 Bart Van Assche 2016-11-21  77  #endif
1a1faf7a8a251d1 Bart Van Assche 2016-11-21  78  

:::::: The code at line 75 was first introduced by commit
:::::: 1a1faf7a8a251d134d375b7783a614ee79e932f2 IB/srp: Fix CONFIG_DYNAMIC_DEBUG=n build

:::::: TO: Bart Van Assche <bart.vanassche@sandisk.com>
:::::: CC: Doug Ledford <dledford@redhat.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
