Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E71E4641BA
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 23:44:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344677AbhK3WsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 17:48:13 -0500
Received: from mga01.intel.com ([192.55.52.88]:11622 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344996AbhK3Wry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 17:47:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="260300114"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="260300114"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 14:44:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="511707941"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 30 Nov 2021 14:44:29 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msBrQ-000Dr1-Mt; Tue, 30 Nov 2021 22:44:28 +0000
Date:   Wed, 1 Dec 2021 06:44:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     kbuild-all@lists.01.org, Jeya R <jeyr@codeaurora.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com, bkumar@qti.qualcomm.com,
        ekangupt@qti.qualcomm.com, jeyr@qti.qualcomm.com
Subject: Re: [PATCH 2/2] misc: fastrpc: Add dma handle implementation
Message-ID: <202112010626.i5LYELFF-lkp@intel.com>
References: <1638277072-6459-4-git-send-email-jeyr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638277072-6459-4-git-send-email-jeyr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on v5.16-rc3 next-20211130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeya-R/misc-fastrpc-Add-fdlist-implementation/20211130-215833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 5d331b5922551637c586cdf5fdc1778910fc937f
config: x86_64-buildonly-randconfig-r004-20211130 (https://download.01.org/0day-ci/archive/20211201/202112010626.i5LYELFF-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/b29c5611eb2bd23a416730b8067a107bcc8594a7
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeya-R/misc-fastrpc-Add-fdlist-implementation/20211130-215833
        git checkout b29c5611eb2bd23a416730b8067a107bcc8594a7
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_get_meta_size':
   drivers/misc/fastrpc.c:721:24: error: 'fastrpc_remote_arg' defined as wrong kind of tag
     721 |  size = (sizeof(struct fastrpc_remote_arg) +
         |                        ^~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:721:17: error: invalid application of 'sizeof' to incomplete type 'struct fastrpc_remote_arg'
     721 |  size = (sizeof(struct fastrpc_remote_arg) +
         |                 ^~~~~~
   drivers/misc/fastrpc.c: In function 'fastrpc_put_args':
   drivers/misc/fastrpc.c:925:9: error: 'fastrpc_remote_arg' defined as wrong kind of tag
     925 |  struct fastrpc_remote_arg *rpra = ctx->rpra;
         |         ^~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:925:36: error: initialization of 'struct fastrpc_remote_arg *' from incompatible pointer type 'union fastrpc_remote_arg *' [-Werror=incompatible-pointer-types]
     925 |  struct fastrpc_remote_arg *rpra = ctx->rpra;
         |                                    ^~~
>> drivers/misc/fastrpc.c:935:49: error: dereferencing pointer to incomplete type 'struct fastrpc_remote_arg'
     935 |  list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
         |                                                 ^~~~~
   drivers/misc/fastrpc.c:942:39: error: invalid use of undefined type 'struct fastrpc_remote_arg'
     942 |    void *src = (void *)(uintptr_t)rpra[i].pv;
         |                                       ^
   drivers/misc/fastrpc.c:944:18: error: invalid use of undefined type 'struct fastrpc_remote_arg'
     944 |    u64 len = rpra[i].len;
         |                  ^
   drivers/misc/fastrpc.c:958:25: error: 'fl' undeclared (first use in this function); did you mean 'fd'?
     958 |   if (!fastrpc_map_find(fl, (int)fdlist[i], &mmap))
         |                         ^~
         |                         fd
   drivers/misc/fastrpc.c:958:25: note: each undeclared identifier is reported only once for each function it appears in
   At top level:
   drivers/misc/fastrpc.c:717:12: warning: 'fastrpc_get_meta_size' defined but not used [-Wunused-function]
     717 | static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
         |            ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +935 drivers/misc/fastrpc.c

c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  921  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  922  static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  923  			    u32 kernel)
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  924  {
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  925  	struct fastrpc_remote_arg *rpra = ctx->rpra;
d9eaed76074c94 Jeya R              2021-11-30  926  	struct fastrpc_map *mmap = NULL;
d9eaed76074c94 Jeya R              2021-11-30  927  	struct fastrpc_invoke_buf *list;
d9eaed76074c94 Jeya R              2021-11-30  928  	struct fastrpc_phy_page *pages;
d9eaed76074c94 Jeya R              2021-11-30  929  	u64 *fdlist;
d9eaed76074c94 Jeya R              2021-11-30  930  	int i, inbufs, outbufs, handles;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  931  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  932  	inbufs = REMOTE_SCALARS_INBUFS(ctx->sc);
d9eaed76074c94 Jeya R              2021-11-30  933  	outbufs = REMOTE_SCALARS_OUTBUFS(ctx->sc);
d9eaed76074c94 Jeya R              2021-11-30  934  	handles = REMOTE_SCALARS_INHANDLES(ctx->sc) + REMOTE_SCALARS_OUTHANDLES(ctx->sc);
d9eaed76074c94 Jeya R              2021-11-30 @935  	list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
d9eaed76074c94 Jeya R              2021-11-30  936  	pages = ctx->buf->virt + ctx->nscalars * (sizeof(*list) +
d9eaed76074c94 Jeya R              2021-11-30  937  		sizeof(*rpra));
d9eaed76074c94 Jeya R              2021-11-30  938  	fdlist = (uint64_t *)(pages + inbufs + outbufs + handles);
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  939  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  940  	for (i = inbufs; i < ctx->nbufs; ++i) {
847afd7bd5607c Jeya R              2021-09-23  941  		if (!ctx->maps[i]) {
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  942  			void *src = (void *)(uintptr_t)rpra[i].pv;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  943  			void *dst = (void *)(uintptr_t)ctx->args[i].ptr;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  944  			u64 len = rpra[i].len;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  945  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  946  			if (!kernel) {
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  947  				if (copy_to_user((void __user *)dst, src, len))
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  948  					return -EFAULT;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  949  			} else {
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  950  				memcpy(dst, src, len);
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  951  			}
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  952  		}
847afd7bd5607c Jeya R              2021-09-23  953  	}
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  954  
d9eaed76074c94 Jeya R              2021-11-30  955  	for (i = 0; i < FASTRPC_MAX_FDLIST; i++) {
d9eaed76074c94 Jeya R              2021-11-30  956  		if (!fdlist[i])
d9eaed76074c94 Jeya R              2021-11-30  957  			break;
d9eaed76074c94 Jeya R              2021-11-30  958  		if (!fastrpc_map_find(fl, (int)fdlist[i], &mmap))
d9eaed76074c94 Jeya R              2021-11-30  959  			fastrpc_map_put(mmap);
d9eaed76074c94 Jeya R              2021-11-30  960  	}
d9eaed76074c94 Jeya R              2021-11-30  961  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  962  	return 0;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  963  }
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  964  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
