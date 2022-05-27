Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032F9536836
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 22:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354639AbiE0UrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 16:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbiE0UrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 16:47:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81779666B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 13:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653684440; x=1685220440;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=ZoLpqqeJFWNouRv1xHnJ62lPTbsXl1pv2HTFnwmtkY8=;
  b=OYOepcjGuUcOdeJTPs4zvOFW/kiee4KRrNeOKByHOxCkJ4E+mvR7RNUE
   z0+coHX+RDkbuIPhVBdoCXsDQRqqMlcxsWzhLQ8que0wKfs1EtRBWulP1
   +Hny+MfhHvY815C9bq0vT0ogwSeJe9rJXeyJZgx3LXS/ts8JzETxw2lul
   H5nPRVtjFYoAWVdXuYMRUK5Au5Vwl1HCQLIK8q2YedfFpHndwAVLQhZbz
   1J1fhiDKcWVjaK9MRwOIq0yG69B8BKHS8vCcdQOcUcGd4wUdPgj8raSJ3
   fMbKBuETpNPhIsFqQjVDp9oBL0ERTglXgXJNFT2d4OY0oyWP7O0uWyDB6
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10360"; a="272143867"
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="272143867"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 13:47:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,256,1647327600"; 
   d="scan'208";a="747254742"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 May 2022 13:47:18 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nugrd-00057J-Su;
        Fri, 27 May 2022 20:47:17 +0000
Date:   Sat, 28 May 2022 04:46:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [dhowells-fs:cifs-for-sfrench 5/9] fs/cifs/smb2ops.c:4754:11:
 warning: comparison of distinct pointer types ('typeof (size - copied) *'
 (aka 'unsigned int *') and 'typeof (((1UL) << (12))) *' (aka 'unsigned long
 *'))
Message-ID: <202205280431.HKHuQxkz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git cifs-for-sfrench
head:   c1da8a43f0f920f86394ca254c99a91622bb3fe4
commit: 36c9de734b21b4bc60b7ee86228659d416d53470 [5/9] cifs: Change the I/O paths to use an iterator rather than a page list
config: riscv-randconfig-r002-20220524 (https://download.01.org/0day-ci/archive/20220528/202205280431.HKHuQxkz-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/commit/?id=36c9de734b21b4bc60b7ee86228659d416d53470
        git remote add dhowells-fs https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git
        git fetch --no-tags dhowells-fs cifs-for-sfrench
        git checkout 36c9de734b21b4bc60b7ee86228659d416d53470
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/cifs/smb2ops.c:4754:11: warning: comparison of distinct pointer types ('typeof (size - copied) *' (aka 'unsigned int *') and 'typeof (((1UL) << (12))) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
                                   seg = min(size - copied, PAGE_SIZE);
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:45:19: note: expanded from macro 'min'
   #define min(x, y)       __careful_cmp(x, y, <)
                           ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/minmax.h:36:24: note: expanded from macro '__careful_cmp'
           __builtin_choose_expr(__safe_cmp(x, y), \
                                 ^~~~~~~~~~~~~~~~
   include/linux/minmax.h:26:4: note: expanded from macro '__safe_cmp'
                   (__typecheck(x, y) && __no_side_effects(x, y))
                    ^~~~~~~~~~~~~~~~~
   include/linux/minmax.h:20:28: note: expanded from macro '__typecheck'
           (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                      ~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:4963:7: warning: variable 'length' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (rdata->result != 0) {
                       ^~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:4995:9: note: uninitialized use occurs here
           return length;
                  ^~~~~~
   fs/cifs/smb2ops.c:4963:3: note: remove the 'if' if its condition is always true
                   if (rdata->result != 0) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:4862:12: note: initialize the variable 'length' to silence this warning
           int length;
                     ^
                      = 0
   2 warnings generated.


vim +4754 fs/cifs/smb2ops.c

  4704	
  4705	/*
  4706	 * This function will initialize new_rq and encrypt the content.
  4707	 * The first entry, new_rq[0], only contains a single iov which contains
  4708	 * a smb2_transform_hdr and is pre-allocated by the caller.
  4709	 * This function then populates new_rq[1+] with the content from olq_rq[0+].
  4710	 *
  4711	 * The end result is an array of smb_rqst structures where the first structure
  4712	 * only contains a single iov for the transform header which we then can pass
  4713	 * to crypt_message().
  4714	 *
  4715	 * new_rq[0].rq_iov[0] :  smb2_transform_hdr pre-allocated by the caller
  4716	 * new_rq[1+].rq_iov[*] == old_rq[0+].rq_iov[*] : SMB2/3 requests
  4717	 */
  4718	static int
  4719	smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
  4720			       struct smb_rqst *new_rq, struct smb_rqst *old_rq)
  4721	{
  4722		struct smb2_transform_hdr *tr_hdr = new_rq[0].rq_iov[0].iov_base;
  4723		struct page *page;
  4724		unsigned int orig_len = 0;
  4725		int i, j;
  4726		int rc = -ENOMEM;
  4727	
  4728		for (i = 1; i < num_rqst; i++) {
  4729			struct smb_rqst *old = &old_rq[i - 1];
  4730			struct smb_rqst *new = &new_rq[i];
  4731			struct xarray *buffer = &new->rq_buffer;
  4732			unsigned int npages;
  4733			size_t size = iov_iter_count(&old->rq_iter), seg, copied = 0;
  4734	
  4735			xa_init(buffer);
  4736	
  4737			if (size > 0) {
  4738				npages = DIV_ROUND_UP(size, PAGE_SIZE);
  4739				for (j = 0; j < npages; j++) {
  4740					void *o;
  4741	
  4742					rc = -ENOMEM;
  4743					page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
  4744					if (!page)
  4745						goto err_free;
  4746					page->index = j;
  4747					o = xa_store(buffer, j, page, GFP_KERNEL);
  4748					if (xa_is_err(o)) {
  4749						rc = xa_err(o);
  4750						put_page(page);
  4751						goto err_free;
  4752					}
  4753	
> 4754					seg = min(size - copied, PAGE_SIZE);
  4755					if (copy_page_from_iter(page, 0, seg, &old->rq_iter) != seg) {
  4756						rc = -EFAULT;
  4757						goto err_free;
  4758					}
  4759					copied += seg;
  4760				}
  4761				iov_iter_xarray(&new->rq_iter, iov_iter_rw(&old->rq_iter),
  4762						buffer, 0, size);
  4763			}
  4764			new->rq_iov = old->rq_iov;
  4765			new->rq_nvec = old->rq_nvec;
  4766			orig_len += smb_rqst_len(server, new);
  4767		}
  4768	
  4769		/* fill the 1st iov with a transform header */
  4770		fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
  4771	
  4772		rc = crypt_message(server, num_rqst, new_rq, 1);
  4773		cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
  4774		if (rc)
  4775			goto err_free;
  4776	
  4777		return rc;
  4778	
  4779	err_free:
  4780		smb3_free_compound_rqst(num_rqst - 1, &new_rq[1]);
  4781		return rc;
  4782	}
  4783	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
