Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BADFE56B10B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 05:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236881AbiGHDr3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 23:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236471AbiGHDrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 23:47:25 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27A274DC3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 20:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657252044; x=1688788044;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=a6tewsjtZFrx9ugYhZX9sqQNv1Saw6kwS91FeQfudEA=;
  b=l64Q4QNyaHdRzL/slH3jzddGaa7IiplVHRsQuDFHeaYMOoUcH8yd+W55
   pH6ihl7ET5FCjlJq1RbbKN00ZupMbgTudHkZ3dN0ViR2hlPcT7g78LJsv
   Ku+JNhDO+wKyf1q/6BiDeWCwlcRCWj7Xa4xZR1RIDuJvH69IJtvoawSH/
   Hbu1M3kCgeOLWEGZoDpF/VAXzI1IPwsxc+gpqKQzhyi3zWM46KWEvBqwi
   s0VdiAYkBC1KVykIzSHNayKpk7yShde75e0PDSR4xDqJIJr6UINip/ANp
   3X6AiDSE570o9WQpogW1lZVmm/WejgnQUj3NJ+9BOVDz3rXIq0/aJPpIF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="281729931"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="281729931"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 20:47:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="568778601"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 07 Jul 2022 20:47:22 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9exe-000MsI-65;
        Fri, 08 Jul 2022 03:47:22 +0000
Date:   Fri, 8 Jul 2022 11:47:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-for-viro 5/8]
 fs/cifs/smb2ops.c:4785:11: warning: comparison of distinct pointer types
 ('typeof (size - copied) *' (aka 'unsigned int *') and 'typeof (((1UL) <<
 12)) *' (aka 'unsigned long *'))
Message-ID: <202207081133.gqSVQ0Ct-lkp@intel.com>
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

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-for-viro
head:   569e0acf4192ada33675e44b24701e679d87ebc9
commit: f398cb911105297654980b5973ff230323061fce [5/8] cifs: Change the I/O paths to use an iterator rather than a page list
config: i386-randconfig-a002 (https://download.01.org/0day-ci/archive/20220708/202207081133.gqSVQ0Ct-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 562c3467a6738aa89203f72fc1d1343e5baadf3c)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/f398cb911105297654980b5973ff230323061fce
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-for-viro
        git checkout f398cb911105297654980b5973ff230323061fce
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash fs/cifs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/cifs/smb2ops.c:4785:11: warning: comparison of distinct pointer types ('typeof (size - copied) *' (aka 'unsigned int *') and 'typeof (((1UL) << 12)) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
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
   fs/cifs/smb2ops.c:4994:7: warning: variable 'length' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (rdata->result != 0) {
                       ^~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:5026:9: note: uninitialized use occurs here
           return length;
                  ^~~~~~
   fs/cifs/smb2ops.c:4994:3: note: remove the 'if' if its condition is always true
                   if (rdata->result != 0) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:4893:12: note: initialize the variable 'length' to silence this warning
           int length;
                     ^
                      = 0
   2 warnings generated.


vim +4785 fs/cifs/smb2ops.c

  4735	
  4736	/*
  4737	 * This function will initialize new_rq and encrypt the content.
  4738	 * The first entry, new_rq[0], only contains a single iov which contains
  4739	 * a smb2_transform_hdr and is pre-allocated by the caller.
  4740	 * This function then populates new_rq[1+] with the content from olq_rq[0+].
  4741	 *
  4742	 * The end result is an array of smb_rqst structures where the first structure
  4743	 * only contains a single iov for the transform header which we then can pass
  4744	 * to crypt_message().
  4745	 *
  4746	 * new_rq[0].rq_iov[0] :  smb2_transform_hdr pre-allocated by the caller
  4747	 * new_rq[1+].rq_iov[*] == old_rq[0+].rq_iov[*] : SMB2/3 requests
  4748	 */
  4749	static int
  4750	smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
  4751			       struct smb_rqst *new_rq, struct smb_rqst *old_rq)
  4752	{
  4753		struct smb2_transform_hdr *tr_hdr = new_rq[0].rq_iov[0].iov_base;
  4754		struct page *page;
  4755		unsigned int orig_len = 0;
  4756		int i, j;
  4757		int rc = -ENOMEM;
  4758	
  4759		for (i = 1; i < num_rqst; i++) {
  4760			struct smb_rqst *old = &old_rq[i - 1];
  4761			struct smb_rqst *new = &new_rq[i];
  4762			struct xarray *buffer = &new->rq_buffer;
  4763			unsigned int npages;
  4764			size_t size = iov_iter_count(&old->rq_iter), seg, copied = 0;
  4765	
  4766			xa_init(buffer);
  4767	
  4768			if (size > 0) {
  4769				npages = DIV_ROUND_UP(size, PAGE_SIZE);
  4770				for (j = 0; j < npages; j++) {
  4771					void *o;
  4772	
  4773					rc = -ENOMEM;
  4774					page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
  4775					if (!page)
  4776						goto err_free;
  4777					page->index = j;
  4778					o = xa_store(buffer, j, page, GFP_KERNEL);
  4779					if (xa_is_err(o)) {
  4780						rc = xa_err(o);
  4781						put_page(page);
  4782						goto err_free;
  4783					}
  4784	
> 4785					seg = min(size - copied, PAGE_SIZE);
  4786					if (copy_page_from_iter(page, 0, seg, &old->rq_iter) != seg) {
  4787						rc = -EFAULT;
  4788						goto err_free;
  4789					}
  4790					copied += seg;
  4791				}
  4792				iov_iter_xarray(&new->rq_iter, iov_iter_rw(&old->rq_iter),
  4793						buffer, 0, size);
  4794			}
  4795			new->rq_iov = old->rq_iov;
  4796			new->rq_nvec = old->rq_nvec;
  4797			orig_len += smb_rqst_len(server, new);
  4798		}
  4799	
  4800		/* fill the 1st iov with a transform header */
  4801		fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
  4802	
  4803		rc = crypt_message(server, num_rqst, new_rq, 1);
  4804		cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
  4805		if (rc)
  4806			goto err_free;
  4807	
  4808		return rc;
  4809	
  4810	err_free:
  4811		smb3_free_compound_rqst(num_rqst - 1, &new_rq[1]);
  4812		return rc;
  4813	}
  4814	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
