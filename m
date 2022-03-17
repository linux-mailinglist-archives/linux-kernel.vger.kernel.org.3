Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49DC84DBBD6
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 01:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242804AbiCQAj1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 20:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiCQAjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 20:39:25 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012311A18
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 17:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647477489; x=1679013489;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JvZMYfhpzxsBHWbBo27k36c1NiWPthcWMJDBU4SNUM4=;
  b=OkS/aDhcbUGQU/JLp8h4LMMaUxB4sBbxL+D7gAqfzASBYPDh7UMBkbJm
   UyT5sqfN5b7xS3GlUyHsLqeiVaQVmLEzW0H8wzjQ0wq0bZrKX+Mij6Am2
   MgXCOrmBbGtEMW+GAQBstcnw+5M6QmBK0awJMs9y4Uz5mw5C0aySlxSaq
   LjMANBTdbU+Mfd8LUZrvvzaHgijKT40rc/Icyd4zktRS98JuaDbYmqVd2
   q2rCq/tLKrepwkQsgRISfALyWRU8ZquftiE+vSVY9cFDK2RRmfXKvhAsG
   fa6b2NgwV/j64DgwSdvOfvSKcPpd5CcN5gVppBxN7jNPWFBGQjp2fedoC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="317468088"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="317468088"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 17:38:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="635187028"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2022 17:38:05 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUe9V-000D7o-4n; Thu, 17 Mar 2022 00:38:05 +0000
Date:   Thu, 17 Mar 2022 08:37:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [ammarfaizi2-block:rostedt/linux-trace/merge-next-20220315 408/512]
 WARNING: modpost: vmlinux.o(.text+0x3ebb16): Section mismatch in reference
 from the function ufs_rename() to the variable .init.text:.LBB130_22
Message-ID: <202203170842.Gc2butT1-lkp@intel.com>
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
commit: 4beb6c5a2edf9f885d4ef58502c0c83d5e68d11d [408/512] mm/migration: add trace events for base page and HugeTLB migrations
config: riscv-randconfig-r042-20220314 (https://download.01.org/0day-ci/archive/20220317/202203170842.Gc2butT1-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/4beb6c5a2edf9f885d4ef58502c0c83d5e68d11d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block rostedt/linux-trace/merge-next-20220315
        git checkout 4beb6c5a2edf9f885d4ef58502c0c83d5e68d11d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0x3ebb16): Section mismatch in reference from the function ufs_rename() to the variable .init.text:.LBB130_22
The function ufs_rename() references
the variable __init .LBB130_22.
This is often because ufs_rename lacks a __init
annotation or the annotation of .LBB130_22 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3ebc14): Section mismatch in reference from the function ufs_rename() to the variable .init.text:.LBB130_20
The function ufs_rename() references
the variable __init .LBB130_20.
This is often because ufs_rename lacks a __init
annotation or the annotation of .LBB130_20 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3f8d4a): Section mismatch in reference from the function jffs2_do_create() to the variable .init.text:.LBB130_32
The function jffs2_do_create() references
the variable __init .LBB130_32.
This is often because jffs2_do_create lacks a __init
annotation or the annotation of .LBB130_32 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3f8f50): Section mismatch in reference from the function jffs2_do_unlink() to the variable .init.text:.LBB130_32
The function jffs2_do_unlink() references
the variable __init .LBB130_32.
This is often because jffs2_do_unlink lacks a __init
annotation or the annotation of .LBB130_32 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3f91f4): Section mismatch in reference from the function jffs2_do_link() to the variable .init.text:.LBB130_32
The function jffs2_do_link() references
the variable __init .LBB130_32.
This is often because jffs2_do_link lacks a __init
annotation or the annotation of .LBB130_32 is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x354e4e): Section mismatch in reference from the function nlmsvc_put_lockowner() to the function .exit.text:test_ww_mutex_exit()
The function nlmsvc_put_lockowner() references a function in an exit section.
Often the function test_ww_mutex_exit() has valid usage outside the exit section
and the fix is to remove the __exit annotation of test_ww_mutex_exit.
--
>> WARNING: modpost: vmlinux.o(.text+0x403312): Section mismatch in reference from the function jffs2_release_xattr_ref() to the function .init.text:set_reset_devices()
The function jffs2_release_xattr_ref() references
the function __init set_reset_devices().
This is often because jffs2_release_xattr_ref lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x355eb6): Section mismatch in reference from the function nlmsvc_release_call() to the function .exit.text:test_ww_mutex_exit()
The function nlmsvc_release_call() references a function in an exit section.
Often the function test_ww_mutex_exit() has valid usage outside the exit section
and the fix is to remove the __exit annotation of test_ww_mutex_exit.
--
>> WARNING: modpost: vmlinux.o(.text+0x461baa): Section mismatch in reference from the function udf_add_aext() to the variable .init.data:__TRACE_SYSTEM_yfs_CB_GetLocalCell
The function udf_add_aext() references
the variable __initdata __TRACE_SYSTEM_yfs_CB_GetLocalCell.
This is often because udf_add_aext lacks a __initdata
annotation or the annotation of __TRACE_SYSTEM_yfs_CB_GetLocalCell is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x3c7adc): Section mismatch in reference from the function ni_try_remove_attr_list() to the function .init.text:set_reset_devices()
The function ni_try_remove_attr_list() references
the function __init set_reset_devices().
This is often because ni_try_remove_attr_list lacks a __init
annotation or the annotation of set_reset_devices is wrong.
--
>> WARNING: modpost: vmlinux.o(.text+0x484460): Section mismatch in reference from the function dtModify() to the variable .init.data:__TRACE_SYSTEM_afs_file_error_writeback_fail
The function dtModify() references
the variable __initdata __TRACE_SYSTEM_afs_file_error_writeback_fail.
This is often because dtModify lacks a __initdata
annotation or the annotation of __TRACE_SYSTEM_afs_file_error_writeback_fail is wrong.
..

Note: the below error/warnings can be found in parent commit:
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x34c1d8): Section mismatch in reference from the function nfs3_proc_unlink_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34c224): Section mismatch in reference from the function nfs3_proc_rename_rpc_prepare() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x34f782): Section mismatch in reference from the function nfs3_xdr_enc_getacl3args() to the variable .init.text:.LBB96_19
<< WARNING: modpost: vmlinux.o(.text+0x359d64): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359d6e): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359d78): Section mismatch in reference from the function __nlm4svc_proc_unlock() to the variable .exit.text:.LBB97_6
<< WARNING: modpost: vmlinux.o(.text+0x359dc2): Section mismatch in reference from the function __nlm4svc_proc_granted() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e06): Section mismatch in reference from the function nlm4svc_callback() to the function .init.text:set_reset_devices()
<< WARNING: modpost: vmlinux.o(.text+0x359e3c): Section mismatch in reference from the function nlm4svc_callback() to the function .exit.text:test_ww_mutex_exit()
<< WARNING: modpost: vmlinux.o(.text+0x359e80): Section mismatch in reference from the function nlm4svc_callback_release() to the function .exit.text:test_ww_mutex_exit()

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
