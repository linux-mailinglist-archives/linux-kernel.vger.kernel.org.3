Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A6566486
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiGEH5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 03:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiGEH5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 03:57:36 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0CD13D7A;
        Tue,  5 Jul 2022 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657007855; x=1688543855;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YK0kaz1WbxoXkKe6+U4yLt7BCkOqmxG4giXSM0IjVos=;
  b=LVuFC88ttXxNTGR92UskyTpS87fN6e5iPG7p9/mfFT2y76+pIdCB8AhA
   EeETnekP8Z3KEBc82c1uFiY/RPKnadcweQASAfMrbLOzSkk8ZKvPz7T4b
   6XQuAKGfu2SXZ8sMaNyUQknqcvNkxU/1iTSsQ02zeEwM3AXu6F21f1MFw
   F89OaXx70hR+ecePf3ppmi2lITN35b+0RPDjDBejPuWkgiY7CgKHrMyYZ
   RRvnzsaTZFK+zNHQG3o9GRsA3PNgDJ4UU+NjLOcsOLW6rHlRRfF++gvgD
   LZsDIDL4I2oaNHL8Fx+GbzVY0HdjUGS21EOSO3rYJFxjSQ8BpE9k7jryU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283312296"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="283312296"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 00:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="567505661"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 05 Jul 2022 00:57:33 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8dR6-000IrL-Js;
        Tue, 05 Jul 2022 07:57:32 +0000
Date:   Tue, 5 Jul 2022 15:56:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Isaku Yamahata <isaku.yamahata@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 306/442] htmldocs:
 Documentation/virt/kvm/tdx-legacy-mmu.rst:49: WARNING: Unexpected
 indentation.
Message-ID: <202207051551.z6X8ExZg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   8af973ebaf30642129fc1ca63f155a469f9615ed
commit: b3b66d4ef5e175da9ce1ed41277130fee7cbdd84 [306/442] KVM: x86: design documentation on TDX support of x86 legacy KVM MMU
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/virt/kvm/tdx-legacy-mmu.rst:49: WARNING: Unexpected indentation.
>> Documentation/virt/kvm/tdx-legacy-mmu.rst:50: WARNING: Block quote ends without a blank line; unexpected unindent.
>> Documentation/virt/kvm/tdx-legacy-mmu.rst:52: WARNING: Definition list ends without a blank line; unexpected unindent.
>> Documentation/virt/kvm/tdx-legacy-mmu.rst: WARNING: document isn't included in any toctree

vim +49 Documentation/virt/kvm/tdx-legacy-mmu.rst

    44	
    45	(private EPT entry, shared EPT entry) =
    46	        (non-present, non-present):             private mapping is allowed
    47	        (present, non-present):                 private mapping is mapped
    48	        (non-present | SPTE_SHARED_MASK, non-present):
  > 49	                                                shared mapping is allowed
  > 50	        (non-present | SPTE_SHARED_MASK, present):
    51	                                                shared mapping is mapped
  > 52	        (present, present):                     invalid combination
    53	
    54	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
