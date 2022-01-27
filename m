Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FC949E038
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbiA0LG5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:06:57 -0500
Received: from mga06.intel.com ([134.134.136.31]:45234 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230431AbiA0LG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643281616; x=1674817616;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KT4Io8SuF1OZXTOQG/jfIaXJVOGu7qVprJChDj/DzkM=;
  b=k5H0IsT3/uoPIMKimOMHIi62W/3wl232MB55feOCniUK2bkJhQWraL1S
   Y4VcushMf1tqKc0K+pRXRPjvaEEJvYKMVDg/wK64MwC76FjXw48+Me/v0
   S1aG/MbL+sVi3RNrWVwXbMcJR8mPz33z2V7fFFh/V5TdCDVwmILWMEvxb
   Il82AJRg2r1ewJg3vkn7LgFUnpq4JardUxI5aQKod5ytqEbQOH99bAbg5
   9755mH0CRqi3H1FfaLKGO3YMXg2OScQH4b+imW3AO+n7d2VNG9kKILAAg
   yegDo92hEAc4oBVEUlPO21rV2EDXq1ZOrMmkIuVrR+PfYfydy0g13OjYm
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="307533344"
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="307533344"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 03:06:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,320,1635231600"; 
   d="scan'208";a="625181578"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jan 2022 03:06:54 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD2c9-000MX1-NK; Thu, 27 Jan 2022 11:06:53 +0000
Date:   Thu, 27 Jan 2022 19:06:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Armelle Laine <armellel@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5860/5866] drivers/trusty/trusty-log.c:354:21: warning: left shift count >=
 width of type
Message-ID: <202201271930.7h18TAIk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   52cdd137fae0b001197a51646289e3cbdda921d5
commit: bf9d994a65a2941d96b58769d79c256f7d8862c0 [5860/5866] ANDROID: trusty-log: Complement logging sink with unthrottled virtual file
config: arm-allyesconfig (https://download.01.org/0day-ci/archive/20220127/202201271930.7h18TAIk-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/bf9d994a65a2941d96b58769d79c256f7d8862c0
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android12-trusty-5.10
        git checkout bf9d994a65a2941d96b58769d79c256f7d8862c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/trusty/trusty-log.c: In function 'trusty_log_seq_next':
>> drivers/trusty/trusty-log.c:354:21: warning: left shift count >= width of type [-Wshift-count-overflow]
     354 |         *pos = (1UL << 32) + log_sfile_sink->get;
         |                     ^~


vim +354 drivers/trusty/trusty-log.c

   323	
   324	static void *trusty_log_seq_next(struct seq_file *sfile, void *v, loff_t *pos)
   325	{
   326		struct trusty_log_sfile *lb;
   327		struct trusty_log_state *s;
   328		struct trusty_log_sink_state *log_sfile_sink = v;
   329		int rc = 0;
   330	
   331		if (WARN_ON(!log_sfile_sink))
   332			return ERR_PTR(-EINVAL);
   333	
   334		lb = sfile->private;
   335		if (WARN_ON(!lb)) {
   336			rc = -EINVAL;
   337			goto end_of_iter;
   338		}
   339		s = container_of(lb, struct trusty_log_state, log_sfile);
   340	
   341		if (WARN_ON(!pos)) {
   342			rc = -EINVAL;
   343			goto end_of_iter;
   344		}
   345		/*
   346		 * When starting a virtual file sink, the start function is invoked
   347		 * with a pos argument which value is set to zero.
   348		 * Subsequent starts are invoked with pos being set to
   349		 * the unwrapped read index (get).
   350		 * Upon u32 wraparound, the get index could be reset to zero.
   351		 * Thus a msb is used to distinguish the `get` zero value
   352		 * from the `start of file` zero value.
   353		 */
 > 354		*pos = (1UL << 32) + log_sfile_sink->get;
   355		if (!trusty_log_has_data(s, log_sfile_sink))
   356			goto end_of_iter;
   357	
   358		return log_sfile_sink;
   359	
   360	end_of_iter:
   361		pr_debug("%s kfree\n", __func__);
   362		kfree(log_sfile_sink);
   363		return rc < 0 ? ERR_PTR(rc) : NULL;
   364	}
   365	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
