Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52A7248691B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 18:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242419AbiAFRsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 12:48:35 -0500
Received: from mga05.intel.com ([192.55.52.43]:61566 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242413AbiAFRs1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 12:48:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641491307; x=1673027307;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=L69EiUxvnkMtOLzS9y6Y326FWiPueb6iTyzdswTejP8=;
  b=dm5dwGxz9ZCFDIXtqcABoqB4UDcrLWg5i0bqDSfFiPRE7WP5vv5vNafj
   +s6gpXF86OaYoRxxeKS/MUhYYzTYo/FbdLMHIeIqMD/n+/ef3L9GriktK
   UPL/RxQ78VzRcBTEgL+3JBmH4vVcQV11adXYEGyVmChogL7aDuN138ecb
   uGN/8GSop15XZPdyJAurtN3Mak5dWe/Nzfb9oAQl7zWlvOMjODfvam6Nr
   yyFmMaZuxpGnVcYZuR3TjlqdZ1vT/mgWiCBg1cb/QA1KWx1yJmertX1qk
   6GKAKAjdqPmOi42tLfe6DGoI7QwIt/yRJruc1qo/FzYp0EdT5Qchyae57
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="329046553"
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="329046553"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 09:48:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="621592276"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 06 Jan 2022 09:48:25 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5WsD-000HpS-85; Thu, 06 Jan 2022 17:48:25 +0000
Date:   Fri, 7 Jan 2022 01:47:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Trond Myklebust <trond.myklebust@hammerspace.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Anna Schumaker <Anna.Schumaker@Netapp.com>
Subject: [anna-nfs:linux-next 12/21] fs/nfs/callback_xdr.c:274:8: warning:
 result of comparison of constant 658812288346769700 with expression of type
 'uint32_t' (aka 'unsigned int') is always false
Message-ID: <202201070108.OWIDTV5G-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.linux-nfs.org/projects/anna/linux-nfs.git linux-next
head:   3e0a5877834cb4899478873b0f6ccc604ab33d28
commit: 9c2f14caf2bfc8b25b9d755aa77a37355d00c7ce [12/21] NFSv4.1: Fix uninitialised variable in devicenotify
config: x86_64-buildonly-randconfig-r001-20220106 (https://download.01.org/0day-ci/archive/20220107/202201070108.OWIDTV5G-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project ca7ffe09dc6e525109e3cd570cc5182ce568be13)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add anna-nfs git://git.linux-nfs.org/projects/anna/linux-nfs.git
        git fetch --no-tags anna-nfs linux-next
        git checkout 9c2f14caf2bfc8b25b9d755aa77a37355d00c7ce
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash fs/nfs/ sound/x86/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> fs/nfs/callback_xdr.c:274:8: warning: result of comparison of constant 658812288346769700 with expression of type 'uint32_t' (aka 'unsigned int') is always false [-Wtautological-constant-out-of-range-compare]
           if (n > ULONG_MAX / sizeof(*args->devs)) {
               ~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +274 fs/nfs/callback_xdr.c

f2a625616045fe Fred Isaman       2011-01-06  254  
1be5683b03a766 Marc Eshel        2011-05-22  255  static
1be5683b03a766 Marc Eshel        2011-05-22  256  __be32 decode_devicenotify_args(struct svc_rqst *rqstp,
1be5683b03a766 Marc Eshel        2011-05-22  257  				struct xdr_stream *xdr,
f4dac4ade5ba4e Christoph Hellwig 2017-05-11  258  				void *argp)
1be5683b03a766 Marc Eshel        2011-05-22  259  {
f4dac4ade5ba4e Christoph Hellwig 2017-05-11  260  	struct cb_devicenotifyargs *args = argp;
9c2f14caf2bfc8 Trond Myklebust   2022-01-03  261  	uint32_t tmp, n, i;
1be5683b03a766 Marc Eshel        2011-05-22  262  	__be32 *p;
1be5683b03a766 Marc Eshel        2011-05-22  263  	__be32 status = 0;
1be5683b03a766 Marc Eshel        2011-05-22  264  
1be5683b03a766 Marc Eshel        2011-05-22  265  	/* Num of device notifications */
eb72f484a5eb94 Chuck Lever       2019-02-11  266  	p = xdr_inline_decode(xdr, sizeof(uint32_t));
1be5683b03a766 Marc Eshel        2011-05-22  267  	if (unlikely(p == NULL)) {
1be5683b03a766 Marc Eshel        2011-05-22  268  		status = htonl(NFS4ERR_BADXDR);
1be5683b03a766 Marc Eshel        2011-05-22  269  		goto out;
1be5683b03a766 Marc Eshel        2011-05-22  270  	}
1be5683b03a766 Marc Eshel        2011-05-22  271  	n = ntohl(*p++);
9c2f14caf2bfc8 Trond Myklebust   2022-01-03  272  	if (n == 0)
1be5683b03a766 Marc Eshel        2011-05-22  273  		goto out;
363e0df057ea8d Dan Carpenter     2012-01-12 @274  	if (n > ULONG_MAX / sizeof(*args->devs)) {
363e0df057ea8d Dan Carpenter     2012-01-12  275  		status = htonl(NFS4ERR_BADXDR);
363e0df057ea8d Dan Carpenter     2012-01-12  276  		goto out;
363e0df057ea8d Dan Carpenter     2012-01-12  277  	}
1be5683b03a766 Marc Eshel        2011-05-22  278  
a4f743a6bb2016 Trond Myklebust   2015-02-11  279  	args->devs = kmalloc_array(n, sizeof(*args->devs), GFP_KERNEL);
1be5683b03a766 Marc Eshel        2011-05-22  280  	if (!args->devs) {
1be5683b03a766 Marc Eshel        2011-05-22  281  		status = htonl(NFS4ERR_DELAY);
1be5683b03a766 Marc Eshel        2011-05-22  282  		goto out;
1be5683b03a766 Marc Eshel        2011-05-22  283  	}
1be5683b03a766 Marc Eshel        2011-05-22  284  
1be5683b03a766 Marc Eshel        2011-05-22  285  	/* Decode each dev notification */
1be5683b03a766 Marc Eshel        2011-05-22  286  	for (i = 0; i < n; i++) {
1be5683b03a766 Marc Eshel        2011-05-22  287  		struct cb_devicenotifyitem *dev = &args->devs[i];
1be5683b03a766 Marc Eshel        2011-05-22  288  
eb72f484a5eb94 Chuck Lever       2019-02-11  289  		p = xdr_inline_decode(xdr, (4 * sizeof(uint32_t)) +
eb72f484a5eb94 Chuck Lever       2019-02-11  290  				      NFS4_DEVICEID4_SIZE);
1be5683b03a766 Marc Eshel        2011-05-22  291  		if (unlikely(p == NULL)) {
1be5683b03a766 Marc Eshel        2011-05-22  292  			status = htonl(NFS4ERR_BADXDR);
1be5683b03a766 Marc Eshel        2011-05-22  293  			goto err;
1be5683b03a766 Marc Eshel        2011-05-22  294  		}
1be5683b03a766 Marc Eshel        2011-05-22  295  
1be5683b03a766 Marc Eshel        2011-05-22  296  		tmp = ntohl(*p++);	/* bitmap size */
1be5683b03a766 Marc Eshel        2011-05-22  297  		if (tmp != 1) {
1be5683b03a766 Marc Eshel        2011-05-22  298  			status = htonl(NFS4ERR_INVAL);
1be5683b03a766 Marc Eshel        2011-05-22  299  			goto err;
1be5683b03a766 Marc Eshel        2011-05-22  300  		}
1be5683b03a766 Marc Eshel        2011-05-22  301  		dev->cbd_notify_type = ntohl(*p++);
1be5683b03a766 Marc Eshel        2011-05-22  302  		if (dev->cbd_notify_type != NOTIFY_DEVICEID4_CHANGE &&
1be5683b03a766 Marc Eshel        2011-05-22  303  		    dev->cbd_notify_type != NOTIFY_DEVICEID4_DELETE) {
1be5683b03a766 Marc Eshel        2011-05-22  304  			status = htonl(NFS4ERR_INVAL);
1be5683b03a766 Marc Eshel        2011-05-22  305  			goto err;
1be5683b03a766 Marc Eshel        2011-05-22  306  		}
1be5683b03a766 Marc Eshel        2011-05-22  307  
1be5683b03a766 Marc Eshel        2011-05-22  308  		tmp = ntohl(*p++);	/* opaque size */
1be5683b03a766 Marc Eshel        2011-05-22  309  		if (((dev->cbd_notify_type == NOTIFY_DEVICEID4_CHANGE) &&
1be5683b03a766 Marc Eshel        2011-05-22  310  		     (tmp != NFS4_DEVICEID4_SIZE + 8)) ||
1be5683b03a766 Marc Eshel        2011-05-22  311  		    ((dev->cbd_notify_type == NOTIFY_DEVICEID4_DELETE) &&
1be5683b03a766 Marc Eshel        2011-05-22  312  		     (tmp != NFS4_DEVICEID4_SIZE + 4))) {
1be5683b03a766 Marc Eshel        2011-05-22  313  			status = htonl(NFS4ERR_INVAL);
1be5683b03a766 Marc Eshel        2011-05-22  314  			goto err;
1be5683b03a766 Marc Eshel        2011-05-22  315  		}
1be5683b03a766 Marc Eshel        2011-05-22  316  		dev->cbd_layout_type = ntohl(*p++);
1be5683b03a766 Marc Eshel        2011-05-22  317  		memcpy(dev->cbd_dev_id.data, p, NFS4_DEVICEID4_SIZE);
1be5683b03a766 Marc Eshel        2011-05-22  318  		p += XDR_QUADLEN(NFS4_DEVICEID4_SIZE);
1be5683b03a766 Marc Eshel        2011-05-22  319  
1be5683b03a766 Marc Eshel        2011-05-22  320  		if (dev->cbd_layout_type == NOTIFY_DEVICEID4_CHANGE) {
eb72f484a5eb94 Chuck Lever       2019-02-11  321  			p = xdr_inline_decode(xdr, sizeof(uint32_t));
1be5683b03a766 Marc Eshel        2011-05-22  322  			if (unlikely(p == NULL)) {
1be5683b03a766 Marc Eshel        2011-05-22  323  				status = htonl(NFS4ERR_BADXDR);
1be5683b03a766 Marc Eshel        2011-05-22  324  				goto err;
1be5683b03a766 Marc Eshel        2011-05-22  325  			}
1be5683b03a766 Marc Eshel        2011-05-22  326  			dev->cbd_immediate = ntohl(*p++);
1be5683b03a766 Marc Eshel        2011-05-22  327  		} else {
1be5683b03a766 Marc Eshel        2011-05-22  328  			dev->cbd_immediate = 0;
1be5683b03a766 Marc Eshel        2011-05-22  329  		}
1be5683b03a766 Marc Eshel        2011-05-22  330  
1be5683b03a766 Marc Eshel        2011-05-22  331  		dprintk("%s: type %d layout 0x%x immediate %d\n",
1be5683b03a766 Marc Eshel        2011-05-22  332  			__func__, dev->cbd_notify_type, dev->cbd_layout_type,
1be5683b03a766 Marc Eshel        2011-05-22  333  			dev->cbd_immediate);
1be5683b03a766 Marc Eshel        2011-05-22  334  	}
9c2f14caf2bfc8 Trond Myklebust   2022-01-03  335  	args->ndevs = n;
9c2f14caf2bfc8 Trond Myklebust   2022-01-03  336  	dprintk("%s: ndevs %d\n", __func__, args->ndevs);
9c2f14caf2bfc8 Trond Myklebust   2022-01-03  337  	return 0;
9c2f14caf2bfc8 Trond Myklebust   2022-01-03  338  err:
9c2f14caf2bfc8 Trond Myklebust   2022-01-03  339  	kfree(args->devs);
1be5683b03a766 Marc Eshel        2011-05-22  340  out:
9c2f14caf2bfc8 Trond Myklebust   2022-01-03  341  	args->devs = NULL;
9c2f14caf2bfc8 Trond Myklebust   2022-01-03  342  	args->ndevs = 0;
1be5683b03a766 Marc Eshel        2011-05-22  343  	dprintk("%s: status %d ndevs %d\n",
1be5683b03a766 Marc Eshel        2011-05-22  344  		__func__, ntohl(status), args->ndevs);
1be5683b03a766 Marc Eshel        2011-05-22  345  	return status;
1be5683b03a766 Marc Eshel        2011-05-22  346  }
1be5683b03a766 Marc Eshel        2011-05-22  347  

:::::: The code at line 274 was first introduced by commit
:::::: 363e0df057ea8da539645fe4c3c227e3d44054cc nfs: check for integer overflow in decode_devicenotify_args()

:::::: TO: Dan Carpenter <dan.carpenter@oracle.com>
:::::: CC: Trond Myklebust <Trond.Myklebust@netapp.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
