Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EE0518C48
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 20:24:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241306AbiECS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 14:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241255AbiECS17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 14:27:59 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432523F305
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 11:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651602264; x=1683138264;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=67C5fBl5+gFrT11tgFgVbebVOACL2I9NZV2PLO+Ug9k=;
  b=KvNMDdNxqvd8dtXhztAyWAW//KmSrIOhoh44WKCFZY+qM0wrCh72nfJn
   4ZTJYbpWrNBwecrqd4u8aceMK8CeEBA49WNHNBx9V7XGQpxcDp+N/z/Zx
   YXE7mVu+cLV137BSa9Cme4xIOXKPFjumgSnY8lo7jfN/HGtqqIVWfB4TV
   3OPrlG1vbozJ25m0Wvn7dSCFoXmGhFFReNrhuFPbbKeaSth8uNCfZ3FYr
   yaRyA2MZ03Amk2A1K7MnfXPiwMj2DCtvQjUZB+GjyKdMnL3ASggE/lAlk
   30KxyH0iPBYrb++YkcMXsDHcDYahDRU3WJZQqFuYksSktaG6atCUDny0R
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="267709589"
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="267709589"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 11:24:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,195,1647327600"; 
   d="scan'208";a="810780524"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 03 May 2022 11:24:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nlxC8-000Ahb-RO;
        Tue, 03 May 2022 18:24:20 +0000
Date:   Wed, 4 May 2022 02:24:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Steve French <stfrench@microsoft.com>
Subject: [samba-ksmbd:for-next 5/6] fs/cifs/smb2pdu.c:4058:31: error: no
 member named 'pages' in 'struct cifs_readdata'
Message-ID: <202205040208.cxCO3upU-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.samba.org/ksmbd.git for-next
head:   9a69931b27c1024b2e042bc2eedcf1f1709b555c
commit: a3035a1481dd6e4685871e5c854045b5829b6845 [5/6] cifs: Change the I/O paths to use an iterator rather than a page list
config: x86_64-allmodconfig (https://download.01.org/0day-ci/archive/20220504/202205040208.cxCO3upU-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 363b3a645a1e30011cc8da624f13dac5fd915628)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add samba-ksmbd git://git.samba.org/ksmbd.git
        git fetch --no-tags samba-ksmbd for-next
        git checkout a3035a1481dd6e4685871e5c854045b5829b6845
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> fs/cifs/smb2pdu.c:4058:31: error: no member named 'pages' in 'struct cifs_readdata'
                                   server->smbd_conn, rdata->pages,
                                                      ~~~~~  ^
>> fs/cifs/smb2pdu.c:4059:12: error: no member named 'nr_pages' in 'struct cifs_readdata'
                                   rdata->nr_pages, rdata->page_offset,
                                   ~~~~~  ^
>> fs/cifs/smb2pdu.c:4059:29: error: no member named 'page_offset' in 'struct cifs_readdata'
                                   rdata->nr_pages, rdata->page_offset,
                                                    ~~~~~  ^
>> fs/cifs/smb2pdu.c:4060:12: error: no member named 'tailsz' in 'struct cifs_readdata'
                                   rdata->tailsz, true, need_invalidate);
                                   ~~~~~  ^
>> fs/cifs/smb2pdu.c:4481:31: error: no member named 'pages' in 'struct cifs_writedata'
                                   server->smbd_conn, wdata->pages,
                                                      ~~~~~  ^
>> fs/cifs/smb2pdu.c:4482:12: error: no member named 'nr_pages' in 'struct cifs_writedata'
                                   wdata->nr_pages, wdata->page_offset,
                                   ~~~~~  ^
>> fs/cifs/smb2pdu.c:4482:29: error: no member named 'page_offset' in 'struct cifs_writedata'
                                   wdata->nr_pages, wdata->page_offset,
                                                    ~~~~~  ^
