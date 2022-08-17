Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8FD5967B8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 05:22:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238105AbiHQDWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 23:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiHQDWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 23:22:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA33B6CF59;
        Tue, 16 Aug 2022 20:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660706530; x=1692242530;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=50uJrH1frOVjQHGQ1WfcJhX0UyzOycX3mdLMscZAHKI=;
  b=FKce/6MeH/h9x9Zv/g5x/1OU4PTXm/1ktIQ1l2iH5KyFEO6G8ZLN8IPH
   hHb5C/IiitmckD7j70/vu3xmM61Kd+4kbmTCOEoGfxPgPfVMUuhdhfn6z
   CUlRW6cEn5IpGJtUtT7R//bC6tJ7Ze8596gyRNxSU9OpkOMHWrkLVs1dD
   U8L/VQbEamwgHMOMm8JOHoCHq7pySOXzpi1FnxZPR/JlYhsKh7IsI12+5
   uaflNPcDcyCEbLwA18MCVce/kUsSqG65xGFo8jLxmrQ13G0ARl/Ah434Q
   MfXbtnLsLEqnwZek63ucN8JCzGQHsr9BAKlVIe29isVCs0oWIy6Wsrdhq
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10441"; a="292384919"
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="292384919"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 20:22:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,242,1654585200"; 
   d="scan'208";a="675473486"
Received: from lkp-server02.sh.intel.com (HELO 81d7e1ade3ba) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 16 Aug 2022 20:22:09 -0700
Received: from kbuild by 81d7e1ade3ba with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oO9dA-0000VE-1r;
        Wed, 17 Aug 2022 03:22:08 +0000
Date:   Wed, 17 Aug 2022 11:21:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 140/308] htmldocs:
 Documentation/virt/kvm/api.rst:1362: WARNING: Literal block ends without a
 blank line; unexpected unindent.
Message-ID: <202208171109.lCfseeP6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   85c097fdd1667a842a9e75d8f658fc16bd72981a
commit: bb90daae9d75517eb0fddd87e26149ed7612995a [140/308] KVM: Extend the memslot to support fd-based private memory
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/virt/kvm/api.rst:1362: WARNING: Literal block ends without a blank line; unexpected unindent.

vim +1362 Documentation/virt/kvm/api.rst

  1347	
  1348	  struct kvm_userspace_memory_region {
  1349		__u32 slot;
  1350		__u32 flags;
  1351		__u64 guest_phys_addr;
  1352		__u64 memory_size; /* bytes */
  1353		__u64 userspace_addr; /* start of the userspace allocated memory */
  1354	  };
  1355	
  1356	  struct kvm_userspace_memory_region_ext {
  1357		struct kvm_userspace_memory_region region;
  1358		__u64 private_offset;
  1359		__u32 private_fd;
  1360		__u32 pad1;
  1361		__u64 pad2[14];
> 1362	};
  1363	
  1364	  /* for kvm_memory_region::flags */
  1365	  #define KVM_MEM_LOG_DIRTY_PAGES	(1UL << 0)
  1366	  #define KVM_MEM_READONLY	(1UL << 1)
  1367	  #define KVM_MEM_PRIVATE		(1UL << 2)
  1368	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
