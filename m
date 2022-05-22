Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8346952FFEB
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 02:18:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345028AbiEVASF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 20:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231842AbiEVAR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 20:17:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286353FBC1
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 17:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653178678; x=1684714678;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=F5kxFy1qSXgHAmK1z9KThZVPBMfDEz5y/zAtXlRLzKU=;
  b=WzLbmrTkzNdCpbRMLcEKjpZpCxkjUGBK+qFp/b4aSzn+drVR/Twhgbe5
   KJoAchnhnCgmhLPKI26xeUtxbwBBv2ajnr2JRDFOXt8eIXfbQ3cysYI/x
   lB9bM72XUGcmiFVNBK3uHEizCxmZjNK42trr0SyEDPzFbNTewH1JhNCRP
   CqByarqB4V8p8QDYvPGh3Ktlb7jASrckbmY8/2GmzkJtHVKde59n4thbi
   hQ7qgO1tMgIieMxezE3/+kKACx6Gkiuew4qxa+oabVm0bkXtu4HddzFDx
   L8pbrbEYZupX1GQu0uNgD+0am2yMOkRkg++n88gFhtSCoFUm9YD87TdBd
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10354"; a="335971925"
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="335971925"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 17:17:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,243,1647327600"; 
   d="scan'208";a="744058940"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 21 May 2022 17:17:56 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsZIB-0006lA-MH;
        Sun, 22 May 2022 00:17:55 +0000
Date:   Sun, 22 May 2022 08:17:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Chuck Lever <chuck.lever@oracle.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: [cel:topic-rpc-with-tls-upcall 3/19] af_tlsh.c:undefined reference
 to `inet6_getname'
Message-ID: <202205220836.G9R3wOR1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux topic-rpc-with-tls-upcall
head:   c484b8917f3569f6fdf4026936f9452dbeb1a8c3
commit: 633fdf59349bcca5ca23885959506d643bbb9daf [3/19] net/tls: Add support for PF_TLSH (a TLS handshake listener)
config: i386-randconfig-a005 (https://download.01.org/0day-ci/archive/20220522/202205220836.G9R3wOR1-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git/commit/?id=633fdf59349bcca5ca23885959506d643bbb9daf
        git remote add cel git://git.kernel.org/pub/scm/linux/kernel/git/cel/linux
        git fetch --no-tags cel topic-rpc-with-tls-upcall
        git checkout 633fdf59349bcca5ca23885959506d643bbb9daf
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: net/tls/af_tlsh.o: in function `tlsh_getname':
>> af_tlsh.c:(.text+0x1f7): undefined reference to `inet6_getname'
   ld: net/tls/af_tlsh.o: in function `tlsh_release':
>> af_tlsh.c:(.text+0x12f7): undefined reference to `inet6_release'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
