Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88F3C5859F5
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234175AbiG3J5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230209AbiG3J5C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:57:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4133E14D0D;
        Sat, 30 Jul 2022 02:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659175022; x=1690711022;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=l5+Ea5xR7MqK9cipnzOCHhx9Szpt4Jb1Cq/MhvotjK0=;
  b=TgmAg6gJTAtmMpsBrdiltg+PXiZVXLhO6EsRYM6cCZkmeGGTCkUHxHk3
   Padw3Q+ZcYteBSgxmRmLYfrfRzjp8VcihKKioMdLMdgjZly1kafDETgMd
   OVXhlLey3HAw60Qd2fN18U7zvDq5+VxyurXWCOp6w22TDTFZhvBBZ2JrW
   IvJxbm3XcQXYVZuODxOPQS3rlcwFJ9lrCzog7DlBe+M2ppQ0kGZvuHCVF
   lFcEvW1F8AO/zuu1FMI6g1UVeD1GfM2dLqoefjfJYVWPry3OocpILEvxf
   t3LxRIh4F7bFQZvc9kOeDdlZKnvMl8lagIgMoLgSuRhS1tIqOvC841PQe
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="268672474"
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="268672474"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 02:57:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,203,1654585200"; 
   d="scan'208";a="669518810"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 30 Jul 2022 02:57:00 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHjDQ-000CiL-07;
        Sat, 30 Jul 2022 09:57:00 +0000
Date:   Sat, 30 Jul 2022 17:56:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jack Rosenthal <jrosenth@chromium.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>, linux-doc@vger.kernel.org
Subject: htmldocs: Documentation/ABI/testing/sysfs-firmware-coreboot:2:
 WARNING: Definition list ends without a blank line; unexpected unindent.
Message-ID: <202207301713.q4988FIe-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel-lab-lkp/linux/commits/UPDATE-20220730-033257/Jack-Rosenthal/firmware-google-Implement-vboot-workbuf-in-sysfs/20220727-075259
head:   7271f1344693f4e86debf8ae58f81ea50f3756c4
commit: 7271f1344693f4e86debf8ae58f81ea50f3756c4 firmware: google: Implement cbmem in sysfs driver
date:   14 hours ago
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/ABI/testing/sysfs-firmware-coreboot:2: WARNING: Definition list ends without a blank line; unexpected unindent.
>> Documentation/ABI/testing/sysfs-firmware-coreboot:2: WARNING: Unexpected indentation.
>> Documentation/ABI/testing/sysfs-firmware-coreboot:2: WARNING: Block quote ends without a blank line; unexpected unindent.

vim +2 Documentation/ABI/testing/sysfs-firmware-coreboot

   > 2	Date:		July 2022

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
