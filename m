Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5800D461127
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 10:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243281AbhK2Jfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 04:35:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:20582 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243681AbhK2Jdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 04:33:54 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="299325834"
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="299325834"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 01:22:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,272,1631602800"; 
   d="scan'208";a="499258035"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2021 01:22:02 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrcrJ-000BlG-Of; Mon, 29 Nov 2021 09:22:01 +0000
Date:   Mon, 29 Nov 2021 17:21:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     kbuild-all@lists.01.org, Jeya R <jeyr@codeaurora.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com
Subject: Re: [PATCH 2/2] misc: fastrpc: Add dma handle implementation
Message-ID: <202111291710.WVYQ9Aed-lkp@intel.com>
References: <1638163720-23123-3-git-send-email-jeyr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638163720-23123-3-git-send-email-jeyr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on v5.16-rc3 next-20211126]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeya-R/Add-DMA-handle-implementation/20211129-133228
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git cd455ebb748c4e198c8158e5d61b3034bf10f22b
config: microblaze-randconfig-r031-20211128 (https://download.01.org/0day-ci/archive/20211129/202111291710.WVYQ9Aed-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d8e9cc594aeafa392d306e883c741b984b5fc89a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeya-R/Add-DMA-handle-implementation/20211129-133228
        git checkout d8e9cc594aeafa392d306e883c741b984b5fc89a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_get_meta_size':
>> drivers/misc/fastrpc.c:721:31: error: 'fastrpc_remote_arg' defined as wrong kind of tag
     721 |         size = (sizeof(struct fastrpc_remote_arg) +
         |                               ^~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:721:24: error: invalid application of 'sizeof' to incomplete type 'struct fastrpc_remote_arg'
     721 |         size = (sizeof(struct fastrpc_remote_arg) +
         |                        ^~~~~~
   drivers/misc/fastrpc.c: In function 'fastrpc_put_args':
   drivers/misc/fastrpc.c:925:16: error: 'fastrpc_remote_arg' defined as wrong kind of tag
     925 |         struct fastrpc_remote_arg *rpra = ctx->rpra;
         |                ^~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:925:43: error: initialization of 'struct fastrpc_remote_arg *' from incompatible pointer type 'union fastrpc_remote_arg *' [-Werror=incompatible-pointer-types]
     925 |         struct fastrpc_remote_arg *rpra = ctx->rpra;
         |                                           ^~~
   drivers/misc/fastrpc.c:935:55: error: invalid application of 'sizeof' to incomplete type 'struct fastrpc_remote_arg'
     935 |         list = ctx->buf->virt + ctx->nscalars * sizeof(*rpra);
         |                                                       ^
   drivers/misc/fastrpc.c:937:23: error: invalid application of 'sizeof' to incomplete type 'struct fastrpc_remote_arg'
     937 |                 sizeof(*rpra));
         |                       ^
>> drivers/misc/fastrpc.c:942:60: error: invalid use of undefined type 'struct fastrpc_remote_arg'
     942 |                         void *src = (void *)(uintptr_t)rpra[i].pv;
         |                                                            ^
   drivers/misc/fastrpc.c:942:63: error: invalid use of undefined type 'struct fastrpc_remote_arg'
     942 |                         void *src = (void *)(uintptr_t)rpra[i].pv;
         |                                                               ^
   drivers/misc/fastrpc.c:944:39: error: invalid use of undefined type 'struct fastrpc_remote_arg'
     944 |                         u64 len = rpra[i].len;
         |                                       ^
   drivers/misc/fastrpc.c:944:42: error: invalid use of undefined type 'struct fastrpc_remote_arg'
     944 |                         u64 len = rpra[i].len;
         |                                          ^
   drivers/misc/fastrpc.c:958:39: error: 'fl' undeclared (first use in this function); did you mean 'fd'?
     958 |                 if (!fastrpc_map_find(fl, (int)fdlist[i], &mmap))
         |                                       ^~
         |                                       fd
   drivers/misc/fastrpc.c:958:39: note: each undeclared identifier is reported only once for each function it appears in
   At top level:
   drivers/misc/fastrpc.c:717:12: warning: 'fastrpc_get_meta_size' defined but not used [-Wunused-function]
     717 | static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
         |            ^~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/fastrpc_remote_arg +721 drivers/misc/fastrpc.c

c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  689  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  690  /*
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  691   * Fastrpc payload buffer with metadata looks like:
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  692   *
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  693   * >>>>>>  START of METADATA <<<<<<<<<
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  694   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  695   * |           Arguments             |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  696   * | type:(struct fastrpc_remote_arg)|
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  697   * |             (0 - N)             |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  698   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  699   * |         Invoke Buffer list      |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  700   * | type:(struct fastrpc_invoke_buf)|
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  701   * |           (0 - N)               |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  702   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  703   * |         Page info list          |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  704   * | type:(struct fastrpc_phy_page)  |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  705   * |             (0 - N)             |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  706   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  707   * |         Optional info           |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  708   * |(can be specific to SoC/Firmware)|
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  709   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  710   * >>>>>>>>  END of METADATA <<<<<<<<<
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  711   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  712   * |         Inline ARGS             |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  713   * |            (0-N)                |
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  714   * +---------------------------------+
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  715   */
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  716  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  717  static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  718  {
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  719  	int size = 0;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  720  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08 @721  	size = (sizeof(struct fastrpc_remote_arg) +
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  722  		sizeof(struct fastrpc_invoke_buf) +
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  723  		sizeof(struct fastrpc_phy_page)) * ctx->nscalars +
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  724  		sizeof(u64) * FASTRPC_MAX_FDLIST +
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  725  		sizeof(u32) * FASTRPC_MAX_CRCLIST;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  726  
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  727  	return size;
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  728  }
c68cfb718c8f97 Srinivas Kandagatla 2019-02-08  729  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
