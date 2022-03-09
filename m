Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E507D4D2929
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbiCIGxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:53:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiCIGw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:52:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06245163059
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 22:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646808719; x=1678344719;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=7C6Ydj69LZ/AcvpOI5MW16tI91B7XN6x1ojyQhKjNd4=;
  b=LdXHSpdYf/zndtBwyssSE+/4E1Jrav+XNZHStrRQ4+r/fQ3G/+qcWhY5
   2yZ6rMJDlTvxu8kpbHlvJ9TU8E7yS2wI8uS0ZKGtJH4hpVMNoqqyw0/F8
   9FyP5vNhtTFdUGVikIDoq5Aj2j5M2EyjBaE3xdKQzmjF4vcS/v6p6/2gQ
   iiQGT0l9P+lTVasN99JA9op8j3n2KcTiXE22Q6iBTSL2L1poi8DsxKi5J
   4G70zLgjKYGvGfO8AxJfEJmZr5Vl/RX3gvHTVV+uKdQOyLlvvl1nUnXaI
   w72AK7hBOsneLgjetA8IM0bGfRSakyDXH5JaO5R/P2s3JrGwBCpY4LV3q
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="254843590"
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="254843590"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 22:51:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,167,1643702400"; 
   d="scan'208";a="513417453"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Mar 2022 22:51:56 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nRqAt-0002mX-VP; Wed, 09 Mar 2022 06:51:55 +0000
Date:   Wed, 9 Mar 2022 14:50:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paul Lawrence <paullawrence@google.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org
Subject: [ammarfaizi2-block:google/android/kernel/common/android13-5.10
 9998/9999] fs/fuse/dev.c:1953:44: warning: cast from pointer to integer of
 different size
