Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6C84DC825
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 15:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234825AbiCQOBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 10:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbiCQOBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 10:01:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCBE1E3181
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 07:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647525613; x=1679061613;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QPfVbT9u+v+Yeu9XDEbPdkI2YLNnYH/l42UkZ4GtSgY=;
  b=nNIh85ZKNHKWBZpQzBTfUSomsiV0Np6G8pXUfewWJgp2sGRuzjyhGqLY
   J3Whed5AbZHsBlUlHf2hdk3LOG50b6lJn7UU8sIYdfwDsxG31Obq07Ym0
   7WtG302EoeOjkEbU0K+ANbwW7M47FZB0OvKWsnVucMslOhXtof8lGJjyj
   Ccw4/ej9pBScjHXr6jbKqtsRfQSlTE2eO7izNMSKyXu8QtRSHr57BTazs
   0lSVzcYy/QHYw1pw++AcuqZHpDE7665L/yofH6E98ewsI0eYmUyba316T
   miIE4BzHl8uL0d1UwYuLm0KXHL9Npp1w4OWBZV8WQ4vkAUt9gHMYu7GPC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="257058377"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="257058377"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 07:00:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="541378125"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 17 Mar 2022 07:00:11 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUqfj-000Djh-2d; Thu, 17 Mar 2022 14:00:11 +0000
Date:   Thu, 17 Mar 2022 21:59:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (Google)" <rostedt@goodmis.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:rostedt/linux-trace/merge-next-20220315 512/512]
 WARNING: modpost: vmlinux.o(.data+0x296750): Section mismatch in reference
 from the variable nft_rt_type to the function .init.text:set_reset_devices()
Message-ID: <202203172141.n0ep448q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/merge-next-20220315
head:   87a21b60077d8cb23d3e70a00a969b542d0695d8
commit: 87a21b60077d8cb23d3e70a00a969b542d0695d8 [512/512] Merge remote-tracking branch 'ftrace/ftrace/core' into HEAD
config: riscv-randconfig-r042-20220314 (https://download.01.org/0day-ci/archive/20220317/202203172141.n0ep448q-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/87a21b60077d8cb23d3e70a00a969b542d0695d8
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/merge-next-20220315
        git checkout 87a21b60077d8cb23d3e70a00a969b542d0695d8
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.data+0x296750): Section mismatch in reference from the variable nft_rt_type to the function .init.text:set_reset_devices()
The variable nft_rt_type references
the function __init set_reset_devices()
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:

--
>> WARNING: modpost: vmlinux.o(.data+0x296764): Section mismatch in reference from the variable nft_rt_type to the variable .init.text:.Ltmp2
The variable nft_rt_type references
the variable __init .Ltmp2
If the reference is valid then annotate the
variable with or __refdata (see linux/init.h) or name the variable:


Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x34cb00): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34cb4c): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3500aa): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ebc5c): Section mismatch in reference from the function ufs_rename() to the variable .init.text:.LBB130_20
<< WARNING: modpost: vmlinux.o(.text+0x3ebc82): Section mismatch in reference from the function ufs_rename() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ebe14): Section mismatch in reference from the function ufs_error() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ebf6e): Section mismatch in reference from the function ufs_panic() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3f1722): Section mismatch in reference from the function ufs_nfs_get_inode() to the variable .init.text:.LBB130_23
<< WARNING: modpost: vmlinux.o(.text+0x3f27c4): Section mismatch in reference from the function jffs2_compressors_exit() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x35026e): Section mismatch in reference from the function nfs3_xdr_enc_setacl3args() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34cb00): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34cb4c): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3500aa): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ebc5c): Section mismatch in reference from the function ufs_rename() to the variable .init.text:.LBB130_20
<< WARNING: modpost: vmlinux.o(.text+0x3ebc82): Section mismatch in reference from the function ufs_rename() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ebe14): Section mismatch in reference from the function ufs_error() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3ebf6e): Section mismatch in reference from the function ufs_panic() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x3f1722): Section mismatch in reference from the function ufs_nfs_get_inode() to the variable .init.text:.LBB130_23
<< WARNING: modpost: vmlinux.o(.text+0x3f27c4): Section mismatch in reference from the function jffs2_compressors_exit() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x35026e): Section mismatch in reference from the function nfs3_xdr_enc_setacl3args() to the function .init.text:set_reset_devices()

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
