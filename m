Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207A44E4A19
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 01:34:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240934AbiCWAgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 20:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240931AbiCWAgG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:36:06 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61A14B846
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 17:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647995677; x=1679531677;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=yV1C5Nj1wV9Q+Hzhlu+s+UcVMxhpQw8XcGsqNbsoG6s=;
  b=a/n0RvBg56WwzyXGA1sRI5Qig2J9wWnH/vDvhQs4BNAGmYhIU1l/zKCl
   54EzKWmCFGjj6rhTUoz+kdYrzoGqJ5XUCqZk2H/LFs/3NXqIHSEAvq1Ad
   UmUkO19Q7f+tnsQX676MkR5zFXpC+CDlZa0N7TO+7oCBK2FPavFrHDI5E
   iKtCePt24p5Rpl8U0v8+DezzU7W7ty4tYzOsG+OlLdCX8E0AXf3WDNoyt
   wk0bKyMVSQYYvcBlRa57Jlh3vbheS7BCa6fnNGArJNWpG1pYyryub/3r/
   8RXXxr5OvNCAgAGkMoqqTsqWT3K5CK1/r1Iso9k4xZ9opI0iaz1MMCYTv
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="238593692"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="238593692"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 17:34:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="519142114"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 22 Mar 2022 17:34:36 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWoxP-000JSP-MC; Wed, 23 Mar 2022 00:34:35 +0000
Date:   Wed, 23 Mar 2022 08:34:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:master 240/2335] fs/ntfs3/ntfs_fs.h: linux/types.h is
 included more than once.
Message-ID: <202203230838.oey8bzni-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
head:   85293bf3fca6d85608cff1447ce3097583f15fab
commit: 136743ce595d268b415d7630e24bb795a69eb4eb [240/2335] headers/prep: Add <linux/types.h> inclusion for files with non-standard header sections
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> fs/ntfs3/ntfs_fs.h: linux/types.h is included more than once.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
