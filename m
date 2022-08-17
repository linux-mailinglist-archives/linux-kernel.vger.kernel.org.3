Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30C5596DC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236348AbiHQLsX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiHQLsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:48:21 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F778B495;
        Wed, 17 Aug 2022 04:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660736900; x=1692272900;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Fex59IXc8Xlcqpigc8QOkKV8TzcouaaAVt4sSBj8G1A=;
  b=C+9qlbNPmaLkgNdavdqEU8ZmKhY6whPi0s0QwaNk/YrHRGHKKv4z7qmg
   8hEmKf+LCpvpXSr9SNaRMSFaDs2EwqJ2k01eA8lhI8lIAEmhwgWcwXsh9
   NsbKJ/HLZd8gtRv7iOj0FPP9Q4di4d69BB8cMV3UA4ipArdILzMYBxKaJ
   bDL9w/V5JkoSxi97j0Qj8/hBggyNKagrHZ70atUnB7wSf9A5dRmk0NQBt
   +qUNiSR4S3SFIKsk+PfZRXgALj0ObH8NS06rqr2eprF5b6V4Xmqls4TUC
   VLG2DEENp3Rmia2XOdzXXN6DswyjDfTXbHzsL85Y10HGPmbytfownfxAH
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="275524840"
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="275524840"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2022 04:48:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,243,1654585200"; 
   d="scan'208";a="558097813"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 17 Aug 2022 04:48:18 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oOHWz-0000su-2E;
        Wed, 17 Aug 2022 11:48:17 +0000
Date:   Wed, 17 Aug 2022 19:48:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Tomasz Figa <tfiga@chromium.org>, linux-doc@vger.kernel.org
Subject: htmldocs: Warning: drivers/acpi/device_pm.c references a file that
 doesn't exist: Documentation/firmware-guide/acpi/low-power-probe.rst
Message-ID: <202208171919.pT3WAxzQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   3cc40a443a04d52b0c95255dce264068b01e9bfe
commit: b82a7df4a7f3841896aaec1ad81e654bc87b5989 ACPI: Add a convenience function to tell a device is in D0 state
date:   10 months ago
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: drivers/acpi/device_pm.c references a file that doesn't exist: Documentation/firmware-guide/acpi/low-power-probe.rst

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
