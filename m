Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1974F53AC
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2359994AbiDFDXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:23:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847929AbiDFCU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:20:29 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AD427681B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649201982; x=1680737982;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=oiWP8LG7mW25VTszXL/2/PEL/8uk43Y4YWtb78uFN9k=;
  b=cYsEW142vCI4yRqcLxNetzJEx3JGLI6z3Hu7bGKIQyU7sId1O34qoC4o
   XPg7sZBPnx0jzbNtkvHfxU1Rj58jaQ7SEWAB/iyGabLI3aKzCJh6sB2Yq
   ERndbYtAQ4zvfSsnhoWorU+WUdRb3X+SXQOSYAV6kPRciroihJmpSaL1r
   ER7KSt3cLeCDfQZWVDAUSo/8Lun0f/WfBdf/u9vtohshbZicb4wfU3qpP
   zds6P4ESP7hzGfPPL4kaX5WCMVwu8Rzf+F2mn1YeVMdmzbwwOvODUWmMG
   mdpJyR649idC/ypHV+v7Et/fURpmn2FOiNLzZunn3ZwRZ5fIuelDwNSCl
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10308"; a="324064182"
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="324064182"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2022 16:39:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,238,1643702400"; 
   d="scan'208";a="524211804"
Received: from lkp-server02.sh.intel.com (HELO a44fdfb70b94) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 05 Apr 2022 16:39:39 -0700
Received: from kbuild by a44fdfb70b94 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nbslv-0003sP-6h;
        Tue, 05 Apr 2022 23:39:39 +0000
Date:   Wed, 6 Apr 2022 07:38:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless 9/9]
 net/rxrpc/call_event.c:168:54: warning: variable 'ack_id' is uninitialized
 when used here
Message-ID: <202204060758.Ap0o3iFm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless
head:   a4b855ffcf1d116e65df68fa6f5df04878bc0083
commit: a4b855ffcf1d116e65df68fa6f5df04878bc0083 [9/9] rxrpc: Use txbufs for acks
config: riscv-randconfig-r042-20220405 (https://download.01.org/0day-ci/archive/20220406/202204060758.Ap0o3iFm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project c4a1b07d0979e7ff20d7d541af666d822d66b566)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/a4b855ffcf1d116e65df68fa6f5df04878bc0083
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless
        git checkout a4b855ffcf1d116e65df68fa6f5df04878bc0083
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from net/rxrpc/call_event.c:13:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from net/rxrpc/call_event.c:13:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from net/rxrpc/call_event.c:13:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> net/rxrpc/call_event.c:168:54: warning: variable 'ack_id' is uninitialized when used here [-Wuninitialized]
           trace_rxrpc_send_ack(call, why, ack_reason, serial, ack_id);
                                                               ^~~~~~
   net/rxrpc/call_event.c:130:21: note: initialize the variable 'ack_id' to silence this warning
           unsigned int ack_id;
                              ^
                               = 0
   8 warnings generated.

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for DRM_GEM_SHMEM_HELPER
   Depends on HAS_IOMEM && DRM && MMU
   Selected by
   - DRM_SSD130X && HAS_IOMEM && DRM


vim +/ack_id +168 net/rxrpc/call_event.c

17926a79320afa9 net/rxrpc/ar-ack.c     David Howells 2007-04-26  121  
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  122  /*
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  123   * Queue an ACK for immediate transmission.
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  124   */
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  125  void rxrpc_send_ACK(struct rxrpc_call *call, u8 ack_reason,
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  126  		    rxrpc_serial_t serial, enum rxrpc_propose_ack_trace why)
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  127  {
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  128  	struct rxrpc_local *local = call->conn->params.local;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  129  	struct rxrpc_txbuf *txb;
9d0c67a9079368a net/rxrpc/call_event.c David Howells 2020-01-30  130  	unsigned int ack_id;
9d0c67a9079368a net/rxrpc/call_event.c David Howells 2020-01-30  131  	int c;
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  132  
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  133  	if (test_bit(RXRPC_CALL_DISCONNECTED, &call->flags))
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  134  		return;
47c723882160486 net/rxrpc/call_event.c David Howells 2020-01-30  135  	if (ack_reason == RXRPC_ACK_DELAY &&
47c723882160486 net/rxrpc/call_event.c David Howells 2020-01-30  136  	    test_and_set_bit(RXRPC_CALL_DELAY_ACK_PENDING, &call->flags)) {
47c723882160486 net/rxrpc/call_event.c David Howells 2020-01-30  137  		trace_rxrpc_drop_ack(call, why, ack_reason, serial, false);
47c723882160486 net/rxrpc/call_event.c David Howells 2020-01-30  138  		return;
47c723882160486 net/rxrpc/call_event.c David Howells 2020-01-30  139  	}
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  140  
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  141  	txb = rxrpc_alloc_txbuf(call, in_softirq() ? GFP_ATOMIC | __GFP_NOWARN : GFP_NOFS);
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  142  	if (!txb) {
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  143  		kleave(" = -ENOMEM");
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  144  		return;
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  145  	}
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  146  
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  147  	txb->ack_why		= why;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  148  	txb->wire.seq		= 0;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  149  	txb->wire.type		= RXRPC_PACKET_TYPE_ACK;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  150  	txb->wire.flags		|= RXRPC_SLOW_START_OK;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  151  	txb->ack.bufferSpace	= htons(8);
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  152  	txb->ack.maxSkew	= 0;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  153  	txb->ack.firstPacket	= 0;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  154  	txb->ack.previousPacket	= 0;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  155  	txb->ack.serial		= htonl(serial);
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  156  	txb->ack.reason		= ack_reason;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  157  	txb->ack.nAcks		= 0;
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  158  
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  159  	rxrpc_get_call(call, rxrpc_call_got);
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  160  
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  161  	spin_lock_bh(&local->ack_tx_lock);
a4b855ffcf1d116 net/rxrpc/call_event.c David Howells 2022-04-05  162  	list_add_tail(&txb->tx_link, &local->ack_tx_queue);
9d0c67a9079368a net/rxrpc/call_event.c David Howells 2020-01-30  163  	c = atomic_inc_return(&local->ack_tx_count);
9d0c67a9079368a net/rxrpc/call_event.c David Howells 2020-01-30  164  	if (c > local->ack_tx_max)
9d0c67a9079368a net/rxrpc/call_event.c David Howells 2020-01-30  165  		local->ack_tx_max = c;
9d0c67a9079368a net/rxrpc/call_event.c David Howells 2020-01-30  166  	local->ack_tx_send++;
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  167  	spin_unlock_bh(&local->ack_tx_lock);
9d0c67a9079368a net/rxrpc/call_event.c David Howells 2020-01-30 @168  	trace_rxrpc_send_ack(call, why, ack_reason, serial, ack_id);
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  169  	rxrpc_wake_up_transmitter(local);
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  170  }
ccfd84e75c84342 net/rxrpc/call_event.c David Howells 2020-01-30  171  

:::::: The code at line 168 was first introduced by commit
:::::: 9d0c67a9079368a107b4010c7b15149ca05a7d05 put ack count in proc

:::::: TO: David Howells <dhowells@redhat.com>
:::::: CC: David Howells <dhowells@redhat.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
