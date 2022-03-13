Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1215D4D7816
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 21:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbiCMUCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 16:02:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbiCMUCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 16:02:18 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50FA8A6F0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 13:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647201667; x=1678737667;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IzdCUkCrcRYFQhe4Kxk+bAiFNJZ7gK+sMWBmaik8dgs=;
  b=jV3GWwKaAODbKigt8dhknokA9KslUXtGpQABguKdtzy7GXJ0H9ieNHRW
   ZilOtBhBJbFt3yHv309sFrcm0BPB+Vqo75N/857Xv9gmCpBFj55FgOUpM
   lMB/6QWA7THW/4Gb/UKNzyjZrzcjy6w+BtFgC2xkX1mWnNXagz86aSRDw
   ZbjVAxWpoRNTbVlL0jG/K4LzAubZtgSCyBhOYu1017FxTP5xjRcedT//B
   rUbTDO/5JR3COSqatCt8LtOv5ml7oj0Zjojed6eO38TFaazNRlemXbB0C
   SBf/j/8LUb6lMSix68B45vDLe1VqeaHp12PVS4ZGdzcRRQKIfN+UsBza8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="236498199"
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="236498199"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 13:01:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,179,1643702400"; 
   d="scan'208";a="597667444"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 13 Mar 2022 13:01:06 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTUOo-0009F0-1N; Sun, 13 Mar 2022 20:01:06 +0000
Date:   Mon, 14 Mar 2022 04:00:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 118/156] crypto/hkdf.c:94:25-31:
 ERROR: application of sizeof to pointer
Message-ID: <202203140317.0on9b3HF-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: ea4c6fc32e5e02a1e4c841f462c3a931b8838f33 [118/156] crypto,fs: Separate out hkdf_extract() and hkdf_expand()
config: x86_64-randconfig-c022 (https://download.01.org/0day-ci/archive/20220314/202203140317.0on9b3HF-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> crypto/hkdf.c:94:25-31: ERROR: application of sizeof to pointer

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
