Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D6E4ED286
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 06:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiCaEOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 00:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbiCaEOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 00:14:19 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE912A046D
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 20:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648698658; x=1680234658;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ywsd5TczOlk5hhmei9XyZgtcABww4n4fQ4XaXobWeWo=;
  b=aGBYqhvoaGdPS4TraHHsP2/goKeWuBUBx8OfoMXvtKz34VQ84G5Kfvhw
   E1RQq+nr/INtny15AbTe+aXbrKBUSgRvWIpaOzUhNd0owskNwc9YWwMZd
   e7fL+7Q9TD3Ld/OcgdQpMneUux0EumVC7tGo0Qk3BKWQqFC8Q6SVj0/yN
   sf74LKaipE+Mso7idpghoSacEo0mHbAnxm9/koSpSOhOZCdSphePCHxL/
   mFHTZV0vXWJKIighMPS52DWkUnFtSVFgzFQ7uCOlUT8T5VNh6kOQhkiR8
   RxkdSfW+9kI7cwZRJNWiUvGLDrwm+9N3nA5k/p4RY9B7N7oDOQLIp1WsN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="257291100"
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="257291100"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 20:28:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,224,1643702400"; 
   d="scan'208";a="503570632"
Received: from lkp-server02.sh.intel.com (HELO 56431612eabd) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Mar 2022 20:28:53 -0700
Received: from kbuild by 56431612eabd with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZlUS-0000oS-IN;
        Thu, 31 Mar 2022 03:28:52 +0000
Date:   Thu, 31 Mar 2022 11:28:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Armelle Laine <armellel@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-trusty-5.10
 5860/5872] drivers/trusty/trusty-log.c:354:21: warning: left shift count >=
 width of type
Message-ID: <202203311133.4BHUMmsV-lkp@intel.com>
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

Hi Armelle,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-trusty-5.10
head:   07055bfd3d810d41a38354693dfaa55a6f8c0025
commit: bf9d994a65a2941d96b58769d79c256f7d8862c0 [5860/5872] ANDROID: trusty-log: Complement logging sink with unthrottled virtual file
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220331/202203311133.4BHUMmsV-lkp@intel.com/config)
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

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
