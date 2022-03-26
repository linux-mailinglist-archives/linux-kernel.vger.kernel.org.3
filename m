Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79ACA4E7FF5
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 09:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbiCZINE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 04:13:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232083AbiCZIM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 04:12:59 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7841E7461
        for <linux-kernel@vger.kernel.org>; Sat, 26 Mar 2022 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648282282; x=1679818282;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P9dVB4ZZc42JPMXDf4ZXEuQtDerWHUFz5SIEYFiNzPs=;
  b=b80mrgSUx38E3yD+vQ/B+m0Ig6UqGNxYk1mjqTNgZ+HGvgERQB69OXpk
   feeTmjZEQj1ttvG7TFzTitJMKAKkdjAFgVUy+FHw+bIoJoCWVAqEaz45F
   B5B4HKROCLfSBlKgLixbSVjjOD8Bs1G63GHz2PshbCu+7dxrBac7pPErV
   a30STo+8Be5VivPeixYYFx12xla5/CCuCeyauwQM7vfjSLhYjLKSRNIHx
   73RigE94S3pRtPbAWiKVkcocASFIvp54qKIOsvoYd2EPHFr8aAD57WfZ+
   Z6W0J+qlCCsKYadmnB83srtpWXmBUWO81wS3/NeT79mwVgztfSN7I/JMn
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10297"; a="258735866"
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="258735866"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 01:11:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,211,1643702400"; 
   d="scan'208";a="516776259"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 26 Mar 2022 01:11:21 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nY1W4-000NB8-KD; Sat, 26 Mar 2022 08:11:20 +0000
Date:   Sat, 26 Mar 2022 16:10:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [intel-tdx:guest-rebased 65/83] kernel/dma/swiotlb.c:433:15-33:
 WARNING: casting value returned by memory allocation function to (struct
 io_tlb_area *) is useless.
Message-ID: <202203261644.zQlZ2Jw4-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-rebased
head:   4c095660b91dbdd18042456e395af0deeef93485
commit: 4ab45cefa80f97ba2bdc31226523c891832d1080 [65/83] swiotlb: Split up single swiotlb lock
config: s390-randconfig-c023-20220324 (https://download.01.org/0day-ci/archive/20220326/202203261644.zQlZ2Jw4-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> kernel/dma/swiotlb.c:433:15-33: WARNING: casting value returned by memory allocation function to (struct io_tlb_area *) is useless.

Please review and possibly fold the followup patch.

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
