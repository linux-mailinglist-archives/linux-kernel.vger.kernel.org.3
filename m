Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383CE4DBB51
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 00:46:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350450AbiCPXsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 19:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237308AbiCPXr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 19:47:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2379E63DF
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 16:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647474404; x=1679010404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4GjD/OZt9YStp94vzGfTNFNjIbukRi5WMqeI8i4H3aY=;
  b=K0BF81gylwfoEKDk/OYm9fgF1bjWkvnR76MPKLok4LcijNF1YuzJ/yxu
   ifXd5vMblKNGTXVJhvjC7p+/XSnOAGMxD0hHZ32dG3eFWmeRvncOkHGWz
   4RIrFOJp/mmbuTN1CeqMKAEM8fHBYUU/DRrzDPfn5Tzhe9yFdjAbGHauo
   GDTeOM1FMlbmi6Yv7sjjocCIkpIzY7e2DcjI15cv6Rl0yFJlRn44GBkDi
   A4ZSVoYUJdMpcX8erx2By22cMiscsK3QL0Io0Y+T8AMO3Ao7AvnBYQNKN
   XjAFKlxX0ybWxPWU4+H93wxYGAU38is0EnitiUvPPZvGzi8lgHs8g4WDr
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="319954013"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="319954013"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 16:46:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="516547578"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 16 Mar 2022 16:46:41 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUdLk-000D5w-Jn; Wed, 16 Mar 2022 23:46:40 +0000
Date:   Thu, 17 Mar 2022 07:45:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/merge-next-20220315 403/512]
 WARNING: modpost: vmlinux.o(.text+0x3e43c2): Section mismatch in reference
 from the function ufs_make_empty() to the function
 .init.text:set_reset_devices()
Message-ID: <202203170727.Iy1d0my1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block rostedt/linux-trace/merge-next-20220315
head:   87a21b60077d8cb23d3e70a00a969b542d0695d8
commit: 76c068f7115ac5a6fb351db3cf91147ccfbd955b [403/512] mm: rmap: introduce pfn_mkclean_range() to cleans PTEs
config: riscv-randconfig-r042-20220314 (https://download.01.org/0day-ci/archive/20220317/202203170727.Iy1d0my1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6ec1e3d798f8eab43fb3a91028c6ab04e115fcb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/76c068f7115ac5a6fb351db3cf91147ccfbd955b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/merge-next-20220315
        git checkout 76c068f7115ac5a6fb351db3cf91147ccfbd955b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x3e43c2): Section mismatch in reference from the function ufs_make_empty() to the function .init.text:set_reset_devices()
The function ufs_make_empty() references
the function __init set_reset_devices().
This is often because ufs_make_empty lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3eb1f8): Section mismatch in reference from the function ufs_mknod() to the variable .init.text:.LBB130_23
The function ufs_mknod() references
the variable __init .LBB130_23.
This is often because ufs_mknod lacks a __init
annotation or the annotation of .LBB130_23 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x446e7c): Section mismatch in reference from the function fuse_open_common() to the variable .init.data:__TRACE_SYSTEM_afs_FS_InlineBulkStatus
The function fuse_open_common() references
the variable __initdata __TRACE_SYSTEM_afs_FS_InlineBulkStatus.
This is often because fuse_open_common lacks a __initdata
annotation or the annotation of __TRACE_SYSTEM_afs_FS_InlineBulkStatus is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x47be1a): Section mismatch in reference from the function duplicateIXtree() to the variable .init.data:__TRACE_SYSTEM_afs_file_error_dir_unmarked_ext
The function duplicateIXtree() references
the variable __initdata __TRACE_SYSTEM_afs_file_error_dir_unmarked_ext.
This is often because duplicateIXtree lacks a __initdata
annotation or the annotation of __TRACE_SYSTEM_afs_file_error_dir_unmarked_ext is wrong.

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x34c044): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c090): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f5ee): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359bd0): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359bda): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359be4): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359c2e): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359c72): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359ca8): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359cec): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c044): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c090): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f5ee): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359bd0): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359bda): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359be4): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359c2e): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359c72): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359ca8): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359cec): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c044): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c090): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f5ee): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359bd0): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359bda): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359be4): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359c2e): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359c72): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359ca8): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359cec): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c044): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c090): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f5ee): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359bd0): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359bda): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359be4): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359c2e): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359c72): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359ca8): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359cec): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
