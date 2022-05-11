Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C913522C6B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242181AbiEKGgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242175AbiEKGf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:35:58 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D293FDF41
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652250955; x=1683786955;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qCr+XBuHIH2CXQ513fSOk9Ub2J6nIW6/4ydXgqPVipE=;
  b=fqLcIeS5FquIPbmmMC5sJvXdyyjet5ZtfQ/AxbKg7T9rSHQml/Uj5Ltq
   N/Bz9g9XMUD+Q7TN/rROnfEo+pYFSZ4CVO0dEy5PxTnL6rrMJrUhrJgqC
   kJsuJFXkWabFAPaKo1cjxfxB1nYQTnDa+lkaEUnf0zlaNF+MEbMX8Pn8Z
   6tufe+2BIq9WXf3F7ZG1/9aZGtARpT0MP0I8PHwPw+xIUvFHZ1EpTf5KY
   LvWqT09NleKZxMeJO9CAX6a7KgtJUfOooYPEKoxdqOXHYG+B7ZJN/XPna
   pDCjI3z775+jquitevwbMM2sM1qsGLUB/nDX9Ch4Hm8jFvTzkYkMdvdY9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="269736488"
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="269736488"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 23:35:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,216,1647327600"; 
   d="scan'208";a="895219123"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2022 23:35:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nofwX-000IoK-DE;
        Wed, 11 May 2022 06:35:29 +0000
Date:   Wed, 11 May 2022 14:34:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-for-sfrench 5/6]
 fs/cifs/smb2pdu.c:4481:57: error: 'struct cifs_writedata' has no member
 named 'pages'
Message-ID: <202205111436.hrkM324G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-for-sfrench
head:   627ce4da99bb612945366770c5604019fb74b653
commit: e4b60df6a12099568c671591d36a9fa16515f6eb [5/6] cifs: Change the I/O paths to use an iterator rather than a page list
config: riscv-allmodconfig (https://download.01.org/0day-ci/archive/20220511/202205111436.hrkM324G-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/e4b60df6a12099568c671591d36a9fa16515f6eb
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-for-sfrench
        git checkout e4b60df6a12099568c671591d36a9fa16515f6eb
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/cifs/smb2pdu.c: In function 'smb2_new_read_req':
   fs/cifs/smb2pdu.c:4058:57: error: 'struct cifs_readdata' has no member named 'pages'
    4058 |                                 server->smbd_conn, rdata->pages,
         |                                                         ^~
   fs/cifs/smb2pdu.c:4059:38: error: 'struct cifs_readdata' has no member named 'nr_pages'
    4059 |                                 rdata->nr_pages, rdata->page_offset,
         |                                      ^~
   fs/cifs/smb2pdu.c:4059:55: error: 'struct cifs_readdata' has no member named 'page_offset'
    4059 |                                 rdata->nr_pages, rdata->page_offset,
         |                                                       ^~
   fs/cifs/smb2pdu.c:4060:38: error: 'struct cifs_readdata' has no member named 'tailsz'
    4060 |                                 rdata->tailsz, true, need_invalidate);
         |                                      ^~
   fs/cifs/smb2pdu.c: In function 'smb2_async_writev':
