Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D01B52633B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 15:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381613AbiEMNiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 09:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381420AbiEMNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 09:36:49 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B84CE2E
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 06:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652449007; x=1683985007;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=QNFJJcpU+Hbk46LlfyqdHGQZ31m431RxZ8vFi6VDvns=;
  b=aILi+ZzddY6u8SQUSyFeEEUK+BF13vM5if4E+P3/eY0nxSllKqCDU5FA
   9E6wlZT7VJcp05oyV4K9Niqc3ljAhpTNqj/X5BGynSkQpwJC6DT7DK3Oy
   IPfK1dVIg05TpTk0gC12t9zoLRg8+4whIMttC1pUaVJLFG7bK9G1dnjfF
   LuXSbPzmFc7iISonrL7dYxXa88gqFdWT/ITcuhy1w1ROluGObs8nq9f6p
   1Q9aDIo8iwf2U1e7rlMk7AVuaaMSCsOvRgJfFQdiNYTWWV8OuJYJTdEv1
   gkPHwNRk+pixzS+H+OCsx4dw/V2PoCEKd5g9V6Y2gQrJswdAwIeol6L5z
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="267898919"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="267898919"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 06:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="543262659"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 13 May 2022 06:36:44 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npVTH-000LnS-H1;
        Fri, 13 May 2022 13:36:43 +0000
Date:   Fri, 13 May 2022 21:35:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Howells <dhowells@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:dhowells/linux-fs/cifs-for-sfrench 5/6]
 fs/cifs/smb2ops.c:4752:11: warning: comparison of distinct pointer types
 ('typeof (size - copied) *' (aka 'unsigned int *') and 'typeof (((1UL) <<
 (12))) *' (aka 'unsigned long *'))
Message-ID: <202205132109.23GgU6Kd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block dhowells/linux-fs/cifs-for-sfrench
head:   627ce4da99bb612945366770c5604019fb74b653
commit: e4b60df6a12099568c671591d36a9fa16515f6eb [5/6] cifs: Change the I/O paths to use an iterator rather than a page list
config: riscv-randconfig-c006-20220510 (https://download.01.org/0day-ci/archive/20220513/202205132109.23GgU6Kd-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/ammarfaizi2/linux-block/commit/e4b60df6a12099568c671591d36a9fa16515f6eb
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block dhowells/linux-fs/cifs-for-sfrench
        git checkout e4b60df6a12099568c671591d36a9fa16515f6eb
        # save the config file
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/cifs/smb2ops.c:4752:11: warning: comparison of distinct pointer types ('typeof (size - copied) *' (aka 'unsigned int *') and 'typeof (((1UL) << (12))) *' (aka 'unsigned long *')) [-Wcompare-distinct-pointer-types]
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
   fs/cifs/smb2ops.c:4961:7: warning: variable 'length' is used uninitialized whenever 'if' condition is false [-Wsometimes-uninitialized]
                   if (rdata->result != 0) {
                       ^~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:4993:9: note: uninitialized use occurs here
           return length;
                  ^~~~~~
   fs/cifs/smb2ops.c:4961:3: note: remove the 'if' if its condition is always true
                   if (rdata->result != 0) {
                   ^~~~~~~~~~~~~~~~~~~~~~~~
   fs/cifs/smb2ops.c:4860:12: note: initialize the variable 'length' to silence this warning
           int length;
                     ^
                      = 0
   2 warnings generated.


vim +4752 fs/cifs/smb2ops.c

  4702	
  4703	/*
  4704	 * This function will initialize new_rq and encrypt the content.
  4705	 * The first entry, new_rq[0], only contains a single iov which contains
  4706	 * a smb2_transform_hdr and is pre-allocated by the caller.
  4707	 * This function then populates new_rq[1+] with the content from olq_rq[0+].
  4708	 *
  4709	 * The end result is an array of smb_rqst structures where the first structure
  4710	 * only contains a single iov for the transform header which we then can pass
  4711	 * to crypt_message().
  4712	 *
  4713	 * new_rq[0].rq_iov[0] :  smb2_transform_hdr pre-allocated by the caller
  4714	 * new_rq[1+].rq_iov[*] == old_rq[0+].rq_iov[*] : SMB2/3 requests
  4715	 */
  4716	static int
  4717	smb3_init_transform_rq(struct TCP_Server_Info *server, int num_rqst,
  4718			       struct smb_rqst *new_rq, struct smb_rqst *old_rq)
  4719	{
  4720		struct smb2_transform_hdr *tr_hdr = new_rq[0].rq_iov[0].iov_base;
  4721		struct page *page;
  4722		unsigned int orig_len = 0;
  4723		int i, j;
  4724		int rc = -ENOMEM;
  4725	
  4726		for (i = 1; i < num_rqst; i++) {
  4727			struct smb_rqst *old = &old_rq[i - 1];
  4728			struct smb_rqst *new = &new_rq[i];
  4729			struct xarray *buffer = &new->rq_buffer;
  4730			unsigned int npages;
  4731			size_t size = iov_iter_count(&old->rq_iter), seg, copied = 0;
  4732	
  4733			xa_init(buffer);
  4734	
  4735			if (size > 0) {
  4736				npages = DIV_ROUND_UP(size, PAGE_SIZE);
  4737				for (j = 0; j < npages; j++) {
  4738					void *o;
  4739	
  4740					rc = -ENOMEM;
  4741					page = alloc_page(GFP_KERNEL|__GFP_HIGHMEM);
  4742					if (!page)
  4743						goto err_free;
  4744					page->index = j;
  4745					o = xa_store(buffer, j, page, GFP_KERNEL);
  4746					if (xa_is_err(o)) {
  4747						rc = xa_err(o);
  4748						put_page(page);
  4749						goto err_free;
  4750					}
  4751	
> 4752					seg = min(size - copied, PAGE_SIZE);
  4753					if (copy_page_from_iter(page, 0, seg, &old->rq_iter) != seg) {
  4754						rc = -EFAULT;
  4755						goto err_free;
  4756					}
  4757					copied += seg;
  4758				}
  4759				iov_iter_xarray(&new->rq_iter, iov_iter_rw(&old->rq_iter),
  4760						buffer, 0, size);
  4761			}
  4762			new->rq_iov = old->rq_iov;
  4763			new->rq_nvec = old->rq_nvec;
  4764			orig_len += smb_rqst_len(server, new);
  4765		}
  4766	
  4767		/* fill the 1st iov with a transform header */
  4768		fill_transform_hdr(tr_hdr, orig_len, old_rq, server->cipher_type);
  4769	
  4770		rc = crypt_message(server, num_rqst, new_rq, 1);
  4771		cifs_dbg(FYI, "Encrypt message returned %d\n", rc);
  4772		if (rc)
  4773			goto err_free;
  4774	
  4775		return rc;
  4776	
  4777	err_free:
  4778		smb3_free_compound_rqst(num_rqst - 1, &new_rq[1]);
  4779		return rc;
  4780	}
  4781	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
