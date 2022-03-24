Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096E04E6A82
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 23:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355243AbiCXWMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 18:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240339AbiCXWMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 18:12:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 968F7A0BF3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 15:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648159869; x=1679695869;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ESz/SG68Pb0KTbl8ghjtIFZFLzowlS5DwfjJQ5SS+qA=;
  b=eiuRNfG5v1wu+p1QgXkjBEW7na5FiogBQvfuLn4qnyUaT0UXU1amtdQs
   76l7OWGnBm+Xh486N1NiZ3W3UJallo/Ilctz3avuGlF1LaE8AkTvj5c9g
   ixVMr6SSPkGc831NbMHMI2s9lSumm2OcQWC0TMaRX47EDi27MksbEl244
   yHx/YB34Wf+n961yFz3U3jdu2JALmCsisbBil6QrHUdFeGP1j+BE6GPcW
   yLGqIAuGkz3cA8uBtzth4Yeztj3Dm8M+VhMoZuO/DLrLu/ZGBwiTYciqe
   87VkXyRvtj/XO5JbzxonSxh9rFQKY9A0jz4vW9Zdgb6Mq20P0UoH4ksaT
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="283367117"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="283367117"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 15:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="544835370"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 24 Mar 2022 15:11:08 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXVff-000LUW-Bj; Thu, 24 Mar 2022 22:11:07 +0000
Date:   Fri, 25 Mar 2022 06:10:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [bvanassche:ufs-for-next 324/324] drivers/scsi/ufs-core/ufshcd.c:
 linux/delay.h is included more than once.
Message-ID: <202203250636.Pdn0SnNa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/bvanassche/linux ufs-for-next
head:   f56a3c9e669eef87e34c40037e7aff58fbb3cd3c
commit: f56a3c9e669eef87e34c40037e7aff58fbb3cd3c [324/324] scsi: ufs: Split the drivers/scsi/ufs directory
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04.1) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


includecheck warnings: (new ones prefixed by >>)
>> drivers/scsi/ufs-core/ufshcd.c: linux/delay.h is included more than once.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