Message-ID: <202203091434.2vqTNOQH-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android13-5.10
head:   5da5b1871950c71755fa5a0b88c78e2f2623da24
commit: 8efdff35e3052e44d519ccfb9d50594f5df0240b [9998/9999] ANDROID: fuse-bpf: Move fd operations to be synchronous
config: arm-randconfig-c002-20220309 (https://download.01.org/0day-ci/archive/20220309/202203091434.2vqTNOQH-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/8efdff35e3052e44d519ccfb9d50594f5df0240b
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block google/android/kernel/common/android13-5.10
        git checkout 8efdff35e3052e44d519ccfb9d50594f5df0240b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash fs/fuse/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   fs/fuse/dev.c: In function 'fuse_dev_do_write':
>> fs/fuse/dev.c:1953:44: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1953 |                         febo->backing_fd = (uint64_t) fget(febo->backing_fd);
         |                                            ^
   fs/fuse/dev.c:1955:40: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1955 |                         febo->bpf_fd = (uint64_t) fget(febo->bpf_fd);
         |                                        ^
--
   fs/fuse/dir.c: In function 'fuse_dentry_revalidate':
>> fs/fuse/dir.c:247:45: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     247 |                         struct file *file = (struct file *) bpf_outarg.backing_fd;
         |                                             ^
   fs/fuse/dir.c:254:45: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     254 |                         struct file *file = (struct file *) bpf_outarg.bpf_fd;
         |                                             ^


vim +1953 fs/fuse/dev.c

  1852	
  1853	/*
  1854	 * Write a single reply to a request.  First the header is copied from
  1855	 * the write buffer.  The request is then searched on the processing
  1856	 * list by the unique ID found in the header.  If found, then remove
  1857	 * it from the list and copy the rest of the buffer to the request.
  1858	 * The request is finished by calling fuse_request_end().
  1859	 */
  1860	static ssize_t fuse_dev_do_write(struct fuse_dev *fud,
  1861					 struct fuse_copy_state *cs, size_t nbytes)
  1862	{
  1863		int err;
  1864		struct fuse_conn *fc = fud->fc;
  1865		struct fuse_pqueue *fpq = &fud->pq;
  1866		struct fuse_req *req;
  1867		struct fuse_out_header oh;
  1868	
  1869		err = -EINVAL;
  1870		if (nbytes < sizeof(struct fuse_out_header))
  1871			goto out;
  1872	
  1873		err = fuse_copy_one(cs, &oh, sizeof(oh));
  1874		if (err)
  1875			goto copy_finish;
  1876	
  1877		err = -EINVAL;
  1878		if (oh.len != nbytes)
  1879			goto copy_finish;
  1880	
  1881		/*
  1882		 * Zero oh.unique indicates unsolicited notification message
  1883		 * and error contains notification code.
  1884		 */
  1885		if (!oh.unique) {
  1886			err = fuse_notify(fc, oh.error, nbytes - sizeof(oh), cs);
  1887			goto out;
  1888		}
  1889	
  1890		err = -EINVAL;
  1891		if (oh.error <= -512 || oh.error > 0)
  1892			goto copy_finish;
  1893	
  1894		spin_lock(&fpq->lock);
  1895		req = NULL;
  1896		if (fpq->connected)
  1897			req = request_find(fpq, oh.unique & ~FUSE_INT_REQ_BIT);
  1898	
  1899		err = -ENOENT;
  1900		if (!req) {
  1901			spin_unlock(&fpq->lock);
  1902			goto copy_finish;
  1903		}
  1904	
  1905		/* Is it an interrupt reply ID? */
  1906		if (oh.unique & FUSE_INT_REQ_BIT) {
  1907			__fuse_get_request(req);
  1908			spin_unlock(&fpq->lock);
  1909	
  1910			err = 0;
  1911			if (nbytes != sizeof(struct fuse_out_header))
  1912				err = -EINVAL;
  1913			else if (oh.error == -ENOSYS)
  1914				fc->no_interrupt = 1;
  1915			else if (oh.error == -EAGAIN)
  1916				err = queue_interrupt(req);
  1917	
  1918			fuse_put_request(req);
  1919	
  1920			goto copy_finish;
  1921		}
  1922	
  1923		clear_bit(FR_SENT, &req->flags);
  1924		list_move(&req->list, &fpq->io);
  1925		req->out.h = oh;
  1926		set_bit(FR_LOCKED, &req->flags);
  1927		spin_unlock(&fpq->lock);
  1928		cs->req = req;
  1929		if (!req->args->page_replace)
  1930			cs->move_pages = 0;
  1931	
  1932		if (oh.error)
  1933			err = nbytes != sizeof(oh) ? -EINVAL : 0;
  1934		else
  1935			err = copy_out_args(cs, req->args, nbytes);
  1936		fuse_copy_finish(cs);
  1937	
  1938		if (!err && req->in.h.opcode == FUSE_CANONICAL_PATH) {
  1939			char *path = (char *)req->args->out_args[0].value;
  1940	
  1941			path[req->args->out_args[0].size - 1] = 0;
  1942			req->out.h.error =
  1943				kern_path(path, 0, req->args->canonical_path);
  1944		}
  1945	
  1946		if (!err && (req->in.h.opcode == FUSE_LOOKUP ||
  1947			     req->in.h.opcode == (FUSE_LOOKUP | FUSE_POSTFILTER)) &&
  1948			req->args->out_args[1].size == sizeof(struct fuse_entry_bpf_out)) {
  1949			struct fuse_entry_bpf_out *febo = (struct fuse_entry_bpf_out *)
  1950					req->args->out_args[1].value;
  1951	
  1952			if (febo->backing_action == FUSE_ACTION_REPLACE)
> 1953				febo->backing_fd = (uint64_t) fget(febo->backing_fd);
  1954			if (febo->bpf_action == FUSE_ACTION_REPLACE)
  1955				febo->bpf_fd = (uint64_t) fget(febo->bpf_fd);
  1956		}
  1957	
  1958		spin_lock(&fpq->lock);
  1959		clear_bit(FR_LOCKED, &req->flags);
  1960		if (!fpq->connected)
  1961			err = -ENOENT;
  1962		else if (err)
  1963			req->out.h.error = -EIO;
  1964		if (!test_bit(FR_PRIVATE, &req->flags))
  1965			list_del_init(&req->list);
  1966		spin_unlock(&fpq->lock);
  1967	
  1968		fuse_request_end(req);
  1969	out:
  1970		return err ? err : nbytes;
  1971	
  1972	copy_finish:
  1973		fuse_copy_finish(cs);
  1974		goto out;
  1975	}
  1976	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
