Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFF7500E66
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 15:12:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243718AbiDNNPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 09:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiDNNPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:15:04 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA3E8BF34
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 06:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649941956; x=1681477956;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=jHOkBjmLjHD0On5vfOBvejXJXvFS3EBtW6ba0H7h9zM=;
  b=K7xDXtzezP2mAsbDow2yUHuwVpmaQU6e2QN30gHhgpv0Npz2jY7BH9aV
   a2r7tBKWZwGRDUnJsfBTXIB5hq6aMHFjncLggv/nHJcKWYijoSI9w88hu
   WPxrNcu+yOH83mubyzL4P7j57reaBVipEHuqgKaB0OEJZJ8trxwcKBzQ2
   L7YcEkf03xAzMCRxtjQ3Jx22jIo28eBCw31dQXwlHa2voS6/SDbrSGIgb
   ln0HkJyMavaN0uQkzb1O7VSdsVUD/3SUQ53KpAtKmfU7A7Dxp2kW1os93
   8wXWVq32HAMGVg5ZRgc8g1xasb2xjq9aNrYWZcP9mZ6sMX4FmQdn4gtsb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10316"; a="349360884"
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="349360884"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 06:12:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,259,1643702400"; 
   d="scan'208";a="612327228"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 14 Apr 2022 06:12:35 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nezH0-0000ya-Gw;
        Thu, 14 Apr 2022 13:12:34 +0000
Date:   Thu, 14 Apr 2022 21:11:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [axboe-block:sock-nolock.2 5/5] net/xfrm/espintcp.c:514:19: error:
 too few arguments to function call, expected 2, have 1
