Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7D24D75E4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 15:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234636AbiCMOhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 10:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiCMOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 10:37:08 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2C57E582
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 07:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647182160; x=1678718160;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=PmI4Dnj9bUe6mktkxURhpIKp1PYRTUDLQyuBJE9tPIQ=;
  b=CXRdU3wqyZuZ7SoK3VkzgMcYYLFC0ZiH/bIOgog8LTk/mKoo/6N8ss9M
   U9hWGQUM+OE7T/oBPtOS4UllDaYuEQc/pe9y3bJnA5deqgc3W60CL5yXh
   /nAwR1WyoELLs6aaUW4lC8MrVU/JeusxWbJFlrP2otD36DXvA4lBlzdvO
   QBpxOENlptxU0dhpM07L9jjbETUPD+CRNHf2yPmTgzGwH4GPLcFc6Gxk5
   nWbQQPiGt9g50d8f+mbip8KXwohMtwZOV8We/xuaQCjmdVlt+19INmFg/
   m1goQpM/TNIyWbo0L+JYt5Gto+Gio6409QyJc/LOz6yi3tqXH+HnupORj
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="236477573"
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="236477573"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2022 07:35:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,178,1643702400"; 
   d="scan'208";a="713422397"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Mar 2022 07:35:58 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nTPKA-00091a-4Q; Sun, 13 Mar 2022 14:35:58 +0000
Date:   Sun, 13 Mar 2022 22:35:11 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [hare-scsi-devel:tls-upcall.v4 127/156] include/net/tls.h:374:1:
 error: unknown type name 'key_ref_t'; did you mean 'key_ref_put'?
Message-ID: <202203132226.RxMqrn2n-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git tls-upcall.v4
head:   d2416ecdb6b03fc2e4aa40b20cdf919322713224
commit: 97a450fed0d4ce4978d51685dcca85f9e8b71811 [127/156] net/tls: register '.tls' keyring
config: arc-defconfig (https://download.01.org/0day-ci/archive/20220313/202203132226.RxMqrn2n-lkp@intel.com/config)
compiler: arc-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git/commit/?id=97a450fed0d4ce4978d51685dcca85f9e8b71811
        git remote add hare-scsi-devel https://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel.git
        git fetch --no-tags hare-scsi-devel tls-upcall.v4
        git checkout 97a450fed0d4ce4978d51685dcca85f9e8b71811
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from net/core/filter.c:79:
>> include/net/tls.h:374:1: error: unknown type name 'key_ref_t'; did you mean 'key_ref_put'?
     374 | key_ref_t tls_psk_refresh(char *identity, u8 *data, size_t data_len);
         | ^~~~~~~~~
         | key_ref_put
   include/net/tls.h:375:1: error: unknown type name 'key_ref_t'; did you mean 'key_ref_put'?
     375 | key_ref_t tls_psk_lookup(char *identity);
         | ^~~~~~~~~
         | key_ref_put


vim +374 include/net/tls.h

   370	
   371	int tlsh_pf_create(struct net *net, struct socket *sock, int protocol,
   372			   int kern);
   373	
 > 374	key_ref_t tls_psk_refresh(char *identity, u8 *data, size_t data_len);
   375	key_ref_t tls_psk_lookup(char *identity);
   376	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
