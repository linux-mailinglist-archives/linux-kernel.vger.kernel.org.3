Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1056F4E5062
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243571AbiCWKhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbiCWKg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:36:58 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9033CA50
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648031728; x=1679567728;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=lXo/fnnmrNow3Vdi2F3Z8ghXF1sjEIneHDbs1kA3NV8=;
  b=H8QPqeUCfxXa2uk2iqkTD/oZxeAY/26/zybg3dWpYx3thxolUr0P3stw
   UF+yMGYqb8d+a8JmbtJqb3m2a+b3zKl+phWhm5qVk9XXiFfqqdduW/u2r
   DKQw6AGq/DlbLiMdqt02751FdQwhgrpPqmgEf0HbRxLr5GyZT6NkXq+RR
   Y8vcjSITYitiZGenZ0zlMRCknxBNikhz7IE8lX7ASSJCQOeNEDtpUeAqn
   EoAGOl9KTrieJoAcFXtGFW3HLChJ0ILMqRPXoKMy3gU0G2WqFIjyiT9a4
   qAyFWNzdOgmGlfmm0TBACE+eOZhl6H7GYFP3fwcZD6KfzMjYaKTS65olg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="344511206"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="344511206"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2022 03:35:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="717346162"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2022 03:35:26 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWyKr-000JyA-MH; Wed, 23 Mar 2022 10:35:25 +0000
Date:   Wed, 23 Mar 2022 18:35:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [intel-tdx:guest-rebased 5/83] ./usr/include/misc/tdx.h:38:12:
 error: expected ':', ',', ';', '}' or '__attribute__' before '__user'
Message-ID: <202203231835.0iF4P3oj-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-rebased
head:   2445b5e99855f3c241a44d2777a74a777f56048c
commit: a7b0255d5b64842244f1957e33eb514d8f82866f [5/83] platform/x86: intel_tdx_attest: Add TDX Guest attestation interface driver
config: x86_64-randconfig-a015 (https://download.01.org/0day-ci/archive/20220323/202203231835.0iF4P3oj-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/a7b0255d5b64842244f1957e33eb514d8f82866f
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-rebased
        git checkout a7b0255d5b64842244f1957e33eb514d8f82866f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from <command-line>:32:
>> ./usr/include/misc/tdx.h:38:12: error: expected ':', ',', ';', '}' or '__attribute__' before '__user'
      38 |  void *buf __user;
         |            ^~~~~~

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
