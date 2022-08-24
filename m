Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B1059F624
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 11:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236227AbiHXJZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 05:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbiHXJZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 05:25:03 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24FA05A83D;
        Wed, 24 Aug 2022 02:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661333102; x=1692869102;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kBqGvGk3EMLX0tGgGU4hl4gNziKpyEA9hY1b6ZILIeU=;
  b=Mp3ncYEdmK2kRSj4GVgkHh5yLQlzz0zQBSr+lnCjzel7ZI6Cc4mir9Hf
   c7sNIHyHojtLO9QYooGZ1dxIR3EYVLBo0tiOcLXRNJVsJw2WsqbVMU0iK
   a6WwEOFejOHeYj5bXFJGtK0lJYDGiw3C/Ev5+zkice6Uq3T4/yb4+7fhS
   W0hn5yAfM+Kf7xJunHeyXziLFqf/jrQbH69cnr5BDJTfg201dZIO6QS8Z
   6H8namw5DYfDax5DNCj+wk9LKW27fRFv9Jlf53EzcETbb4qzM9mwFk/SH
   LRqgDym3cRAfGkbgpFvwUT4cEaxEuQA216qLkjo7HCQouYB9+6mgrHfRa
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="274304810"
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="274304810"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2022 02:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="677972129"
Received: from lkp-server02.sh.intel.com (HELO 34e741d32628) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 24 Aug 2022 02:25:00 -0700
Received: from kbuild by 34e741d32628 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oQmd9-0000BB-2L;
        Wed, 24 Aug 2022 09:24:59 +0000
Date:   Wed, 24 Aug 2022 17:24:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Jason A. Donenfeld" <zx2c4@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@google.com>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        linux-doc@vger.kernel.org
Subject: [linux-stable-rc:linux-5.4.y 4226/5188] htmldocs: Warning:
 Documentation/admin-guide/sysctl/kernel.rst references a file that doesn't
 exist: Documentation/filesystems/devpts.rst
Message-ID: <202208241747.vdIjFCwW-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
head:   1cece69eaa889a27cf3e9f2051fcc57eda957271
commit: 42a9a7e807505b485f7c6a7ffb0ffb7dab8e1b51 [4226/5188] random: always wake up entropy writers after extraction
reproduce:
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=42a9a7e807505b485f7c6a7ffb0ffb7dab8e1b51
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc linux-5.4.y
        git checkout 42a9a7e807505b485f7c6a7ffb0ffb7dab8e1b51
        make menuconfig
        # enable CONFIG_COMPILE_TEST, CONFIG_WARN_MISSING_DOCUMENTS, CONFIG_WARN_ABI_ERRORS
        make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Warning: Documentation/admin-guide/sysctl/kernel.rst references a file that doesn't exist: Documentation/filesystems/devpts.rst

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
