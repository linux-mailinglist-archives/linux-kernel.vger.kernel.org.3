Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F37156CC1C
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 02:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbiGJAw2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 20:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJAw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 20:52:27 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05A813D7D;
        Sat,  9 Jul 2022 17:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657414346; x=1688950346;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=0WBawKch8FgdG5q67N7Y+VHMcNvqfbYKAysDrYg405o=;
  b=R7RL5lu6EvmtSKSvrnd36UPqksSyoLgqRuvlRZ+ZSrrnoNdxF+J5TWhZ
   QgK+tneR+MzAT7YFLxNUGiMY2Mk3w4NE00d5yfTPY6V/APyRKcA3n9ieD
   +k+Gj8kLmd0KC0oWksbkyMIBvKt0rJ+l8GikZGPcXawddau4EQHGmPB1N
   K5NnfN5xw+N6U5zwqy48caLu+a2HQMA9mzg0DfKh6mM3JjTsJBcmp5jvU
   ELB59MldUnVX/RmUNFktVr9GkK6uVguNGRgE9MO50r7ZoysJMQk7EkZWs
   MHJ1imufGDVFaTFghxloZgC61HWMsdt6XFNimvGdOiZwZaNwASoIK/FIS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10403"; a="267512531"
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="267512531"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2022 17:52:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,260,1650956400"; 
   d="scan'208";a="594492129"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Jul 2022 17:52:23 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oALBP-000PKe-Al;
        Sun, 10 Jul 2022 00:52:23 +0000
Date:   Sun, 10 Jul 2022 08:52:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chao Peng <chao.p.peng@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Isaku Yamahata <isaku.yamahata@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        linux-doc@vger.kernel.org
Subject: [intel-tdx:kvm-upstream-workaround 296/418] htmldocs:
 Documentation/virt/kvm/api.rst:6679: WARNING: Definition list ends without a
 blank line; unexpected unindent.
Message-ID: <202207100806.ymoTKohh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git kvm-upstream-workaround
head:   c2b43d6ee32b2f2de54395e7b2d7ba9bfa727608
commit: e11dbdbae913817716494fb41eb22aa88e1464e0 [296/418] KVM: Add KVM_EXIT_MEMORY_FAULT exit
reproduce: make htmldocs

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> Documentation/virt/kvm/api.rst:6679: WARNING: Definition list ends without a blank line; unexpected unindent.

vim +6679 Documentation/virt/kvm/api.rst

  6667	
  6668	  };
  6669	
  6670	::
  6671			/* KVM_EXIT_MEMORY_FAULT */
  6672			struct {
  6673	  #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1 << 0)
  6674				__u32 flags;
  6675				__u32 padding;
  6676				__u64 gpa;
  6677				__u64 size;
  6678			} memory;
> 6679	If exit reason is KVM_EXIT_MEMORY_FAULT then it indicates that the VCPU has
  6680	encountered a memory error which is not handled by KVM kernel module and
  6681	userspace may choose to handle it. The 'flags' field indicates the memory
  6682	properties of the exit.
  6683	
  6684	 - KVM_MEMORY_EXIT_FLAG_PRIVATE - indicates the memory error is caused by
  6685	   private memory access when the bit is set otherwise the memory error is
  6686	   caused by shared memory access when the bit is clear.
  6687	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