>> fs/cifs/smb2pdu.c:4483:12: error: no member named 'tailsz' in 'struct cifs_writedata'
                                   wdata->tailsz, false, need_invalidate);
                                   ~~~~~  ^
   fs/cifs/smb2pdu.c:4490:14: error: no member named 'nr_pages' in 'struct cifs_writedata'
                   if (wdata->nr_pages > 1)
                       ~~~~~  ^
   fs/cifs/smb2pdu.c:4493:14: error: no member named 'nr_pages' in 'struct cifs_writedata'
                                           (wdata->nr_pages - 1) * wdata->pagesz -
                                            ~~~~~  ^
   include/linux/byteorder/generic.h:88:21: note: expanded from macro 'cpu_to_le32'
   #define cpu_to_le32 __cpu_to_le32
                       ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> fs/cifs/smb2pdu.c:4493:37: error: no member named 'pagesz' in 'struct cifs_writedata'
                                           (wdata->nr_pages - 1) * wdata->pagesz -
                                                                   ~~~~~  ^
   include/linux/byteorder/generic.h:88:21: note: expanded from macro 'cpu_to_le32'
   #define cpu_to_le32 __cpu_to_le32
                       ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   fs/cifs/smb2pdu.c:4494:13: error: no member named 'page_offset' in 'struct cifs_writedata'
                                           wdata->page_offset + wdata->tailsz
                                           ~~~~~  ^
   include/linux/byteorder/generic.h:88:21: note: expanded from macro 'cpu_to_le32'
   #define cpu_to_le32 __cpu_to_le32
                       ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   fs/cifs/smb2pdu.c:4494:34: error: no member named 'tailsz' in 'struct cifs_writedata'
                                           wdata->page_offset + wdata->tailsz
                                                                ~~~~~  ^
   include/linux/byteorder/generic.h:88:21: note: expanded from macro 'cpu_to_le32'
   #define cpu_to_le32 __cpu_to_le32
                       ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
   fs/cifs/smb2pdu.c:4497:45: error: no member named 'tailsz' in 'struct cifs_writedata'
                           req->RemainingBytes = cpu_to_le32(wdata->tailsz);
                                                             ~~~~~  ^
   include/linux/byteorder/generic.h:88:21: note: expanded from macro 'cpu_to_le32'
   #define cpu_to_le32 __cpu_to_le32
                       ^
   include/uapi/linux/byteorder/little_endian.h:34:51: note: expanded from macro '__cpu_to_le32'
   #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
                                                     ^
>> fs/cifs/smb2pdu.c:4520:8: error: no member named 'rq_npages' in 'struct smb_rqst'
                   rqst.rq_npages = 0;
                   ~~~~ ^
   15 errors generated.
