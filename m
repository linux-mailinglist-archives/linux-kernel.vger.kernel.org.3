Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67ACC4B7F6E
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:21:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242194AbiBPEUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:20:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235192AbiBPEUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:20:36 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE1A99ECB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:20:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644985225; x=1676521225;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7TcxNdl9gK5Lcl0IKx5VtwwaioLOVFUco0qT/Cnvr+8=;
  b=PHaHwG/+lAW4rd9CuoQ0/yudSdlnflC+DZLKj3+n2EqmQ2B7CyHpNCM+
   hNdxnaZ1LdcYMLvyUxL+M1CJHh2ZHYrBsr4ddif3YjFrpzwhDxAavm149
   M01970TZy9JsVuDAJ9W/P5AidhIQULaU1PndgEfY4WeM76UV3P6bRT2bX
   7vmMEFTQyRUc5D2Od65+hkGv9mDi5vwfnfLDBdaz/0sL/Tah/Z4yuF0e6
   XJLJU7v4PSa++8Fg++wFK+zLhpL9UuJJDC3If1cr2J/0tE4KpbVFAOkTe
   Q5eAq3TnDOzJFp30nY7EsnNJDpijWII3e3/pSUdo3arXvTBmlddOH0bcL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10259"; a="237924749"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="237924749"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 20:20:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="625204923"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 15 Feb 2022 20:20:23 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKBnj-000AOu-81; Wed, 16 Feb 2022 04:20:23 +0000
Date:   Wed, 16 Feb 2022 12:19:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [intel-tdx:guest-rebased 115/133] kernel/dma/swiotlb.c:433:15-33:
 WARNING: casting value returned by memory allocation function to (struct
 io_tlb_area *) is useless.
Message-ID: <202202161256.1zrqppDy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-rebased
head:   36c91f6d572820e8556972fd7644bd96798e85d6
commit: 77d5cb1c6d4fe32593d65a38b4732da6c90b8f29 [115/133] swiotlb: Split up single swiotlb lock
config: x86_64-randconfig-c002-20220214 (https://download.01.org/0day-ci/archive/20220216/202202161256.1zrqppDy-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> kernel/dma/swiotlb.c:433:15-33: WARNING: casting value returned by memory allocation function to (struct io_tlb_area *) is useless.

Please review and possibly fold the followup patch.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
