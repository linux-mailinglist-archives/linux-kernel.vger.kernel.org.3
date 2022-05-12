Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA6385244DD
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 07:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349914AbiELF0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 01:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349850AbiELF0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 01:26:37 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 288BD68FB0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 22:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652333197; x=1683869197;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=mVfM7QLj1rXP6K3oDoIRYasH9S55bIGd4untQqkVOFQ=;
  b=eRWlLZ4BKNdRBs/6VcZk/bb/Ric8cj2zCsmiZ6lUAafXy5cqkGb02o1Y
   b2xkM51P/+37cTcylFfEGShqz/v/MuzWmwTYf5PGPCMgdPoSlcdPihDUb
   XGgtn03VZEnIozAKpFfj9Js2coPPmknlSINEnaKx3OvRx1aztTlZ/UxGu
   BrwaNIhrk/0qoZVFCnDDtQ51A6ubQ2pS3hrdZmpx2vEd32VOgM6TV2tsu
   2yckPCFfZvsXpyyOkElijlHzfhCoUv90CL3dh82m+ERQFFXUnrNiznev/
   cQx+nd5iRa9llgu/b99j2MFy+IThlMn1bs2eBO7pGCIRmmZ97FjT7r1ju
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="269568881"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="269568881"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 22:26:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="697882184"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 11 May 2022 22:26:35 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1np1LO-000JyY-PJ;
        Thu, 12 May 2022 05:26:34 +0000
Date:   Thu, 12 May 2022 13:26:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3289
 pvr2_hdw_get_tuner_status() warn: inconsistent indenting
Message-ID: <202205121326.j3iqIW7j-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   feb9c5e19e913b53cb536a7aa7c9f20107bb51ec
commit: f68f2ff91512c199ec24883001245912afc17873 fortify: Detect struct member overflows in memcpy() at compile-time
date:   3 months ago
config: x86_64-randconfig-m031-20220509 (https://download.01.org/0day-ci/archive/20220512/202205121326.j3iqIW7j-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/media/usb/pvrusb2/pvrusb2-hdw.c:3289 pvr2_hdw_get_tuner_status() warn: inconsistent indenting

vim +3289 drivers/media/usb/pvrusb2/pvrusb2-hdw.c

432907f750b27a drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2008-08-31  3279  
432907f750b27a drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2008-08-31  3280  
18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3281  /* Return information about the tuner */
18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3282  int pvr2_hdw_get_tuner_status(struct pvr2_hdw *hdw,struct v4l2_tuner *vtp)
18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3283  {
18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3284  	LOCK_TAKE(hdw->big_lock); do {
18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3285  		if (hdw->tuner_signal_stale) {
a51f5000b79100 drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2009-03-06  3286  			pvr2_hdw_status_poll(hdw);
18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3287  		}
18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3288  		memcpy(vtp,&hdw->tuner_signal_info,sizeof(struct v4l2_tuner));
18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20 @3289  	} while (0); LOCK_GIVE(hdw->big_lock);
18103c57b0168e drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2007-01-20  3290  	return 0;
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2006-06-26  3291  }
d855497edbfbf9 drivers/media/video/pvrusb2/pvrusb2-hdw.c Mike Isely 2006-06-26  3292  

:::::: The code at line 3289 was first introduced by commit
:::::: 18103c57b0168ebc0401702d483fe131f0aecc7a V4L/DVB (5081): Pvrusb2: VIDIOC_G_TUNER cleanup

:::::: TO: Mike Isely <isely@pobox.com>
:::::: CC: Mauro Carvalho Chehab <mchehab@infradead.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
