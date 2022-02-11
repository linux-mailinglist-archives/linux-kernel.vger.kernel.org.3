Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06C684B2C44
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:00:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344503AbiBKR7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:59:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343674AbiBKR7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:59:04 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB95BCE9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:59:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644602342; x=1676138342;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TL++bZhhP8obKU8rV7DT17KbsEkZMjE8TOIN0Y4aU+Y=;
  b=bdZHkq1g32hBsa1NjF86UPbnr1rsINU2j4/0yAm5vJSuoVJyrvAdHSI8
   C9iJrBMap610snQ7hxAfr6EWW3V3qc5N9KRVPhlkaZSb3oy5HhLjPut9M
   HO1icteymjLScUs4KEuMGBPu9RXew8J2OLtRt6rQRDoxibjO50/8jZNg4
   YZ1w2B0WPL3AvW60PW9BN4d05tkYZQ6lz88ENNfahOP5G1rzMgYc0Wu/t
   zrSMHZ+AO48fHBWdwjEl1TmW+4rx6hXJ5ZmMG/0Euz0RQ2Q4KRcWbnb/Z
   s6PkyE7fC66HgofLcgubFXtcvUxw6ln+CWNGC6HcmSG0+vdxW5AKV9XDf
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="230419959"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="230419959"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 09:59:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="586424423"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 11 Feb 2022 09:59:01 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIaCD-0004uW-4Y; Fri, 11 Feb 2022 17:59:01 +0000
Date:   Sat, 12 Feb 2022 01:58:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/netfs-maple 34/35]
 nios2-linux-ld: flush.c:undefined reference to `xa_store_range'
Message-ID: <202202112245.r3x89mqA-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/netfs-maple
head:   429e2bb6fb190f390ed23afc0d2308e877c43be5
commit: e9340673baaf1ff587aed3391aa411cf554bc42e [34/35] netfs: Slice a writeback from a dirty region
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220211/202202112245.r3x89mqA-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e9340673baaf1ff587aed3391aa411cf554bc42e
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/netfs-maple
        git checkout e9340673baaf1ff587aed3391aa411cf554bc42e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nios2-linux-ld: fs/netfs/flush.o: in function `netfs_flush_get_pages':
   flush.c:(.text.unlikely+0x244): undefined reference to `xa_store_range'
   flush.c:(.text.unlikely+0x244): relocation truncated to fit: R_NIOS2_CALL26 against `xa_store_range'
>> nios2-linux-ld: flush.c:(.text.unlikely+0x2fc): undefined reference to `xa_store_range'
   flush.c:(.text.unlikely+0x2fc): relocation truncated to fit: R_NIOS2_CALL26 against `xa_store_range'
   `adc3xxx_i2c_remove' referenced in section `.data' of sound/soc/codecs/tlv320adc3xxx.o: defined in discarded section `.exit.text' of sound/soc/codecs/tlv320adc3xxx.o

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
