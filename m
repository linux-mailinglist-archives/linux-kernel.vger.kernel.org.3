Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A475649C04D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 01:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbiAZAoc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 19:44:32 -0500
Received: from mga12.intel.com ([192.55.52.136]:40426 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231603AbiAZAoa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 19:44:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643157870; x=1674693870;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=p6ceDH+nKqNftZjNvRZ+EqPMHlI6a8QHrw2ylqAskeA=;
  b=WG+ifOX1vqPB2h9Q5+xX0SSf60Hjf25mYZlytIVPsdj9ZXFbE/WKQDoH
   DCdUncN4sZGDRcXEiOPZtPRqG3ziv21b1CTn0xur/EVvvnNxinJ8y0bmL
   QrNF1NIOsrtWPDF8aycaFZrxfZH4alxGOtsMzSDbriLh3txgS0xGhOIj5
   BBWUZolNSr5rZLhKSSvrhNg+O+jN14eP+pXK3rqkPWd6dYS735H5A4jR8
   CUx2w1PMCGrTC+dEnNkDRLNO261ULHej9LXvzkJlBdA9HxQ1XFKBX1n/L
   iKTerl7kj+urcZp34eDJq1VPT2ncro8kcA04n5kJ8wKqVjr10Qps8S3rj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="226427685"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="226427685"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 16:44:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="495194435"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Jan 2022 16:44:28 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nCWQF-000Kbh-Ib; Wed, 26 Jan 2022 00:44:27 +0000
Date:   Wed, 26 Jan 2022 08:44:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Satya Tangirala <satyat@google.com>
Cc:     kbuild-all@lists.01.org, GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Eric Biggers <ebiggers@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android-4.14-stable
 3738/9999] drivers/mmc/core/crypto.c:14:6: warning: no previous declaration
 for 'mmc_crypto_setup_queue'
Message-ID: <202201260846.mr5Y6XLD-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Satya,

FYI, the error/warning still remains.

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android-4.14-stable
head:   4ab5bac1598e3ed91a6267f6cada336467312112
commit: 86556e67a9fde013721c184f1590930b5811505f [3738/9999] ANDROID: mmc: MMC crypto API
config: x86_64-randconfig-a002-20220124 (https://download.01.org/0day-ci/archive/20220126/202201260846.mr5Y6XLD-lkp@intel.com/config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/86556e67a9fde013721c184f1590930b5811505f
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android-4.14-stable
        git checkout 86556e67a9fde013721c184f1590930b5811505f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash LDFLAGS=-z max-page-size=0x200000  drivers/mmc/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/mmc/core/crypto.c:14:6: warning: no previous declaration for 'mmc_crypto_setup_queue' [-Wmissing-declarations]
    void mmc_crypto_setup_queue(struct mmc_host *host, struct request_queue *q)
         ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/core/crypto.c:21:6: warning: no previous declaration for 'mmc_crypto_free_host' [-Wmissing-declarations]
    void mmc_crypto_free_host(struct mmc_host *host)
         ^~~~~~~~~~~~~~~~~~~~
>> drivers/mmc/core/crypto.c:26:6: warning: no previous declaration for 'mmc_crypto_prepare_req' [-Wmissing-declarations]
    void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)
         ^~~~~~~~~~~~~~~~~~~~~~


vim +/mmc_crypto_setup_queue +14 drivers/mmc/core/crypto.c

    13	
  > 14	void mmc_crypto_setup_queue(struct mmc_host *host, struct request_queue *q)
    15	{
    16		if (host->caps2 & MMC_CAP2_CRYPTO)
    17			q->ksm = host->ksm;
    18	}
    19	EXPORT_SYMBOL_GPL(mmc_crypto_setup_queue);
    20	
  > 21	void mmc_crypto_free_host(struct mmc_host *host)
    22	{
    23		keyslot_manager_destroy(host->ksm);
    24	}
    25	
  > 26	void mmc_crypto_prepare_req(struct mmc_queue_req *mqrq)

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
