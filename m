Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099D6591DC1
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 05:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiHND0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 23:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiHND0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 23:26:44 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A3C1E3F2
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 20:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660447603; x=1691983603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=iAccyRZIxgT2houJGp9FQrTZLSt7u0p5I+HeD0Bqgi4=;
  b=PILAp6AqjDG1EWgpmkBpKr/aO/yOWl1X8eTBHDDtfCZyrumyvKgQolRe
   pN753VWpzeN4kcMz+lOriXKYySC4E/xCDXOaStjkqg0KtbBYJcbiR50Du
   2X5W/8XIukCG41+zIDL+dfdISotIVfAZpGUQLSylcs7JcyfprPMmdofmq
   UB9vB5VLLvUFOrClx6UHW47yuTbr1hcK48FxUPt05T8LsXRZbewJeXQvI
   RxA5GFS7KPvahKnYneeQKgqm14U9JV6xY2Nv2XNvkCvO9b0+ls4zCqoEH
   q+PL50OOOkFlhuw9wwXGAJ62fyQTDEsXI2nPPwwDMfvIA9BNxVVXMT/fd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="355801849"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="355801849"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 20:26:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="695636671"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 13 Aug 2022 20:26:40 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oN4Gu-0002R9-0s;
        Sun, 14 Aug 2022 03:26:40 +0000
Date:   Sun, 14 Aug 2022 11:26:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     bchalios@amazon.es, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, bchalios@amazon.es, tytso@mit.edu,
        Jason@zx2c4.com, dwmw@amazon.co.uk, graf@amazon.de,
        xmarcalx@amazon.co.uk, gregkh@linuxfoundation.org
Subject: Re: [PATCH 2/2] virt: vmgenid: add support for generation counter
Message-ID: <202208141147.UE8mhW6c-lkp@intel.com>
References: <20220803152127.48281-3-bchalios@amazon.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220803152127.48281-3-bchalios@amazon.es>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on crng-random/master]
[also build test WARNING on linus/master v5.19 next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/bchalios-amazon-es/virt-vmgenid-add-generation-counter/20220803-232559
base:   git://git.kernel.org/pub/scm/linux/kernel/git/crng/random.git master
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/virt/vmgenid.rst:79: WARNING: Inline literal start-string without end-string.
>> Documentation/virt/vmgenid.rst:79: WARNING: Inline emphasis start-string without end-string.
>> Documentation/virt/vmgenid.rst:89: WARNING: Unexpected indentation.
>> Documentation/virt/vmgenid.rst:98: WARNING: Definition list ends without a blank line; unexpected unindent.
>> Documentation/virt/vmgenid.rst:102: WARNING: Inline interpreted text or phrase reference start-string without end-string.
>> Documentation/virt/vmgenid.rst: WARNING: document isn't included in any toctree

vim +79 Documentation/virt/vmgenid.rst

    78	
  > 79	```
    80	uint32_t *gen_cntr = mmaped_gen_counter();
    81	uint32_t cached_gen_cntr = *gen_cntr;
    82	char *secret;
    83	
    84	for(;;) {
    85	    secret = get_secret();
    86	
    87	    // All good, not restore has happened.
    88	    if (cached_gen_cntr == *gen_cntr)
  > 89	        break;
    90	
    91	    // Generation counter has changed. We need to recreate caches and try again
    92	
    93	    cached_gen_cntr = *gen_cntr;
    94	    barrier();
    95	
    96	    // recreate secrets' cache
    97	    rebuild_cache();
  > 98	}
    99	
   100	consume_secret(secret);
   101	
 > 102	```
   103	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