Message-ID: <202204142116.e1SadX9n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git sock-nolock.2
head:   95f2e3bd27b30244f79deacbc1aac49d294bd854
commit: 95f2e3bd27b30244f79deacbc1aac49d294bd854 [5/5] net: allow sk_prot->release_cb() without sock lock held
config: s390-randconfig-r044-20220414 (https://download.01.org/0day-ci/archive/20220414/202204142116.e1SadX9n-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6b7e6ea489f6dd45a9b0da9ac20871560917b9b0)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?id=95f2e3bd27b30244f79deacbc1aac49d294bd854
        git remote add axboe-block https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
        git fetch --no-tags axboe-block sock-nolock.2
        git checkout 95f2e3bd27b30244f79deacbc1aac49d294bd854
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash net/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/xfrm/espintcp.c:2:
   In file included from include/net/tcp.h:20:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from net/xfrm/espintcp.c:2:
   In file included from include/net/tcp.h:20:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from net/xfrm/espintcp.c:2:
   In file included from include/net/tcp.h:20:
   In file included from include/linux/tcp.h:17:
   In file included from include/linux/skbuff.h:31:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
>> net/xfrm/espintcp.c:514:19: error: too few arguments to function call, expected 2, have 1
           tcp_release_cb(sk);
           ~~~~~~~~~~~~~~   ^
   include/net/tcp.h:337:6: note: 'tcp_release_cb' declared here
   void tcp_release_cb(struct sock *sk, bool locked);
        ^
>> net/xfrm/espintcp.c:566:28: error: incompatible function pointer types assigning to 'void (*)(struct sock *, bool)' (aka 'void (*)(struct sock *, _Bool)') from 'void (struct sock *)' [-Werror,-Wincompatible-function-pointer-types]
           espintcp_prot->release_cb = espintcp_release;
                                     ^ ~~~~~~~~~~~~~~~~
   12 warnings and 2 errors generated.


vim +514 net/xfrm/espintcp.c

e27cca96cd68fa Sabrina Dubroca 2019-11-25  501  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  502  static void espintcp_release(struct sock *sk)
e27cca96cd68fa Sabrina Dubroca 2019-11-25  503  {
e27cca96cd68fa Sabrina Dubroca 2019-11-25  504  	struct espintcp_ctx *ctx = espintcp_getctx(sk);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  505  	struct sk_buff_head queue;
e27cca96cd68fa Sabrina Dubroca 2019-11-25  506  	struct sk_buff *skb;
e27cca96cd68fa Sabrina Dubroca 2019-11-25  507  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  508  	__skb_queue_head_init(&queue);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  509  	skb_queue_splice_init(&ctx->out_queue, &queue);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  510  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  511  	while ((skb = __skb_dequeue(&queue)))
e27cca96cd68fa Sabrina Dubroca 2019-11-25  512  		espintcp_push_skb(sk, skb);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  513  
e27cca96cd68fa Sabrina Dubroca 2019-11-25 @514  	tcp_release_cb(sk);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  515  }
e27cca96cd68fa Sabrina Dubroca 2019-11-25  516  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  517  static void espintcp_close(struct sock *sk, long timeout)
e27cca96cd68fa Sabrina Dubroca 2019-11-25  518  {
e27cca96cd68fa Sabrina Dubroca 2019-11-25  519  	struct espintcp_ctx *ctx = espintcp_getctx(sk);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  520  	struct espintcp_msg *emsg = &ctx->partial;
e27cca96cd68fa Sabrina Dubroca 2019-11-25  521  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  522  	strp_stop(&ctx->strp);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  523  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  524  	sk->sk_prot = &tcp_prot;
e27cca96cd68fa Sabrina Dubroca 2019-11-25  525  	barrier();
e27cca96cd68fa Sabrina Dubroca 2019-11-25  526  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  527  	cancel_work_sync(&ctx->work);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  528  	strp_done(&ctx->strp);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  529  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  530  	skb_queue_purge(&ctx->out_queue);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  531  	skb_queue_purge(&ctx->ike_queue);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  532  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  533  	if (emsg->len) {
e27cca96cd68fa Sabrina Dubroca 2019-11-25  534  		if (emsg->skb)
e27cca96cd68fa Sabrina Dubroca 2019-11-25  535  			kfree_skb(emsg->skb);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  536  		else
e27cca96cd68fa Sabrina Dubroca 2019-11-25  537  			sk_msg_free(sk, &emsg->skmsg);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  538  	}
e27cca96cd68fa Sabrina Dubroca 2019-11-25  539  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  540  	tcp_close(sk, timeout);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  541  }
e27cca96cd68fa Sabrina Dubroca 2019-11-25  542  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  543  static __poll_t espintcp_poll(struct file *file, struct socket *sock,
e27cca96cd68fa Sabrina Dubroca 2019-11-25  544  			      poll_table *wait)
e27cca96cd68fa Sabrina Dubroca 2019-11-25  545  {
e27cca96cd68fa Sabrina Dubroca 2019-11-25  546  	__poll_t mask = datagram_poll(file, sock, wait);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  547  	struct sock *sk = sock->sk;
e27cca96cd68fa Sabrina Dubroca 2019-11-25  548  	struct espintcp_ctx *ctx = espintcp_getctx(sk);
e27cca96cd68fa Sabrina Dubroca 2019-11-25  549  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  550  	if (!skb_queue_empty(&ctx->ike_queue))
e27cca96cd68fa Sabrina Dubroca 2019-11-25  551  		mask |= EPOLLIN | EPOLLRDNORM;
e27cca96cd68fa Sabrina Dubroca 2019-11-25  552  
e27cca96cd68fa Sabrina Dubroca 2019-11-25  553  	return mask;
e27cca96cd68fa Sabrina Dubroca 2019-11-25  554  }
e27cca96cd68fa Sabrina Dubroca 2019-11-25  555  
26333c37fc285e Sabrina Dubroca 2020-04-27  556  static void build_protos(struct proto *espintcp_prot,
26333c37fc285e Sabrina Dubroca 2020-04-27  557  			 struct proto_ops *espintcp_ops,
26333c37fc285e Sabrina Dubroca 2020-04-27  558  			 const struct proto *orig_prot,
26333c37fc285e Sabrina Dubroca 2020-04-27  559  			 const struct proto_ops *orig_ops)
26333c37fc285e Sabrina Dubroca 2020-04-27  560  {
26333c37fc285e Sabrina Dubroca 2020-04-27  561  	memcpy(espintcp_prot, orig_prot, sizeof(struct proto));
26333c37fc285e Sabrina Dubroca 2020-04-27  562  	memcpy(espintcp_ops, orig_ops, sizeof(struct proto_ops));
26333c37fc285e Sabrina Dubroca 2020-04-27  563  	espintcp_prot->sendmsg = espintcp_sendmsg;
26333c37fc285e Sabrina Dubroca 2020-04-27  564  	espintcp_prot->recvmsg = espintcp_recvmsg;
26333c37fc285e Sabrina Dubroca 2020-04-27  565  	espintcp_prot->close = espintcp_close;
26333c37fc285e Sabrina Dubroca 2020-04-27 @566  	espintcp_prot->release_cb = espintcp_release;
26333c37fc285e Sabrina Dubroca 2020-04-27  567  	espintcp_ops->poll = espintcp_poll;
26333c37fc285e Sabrina Dubroca 2020-04-27  568  }
26333c37fc285e Sabrina Dubroca 2020-04-27  569  

:::::: The code at line 514 was first introduced by commit
:::::: e27cca96cd68fa2c6814c90f9a1cfd36bb68c593 xfrm: add espintcp (RFC 8229)

:::::: TO: Sabrina Dubroca <sd@queasysnail.net>
:::::: CC: Steffen Klassert <steffen.klassert@secunet.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
