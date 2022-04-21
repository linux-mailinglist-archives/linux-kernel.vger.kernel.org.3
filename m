Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F8250AA67
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 22:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392621AbiDUU5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 16:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356581AbiDUU5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 16:57:38 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC0A24EA27
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 13:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650574487; x=1682110487;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Lw6hC19E0serumFzQ2gBeufPShi1ToHepTnv5q3Ayz4=;
  b=SZjeEB/dMN7KXEt9TQrYPV5s5f8b2Qkjl9sLvtS3aSYz5y8BugITUZqa
   jbnHQDG4cKQH8bfC40yyfHHK+1aJ/+fzdD/kYbaClzpTFNZP1asDKrgib
   4ZzFaoHb9Yh1UUwI+MhwtNyojiia3Y/fQ/T4MvjwLTn7ZYIL2W2PTrrKC
   hR4dsQUUBCDNWPOt2Spv4Us/BYi0uCGOGaW8P7re7U+/PCKrk1x1mOcDZ
   fcC5BFoEoh5MkmHSns3AUrzjX86179NKYdcMa+Cr9IGyYMheTtAKAyHhP
   QGocTnKVqUNTblmWF8CGpFD4QhzjwAS4GNGel7uWa1PjbYanUMQRqAlOX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="246380375"
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="246380375"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 13:54:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,279,1643702400"; 
   d="scan'208";a="658694917"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 21 Apr 2022 13:54:45 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhdp7-0008mt-At;
        Thu, 21 Apr 2022 20:54:45 +0000
Date:   Fri, 22 Apr 2022 04:54:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-rebased 5/83] ./usr/include/misc/tdx.h:38:19:
 error: expected ':', ',', ';', '}' or '__attribute__' before '__user'
Message-ID: <202204220424.OtE3RBb1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuppuswamy,

FYI, the error/warning still remains.

tree:   https://github.com/intel/tdx.git guest-rebased
head:   4c095660b91dbdd18042456e395af0deeef93485
commit: a7b0255d5b64842244f1957e33eb514d8f82866f [5/83] platform/x86: intel_tdx_attest: Add TDX Guest attestation interface driver
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220422/202204220424.OtE3RBb1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/a7b0255d5b64842244f1957e33eb514d8f82866f
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-rebased
        git checkout a7b0255d5b64842244f1957e33eb514d8f82866f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:
>> ./usr/include/misc/tdx.h:38:19: error: expected ':', ',', ';', '}' or '__attribute__' before '__user'
      38 |         void *buf __user;
         |                   ^~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
