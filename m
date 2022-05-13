Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3480A525926
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 03:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359820AbiEMBAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 21:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241356AbiEMBAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 21:00:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBF725509E
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 18:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652403621; x=1683939621;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=h+CBhS+9r9aX0w6K7C1Kn4GMveFRn/hT6QJ+Y2T1zfM=;
  b=CkuVex8wmQYCXlb/aRRQzM5KMWqyQM2VjsMzY533TVeGTqIqV4KDt4Im
   00G9h1wjz4o5Cy0pnQQPIlUlx1Ua/t0NfnWVEYG7onzkA7Qqptgm7ubYg
   kel/BqyhCTwIHFD2B0G3/oOrxprsbTUZfIjpTTR7bWyGFLOdRlFlVJUsq
   eMdEFPgSMexfryg5q7meVYaawmNgCH/1zr+zBJnbA0a/W7ZbmGPRT7fRY
   ognpO229JBjHy8aaqsjwtbGctgv3MmnQt0Xq1V6XwOGKSwHu1k7Gz9lUG
   5OKudJGh/btsMbganPAVKwfYqt47eWWc0QPKtdy4NJ2kNaLDZwKGMGoq8
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="270113275"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="270113275"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 18:00:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="554015968"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 12 May 2022 18:00:19 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npJfH-000L7k-5D;
        Fri, 13 May 2022 01:00:19 +0000
Date:   Fri, 13 May 2022 09:00:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless 35/35]
 net/rxrpc/recvmsg.c:297:9: warning: variable 'j' is uninitialized when used
 here
Message-ID: <202205130800.78D0sAwZ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless
head:   36075641f704b02b4bcaee01d904a06676b32199
commit: 36075641f704b02b4bcaee01d904a06676b32199 [35/35] rxrpc: Don't split up received jumbo packets
config: i386-randconfig-a013 (https://download.01.org/0day-ci/archive/20220513/202205130800.78D0sAwZ-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9519dacab7b8afd537811fc2abaceb4d14f4e16a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/36075641f704b02b4bcaee01d904a06676b32199
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless
        git checkout 36075641f704b02b4bcaee01d904a06676b32199
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iommu/ kernel/trace/ net/rxrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/rxrpc/recvmsg.c:297:9: warning: variable 'j' is uninitialized when used here [-Wuninitialized]
           for (; j < nr_subs; j++, seq++) {
                  ^
   net/rxrpc/recvmsg.c:289:47: note: initialize the variable 'j' to silence this warning
           int nr_subs = sp->nr_subpackets - 1, i = 0, j;
                                                        ^
                                                         = 0
   1 warning generated.


vim +/j +297 net/rxrpc/recvmsg.c

   275	
   276	/*
   277	 * Set up a data location table for a jumbo DATA packet then verify
   278	 * and decrypt all the subpackets and locate the data for each.  We
   279	 * also need to skip over any duplicate subpackets.
   280	 */
   281	static int rxrpc_verify_data(struct rxrpc_call *call, struct sk_buff *skb)
   282	{
   283		struct rxrpc_jumbo_header jhdr;
   284		struct rxrpc_skb_subpacket *subs;
   285		struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
   286		unsigned int offset = sizeof(struct rxrpc_wire_header);
   287		unsigned int len = skb->len - sizeof(struct rxrpc_wire_header);
   288		rxrpc_seq_t seq = sp->hdr.seq;
   289		int nr_subs = sp->nr_subpackets - 1, i = 0, j;
   290		u16 cksum = sp->hdr.cksum;
   291	
   292		subs = kcalloc(sp->nr_subpackets, sizeof(*sp->subs), GFP_KERNEL);
   293		if (!subs)
   294			return -ENOMEM;
   295		sp->subs = subs;
   296	
 > 297		for (; j < nr_subs; j++, seq++) {
   298			if (after(seq, call->rx_consumed)) {
   299				subs[i].offset	= offset;
   300				subs[i].len	= RXRPC_JUMBO_DATALEN;
   301				subs[i].cksum	= cksum;
   302				i++;
   303			} else {
   304				sp->hdr.seq++;
   305				sp->nr_subpackets--;
   306			}
   307			offset += RXRPC_JUMBO_DATALEN;
   308			if (skb_copy_bits(skb, offset, &jhdr.cksum, 2) < 0)
   309				return -EPROTO;
   310			offset += sizeof(jhdr);
   311			cksum = htons(jhdr.cksum);
   312			len -= RXRPC_JUMBO_SUBPKTLEN;
   313		}
   314	
   315		subs[i].offset	= offset;
   316		subs[i].len	= len;
   317		subs[i].cksum	= cksum;
   318		return call->security->verify_packet(call, skb);
   319	}
   320	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
