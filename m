Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 081544B9E60
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 12:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238629AbiBQLLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 06:11:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239693AbiBQLLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 06:11:08 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CBF2A5218;
        Thu, 17 Feb 2022 03:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645096249; x=1676632249;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kUAzxYLqH3Wl8CbcjdnZky0Irg6Ay/7fZGWkkNOZACY=;
  b=BdJG3U8t8nip1IOZCi250iFzNmC6P1wS+2bDjnccUaquMw6sw8ncvEP4
   oMpMIyRtydg7ajkNPRP5UKyf+RRjhoxVP7yTlX5Ru9Dyixs1COI8N0g0J
   qwQY60ixI+9oi9VJWYX4fu2PqOasXa5IG4nl8cGgRH9meUwTxXvbrf0m5
   G6li6tbYpCV9hkmNoCKTlkrAg2W5ETLOYsTn7v2UzA4kOxBaLK23XQjdY
   jg3oH3ZHD+e4Qmwn7vkg0Ctkp1Epb/pZWBZLCh093mMR+KS4PTlX3wi8o
   nUvLKwPqqWFBVMUoyUE1g/aqgtbvgGZLd+YRGmkW4nzXZd5D8WuzAG3WI
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="234380572"
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="234380572"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 03:10:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,375,1635231600"; 
   d="scan'208";a="530135129"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Feb 2022 03:10:46 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKegP-00006C-Gf; Thu, 17 Feb 2022 11:10:45 +0000
Date:   Thu, 17 Feb 2022 19:10:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Guixin Liu <kanie@linux.alibaba.com>, gregkh@linuxfoundation.org,
        bostroesser@gmail.com, martin.petersen@oracle.com
Cc:     kbuild-all@lists.01.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        xiaoguang.wang@linux.alibaba.com, xlpang@linux.alibaba.com
Subject: [RFC PATCH] scsi:target:tcmu:
 tcmu_ioctl_copy_between_sgl_and_iovec() can be static
Message-ID: <20220217111004.GA73979@5a5c9590ad42>
References: <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645064962-94123-2-git-send-email-kanie@linux.alibaba.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drivers/target/target_core_user.c:1987:6: warning: symbol 'tcmu_ioctl_copy_between_sgl_and_iovec' was not declared. Should it be static?
drivers/target/target_core_user.c:2031:6: warning: symbol 'tcmu_ioctl' was not declared. Should it be static?

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: kernel test robot <lkp@intel.com>
---
 drivers/target/target_core_user.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/target_core_user.c b/drivers/target/target_core_user.c
index afea088f24862b..ea1af59e03deff 100644
--- a/drivers/target/target_core_user.c
+++ b/drivers/target/target_core_user.c
@@ -1984,7 +1984,7 @@ static int tcmu_release(struct uio_info *info, struct inode *inode)
 	return 0;
 }
 
-long tcmu_ioctl_copy_between_sgl_and_iovec(struct tcmu_cmd *tcmu_cmd,
+static long tcmu_ioctl_copy_between_sgl_and_iovec(struct tcmu_cmd *tcmu_cmd,
 			struct iovec __user *uiovec,
 			unsigned long vcnt,
 			bool is_copy_to_sgl)
@@ -2028,7 +2028,7 @@ long tcmu_ioctl_copy_between_sgl_and_iovec(struct tcmu_cmd *tcmu_cmd,
 	return copy_ret;
 }
 
-long tcmu_ioctl(struct uio_info *info, unsigned int cmd, unsigned long arg)
+static long tcmu_ioctl(struct uio_info *info, unsigned int cmd, unsigned long arg)
 {
 	struct tcmu_dev *udev = container_of(info, struct tcmu_dev, uio_info);
 	struct tcmu_data_xfer __user *uxfer = (struct tcmu_data_xfer __user *)arg;