--
>> fs/cifs/smbdirect.c:2037:36: error: no member named 'rq_npages' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                              ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
                                                    ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                                 ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:53: error: no member named 'rq_pagesz' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                                               ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
                                                    ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                                 ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2038:11: error: no member named 'rq_tailsz' in 'struct smb_rqst'
                     rqst->rq_tailsz, smb_rqst_len(server, rqst));
                     ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
                                                    ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                                 ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:36: error: no member named 'rq_npages' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                              ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
                                                    ^~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/once_lite.h:19:9: note: expanded from macro 'DO_ONCE_LITE_IF'
                           func(__VA_ARGS__);                              \
                                ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:53: error: no member named 'rq_pagesz' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                                               ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
                                                    ^~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/once_lite.h:19:9: note: expanded from macro 'DO_ONCE_LITE_IF'
                           func(__VA_ARGS__);                              \
                                ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2038:11: error: no member named 'rq_tailsz' in 'struct smb_rqst'
                     rqst->rq_tailsz, smb_rqst_len(server, rqst));
                     ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
                                                    ^~~~~~~~~~~
   note: (skipping 4 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/once_lite.h:19:9: note: expanded from macro 'DO_ONCE_LITE_IF'
                           func(__VA_ARGS__);                              \
                                ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:36: error: no member named 'rq_npages' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                              ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
                                                    ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                                 ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:53: error: no member named 'rq_pagesz' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                                               ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
                                                    ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                                 ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2038:11: error: no member named 'rq_tailsz' in 'struct smb_rqst'
                     rqst->rq_tailsz, smb_rqst_len(server, rqst));
                     ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:77:36: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
                                                    ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/printk.h:132:17: note: expanded from macro 'no_printk'
                   printk(fmt, ##__VA_ARGS__);             \
                                 ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:36: error: no member named 'rq_npages' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                              ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
                                                           ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:66:23: note: expanded from macro 'cifs_dbg_func'
                                         __FILE__, ##__VA_ARGS__);         \
                                                     ^~~~~~~~~~~
   include/linux/printk.h:683:50: note: expanded from macro 'pr_debug_ratelimited'
                   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
                                                                  ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:53: error: no member named 'rq_pagesz' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                                               ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
                                                           ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:66:23: note: expanded from macro 'cifs_dbg_func'
                                         __FILE__, ##__VA_ARGS__);         \
                                                     ^~~~~~~~~~~
   include/linux/printk.h:683:50: note: expanded from macro 'pr_debug_ratelimited'
                   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
                                                                  ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2038:11: error: no member named 'rq_tailsz' in 'struct smb_rqst'
                     rqst->rq_tailsz, smb_rqst_len(server, rqst));
                     ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
                                                           ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:66:23: note: expanded from macro 'cifs_dbg_func'
                                         __FILE__, ##__VA_ARGS__);         \
                                                     ^~~~~~~~~~~
   include/linux/printk.h:683:50: note: expanded from macro 'pr_debug_ratelimited'
                   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
                                                                  ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:36: error: no member named 'rq_npages' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                              ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
                                                           ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/printk.h:640:17: note: expanded from macro 'printk_ratelimited'
                   printk(fmt, ##__VA_ARGS__);                             \
                                 ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:53: error: no member named 'rq_pagesz' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                                               ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
                                                           ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/printk.h:640:17: note: expanded from macro 'printk_ratelimited'
                   printk(fmt, ##__VA_ARGS__);                             \
                                 ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2038:11: error: no member named 'rq_tailsz' in 'struct smb_rqst'
                     rqst->rq_tailsz, smb_rqst_len(server, rqst));
                     ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
                                                           ^~~~~~~~~~~
   note: (skipping 2 expansions in backtrace; use -fmacro-backtrace-limit=0 to see all)
   include/linux/printk.h:640:17: note: expanded from macro 'printk_ratelimited'
                   printk(fmt, ##__VA_ARGS__);                             \
                                 ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                              ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                                   ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:36: error: no member named 'rq_npages' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                              ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
                                                           ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:70:32: note: expanded from macro 'cifs_dbg_func'
                   pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
                                                ^~~~~~~~~~~
   include/linux/printk.h:683:50: note: expanded from macro 'pr_debug_ratelimited'
                   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
                                                                  ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2037:53: error: no member named 'rq_pagesz' in 'struct smb_rqst'
                     rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
                                                               ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
                                                           ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:70:32: note: expanded from macro 'cifs_dbg_func'
                   pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
                                                ^~~~~~~~~~~
   include/linux/printk.h:683:50: note: expanded from macro 'pr_debug_ratelimited'
                   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
                                                                  ^~~~~~~~~~~
>> fs/cifs/smbdirect.c:2038:11: error: no member named 'rq_tailsz' in 'struct smb_rqst'
                     rqst->rq_tailsz, smb_rqst_len(server, rqst));
                     ~~~~  ^
   fs/cifs/smbdirect.c:146:74: note: expanded from macro 'log_write'
   #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
                                                                             ^~~~
   fs/cifs/smbdirect.c:138:53: note: expanded from macro 'log_rdma'
                   cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
                                                                     ^~~~
   fs/cifs/cifs_debug.h:79:43: note: expanded from macro 'cifs_dbg'
                   cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
                                                           ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:70:32: note: expanded from macro 'cifs_dbg_func'
                   pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
                                                ^~~~~~~~~~~
   include/linux/printk.h:683:50: note: expanded from macro 'pr_debug_ratelimited'
                   __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
                                                                  ^~~~~~~~~~~
   fs/cifs/smbdirect.c:2107:24: error: no member named 'rq_npages' in 'struct smb_rqst'
           for (i = 0; i < rqst->rq_npages; i++) {
                           ~~~~  ^
   fatal error: too many errors emitted, stopping now [-ferror-limit=]
   20 errors generated.


vim +4058 fs/cifs/smb2pdu.c

09a4707e763824 Pavel Shilovsky 2012-09-18  4007  
09a4707e763824 Pavel Shilovsky 2012-09-18  4008  /*
09a4707e763824 Pavel Shilovsky 2012-09-18  4009   * To form a chain of read requests, any read requests after the first should
09a4707e763824 Pavel Shilovsky 2012-09-18  4010   * have the end_of_chain boolean set to true.
09a4707e763824 Pavel Shilovsky 2012-09-18  4011   */
09a4707e763824 Pavel Shilovsky 2012-09-18  4012  static int
738f9de5cdb917 Pavel Shilovsky 2016-11-23  4013  smb2_new_read_req(void **buf, unsigned int *total_len,
2dabfd5baba641 Long Li         2017-11-07  4014  	struct cifs_io_parms *io_parms, struct cifs_readdata *rdata,
2dabfd5baba641 Long Li         2017-11-07  4015  	unsigned int remaining_bytes, int request_type)
09a4707e763824 Pavel Shilovsky 2012-09-18  4016  {
09a4707e763824 Pavel Shilovsky 2012-09-18  4017  	int rc = -EACCES;
d8d9de532de9fa Ronnie Sahlberg 2021-09-08  4018  	struct smb2_read_req *req = NULL;
0d35e382e4e96a Ronnie Sahlberg 2021-11-05  4019  	struct smb2_hdr *shdr;
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4020  	struct TCP_Server_Info *server = io_parms->server;
09a4707e763824 Pavel Shilovsky 2012-09-18  4021  
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4022  	rc = smb2_plain_req_init(SMB2_READ, io_parms->tcon, server,
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4023  				 (void **) &req, total_len);
09a4707e763824 Pavel Shilovsky 2012-09-18  4024  	if (rc)
09a4707e763824 Pavel Shilovsky 2012-09-18  4025  		return rc;
2dabfd5baba641 Long Li         2017-11-07  4026  
2dabfd5baba641 Long Li         2017-11-07  4027  	if (server == NULL)
09a4707e763824 Pavel Shilovsky 2012-09-18  4028  		return -ECONNABORTED;
09a4707e763824 Pavel Shilovsky 2012-09-18  4029  
0d35e382e4e96a Ronnie Sahlberg 2021-11-05  4030  	shdr = &req->hdr;
0d35e382e4e96a Ronnie Sahlberg 2021-11-05  4031  	shdr->Id.SyncId.ProcessId = cpu_to_le32(io_parms->pid);
09a4707e763824 Pavel Shilovsky 2012-09-18  4032  
351a59dace0e0e Paulo Alcantara 2022-03-21  4033  	req->PersistentFileId = io_parms->persistent_fid;
351a59dace0e0e Paulo Alcantara 2022-03-21  4034  	req->VolatileFileId = io_parms->volatile_fid;
09a4707e763824 Pavel Shilovsky 2012-09-18  4035  	req->ReadChannelInfoOffset = 0; /* reserved */
09a4707e763824 Pavel Shilovsky 2012-09-18  4036  	req->ReadChannelInfoLength = 0; /* reserved */
09a4707e763824 Pavel Shilovsky 2012-09-18  4037  	req->Channel = 0; /* reserved */
09a4707e763824 Pavel Shilovsky 2012-09-18  4038  	req->MinimumCount = 0;
09a4707e763824 Pavel Shilovsky 2012-09-18  4039  	req->Length = cpu_to_le32(io_parms->length);
09a4707e763824 Pavel Shilovsky 2012-09-18  4040  	req->Offset = cpu_to_le64(io_parms->offset);
d323c24617527f Steve French    2019-02-25  4041  
d323c24617527f Steve French    2019-02-25  4042  	trace_smb3_read_enter(0 /* xid */,
d323c24617527f Steve French    2019-02-25  4043  			io_parms->persistent_fid,
d323c24617527f Steve French    2019-02-25  4044  			io_parms->tcon->tid, io_parms->tcon->ses->Suid,
d323c24617527f Steve French    2019-02-25  4045  			io_parms->offset, io_parms->length);
bd3dcc6a22a918 Long Li         2017-11-22  4046  #ifdef CONFIG_CIFS_SMB_DIRECT
bd3dcc6a22a918 Long Li         2017-11-22  4047  	/*
bd3dcc6a22a918 Long Li         2017-11-22  4048  	 * If we want to do a RDMA write, fill in and append
bd3dcc6a22a918 Long Li         2017-11-22  4049  	 * smbd_buffer_descriptor_v1 to the end of read request
bd3dcc6a22a918 Long Li         2017-11-22  4050  	 */
bb4c0419476bd3 Long Li         2018-04-17  4051  	if (server->rdma && rdata && !server->sign &&
bd3dcc6a22a918 Long Li         2017-11-22  4052  		rdata->bytes >= server->smbd_conn->rdma_readwrite_threshold) {
bd3dcc6a22a918 Long Li         2017-11-22  4053  
bd3dcc6a22a918 Long Li         2017-11-22  4054  		struct smbd_buffer_descriptor_v1 *v1;
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4055  		bool need_invalidate = server->dialect == SMB30_PROT_ID;
bd3dcc6a22a918 Long Li         2017-11-22  4056  
bd3dcc6a22a918 Long Li         2017-11-22  4057  		rdata->mr = smbd_register_mr(
bd3dcc6a22a918 Long Li         2017-11-22 @4058  				server->smbd_conn, rdata->pages,
7cf20bce77581b Long Li         2018-05-30 @4059  				rdata->nr_pages, rdata->page_offset,
7cf20bce77581b Long Li         2018-05-30 @4060  				rdata->tailsz, true, need_invalidate);
bd3dcc6a22a918 Long Li         2017-11-22  4061  		if (!rdata->mr)
b7972092199f6d Long Li         2019-04-05  4062  			return -EAGAIN;
bd3dcc6a22a918 Long Li         2017-11-22  4063  
bd3dcc6a22a918 Long Li         2017-11-22  4064  		req->Channel = SMB2_CHANNEL_RDMA_V1_INVALIDATE;
bd3dcc6a22a918 Long Li         2017-11-22  4065  		if (need_invalidate)
bd3dcc6a22a918 Long Li         2017-11-22  4066  			req->Channel = SMB2_CHANNEL_RDMA_V1;
bd3dcc6a22a918 Long Li         2017-11-22  4067  		req->ReadChannelInfoOffset =
d8d9de532de9fa Ronnie Sahlberg 2021-09-08  4068  			cpu_to_le16(offsetof(struct smb2_read_req, Buffer));
bd3dcc6a22a918 Long Li         2017-11-22  4069  		req->ReadChannelInfoLength =
2026b06e9ce852 Steve French    2018-01-24  4070  			cpu_to_le16(sizeof(struct smbd_buffer_descriptor_v1));
bd3dcc6a22a918 Long Li         2017-11-22  4071  		v1 = (struct smbd_buffer_descriptor_v1 *) &req->Buffer[0];
2026b06e9ce852 Steve French    2018-01-24  4072  		v1->offset = cpu_to_le64(rdata->mr->mr->iova);
2026b06e9ce852 Steve French    2018-01-24  4073  		v1->token = cpu_to_le32(rdata->mr->mr->rkey);
2026b06e9ce852 Steve French    2018-01-24  4074  		v1->length = cpu_to_le32(rdata->mr->mr->length);
bd3dcc6a22a918 Long Li         2017-11-22  4075  
bd3dcc6a22a918 Long Li         2017-11-22  4076  		*total_len += sizeof(*v1) - 1;
bd3dcc6a22a918 Long Li         2017-11-22  4077  	}
bd3dcc6a22a918 Long Li         2017-11-22  4078  #endif
09a4707e763824 Pavel Shilovsky 2012-09-18  4079  	if (request_type & CHAINED_REQUEST) {
09a4707e763824 Pavel Shilovsky 2012-09-18  4080  		if (!(request_type & END_OF_CHAIN)) {
b8f57ee8aad414 Pavel Shilovsky 2016-11-23  4081  			/* next 8-byte aligned request */
b8f57ee8aad414 Pavel Shilovsky 2016-11-23  4082  			*total_len = DIV_ROUND_UP(*total_len, 8) * 8;
b8f57ee8aad414 Pavel Shilovsky 2016-11-23  4083  			shdr->NextCommand = cpu_to_le32(*total_len);
09a4707e763824 Pavel Shilovsky 2012-09-18  4084  		} else /* END_OF_CHAIN */
31473fc4f9653b Pavel Shilovsky 2016-10-24  4085  			shdr->NextCommand = 0;
09a4707e763824 Pavel Shilovsky 2012-09-18  4086  		if (request_type & RELATED_REQUEST) {
31473fc4f9653b Pavel Shilovsky 2016-10-24  4087  			shdr->Flags |= SMB2_FLAGS_RELATED_OPERATIONS;
09a4707e763824 Pavel Shilovsky 2012-09-18  4088  			/*
09a4707e763824 Pavel Shilovsky 2012-09-18  4089  			 * Related requests use info from previous read request
09a4707e763824 Pavel Shilovsky 2012-09-18  4090  			 * in chain.
09a4707e763824 Pavel Shilovsky 2012-09-18  4091  			 */
0d35e382e4e96a Ronnie Sahlberg 2021-11-05  4092  			shdr->SessionId = cpu_to_le64(0xFFFFFFFFFFFFFFFF);
0d35e382e4e96a Ronnie Sahlberg 2021-11-05  4093  			shdr->Id.SyncId.TreeId = cpu_to_le32(0xFFFFFFFF);
351a59dace0e0e Paulo Alcantara 2022-03-21  4094  			req->PersistentFileId = (u64)-1;
351a59dace0e0e Paulo Alcantara 2022-03-21  4095  			req->VolatileFileId = (u64)-1;
09a4707e763824 Pavel Shilovsky 2012-09-18  4096  		}
09a4707e763824 Pavel Shilovsky 2012-09-18  4097  	}
09a4707e763824 Pavel Shilovsky 2012-09-18  4098  	if (remaining_bytes > io_parms->length)
09a4707e763824 Pavel Shilovsky 2012-09-18  4099  		req->RemainingBytes = cpu_to_le32(remaining_bytes);
09a4707e763824 Pavel Shilovsky 2012-09-18  4100  	else
09a4707e763824 Pavel Shilovsky 2012-09-18  4101  		req->RemainingBytes = 0;
09a4707e763824 Pavel Shilovsky 2012-09-18  4102  
738f9de5cdb917 Pavel Shilovsky 2016-11-23  4103  	*buf = req;
09a4707e763824 Pavel Shilovsky 2012-09-18  4104  	return rc;
09a4707e763824 Pavel Shilovsky 2012-09-18  4105  }
09a4707e763824 Pavel Shilovsky 2012-09-18  4106  

:::::: The code at line 4058 was first introduced by commit
:::::: bd3dcc6a22a9186ed78da51ce09e889803552189 CIFS: SMBD: Upper layer performs SMB read via RDMA write through memory registration

:::::: TO: Long Li <longli@microsoft.com>
:::::: CC: Steve French <smfrench@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
