Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12C464FC51F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 21:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347905AbiDKT3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 15:29:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349704AbiDKT3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 15:29:09 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F24A37A2C
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 12:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649705206; x=1681241206;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=RuL8Rs7EZn6u0P2PWiYlIL4+LThxTGv99e+mSM/EZEo=;
  b=Bx+tA47UBOgTcraQD+rP/sw1AL43wQWuKbB+Lyy1DFjusvAT5Dh/Um/K
   Qjfh2I6On+UimW2ru7h60YTNIEsJssKm+srquqwjznOcqUcWQ7OmYAsk2
   GKKeokKd4DZohHyPg20hrT2EU1t1r4Rop2qyC/OT1Ae/CiGc6n0EYjdSt
   dkUGdMf58scDKp9HqrUrO6fbZwvi2YOTen0r1dvfKPtwNpluvEJCM4ipq
   gMl7x+cyme2LDxdnsxl4BfXWynAZ2y6la3GknJFNJYEFWyd0sTDoKmizt
   xQc8MLoqYTZh63iRiuhooVkHgjMfHKpMCHlMZNEfZxoW6zvKFn58C27Lc
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261045392"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="261045392"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 12:26:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="644211784"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 11 Apr 2022 12:26:28 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ndzgC-00026w-Aa;
        Mon, 11 Apr 2022 19:26:28 +0000
Date:   Tue, 12 Apr 2022 03:25:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Keith Busch <keith.busch@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Rajat Jain <rajatja@google.com>,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [jsarha:topic/chromeos-4.19-s0ix 7573/9999]
 drivers/nvme/host/pci.c:2705:25: sparse: sparse: symbol 'nvme_dev_pm_ops'
 was not declared. Should it be static?
Message-ID: <202204120348.5EvqQlqc-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/chromeos-4.19-s0ix
head:   430bdaa0a8c38697780f45a148964d71951df11f
commit: bc7304877066a781782a7b43ea0ed2edcc767637 [7573/9999] BACKPORT: FROMGIT: nvme-pci: Use host managed power state for suspend
config: i386-randconfig-s001-20220411 (https://download.01.org/0day-ci/archive/20220412/202204120348.5EvqQlqc-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/jsarha/linux/commit/bc7304877066a781782a7b43ea0ed2edcc767637
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/chromeos-4.19-s0ix
        git checkout bc7304877066a781782a7b43ea0ed2edcc767637
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash drivers/nvme/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> drivers/nvme/host/pci.c:2705:25: sparse: sparse: symbol 'nvme_dev_pm_ops' was not declared. Should it be static?
   drivers/nvme/host/pci.c:1263: warning: Function parameter or member 'nvmeq' not described in 'nvme_suspend_queue'

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
