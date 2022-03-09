Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661B24D3643
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 18:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbiCIRXg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 12:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiCIRXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 12:23:19 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 411107DE1C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 09:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646846540; x=1678382540;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7f4iZMrBn6wHaM9lEp6l01evKdwSBfvVFOQjl7wiQVI=;
  b=i9bW7nNpJEG7eGBZkqghXQQ8qrxo/wG1FwNiIZbiv/AZKuj5KoP6dIQp
   8qWWh/LqmsyikR5ocdKeOJA6NxDeHLeMgVbp88x03JgK3WxkYr3P6ifdl
   wunN1B+TQIY9C+WGlckUbY0qQznvqWnmUyeEh+C3ap69e+vxx5OfQn9e/
   svvbigqCBo5Dt4WfueScUMjqjh8YhCeq8ISwo+rFbsrP1WGIe5fnjzxDy
   0RfCuzU5379qN550CAnf5arYvnUmgIZGVq0hJPrQcix8wTnFwHeD2Z5ou
   +iHruyLXuhFvLV5MnSlIEfpmPB3BLSFUG1PYGa0j9OmRfuYfK1XnsFfdp
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="237204858"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="237204858"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 09:22:19 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="513607490"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Mar 2022 09:22:18 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS00v-0003bi-HR; Wed, 09 Mar 2022 17:22:17 +0000
Date:   Thu, 10 Mar 2022 01:21:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
        linux-kernel@vger.kernel.org, David Ahern <dsahern@kernel.org>
Subject: [tnguy-next-queue:dev-queue 192/252] include/net/tcp.h:1697:1:
 error: expected identifier or '(' before '{' token
Message-ID: <202203100120.Jk1QDYfg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   1f3c9cdce1f36b6edf8296139dafa6cb39826543
commit: 1330b6ef3313fcec577d2b020c290dc8b9f11f1a [192/252] skb: make drop reason booleanable
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20220310/202203100120.Jk1QDYfg-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=1330b6ef3313fcec577d2b020c290dc8b9f11f1a
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 1330b6ef3313fcec577d2b020c290dc8b9f11f1a
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/net/slip/slhc.c:74:
>> include/net/tcp.h:1697:1: error: expected identifier or '(' before '{' token
    1697 | {
         | ^
   include/net/tcp.h:1694:1: warning: 'tcp_inbound_md5_hash' declared 'static' but never defined [-Wunused-function]
    1694 | tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
         | ^~~~~~~~~~~~~~~~~~~~
--
   In file included from net/ipv4/tcp_ipv4.c:64:
>> include/net/tcp.h:1697:1: error: expected identifier or '(' before '{' token
    1697 | {
         | ^
   include/net/tcp.h:1694:1: warning: 'tcp_inbound_md5_hash' used but never defined
    1694 | tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
         | ^~~~~~~~~~~~~~~~~~~~
--
   In file included from net/ipv4/route.c:95:
>> include/net/tcp.h:1697:1: error: expected identifier or '(' before '{' token
    1697 | {
         | ^
   net/ipv4/route.c: In function 'ip_rt_send_redirect':
   net/ipv4/route.c:869:6: warning: variable 'log_martians' set but not used [-Wunused-but-set-variable]
     869 |  int log_martians;
         |      ^~~~~~~~~~~~
   In file included from net/ipv4/route.c:95:
   net/ipv4/route.c: At top level:
   include/net/tcp.h:1694:1: warning: 'tcp_inbound_md5_hash' declared 'static' but never defined [-Wunused-function]
    1694 | tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
         | ^~~~~~~~~~~~~~~~~~~~


vim +1697 include/net/tcp.h

1330b6ef3313fc Jakub Kicinski    2022-03-07  1692  
1330b6ef3313fc Jakub Kicinski    2022-03-07  1693  static inline enum skb_drop_reason
1330b6ef3313fc Jakub Kicinski    2022-03-07  1694  tcp_inbound_md5_hash(const struct sock *sk, const struct sk_buff *skb,
7bbb765b734966 Dmitry Safonov    2022-02-23  1695  		     const void *saddr, const void *daddr,
1330b6ef3313fc Jakub Kicinski    2022-03-07  1696  		     int family, int dif, int sdif);
7bbb765b734966 Dmitry Safonov    2022-02-23 @1697  {
1330b6ef3313fc Jakub Kicinski    2022-03-07  1698  	return SKB_NOT_DROPPED_YET;
7bbb765b734966 Dmitry Safonov    2022-02-23  1699  }
9501f9722922f2 YOSHIFUJI Hideaki 2008-04-18  1700  #define tcp_twsk_md5_key(twsk)	NULL
9501f9722922f2 YOSHIFUJI Hideaki 2008-04-18  1701  #endif
9501f9722922f2 YOSHIFUJI Hideaki 2008-04-18  1702  

:::::: The code at line 1697 was first introduced by commit
:::::: 7bbb765b73496699a165d505ecdce962f903b422 net/tcp: Merge TCP-MD5 inbound callbacks

:::::: TO: Dmitry Safonov <dima@arista.com>
:::::: CC: Jakub Kicinski <kuba@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
