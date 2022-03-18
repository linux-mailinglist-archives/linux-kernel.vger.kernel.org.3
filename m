Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5724DE409
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 23:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241315AbiCRWdP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 18:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239037AbiCRWdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 18:33:12 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07DEC2EAF77
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 15:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647642712; x=1679178712;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zIw54+e45boIaDOdi15UX3ZvBJl8AV/hmlrf8+mVydM=;
  b=RzdTqDH1B08Q8MxJjix2YifKTFyEcQJDdgH0Pb8CCXFLB3XB1ZmZ308x
   6FRxa//r0lc/bNuHFoMwCCbqkFT2woez+/n8czt0Rf1MbpX1k3KwBiR4c
   GKO9lZ9kvR3IX4MV7rmXgnbgWtxTkmHFSULFJsJfWq2X20Qa5nHG7KuXd
   f9P5DujSpbG1WBmUgeE2n4n87Gd8vlZaza1j5Xgdufs2jLQ+3eCEOR6+e
   bPyl0md6CYokPpPMi7nU+toMIsNwPOP4ICbQV86xXuzti3Etn6AOmXGK/
   xSSBsrluI+GOm4ooLlUcdqIlSIhEoNgcTiPRuWMddbGJD4NA69ovVuhKu
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10290"; a="282054276"
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="282054276"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2022 15:31:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,192,1643702400"; 
   d="scan'208";a="581931749"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 18 Mar 2022 15:31:50 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nVL8Q-000FE6-44; Fri, 18 Mar 2022 22:31:50 +0000
Date:   Sat, 19 Mar 2022 06:31:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jonathan Lassoff <jof@thejof.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org, Jonathan Lassoff <jof@thejof.com>
Subject: Re: [PATCH v2] Add FAT messages to printk index
Message-ID: <202203190644.dlcQDVaN-lkp@intel.com>
References: <c11c5c259d5e53afe5b20fa761002e7edd48277f.1647624190.git.jof@thejof.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c11c5c259d5e53afe5b20fa761002e7edd48277f.1647624190.git.jof@thejof.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]
[also build test WARNING on linux/master linus/master v5.17-rc8 next-20220318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jonathan-Lassoff/Add-FAT-messages-to-printk-index/20220319-012711
base:   https://github.com/hnaz/linux-mm master
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220319/202203190644.dlcQDVaN-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6e70e4056dff962ec634c5bd4f2f4105a0bef71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e3f2c52ef480a29ed0b693801bcd9497c19b89ab
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jonathan-Lassoff/Add-FAT-messages-to-printk-index/20220319-012711
        git checkout e3f2c52ef480a29ed0b693801bcd9497c19b89ab
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/fat/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/fat/misc.c:49: warning: Function parameter or member 'sb' not described in '_fat_msg'
   fs/fat/misc.c:49: warning: Function parameter or member 'level' not described in '_fat_msg'
   fs/fat/misc.c:49: warning: Function parameter or member 'fmt' not described in '_fat_msg'
>> fs/fat/misc.c:49: warning: expecting prototype for fat_msg(). Prototype was for _fat_msg() instead


vim +49 fs/fat/misc.c

^1da177e4c3f41 Linus Torvalds   2005-04-16  43  
81ac21d34a91e8 Oleksij Rempel   2011-04-12  44  /**
81ac21d34a91e8 Oleksij Rempel   2011-04-12  45   * fat_msg() - print preformated FAT specific messages. Every thing what is
81ac21d34a91e8 Oleksij Rempel   2011-04-12  46   * not fat_fs_error() should be fat_msg().
81ac21d34a91e8 Oleksij Rempel   2011-04-12  47   */
e3f2c52ef480a2 Jonathan Lassoff 2022-03-18  48  void _fat_msg(struct super_block *sb, const char *level, const char *fmt, ...)
81ac21d34a91e8 Oleksij Rempel   2011-04-12 @49  {
81ac21d34a91e8 Oleksij Rempel   2011-04-12  50  	struct va_format vaf;
81ac21d34a91e8 Oleksij Rempel   2011-04-12  51  	va_list args;
81ac21d34a91e8 Oleksij Rempel   2011-04-12  52  
81ac21d34a91e8 Oleksij Rempel   2011-04-12  53  	va_start(args, fmt);
81ac21d34a91e8 Oleksij Rempel   2011-04-12  54  	vaf.fmt = fmt;
81ac21d34a91e8 Oleksij Rempel   2011-04-12  55  	vaf.va = &args;
e3f2c52ef480a2 Jonathan Lassoff 2022-03-18  56  	_printk(FAT_PRINTK_PREFIX "%pV\n", level, sb->s_id, &vaf);
81ac21d34a91e8 Oleksij Rempel   2011-04-12  57  	va_end(args);
81ac21d34a91e8 Oleksij Rempel   2011-04-12  58  }
81ac21d34a91e8 Oleksij Rempel   2011-04-12  59  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
