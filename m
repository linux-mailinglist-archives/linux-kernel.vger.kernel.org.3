Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080DD556FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbiFWB2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237818AbiFWB2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:28:05 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56A452DDF
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 18:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655947674; x=1687483674;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=T5wezX84HCtJ7b2C0qpt52HQ/Y27+gbiic17uzTRHuI=;
  b=HwKvVx9+/dcbfbV2w84gVkeaUsHw5/21Wh9aLCNTiv2DedaXTv09F5/5
   cBG1NWNGt0TB1WPmqTDwx+xOQ0mYzBAKMVsXROA19KdS6ahTjAZBsz/PS
   6LGwGUsxzMOfYvycMvxhJ/iGT4GrrGjy7lnlmfh1zpIimlxuh3stD+Qby
   KSGFuubHkxAmtnajw82NdRuMLvF30rDbeAs98yT3s3sF9D2XCHHsWxpmI
   2PFqlYrsp5m2mZl3o+KzCDzgGgzdwkDoPRtDT7ypHS3VZ5Mk9Q0GKygKt
   ztvR5ZsRd7T0sR5TmG0+oZqngevElJceBERjZKfNfVX02fJt3tkBqrMmu
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280640418"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="280640418"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 18:27:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="730624786"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2022 18:27:52 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4BdQ-00007Z-7p;
        Thu, 23 Jun 2022 01:27:52 +0000
Date:   Thu, 23 Jun 2022 08:46:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dylan Yudaken <dylany@fb.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [ammarfaizi2-block:axboe/linux-block/for-5.20/io_uring-buffered-writes
 118/137] io_uring/io_uring.c:1038: warning: expecting prototype for
 io_llist_xchg(). Prototype was for io_llist_cmpxchg() instead
Message-ID: <202206230848.OkDjWWbp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block axboe/linux-block/for-5.20/io_uring-buffered-writes
head:   e9cfc64a27f7a581b8c5d14da4efccfeae9c63bd
commit: c0808632a83a7c607a987154372e705353acf4f2 [118/137] io_uring: introduce llist helpers
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220623/202206230848.OkDjWWbp-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/ammarfaizi2/linux-block/commit/c0808632a83a7c607a987154372e705353acf4f2
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block axboe/linux-block/for-5.20/io_uring-buffered-writes
        git checkout c0808632a83a7c607a987154372e705353acf4f2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   io_uring/io_uring.c:1022: warning: Function parameter or member 'node' not described in 'io_llist_xchg'
   io_uring/io_uring.c:1022: warning: Excess function parameter 'new' description in 'io_llist_xchg'
>> io_uring/io_uring.c:1038: warning: expecting prototype for io_llist_xchg(). Prototype was for io_llist_cmpxchg() instead


vim +1038 io_uring/io_uring.c

  1025	
  1026	/**
  1027	 * io_llist_xchg - possibly swap all entries in a lock-less list
  1028	 * @head:	the head of lock-less list to delete all entries
  1029	 * @old:	expected old value of the first entry of the list
  1030	 * @new:	new entry as the head of the list
  1031	 *
  1032	 * perform a cmpxchg on the first entry of the list.
  1033	 */
  1034	
  1035	static inline struct llist_node *io_llist_cmpxchg(struct llist_head *head,
  1036							  struct llist_node *old,
  1037							  struct llist_node *new)
> 1038	{
  1039		return cmpxchg(&head->first, old, new);
  1040	}
  1041	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
