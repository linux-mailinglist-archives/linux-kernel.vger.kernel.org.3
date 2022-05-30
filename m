Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9DA53731D
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 02:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232003AbiE3AnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 20:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbiE3AnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 20:43:11 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265EE1D307
        for <linux-kernel@vger.kernel.org>; Sun, 29 May 2022 17:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653871391; x=1685407391;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=J7WPoFuWwXk1d8BpiQ7DWYSAVOuKKLbKnpnHfxLZ+z8=;
  b=V3OKsNQtgXoNnmOOE3Lpf9Z2sWRh4/dQBURuRk8HvyOCW1S1mxW3MNDI
   aivpR9560VP2ZFCJ40a6krInjanklR4G0ZTbXQhliaGx3usC8+huELz6y
   /4n49Hzw/RFjjazp6O4ATOpFI3Xrbct0De7ZudGRrogoe/nR7Bdn8wkk2
   nI0gIH2v/Zwf3sC31W4JGnB7LQ/UKGfCqw1VtQ44095uA72dUC/3knYPX
   4SSEZ0qRJQHHAEoMqV+LwRvbpB7rsjE+t/RiwPfoXWU6f66wix2tErzDB
   NvW6c9Zz6h+TytUjCCv6NDY6T6EOamvkCEtS2/ES+oTVisP1CBXFlTtIB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10362"; a="361237342"
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="361237342"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 17:43:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,261,1647327600"; 
   d="scan'208";a="611225462"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 29 May 2022 17:43:09 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvTUy-0001L4-Qg;
        Mon, 30 May 2022 00:43:08 +0000
Date:   Mon, 30 May 2022 08:42:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [cel:topic-rpc-with-tls-upcall 3/19] af_tlsh.c:undefined reference
 to `inet6_getname'
Message-ID: <202205300819.feTtS52k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   b1c8574490c25c8b5bade67796641a449badc818
commit: 47ebadbb7c8a9c6329f485ed254c38350492727b [3/19] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: i386-randconfig-a005-20220530 (https://download.01.org/0day-ci/archive/20220530/202205300819.feTtS52k-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=47ebadbb7c8a9c6329f485ed254c38350492727b
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 47ebadbb7c8a9c6329f485ed254c38350492727b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/tls/af_tlsh.o: in function `tlsh_getname':
>> af_tlsh.c:(.text+0x4ff): undefined reference to `inet6_getname'
   ld: net/tls/af_tlsh.o: in function `tlsh_release':
>> af_tlsh.c:(.text+0x2991): undefined reference to `inet6_release'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
