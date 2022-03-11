Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C190B4D6096
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiCKLb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbiCKLbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:31:19 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF3851BAF25
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 03:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646998215; x=1678534215;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=NwK6+euv7dsBV1AttyeOR0Bgaq+zNotO35uZNwD3Rig=;
  b=Yinb1efMpGV3iP7ucHVmgiiFpL492cSqrQ7i0056ghgrRHPEMc6CBKTR
   PuovVBj/6Cx0M0LGyY1Kid5m0Uz713XyjT/LIuNmZvJej8P5qQRl3+Kva
   huszzpM9/mvk/Da35QydqRtOCLkJcE9NNVTaKnOXMvksu0EIQx0Ow39aL
   oJc/WiNIJXcP3JkFEQzMD04ntkNglZ9AYyS0CnSvoUSbHZLXBqo9NerxQ
   opZWs8cgtQVXZUwcY6maoCbovDb9C+gSlL1PcRSAaLZzwoi8oEIGY3k8Y
   fn98cFVil6q61wwYf5Lgm4MHzj0wVdqheuD6vnpGZa0vB9TDP/CxS9nxi
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="237728097"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="237728097"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 03:29:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="538969034"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 11 Mar 2022 03:29:56 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nSdT1-0006Jf-Kl; Fri, 11 Mar 2022 11:29:55 +0000
Date:   Fri, 11 Mar 2022 19:29:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: net/core/gro.c:290:9: error: implicit declaration of function
 'list_for_each_entry_safe_reverse_inside'; did you mean
 'list_for_each_entry_safe_reverse'?
Message-ID: <202203111919.3iLzhcNo-lkp@intel.com>
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

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20220311-151720/Xiaomeng-Tong/list_for_each_entry-make-iterator-invisiable-outside-the-loop/20220301-160113
head:   54ae283053c127aac4b946dffa0f31f9885dbb77
commit: c74b61caeb4780382f24aa0d6e0fabe81b703eac net/core: remove iterator use outside the loop
date:   4 hours ago
config: arm-buildonly-randconfig-r006-20220310 (https://download.01.org/0day-ci/archive/20220311/202203111919.3iLzhcNo-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c74b61caeb4780382f24aa0d6e0fabe81b703eac
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20220311-151720/Xiaomeng-Tong/list_for_each_entry-make-iterator-invisiable-outside-the-loop/20220301-160113
        git checkout c74b61caeb4780382f24aa0d6e0fabe81b703eac
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash net/core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   net/core/gro.c: In function '__napi_gro_flush_chain':
>> net/core/gro.c:290:9: error: implicit declaration of function 'list_for_each_entry_safe_reverse_inside'; did you mean 'list_for_each_entry_safe_reverse'? [-Werror=implicit-function-declaration]
     290 |         list_for_each_entry_safe_reverse_inside(skb, p, struct sk_buff, head, list) {
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |         list_for_each_entry_safe_reverse
>> net/core/gro.c:290:49: error: 'skb' undeclared (first use in this function)
     290 |         list_for_each_entry_safe_reverse_inside(skb, p, struct sk_buff, head, list) {
         |                                                 ^~~
   net/core/gro.c:290:49: note: each undeclared identifier is reported only once for each function it appears in
>> net/core/gro.c:290:54: error: 'p' undeclared (first use in this function); did you mean 'up'?
     290 |         list_for_each_entry_safe_reverse_inside(skb, p, struct sk_buff, head, list) {
         |                                                      ^
         |                                                      up
>> net/core/gro.c:290:57: error: expected expression before 'struct'
     290 |         list_for_each_entry_safe_reverse_inside(skb, p, struct sk_buff, head, list) {
         |                                                         ^~~~~~
>> net/core/gro.c:290:84: error: expected ';' before '{' token
     290 |         list_for_each_entry_safe_reverse_inside(skb, p, struct sk_buff, head, list) {
         |                                                                                    ^~
         |                                                                                    ;
   net/core/gro.c:288:27: warning: unused variable 'head' [-Wunused-variable]
     288 |         struct list_head *head = &napi->gro_hash[index].list;
         |                           ^~~~
   cc1: some warnings being treated as errors


vim +290 net/core/gro.c

   284	
   285	static void __napi_gro_flush_chain(struct napi_struct *napi, u32 index,
   286					   bool flush_old)
   287	{
   288		struct list_head *head = &napi->gro_hash[index].list;
   289	
 > 290		list_for_each_entry_safe_reverse_inside(skb, p, struct sk_buff, head, list) {
   291			if (flush_old && NAPI_GRO_CB(skb)->age == jiffies)
   292				return;
   293			skb_list_del_init(skb);
   294			napi_gro_complete(napi, skb);
   295			napi->gro_hash[index].count--;
   296		}
   297	
   298		if (!napi->gro_hash[index].count)
   299			__clear_bit(index, &napi->gro_bitmask);
   300	}
   301	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
