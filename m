Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB067525DEC
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378719AbiEMJAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347155AbiEMJAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:00:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EED8D2B24CF
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652432430; x=1683968430;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=UZNkG4uYXbLPDXpnWT/lY5jCnuirKRlehwcMQwjEFIg=;
  b=CPT034C5Qvge/vqP4na/bj3PeTOPG1BCl72cprDGxeXefgVayzmVvgll
   gbf5po+emdhJZDgkdvwMPlrhxR93vhbRsGthfME9fGTahr3sdCle7MhiU
   Xl0B4nyHSFHJBjyFq8FZigkh/31TIiOXFLKzZG9CUhNUsoX3+ETSra+oV
   xA2hCkwT62grpntFjGWwA3/ZWxSKdqeUcCUHwK4GHS7VUYZzTo7isEJtw
   4aNwSGLpwE7I1+ARlf91yiIRAtJq8mQA05aBAlFL/ztfcHsoBsjxF6vRd
   uPNAhdPhnmye+M90pJRUUDmQOuyyqGU0ap+WJfJGIZv/VcbUdhDViL0mp
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257803076"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="257803076"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 02:00:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="637219581"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 13 May 2022 02:00:27 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npR9v-000LZ8-4m;
        Fri, 13 May 2022 09:00:27 +0000
Date:   Fri, 13 May 2022 16:59:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/rxrpc-ringless 35/35]
 net/rxrpc/recvmsg.c:311:25: sparse: sparse: cast from restricted __be16
Message-ID: <202205131657.SjbSnATI-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/rxrpc-ringless
head:   36075641f704b02b4bcaee01d904a06676b32199
commit: 36075641f704b02b4bcaee01d904a06676b32199 [35/35] rxrpc: Don't split up received jumbo packets
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220513/202205131657.SjbSnATI-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/ammarfaizi2/linux-block/commit/36075641f704b02b4bcaee01d904a06676b32199
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/rxrpc-ringless
        git checkout 36075641f704b02b4bcaee01d904a06676b32199
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sh SHELL=/bin/bash net/rxrpc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> net/rxrpc/recvmsg.c:311:25: sparse: sparse: cast from restricted __be16
>> net/rxrpc/recvmsg.c:311:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] val @@     got restricted __be16 [addressable] [usertype] cksum @@
   net/rxrpc/recvmsg.c:311:25: sparse:     expected unsigned short [usertype] val
   net/rxrpc/recvmsg.c:311:25: sparse:     got restricted __be16 [addressable] [usertype] cksum
>> net/rxrpc/recvmsg.c:311:25: sparse: sparse: cast from restricted __be16
>> net/rxrpc/recvmsg.c:311:25: sparse: sparse: cast from restricted __be16
>> net/rxrpc/recvmsg.c:311:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] cksum @@     got restricted __be16 [usertype] @@
   net/rxrpc/recvmsg.c:311:23: sparse:     expected unsigned short [usertype] cksum
   net/rxrpc/recvmsg.c:311:23: sparse:     got restricted __be16 [usertype]

vim +311 net/rxrpc/recvmsg.c

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
   297		for (; j < nr_subs; j++, seq++) {
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
 > 311			cksum = htons(jhdr.cksum);
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
