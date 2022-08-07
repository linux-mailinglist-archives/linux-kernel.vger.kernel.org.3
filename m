Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2EC058BA97
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 12:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbiHGKoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 06:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiHGKoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 06:44:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5FBCE1C
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 03:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659869071; x=1691405071;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=cO4wM4WNsZqpeCfcK/CC2HQNcgpZNb0M9sjhJ040lnY=;
  b=dAaoTYh6CSnGaiZEy0e3DmocHOULLRQsjQ0njZ7TGIoxWXOX7gSPgWf5
   BZeDi7/4BEWRVru3eURS4Jj8Aab9iTkuonrand+CSGkpklWwVCEfvfK2l
   RVHqUMbeTUseyHtbm+lvOUylZtFaFkOV41iVJc/UVEeTfA/9syYNgz3jR
   zbDcSp1M5Zi3o7yUGQ06XlLa+Q4LLjtmIdU+7OLWB/7JyO+Uf3BQEIPl+
   uNkUaAN15fUmVs5AUYxXoyYsoesGh9RNXEU7Aqs0CPTkyW3OPUoLVdmo+
   rAlJSmp0AQU0A+jALdXyUQ80hkkXFP/ncmyfulOQQYVHRHMzFyhmzGy0W
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="291203219"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="291203219"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 03:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="663562523"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2022 03:44:30 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKdll-000LEX-1x;
        Sun, 07 Aug 2022 10:44:29 +0000
Date:   Sun, 7 Aug 2022 18:43:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: net/bluetooth/hci_conn.c:800:5-12: WARNING: kzalloc should be used
 for d, instead of kmalloc/memset
Message-ID: <202208071815.IxeJjCaT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1612c382ffbdf1f673caec76502b1c00e6d35363
commit: eca0ae4aea66914515e5e3098ea051b518ee5316 Bluetooth: Add initial implementation of BIS connections
date:   2 weeks ago
config: alpha-randconfig-c042-20220805 (https://download.01.org/0day-ci/archive/20220807/202208071815.IxeJjCaT-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 12.1.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

cocci warnings: (new ones prefixed by >>)
>> net/bluetooth/hci_conn.c:800:5-12: WARNING: kzalloc should be used for d, instead of kmalloc/memset
   net/bluetooth/hci_conn.c:763:5-12: WARNING: kzalloc should be used for d, instead of kmalloc/memset

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