>> fs/cifs/smb2pdu.c:4481:57: error: 'struct cifs_writedata' has no member named 'pages'
    4481 |                                 server->smbd_conn, wdata->pages,
         |                                                         ^~
   fs/cifs/smb2pdu.c:4482:38: error: 'struct cifs_writedata' has no member named 'nr_pages'
    4482 |                                 wdata->nr_pages, wdata->page_offset,
         |                                      ^~
   fs/cifs/smb2pdu.c:4482:55: error: 'struct cifs_writedata' has no member named 'page_offset'
    4482 |                                 wdata->nr_pages, wdata->page_offset,
         |                                                       ^~
   fs/cifs/smb2pdu.c:4483:38: error: 'struct cifs_writedata' has no member named 'tailsz'
    4483 |                                 wdata->tailsz, false, need_invalidate);
         |                                      ^~
   fs/cifs/smb2pdu.c:4490:26: error: 'struct cifs_writedata' has no member named 'nr_pages'
    4490 |                 if (wdata->nr_pages > 1)
         |                          ^~
   In file included from include/linux/byteorder/little_endian.h:5,
                    from arch/riscv/include/uapi/asm/byteorder.h:10,
                    from include/asm-generic/bitops/le.h:6,
                    from arch/riscv/include/asm/bitops.h:201,
                    from include/linux/bitops.h:33,
                    from include/linux/thread_info.h:27,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/riscv/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:55,
                    from include/linux/wait.h:9,
                    from include/linux/wait_bit.h:8,
                    from include/linux/fs.h:6,
                    from fs/cifs/smb2pdu.c:18:
   fs/cifs/smb2pdu.c:4493:47: error: 'struct cifs_writedata' has no member named 'nr_pages'
    4493 |                                         (wdata->nr_pages - 1) * wdata->pagesz -
         |                                               ^~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
      34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   fs/cifs/smb2pdu.c:4492:33: note: in expansion of macro 'cpu_to_le32'
    4492 |                                 cpu_to_le32(
         |                                 ^~~~~~~~~~~
   fs/cifs/smb2pdu.c:4493:70: error: 'struct cifs_writedata' has no member named 'pagesz'
    4493 |                                         (wdata->nr_pages - 1) * wdata->pagesz -
         |                                                                      ^~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
      34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   fs/cifs/smb2pdu.c:4492:33: note: in expansion of macro 'cpu_to_le32'
    4492 |                                 cpu_to_le32(
         |                                 ^~~~~~~~~~~
   fs/cifs/smb2pdu.c:4494:46: error: 'struct cifs_writedata' has no member named 'page_offset'
    4494 |                                         wdata->page_offset + wdata->tailsz
         |                                              ^~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
      34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   fs/cifs/smb2pdu.c:4492:33: note: in expansion of macro 'cpu_to_le32'
    4492 |                                 cpu_to_le32(
         |                                 ^~~~~~~~~~~
   fs/cifs/smb2pdu.c:4494:67: error: 'struct cifs_writedata' has no member named 'tailsz'
    4494 |                                         wdata->page_offset + wdata->tailsz
         |                                                                   ^~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
      34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   fs/cifs/smb2pdu.c:4492:33: note: in expansion of macro 'cpu_to_le32'
    4492 |                                 cpu_to_le32(
         |                                 ^~~~~~~~~~~
   fs/cifs/smb2pdu.c:4497:64: error: 'struct cifs_writedata' has no member named 'tailsz'
    4497 |                         req->RemainingBytes = cpu_to_le32(wdata->tailsz);
         |                                                                ^~
   include/uapi/linux/byteorder/little_endian.h:34:51: note: in definition of macro '__cpu_to_le32'
      34 | #define __cpu_to_le32(x) ((__force __le32)(__u32)(x))
         |                                                   ^
   fs/cifs/smb2pdu.c:4497:47: note: in expansion of macro 'cpu_to_le32'
    4497 |                         req->RemainingBytes = cpu_to_le32(wdata->tailsz);
         |                                               ^~~~~~~~~~~
   fs/cifs/smb2pdu.c:4520:21: error: 'struct smb_rqst' has no member named 'rq_npages'
    4520 |                 rqst.rq_npages = 0;
         |                     ^
--
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/cmpxchg.h:9,
                    from arch/riscv/include/asm/atomic.h:19,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from fs/cifs/smbdirect.c:7:
   fs/cifs/smbdirect.c: In function 'smbd_send':
>> fs/cifs/smbdirect.c:2037:48: error: 'struct smb_rqst' has no member named 'rq_npages'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:625:9: note: in expansion of macro 'no_printk'
     625 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   fs/cifs/cifs_debug.h:65:17: note: in expansion of macro 'pr_debug_once'
      65 |                 pr_debug_ ## ratefunc("%s: " fmt,                       \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
>> fs/cifs/smbdirect.c:2037:65: error: 'struct smb_rqst' has no member named 'rq_pagesz'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                                 ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:625:9: note: in expansion of macro 'no_printk'
     625 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   fs/cifs/cifs_debug.h:65:17: note: in expansion of macro 'pr_debug_once'
      65 |                 pr_debug_ ## ratefunc("%s: " fmt,                       \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   fs/cifs/smbdirect.c:2038:23: error: 'struct smb_rqst' has no member named 'rq_tailsz'
    2038 |                   rqst->rq_tailsz, smb_rqst_len(server, rqst));
         |                       ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:625:9: note: in expansion of macro 'no_printk'
     625 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   fs/cifs/cifs_debug.h:65:17: note: in expansion of macro 'pr_debug_once'
      65 |                 pr_debug_ ## ratefunc("%s: " fmt,                       \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
>> fs/cifs/smbdirect.c:2037:48: error: 'struct smb_rqst' has no member named 'rq_npages'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/once_lite.h:19:25: note: in expansion of macro 'printk'
      19 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/linux/once_lite.h:11:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
      11 |         DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/printk.h:585:9: note: in expansion of macro 'DO_ONCE_LITE'
     585 |         DO_ONCE_LITE(printk, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   include/linux/printk.h:602:9: note: in expansion of macro 'printk_once'
     602 |         printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:68:17: note: in expansion of macro 'pr_err_once'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                 ^~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
>> fs/cifs/smbdirect.c:2037:65: error: 'struct smb_rqst' has no member named 'rq_pagesz'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                                 ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/once_lite.h:19:25: note: in expansion of macro 'printk'
      19 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/linux/once_lite.h:11:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
      11 |         DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/printk.h:585:9: note: in expansion of macro 'DO_ONCE_LITE'
     585 |         DO_ONCE_LITE(printk, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   include/linux/printk.h:602:9: note: in expansion of macro 'printk_once'
     602 |         printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:68:17: note: in expansion of macro 'pr_err_once'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                 ^~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   fs/cifs/smbdirect.c:2038:23: error: 'struct smb_rqst' has no member named 'rq_tailsz'
    2038 |                   rqst->rq_tailsz, smb_rqst_len(server, rqst));
         |                       ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/once_lite.h:19:25: note: in expansion of macro 'printk'
      19 |                         func(__VA_ARGS__);                              \
         |                         ^~~~
   include/linux/once_lite.h:11:9: note: in expansion of macro 'DO_ONCE_LITE_IF'
      11 |         DO_ONCE_LITE_IF(true, func, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/printk.h:585:9: note: in expansion of macro 'DO_ONCE_LITE'
     585 |         DO_ONCE_LITE(printk, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   include/linux/printk.h:602:9: note: in expansion of macro 'printk_once'
     602 |         printk_once(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:68:17: note: in expansion of macro 'pr_err_once'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                 ^~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
>> fs/cifs/smbdirect.c:2037:48: error: 'struct smb_rqst' has no member named 'rq_npages'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:625:9: note: in expansion of macro 'no_printk'
     625 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   fs/cifs/cifs_debug.h:70:17: note: in expansion of macro 'pr_debug_once'
      70 |                 pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
>> fs/cifs/smbdirect.c:2037:65: error: 'struct smb_rqst' has no member named 'rq_pagesz'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                                 ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:625:9: note: in expansion of macro 'no_printk'
     625 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   fs/cifs/cifs_debug.h:70:17: note: in expansion of macro 'pr_debug_once'
      70 |                 pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   fs/cifs/smbdirect.c:2038:23: error: 'struct smb_rqst' has no member named 'rq_tailsz'
    2038 |                   rqst->rq_tailsz, smb_rqst_len(server, rqst));
         |                       ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:132:17: note: in expansion of macro 'printk'
     132 |                 printk(fmt, ##__VA_ARGS__);             \
         |                 ^~~~~~
   include/linux/printk.h:625:9: note: in expansion of macro 'no_printk'
     625 |         no_printk(KERN_DEBUG pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~
   fs/cifs/cifs_debug.h:70:17: note: in expansion of macro 'pr_debug_once'
      70 |                 pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);              \
         |                 ^~~~~~~~~
   fs/cifs/cifs_debug.h:77:17: note: in expansion of macro 'cifs_dbg_func'
      77 |                 cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);          \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/cmpxchg.h:9,
                    from arch/riscv/include/asm/atomic.h:19,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from fs/cifs/smbdirect.c:7:
>> fs/cifs/smbdirect.c:2037:48: error: 'struct smb_rqst' has no member named 'rq_npages'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                ^~
   include/linux/printk.h:683:64: note: in definition of macro 'pr_debug_ratelimited'
     683 |                 __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
         |                                                                ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
>> fs/cifs/smbdirect.c:2037:65: error: 'struct smb_rqst' has no member named 'rq_pagesz'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                                 ^~
   include/linux/printk.h:683:64: note: in definition of macro 'pr_debug_ratelimited'
     683 |                 __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
         |                                                                ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   fs/cifs/smbdirect.c:2038:23: error: 'struct smb_rqst' has no member named 'rq_tailsz'
    2038 |                   rqst->rq_tailsz, smb_rqst_len(server, rqst));
         |                       ^~
   include/linux/printk.h:683:64: note: in definition of macro 'pr_debug_ratelimited'
     683 |                 __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
         |                                                                ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/cmpxchg.h:9,
                    from arch/riscv/include/asm/atomic.h:19,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from fs/cifs/smbdirect.c:7:
>> fs/cifs/smbdirect.c:2037:48: error: 'struct smb_rqst' has no member named 'rq_npages'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:640:17: note: in expansion of macro 'printk'
     640 |                 printk(fmt, ##__VA_ARGS__);                             \
         |                 ^~~~~~
   include/linux/printk.h:654:9: note: in expansion of macro 'printk_ratelimited'
     654 |         printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~
   fs/cifs/cifs_debug.h:68:17: note: in expansion of macro 'pr_err_ratelimited'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                 ^~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
>> fs/cifs/smbdirect.c:2037:65: error: 'struct smb_rqst' has no member named 'rq_pagesz'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                                 ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:640:17: note: in expansion of macro 'printk'
     640 |                 printk(fmt, ##__VA_ARGS__);                             \
         |                 ^~~~~~
   include/linux/printk.h:654:9: note: in expansion of macro 'printk_ratelimited'
     654 |         printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~
   fs/cifs/cifs_debug.h:68:17: note: in expansion of macro 'pr_err_ratelimited'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                 ^~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   fs/cifs/smbdirect.c:2038:23: error: 'struct smb_rqst' has no member named 'rq_tailsz'
    2038 |                   rqst->rq_tailsz, smb_rqst_len(server, rqst));
         |                       ^~
   include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                                 ^~~~~~~~~~~
   include/linux/printk.h:640:17: note: in expansion of macro 'printk'
     640 |                 printk(fmt, ##__VA_ARGS__);                             \
         |                 ^~~~~~
   include/linux/printk.h:654:9: note: in expansion of macro 'printk_ratelimited'
     654 |         printk_ratelimited(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~~~
   fs/cifs/cifs_debug.h:68:17: note: in expansion of macro 'pr_err_ratelimited'
      68 |                 pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);        \
         |                 ^~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   In file included from include/asm-generic/bug.h:22,
                    from arch/riscv/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from arch/riscv/include/asm/cmpxchg.h:9,
                    from arch/riscv/include/asm/atomic.h:19,
                    from include/linux/atomic.h:7,
                    from include/linux/mm_types_task.h:13,
                    from include/linux/mm_types.h:5,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from fs/cifs/smbdirect.c:7:
>> fs/cifs/smbdirect.c:2037:48: error: 'struct smb_rqst' has no member named 'rq_npages'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                ^~
   include/linux/printk.h:683:64: note: in definition of macro 'pr_debug_ratelimited'
     683 |                 __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
         |                                                                ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
>> fs/cifs/smbdirect.c:2037:65: error: 'struct smb_rqst' has no member named 'rq_pagesz'
    2037 |                   rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
         |                                                                 ^~
   include/linux/printk.h:683:64: note: in definition of macro 'pr_debug_ratelimited'
     683 |                 __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
         |                                                                ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   fs/cifs/smbdirect.c:2038:23: error: 'struct smb_rqst' has no member named 'rq_tailsz'
    2038 |                   rqst->rq_tailsz, smb_rqst_len(server, rqst));
         |                       ^~
   include/linux/printk.h:683:64: note: in definition of macro 'pr_debug_ratelimited'
     683 |                 __dynamic_pr_debug(&descriptor, pr_fmt(fmt), ##__VA_ARGS__);    \
         |                                                                ^~~~~~~~~~~
   fs/cifs/cifs_debug.h:79:17: note: in expansion of macro 'cifs_dbg_func'
      79 |                 cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);   \
         |                 ^~~~~~~~~~~~~
   fs/cifs/smbdirect.c:138:17: note: in expansion of macro 'cifs_dbg'
     138 |                 cifs_dbg(VFS, "%s:%d " fmt, __func__, __LINE__, ##args);\
         |                 ^~~~~~~~
   fs/cifs/smbdirect.c:146:41: note: in expansion of macro 'log_rdma'
     146 | #define log_write(level, fmt, args...)  log_rdma(level, LOG_WRITE, fmt, ##args)
         |                                         ^~~~~~~~
   fs/cifs/smbdirect.c:2036:9: note: in expansion of macro 'log_write'
    2036 |         log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
         |         ^~~~~~~~~
   fs/cifs/smbdirect.c:2107:29: error: 'struct smb_rqst' has no member named 'rq_npages'
    2107 |         for (i = 0; i < rqst->rq_npages; i++) {
         |                             ^~
>> fs/cifs/smbdirect.c:2110:17: error: implicit declaration of function 'rqst_page_get_length' [-Werror=implicit-function-declaration]
    2110 |                 rqst_page_get_length(rqst, i, &buflen, &offset);
         |                 ^~~~~~~~~~~~~~~~~~~~
>> fs/cifs/smbdirect.c:2123:43: error: 'struct smb_rqst' has no member named 'rq_pages'
    2123 |                                 info, rqst->rq_pages[i],
         |                                           ^~
   cc1: some warnings being treated as errors


vim +4481 fs/cifs/smb2pdu.c

33319141252fd1 Pavel Shilovsky 2012-09-18  4428  
33319141252fd1 Pavel Shilovsky 2012-09-18  4429  /* smb2_async_writev - send an async write, and set up mid to handle result */
33319141252fd1 Pavel Shilovsky 2012-09-18  4430  int
4a5c80d7b5615b Steve French    2014-02-07  4431  smb2_async_writev(struct cifs_writedata *wdata,
4a5c80d7b5615b Steve French    2014-02-07  4432  		  void (*release)(struct kref *kref))
33319141252fd1 Pavel Shilovsky 2012-09-18  4433  {
cb7e9eabb2b584 Pavel Shilovsky 2014-06-05  4434  	int rc = -EACCES, flags = 0;
33319141252fd1 Pavel Shilovsky 2012-09-18  4435  	struct smb2_write_req *req = NULL;
0d35e382e4e96a Ronnie Sahlberg 2021-11-05  4436  	struct smb2_hdr *shdr;
33319141252fd1 Pavel Shilovsky 2012-09-18  4437  	struct cifs_tcon *tcon = tlink_tcon(wdata->cfile->tlink);
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4438  	struct TCP_Server_Info *server = wdata->server;
c713c8770fa5bf Ronnie Sahlberg 2018-06-12  4439  	struct kvec iov[1];
738f9de5cdb917 Pavel Shilovsky 2016-11-23  4440  	struct smb_rqst rqst = { };
f5688a6d7c5c52 Ronnie Sahlberg 2017-11-20  4441  	unsigned int total_len;
33319141252fd1 Pavel Shilovsky 2012-09-18  4442  
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4443  	if (!wdata->server)
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4444  		server = wdata->server = cifs_pick_channel(tcon->ses);
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4445  
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4446  	rc = smb2_plain_req_init(SMB2_WRITE, tcon, server,
352d96f3acc6e0 Aurelien Aptel  2020-05-31  4447  				 (void **) &req, &total_len);
f0b93cb9d10789 Pavel Shilovsky 2019-01-25  4448  	if (rc)
f0b93cb9d10789 Pavel Shilovsky 2019-01-25  4449  		return rc;
33319141252fd1 Pavel Shilovsky 2012-09-18  4450  
5a77e75fedce55 Steve French    2018-05-09  4451  	if (smb3_encryption_required(tcon))
7fb8986e7449d0 Pavel Shilovsky 2016-10-31  4452  		flags |= CIFS_TRANSFORM_REQ;
7fb8986e7449d0 Pavel Shilovsky 2016-10-31  4453  
0d35e382e4e96a Ronnie Sahlberg 2021-11-05  4454  	shdr = (struct smb2_hdr *)req;
0d35e382e4e96a Ronnie Sahlberg 2021-11-05  4455  	shdr->Id.SyncId.ProcessId = cpu_to_le32(wdata->cfile->pid);
33319141252fd1 Pavel Shilovsky 2012-09-18  4456  
351a59dace0e0e Paulo Alcantara 2022-03-21  4457  	req->PersistentFileId = wdata->cfile->fid.persistent_fid;
351a59dace0e0e Paulo Alcantara 2022-03-21  4458  	req->VolatileFileId = wdata->cfile->fid.volatile_fid;
33319141252fd1 Pavel Shilovsky 2012-09-18  4459  	req->WriteChannelInfoOffset = 0;
33319141252fd1 Pavel Shilovsky 2012-09-18  4460  	req->WriteChannelInfoLength = 0;
33319141252fd1 Pavel Shilovsky 2012-09-18  4461  	req->Channel = 0;
33319141252fd1 Pavel Shilovsky 2012-09-18  4462  	req->Offset = cpu_to_le64(wdata->offset);
33319141252fd1 Pavel Shilovsky 2012-09-18  4463  	req->DataOffset = cpu_to_le16(
f5688a6d7c5c52 Ronnie Sahlberg 2017-11-20  4464  				offsetof(struct smb2_write_req, Buffer));
33319141252fd1 Pavel Shilovsky 2012-09-18  4465  	req->RemainingBytes = 0;
d323c24617527f Steve French    2019-02-25  4466  
d323c24617527f Steve French    2019-02-25  4467  	trace_smb3_write_enter(0 /* xid */, wdata->cfile->fid.persistent_fid,
d323c24617527f Steve French    2019-02-25  4468  		tcon->tid, tcon->ses->Suid, wdata->offset, wdata->bytes);
db223a590d45b5 Long Li         2017-11-22  4469  #ifdef CONFIG_CIFS_SMB_DIRECT
db223a590d45b5 Long Li         2017-11-22  4470  	/*
db223a590d45b5 Long Li         2017-11-22  4471  	 * If we want to do a server RDMA read, fill in and append
db223a590d45b5 Long Li         2017-11-22  4472  	 * smbd_buffer_descriptor_v1 to the end of write request
db223a590d45b5 Long Li         2017-11-22  4473  	 */
bb4c0419476bd3 Long Li         2018-04-17  4474  	if (server->rdma && !server->sign && wdata->bytes >=
db223a590d45b5 Long Li         2017-11-22  4475  		server->smbd_conn->rdma_readwrite_threshold) {
db223a590d45b5 Long Li         2017-11-22  4476  
db223a590d45b5 Long Li         2017-11-22  4477  		struct smbd_buffer_descriptor_v1 *v1;
db223a590d45b5 Long Li         2017-11-22  4478  		bool need_invalidate = server->dialect == SMB30_PROT_ID;
db223a590d45b5 Long Li         2017-11-22  4479  
db223a590d45b5 Long Li         2017-11-22  4480  		wdata->mr = smbd_register_mr(
db223a590d45b5 Long Li         2017-11-22 @4481  				server->smbd_conn, wdata->pages,
7cf20bce77581b Long Li         2018-05-30  4482  				wdata->nr_pages, wdata->page_offset,
7cf20bce77581b Long Li         2018-05-30  4483  				wdata->tailsz, false, need_invalidate);
db223a590d45b5 Long Li         2017-11-22  4484  		if (!wdata->mr) {
b7972092199f6d Long Li         2019-04-05  4485  			rc = -EAGAIN;
db223a590d45b5 Long Li         2017-11-22  4486  			goto async_writev_out;
db223a590d45b5 Long Li         2017-11-22  4487  		}
db223a590d45b5 Long Li         2017-11-22  4488  		req->Length = 0;
db223a590d45b5 Long Li         2017-11-22  4489  		req->DataOffset = 0;
7cf20bce77581b Long Li         2018-05-30  4490  		if (wdata->nr_pages > 1)
db223a590d45b5 Long Li         2017-11-22  4491  			req->RemainingBytes =
7cf20bce77581b Long Li         2018-05-30  4492  				cpu_to_le32(
7cf20bce77581b Long Li         2018-05-30  4493  					(wdata->nr_pages - 1) * wdata->pagesz -
7cf20bce77581b Long Li         2018-05-30  4494  					wdata->page_offset + wdata->tailsz
7cf20bce77581b Long Li         2018-05-30  4495  				);
7cf20bce77581b Long Li         2018-05-30  4496  		else
7cf20bce77581b Long Li         2018-05-30  4497  			req->RemainingBytes = cpu_to_le32(wdata->tailsz);
db223a590d45b5 Long Li         2017-11-22  4498  		req->Channel = SMB2_CHANNEL_RDMA_V1_INVALIDATE;
db223a590d45b5 Long Li         2017-11-22  4499  		if (need_invalidate)
db223a590d45b5 Long Li         2017-11-22  4500  			req->Channel = SMB2_CHANNEL_RDMA_V1;
db223a590d45b5 Long Li         2017-11-22  4501  		req->WriteChannelInfoOffset =
2026b06e9ce852 Steve French    2018-01-24  4502  			cpu_to_le16(offsetof(struct smb2_write_req, Buffer));
db223a590d45b5 Long Li         2017-11-22  4503  		req->WriteChannelInfoLength =
2026b06e9ce852 Steve French    2018-01-24  4504  			cpu_to_le16(sizeof(struct smbd_buffer_descriptor_v1));
db223a590d45b5 Long Li         2017-11-22  4505  		v1 = (struct smbd_buffer_descriptor_v1 *) &req->Buffer[0];
2026b06e9ce852 Steve French    2018-01-24  4506  		v1->offset = cpu_to_le64(wdata->mr->mr->iova);
2026b06e9ce852 Steve French    2018-01-24  4507  		v1->token = cpu_to_le32(wdata->mr->mr->rkey);
2026b06e9ce852 Steve French    2018-01-24  4508  		v1->length = cpu_to_le32(wdata->mr->mr->length);
db223a590d45b5 Long Li         2017-11-22  4509  	}
db223a590d45b5 Long Li         2017-11-22  4510  #endif
c713c8770fa5bf Ronnie Sahlberg 2018-06-12  4511  	iov[0].iov_len = total_len - 1;
c713c8770fa5bf Ronnie Sahlberg 2018-06-12  4512  	iov[0].iov_base = (char *)req;
33319141252fd1 Pavel Shilovsky 2012-09-18  4513  
738f9de5cdb917 Pavel Shilovsky 2016-11-23  4514  	rqst.rq_iov = iov;
c713c8770fa5bf Ronnie Sahlberg 2018-06-12  4515  	rqst.rq_nvec = 1;
e4b60df6a12099 David Howells   2022-01-24  4516  	rqst.rq_iter = wdata->iter;
db223a590d45b5 Long Li         2017-11-22  4517  #ifdef CONFIG_CIFS_SMB_DIRECT
db223a590d45b5 Long Li         2017-11-22  4518  	if (wdata->mr) {
c713c8770fa5bf Ronnie Sahlberg 2018-06-12  4519  		iov[0].iov_len += sizeof(struct smbd_buffer_descriptor_v1);
db223a590d45b5 Long Li         2017-11-22  4520  		rqst.rq_npages = 0;
db223a590d45b5 Long Li         2017-11-22  4521  	}
db223a590d45b5 Long Li         2017-11-22  4522  #endif
f96637be081141 Joe Perches     2013-05-04  4523  	cifs_dbg(FYI, "async write at %llu %u bytes\n",
f96637be081141 Joe Perches     2013-05-04  4524  		 wdata->offset, wdata->bytes);
33319141252fd1 Pavel Shilovsky 2012-09-18  4525  

:::::: The code at line 4481 was first introduced by commit
:::::: db223a590d45b5e584a430c46a778699a5825cdd CIFS: SMBD: Upper layer performs SMB write via RDMA read through memory registration

:::::: TO: Long Li <longli@microsoft.com>
:::::: CC: Steve French <smfrench@gmail.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
