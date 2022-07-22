Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC7D757D9D5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 07:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbiGVFr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 01:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiGVFrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 01:47:24 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D94DC28719
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 22:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658468842; x=1690004842;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=YHwXPkrpZBQaAd5USw2TBbYcHsrc7i5dEk1w3ppbFhE=;
  b=FCRV99RQliCEXixznZ2DKKai0dpl4a0mEsUzSqbAnotqwlDLHmiB5C9M
   sMUA6AaV2N2nNR4ZPK81WkmMISw1qqLoAVlHA1IbbfX71bNTEu5ScXqOZ
   r2wLMkqagoo0MrME9vWZxviSeJKo7mxjDCJ3+h0myLvlcnjAgPEES3ZFT
   DttZ0DPPouDi044gbcHO2GEqC4k9zkoMsR2zrqRB5LV8huiC1uLZGQbGu
   r8hX47FeL2V5F2r0eSknZ5B0uNYxH9kM+Dqkm8WfCtTCE3kNWRntR+8po
   Hv+tphRnP6HvkPIc3gMyO6YymoffLvw0MzNr32YXPWbdguDabzhcczHIk
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10415"; a="287996670"
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="287996670"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2022 22:47:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,184,1654585200"; 
   d="scan'208";a="925930572"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2022 22:47:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oElVQ-00012K-22;
        Fri, 22 Jul 2022 05:47:20 +0000
Date:   Fri, 22 Jul 2022 13:46:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>
Subject: include/linux/seq_file.h:247:9: warning: 'strncpy' output may be
 truncated copying 4 bytes from a string of length 4
Message-ID: <202207221351.t3rqiS3k-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilya,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   68e77ffbfd06ae3ef8f2abf1c3b971383c866983
commit: e37b3dd063a1a68e28a7cfaf77c84c472112e330 s390: enable KCSAN
date:   12 months ago
config: s390-randconfig-r036-20220721 (https://download.01.org/0day-ci/archive/20220722/202207221351.t3rqiS3k-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e37b3dd063a1a68e28a7cfaf77c84c472112e330
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout e37b3dd063a1a68e28a7cfaf77c84c472112e330
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash fs/ocfs2/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/seq_file_net.h:5,
                    from include/net/net_namespace.h:179,
                    from include/linux/inet.h:42,
                    from fs/ocfs2/super.c:21:
   fs/ocfs2/super.c: In function 'ocfs2_show_options':
>> include/linux/seq_file.h:247:9: warning: 'strncpy' output may be truncated copying 4 bytes from a string of length 4 [-Wstringop-truncation]
     247 |         strncpy(val_buf, value, length);                \
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   fs/ocfs2/super.c:1539:17: note: in expansion of macro 'seq_show_option_n'
    1539 |                 seq_show_option_n(s, "cluster_stack", osb->osb_cluster_stack,
         |                 ^~~~~~~~~~~~~~~~~


vim +/strncpy +247 include/linux/seq_file.h

a068acf2ee7769 Kees Cook 2015-09-04  233  
a068acf2ee7769 Kees Cook 2015-09-04  234  /**
a068acf2ee7769 Kees Cook 2015-09-04  235   * seq_show_option_n - display mount options with appropriate escapes
a068acf2ee7769 Kees Cook 2015-09-04  236   *		       where @value must be a specific length.
a068acf2ee7769 Kees Cook 2015-09-04  237   * @m: the seq_file handle
a068acf2ee7769 Kees Cook 2015-09-04  238   * @name: the mount option name
a068acf2ee7769 Kees Cook 2015-09-04  239   * @value: the mount option name's value, cannot be NULL
a068acf2ee7769 Kees Cook 2015-09-04  240   * @length: the length of @value to display
a068acf2ee7769 Kees Cook 2015-09-04  241   *
a068acf2ee7769 Kees Cook 2015-09-04  242   * This is a macro since this uses "length" to define the size of the
a068acf2ee7769 Kees Cook 2015-09-04  243   * stack buffer.
a068acf2ee7769 Kees Cook 2015-09-04  244   */
a068acf2ee7769 Kees Cook 2015-09-04  245  #define seq_show_option_n(m, name, value, length) {	\
a068acf2ee7769 Kees Cook 2015-09-04  246  	char val_buf[length + 1];			\
a068acf2ee7769 Kees Cook 2015-09-04 @247  	strncpy(val_buf, value, length);		\
a068acf2ee7769 Kees Cook 2015-09-04  248  	val_buf[length] = '\0';				\
a068acf2ee7769 Kees Cook 2015-09-04  249  	seq_show_option(m, name, val_buf);		\
a068acf2ee7769 Kees Cook 2015-09-04  250  }
a068acf2ee7769 Kees Cook 2015-09-04  251  

:::::: The code at line 247 was first introduced by commit
:::::: a068acf2ee77693e0bf39d6e07139ba704f461c3 fs: create and use seq_show_option for escaping

:::::: TO: Kees Cook <keescook@chromium.org>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
