Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E660D4EA374
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 01:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbiC1XJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 19:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbiC1XJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 19:09:16 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D80F60C2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 16:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648508854; x=1680044854;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=tvAFI6iISHckMFlraLRgHpijQiwX/o6AHylRpEbVP+8=;
  b=NW8ckGgxUN9UzSWdNYWV4ucfkcu5IL/bw4SBOduAPf7k+xY4Fvx3RYso
   rAArniZHYcoqs5YmtjbxLJbk7eeqvUhuqYjU42mdU7vD6U8GTtldgeAIK
   9SJzHtllxBR9LmsyJL9MqbHTsWFDgThH0HHDUfTuMPCLioc7If6nH3j10
   OFwn772aptOPQdnIv2b1/w0pIgEk2ps3Jryro/ciTSptNSDYJzWST5qrJ
   lYwJwK3+FifPTOIcpDDKDGOi8GMkBrnXq6LW+rKSd1A/NCQ6zyAxCUtDh
   XlkoWVFXmbFBrGI1dL/Ca3Yk/mgewPl/mG7sV1HDRAIh/hllyzcupkE6E
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="241273993"
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="241273993"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 16:07:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,218,1643702400"; 
   d="scan'208";a="546147297"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2022 16:07:32 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYySR-0002P2-Us; Mon, 28 Mar 2022 23:07:31 +0000
Date:   Tue, 29 Mar 2022 07:06:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:axboe/linux-block/sock-nolock 6/6]
 fs/io_uring.c:8999:9: error: implicit declaration of function
 'io_sock_nolock_clear'
Message-ID: <202203290706.2CmUdsqb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/sock-nolock
head:   90b2144118aabeddabb82f22e07b87da068c54cd
commit: 90b2144118aabeddabb82f22e07b87da068c54cd [6/6] io_uring: mark accept direct socket as no-lock
config: powerpc-allnoconfig (https://download.01.org/0day-ci/archive/20220329/202203290706.2CmUdsqb-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/90b2144118aabeddabb82f22e07b87da068c54cd
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/sock-nolock
        git checkout 90b2144118aabeddabb82f22e07b87da068c54cd
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/io_uring.c: In function '__io_submit_flush_completions':
   fs/io_uring.c:2705:40: warning: variable 'prev' set but not used [-Wunused-but-set-variable]
    2705 |         struct io_wq_work_node *node, *prev;
         |                                        ^~~~
   fs/io_uring.c: In function 'io_rsrc_file_put':
>> fs/io_uring.c:8999:9: error: implicit declaration of function 'io_sock_nolock_clear' [-Werror=implicit-function-declaration]
    8999 |         io_sock_nolock_clear(file);
         |         ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/io_sock_nolock_clear +8999 fs/io_uring.c

  8938	
  8939	static void io_rsrc_file_put(struct io_ring_ctx *ctx, struct io_rsrc_put *prsrc)
  8940	{
  8941		struct file *file = prsrc->file;
  8942	#if defined(CONFIG_UNIX)
  8943		struct sock *sock = ctx->ring_sock->sk;
  8944		struct sk_buff_head list, *head = &sock->sk_receive_queue;
  8945		struct sk_buff *skb;
  8946		int i;
  8947	
  8948		__skb_queue_head_init(&list);
  8949	
  8950		/*
  8951		 * Find the skb that holds this file in its SCM_RIGHTS. When found,
  8952		 * remove this entry and rearrange the file array.
  8953		 */
  8954		skb = skb_dequeue(head);
  8955		while (skb) {
  8956			struct scm_fp_list *fp;
  8957	
  8958			fp = UNIXCB(skb).fp;
  8959			for (i = 0; i < fp->count; i++) {
  8960				int left;
  8961	
  8962				if (fp->fp[i] != file)
  8963					continue;
  8964	
  8965				unix_notinflight(fp->user, fp->fp[i]);
  8966				left = fp->count - 1 - i;
  8967				if (left) {
  8968					memmove(&fp->fp[i], &fp->fp[i + 1],
  8969							left * sizeof(struct file *));
  8970				}
  8971				fp->count--;
  8972				if (!fp->count) {
  8973					kfree_skb(skb);
  8974					skb = NULL;
  8975				} else {
  8976					__skb_queue_tail(&list, skb);
  8977				}
  8978				io_sock_nolock_clear(file);
  8979				fput(file);
  8980				file = NULL;
  8981				break;
  8982			}
  8983	
  8984			if (!file)
  8985				break;
  8986	
  8987			__skb_queue_tail(&list, skb);
  8988	
  8989			skb = skb_dequeue(head);
  8990		}
  8991	
  8992		if (skb_peek(&list)) {
  8993			spin_lock_irq(&head->lock);
  8994			while ((skb = __skb_dequeue(&list)) != NULL)
  8995				__skb_queue_tail(head, skb);
  8996			spin_unlock_irq(&head->lock);
  8997		}
  8998	#else
> 8999		io_sock_nolock_clear(file);
  9000		fput(file);
  9001	#endif
  9002	}
  9003	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
