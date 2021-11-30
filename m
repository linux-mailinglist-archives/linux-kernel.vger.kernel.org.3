Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6546463DC8
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 19:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245465AbhK3SaQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 13:30:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:22644 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242593AbhK3SaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 13:30:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="233790215"
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="233790215"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 10:19:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,276,1631602800"; 
   d="scan'208";a="512306826"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 30 Nov 2021 10:19:03 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1ms7iY-000Dci-Mw; Tue, 30 Nov 2021 18:19:02 +0000
Date:   Wed, 1 Dec 2021 02:18:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jeya R <jeyr@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Cc:     kbuild-all@lists.01.org, Jeya R <jeyr@codeaurora.org>,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        fastrpc.upstream@qti.qualcomm.com, bkumar@qti.qualcomm.com,
        ekangupt@qti.qualcomm.com, jeyr@qti.qualcomm.com
Subject: Re: [PATCH 3/3] misc: fastrpc: Handle mapping of invoke argument
 with attribute
Message-ID: <202112010230.ONOKNnFv-lkp@intel.com>
References: <1638277072-6459-6-git-send-email-jeyr@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638277072-6459-6-git-send-email-jeyr@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeya,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on char-misc/char-misc-testing]
[also build test ERROR on robh/for-next linux/master linus/master v5.16-rc3 next-20211130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Jeya-R/Add-vmid-property-and-mapping-attribute/20211130-205941
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git 5d331b5922551637c586cdf5fdc1778910fc937f
config: alpha-randconfig-r025-20211130 (https://download.01.org/0day-ci/archive/20211201/202112010230.ONOKNnFv-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/d8dfc6d253cf3fe6c952b900243caf9b0b120ddf
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Jeya-R/Add-vmid-property-and-mapping-attribute/20211130-205941
        git checkout d8dfc6d253cf3fe6c952b900243caf9b0b120ddf
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/misc/fastrpc.c: In function 'fastrpc_free_map':
>> drivers/misc/fastrpc.c:263:13: error: invalid storage class for function 'fastrpc_map_put'
     263 | static void fastrpc_map_put(struct fastrpc_map *map)
         |             ^~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:263:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
     263 | static void fastrpc_map_put(struct fastrpc_map *map)
         | ^~~~~~
>> drivers/misc/fastrpc.c:269:13: error: invalid storage class for function 'fastrpc_map_get'
     269 | static void fastrpc_map_get(struct fastrpc_map *map)
         |             ^~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:275:12: error: invalid storage class for function 'fastrpc_map_find'
     275 | static int fastrpc_map_find(struct fastrpc_user *fl, int fd,
         |            ^~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:294:13: error: invalid storage class for function 'fastrpc_buf_free'
     294 | static void fastrpc_buf_free(struct fastrpc_buf *buf)
         |             ^~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:301:12: error: invalid storage class for function 'fastrpc_buf_alloc'
     301 | static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
         |            ^~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:337:13: error: invalid storage class for function 'fastrpc_channel_ctx_free'
     337 | static void fastrpc_channel_ctx_free(struct kref *ref)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:346:13: error: invalid storage class for function 'fastrpc_channel_ctx_get'
     346 | static void fastrpc_channel_ctx_get(struct fastrpc_channel_ctx *cctx)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:351:13: error: invalid storage class for function 'fastrpc_channel_ctx_put'
     351 | static void fastrpc_channel_ctx_put(struct fastrpc_channel_ctx *cctx)
         |             ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:356:13: error: invalid storage class for function 'fastrpc_context_free'
     356 | static void fastrpc_context_free(struct kref *ref)
         |             ^~~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:383:13: error: invalid storage class for function 'fastrpc_context_get'
     383 | static void fastrpc_context_get(struct fastrpc_invoke_ctx *ctx)
         |             ^~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:388:13: error: invalid storage class for function 'fastrpc_context_put'
     388 | static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx)
         |             ^~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:393:13: error: invalid storage class for function 'fastrpc_context_put_wq'
     393 | static void fastrpc_context_put_wq(struct work_struct *work)
         |             ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:402:12: error: invalid storage class for function 'olaps_cmp'
     402 | static int olaps_cmp(const void *a, const void *b)
         |            ^~~~~~~~~
>> drivers/misc/fastrpc.c:414:13: error: invalid storage class for function 'fastrpc_get_buff_overlaps'
     414 | static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:450:35: error: invalid storage class for function 'fastrpc_context_alloc'
     450 | static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
         |                                   ^~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:528:1: error: invalid storage class for function 'fastrpc_map_dma_buf'
     528 | fastrpc_map_dma_buf(struct dma_buf_attachment *attachment,
         | ^~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:543:13: error: invalid storage class for function 'fastrpc_unmap_dma_buf'
     543 | static void fastrpc_unmap_dma_buf(struct dma_buf_attachment *attach,
         |             ^~~~~~~~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:550:13: error: invalid storage class for function 'fastrpc_release'
     550 | static void fastrpc_release(struct dma_buf *dmabuf)
         |             ^~~~~~~~~~~~~~~
>> drivers/misc/fastrpc.c:557:12: error: invalid storage class for function 'fastrpc_dma_buf_attach'
     557 | static int fastrpc_dma_buf_attach(struct dma_buf *dmabuf,
         |            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:587:13: error: invalid storage class for function 'fastrpc_dma_buf_detatch'
     587 | static void fastrpc_dma_buf_detatch(struct dma_buf *dmabuf,
         |             ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:600:12: error: invalid storage class for function 'fastrpc_vmap'
     600 | static int fastrpc_vmap(struct dma_buf *dmabuf, struct dma_buf_map *map)
         |            ^~~~~~~~~~~~
   drivers/misc/fastrpc.c:609:12: error: invalid storage class for function 'fastrpc_mmap'
     609 | static int fastrpc_mmap(struct dma_buf *dmabuf,
         |            ^~~~~~~~~~~~
   drivers/misc/fastrpc.c:620:19: error: initializer element is not constant
     620 |         .attach = fastrpc_dma_buf_attach,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:620:19: note: (near initialization for 'fastrpc_dma_buf_ops.attach')
   drivers/misc/fastrpc.c:621:19: error: initializer element is not constant
     621 |         .detach = fastrpc_dma_buf_detatch,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:621:19: note: (near initialization for 'fastrpc_dma_buf_ops.detach')
   drivers/misc/fastrpc.c:622:24: error: initializer element is not constant
     622 |         .map_dma_buf = fastrpc_map_dma_buf,
         |                        ^~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:622:24: note: (near initialization for 'fastrpc_dma_buf_ops.map_dma_buf')
   drivers/misc/fastrpc.c:623:26: error: initializer element is not constant
     623 |         .unmap_dma_buf = fastrpc_unmap_dma_buf,
         |                          ^~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:623:26: note: (near initialization for 'fastrpc_dma_buf_ops.unmap_dma_buf')
   drivers/misc/fastrpc.c:624:17: error: initializer element is not constant
     624 |         .mmap = fastrpc_mmap,
         |                 ^~~~~~~~~~~~
   drivers/misc/fastrpc.c:624:17: note: (near initialization for 'fastrpc_dma_buf_ops.mmap')
   drivers/misc/fastrpc.c:625:17: error: initializer element is not constant
     625 |         .vmap = fastrpc_vmap,
         |                 ^~~~~~~~~~~~
   drivers/misc/fastrpc.c:625:17: note: (near initialization for 'fastrpc_dma_buf_ops.vmap')
   drivers/misc/fastrpc.c:626:20: error: initializer element is not constant
     626 |         .release = fastrpc_release,
         |                    ^~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:626:20: note: (near initialization for 'fastrpc_dma_buf_ops.release')
   drivers/misc/fastrpc.c:629:12: error: invalid storage class for function 'fastrpc_map_create'
     629 | static int fastrpc_map_create(struct fastrpc_user *fl, int fd,
         |            ^~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:724:12: error: invalid storage class for function 'fastrpc_get_meta_size'
     724 | static int fastrpc_get_meta_size(struct fastrpc_invoke_ctx *ctx)
         |            ^~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:737:12: error: invalid storage class for function 'fastrpc_get_payload_size'
     737 | static u64 fastrpc_get_payload_size(struct fastrpc_invoke_ctx *ctx, int metalen)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:756:12: error: invalid storage class for function 'fastrpc_create_maps'
     756 | static int fastrpc_create_maps(struct fastrpc_invoke_ctx *ctx)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c: In function 'fastrpc_create_maps':
   drivers/misc/fastrpc.c:767:82: error: 'x' undeclared (first use in this function)
     767 |                                          ctx->args[i].length, ctx->args[i].attr, x->maps[i]);
         |                                                                                  ^
   drivers/misc/fastrpc.c:767:82: note: each undeclared identifier is reported only once for each function it appears in
   drivers/misc/fastrpc.c: In function 'fastrpc_free_map':
   drivers/misc/fastrpc.c:777:12: error: invalid storage class for function 'fastrpc_get_args'
     777 | static int fastrpc_get_args(u32 kernel, struct fastrpc_invoke_ctx *ctx)
         |            ^~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:900:12: error: invalid storage class for function 'fastrpc_put_args'
     900 | static int fastrpc_put_args(struct fastrpc_invoke_ctx *ctx,
         |            ^~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:926:12: error: invalid storage class for function 'fastrpc_invoke_send'
     926 | static int fastrpc_invoke_send(struct fastrpc_session_ctx *sctx,
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:958:12: error: invalid storage class for function 'fastrpc_internal_invoke'
     958 | static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1031:12: error: invalid storage class for function 'fastrpc_init_create_process'
    1031 | static int fastrpc_init_create_process(struct fastrpc_user *fl,
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1143:36: error: invalid storage class for function 'fastrpc_session_alloc'
    1143 | static struct fastrpc_session_ctx *fastrpc_session_alloc(
         |                                    ^~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1163:13: error: invalid storage class for function 'fastrpc_session_free'
    1163 | static void fastrpc_session_free(struct fastrpc_channel_ctx *cctx,
         |             ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1173:12: error: invalid storage class for function 'fastrpc_release_current_dsp_process'
    1173 | static int fastrpc_release_current_dsp_process(struct fastrpc_user *fl)
         |            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1189:12: error: invalid storage class for function 'fastrpc_device_release'
    1189 | static int fastrpc_device_release(struct inode *inode, struct file *file)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1232:12: error: invalid storage class for function 'fastrpc_device_open'
    1232 | static int fastrpc_device_open(struct inode *inode, struct file *filp)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1271:12: error: invalid storage class for function 'fastrpc_dmabuf_alloc'
    1271 | static int fastrpc_dmabuf_alloc(struct fastrpc_user *fl, char __user *argp)
         |            ^~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1309:12: error: invalid storage class for function 'fastrpc_init_attach'
    1309 | static int fastrpc_init_attach(struct fastrpc_user *fl, int pd)
         |            ^~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1325:12: error: invalid storage class for function 'fastrpc_invoke'
    1325 | static int fastrpc_invoke(struct fastrpc_user *fl, char __user *argp)
         |            ^~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1355:12: error: invalid storage class for function 'fastrpc_req_munmap_impl'
    1355 | static int fastrpc_req_munmap_impl(struct fastrpc_user *fl,
         |            ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/misc/fastrpc.c:1401:12: error: invalid storage class for function 'fastrpc_req_munmap'


vim +/fastrpc_map_put +263 drivers/misc/fastrpc.c

c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  262  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @263  static void fastrpc_map_put(struct fastrpc_map *map)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  264  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  265  	if (map)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  266  		kref_put(&map->refcount, fastrpc_free_map);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  267  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  268  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @269  static void fastrpc_map_get(struct fastrpc_map *map)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  270  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  271  	if (map)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  272  		kref_get(&map->refcount);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  273  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  274  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @275  static int fastrpc_map_find(struct fastrpc_user *fl, int fd,
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  276  			    struct fastrpc_map **ppmap)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  277  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  278  	struct fastrpc_map *map = NULL;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  279  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  280  	mutex_lock(&fl->mutex);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  281  	list_for_each_entry(map, &fl->maps, node) {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  282  		if (map->fd == fd) {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  283  			fastrpc_map_get(map);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  284  			*ppmap = map;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  285  			mutex_unlock(&fl->mutex);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  286  			return 0;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  287  		}
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  288  	}
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  289  	mutex_unlock(&fl->mutex);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  290  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  291  	return -ENOENT;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  292  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  293  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @294  static void fastrpc_buf_free(struct fastrpc_buf *buf)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  295  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  296  	dma_free_coherent(buf->dev, buf->size, buf->virt,
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  297  			  FASTRPC_PHYS(buf->phys));
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  298  	kfree(buf);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  299  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  300  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @301  static int fastrpc_buf_alloc(struct fastrpc_user *fl, struct device *dev,
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  302  			     u64 size, struct fastrpc_buf **obuf)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  303  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  304  	struct fastrpc_buf *buf;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  305  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  306  	buf = kzalloc(sizeof(*buf), GFP_KERNEL);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  307  	if (!buf)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  308  		return -ENOMEM;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  309  
6cffd79504ce040 Srinivas Kandagatla 2019-02-08  310  	INIT_LIST_HEAD(&buf->attachments);
2419e55e532de14 Jorge Ramirez-Ortiz 2019-10-09  311  	INIT_LIST_HEAD(&buf->node);
6cffd79504ce040 Srinivas Kandagatla 2019-02-08  312  	mutex_init(&buf->lock);
6cffd79504ce040 Srinivas Kandagatla 2019-02-08  313  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  314  	buf->fl = fl;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  315  	buf->virt = NULL;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  316  	buf->phys = 0;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  317  	buf->size = size;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  318  	buf->dev = dev;
2419e55e532de14 Jorge Ramirez-Ortiz 2019-10-09  319  	buf->raddr = 0;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  320  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  321  	buf->virt = dma_alloc_coherent(dev, buf->size, (dma_addr_t *)&buf->phys,
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  322  				       GFP_KERNEL);
41db5f8397eee75 Jorge Ramirez-Ortiz 2019-07-05  323  	if (!buf->virt) {
41db5f8397eee75 Jorge Ramirez-Ortiz 2019-07-05  324  		mutex_destroy(&buf->lock);
41db5f8397eee75 Jorge Ramirez-Ortiz 2019-07-05  325  		kfree(buf);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  326  		return -ENOMEM;
41db5f8397eee75 Jorge Ramirez-Ortiz 2019-07-05  327  	}
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  328  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  329  	if (fl->sctx && fl->sctx->sid)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  330  		buf->phys += ((u64)fl->sctx->sid << 32);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  331  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  332  	*obuf = buf;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  333  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  334  	return 0;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  335  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  336  
278d56f970ae6e0 Bjorn Andersson     2019-08-29 @337  static void fastrpc_channel_ctx_free(struct kref *ref)
278d56f970ae6e0 Bjorn Andersson     2019-08-29  338  {
278d56f970ae6e0 Bjorn Andersson     2019-08-29  339  	struct fastrpc_channel_ctx *cctx;
278d56f970ae6e0 Bjorn Andersson     2019-08-29  340  
278d56f970ae6e0 Bjorn Andersson     2019-08-29  341  	cctx = container_of(ref, struct fastrpc_channel_ctx, refcount);
278d56f970ae6e0 Bjorn Andersson     2019-08-29  342  
278d56f970ae6e0 Bjorn Andersson     2019-08-29  343  	kfree(cctx);
278d56f970ae6e0 Bjorn Andersson     2019-08-29  344  }
278d56f970ae6e0 Bjorn Andersson     2019-08-29  345  
278d56f970ae6e0 Bjorn Andersson     2019-08-29 @346  static void fastrpc_channel_ctx_get(struct fastrpc_channel_ctx *cctx)
278d56f970ae6e0 Bjorn Andersson     2019-08-29  347  {
278d56f970ae6e0 Bjorn Andersson     2019-08-29  348  	kref_get(&cctx->refcount);
278d56f970ae6e0 Bjorn Andersson     2019-08-29  349  }
278d56f970ae6e0 Bjorn Andersson     2019-08-29  350  
278d56f970ae6e0 Bjorn Andersson     2019-08-29 @351  static void fastrpc_channel_ctx_put(struct fastrpc_channel_ctx *cctx)
278d56f970ae6e0 Bjorn Andersson     2019-08-29  352  {
278d56f970ae6e0 Bjorn Andersson     2019-08-29  353  	kref_put(&cctx->refcount, fastrpc_channel_ctx_free);
278d56f970ae6e0 Bjorn Andersson     2019-08-29  354  }
278d56f970ae6e0 Bjorn Andersson     2019-08-29  355  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @356  static void fastrpc_context_free(struct kref *ref)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  357  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  358  	struct fastrpc_invoke_ctx *ctx;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  359  	struct fastrpc_channel_ctx *cctx;
977e6c8d1d18061 Srinivas Kandagatla 2019-03-07  360  	unsigned long flags;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  361  	int i;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  362  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  363  	ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  364  	cctx = ctx->cctx;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  365  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  366  	for (i = 0; i < ctx->nscalars; i++)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  367  		fastrpc_map_put(ctx->maps[i]);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  368  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  369  	if (ctx->buf)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  370  		fastrpc_buf_free(ctx->buf);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  371  
977e6c8d1d18061 Srinivas Kandagatla 2019-03-07  372  	spin_lock_irqsave(&cctx->lock, flags);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  373  	idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
977e6c8d1d18061 Srinivas Kandagatla 2019-03-07  374  	spin_unlock_irqrestore(&cctx->lock, flags);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  375  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  376  	kfree(ctx->maps);
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  377  	kfree(ctx->olaps);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  378  	kfree(ctx);
278d56f970ae6e0 Bjorn Andersson     2019-08-29  379  
278d56f970ae6e0 Bjorn Andersson     2019-08-29  380  	fastrpc_channel_ctx_put(cctx);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  381  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  382  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @383  static void fastrpc_context_get(struct fastrpc_invoke_ctx *ctx)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  384  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  385  	kref_get(&ctx->refcount);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  386  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  387  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @388  static void fastrpc_context_put(struct fastrpc_invoke_ctx *ctx)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  389  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  390  	kref_put(&ctx->refcount, fastrpc_context_free);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  391  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  392  
8e7389c79b40ed4 Thierry Escande     2019-03-07 @393  static void fastrpc_context_put_wq(struct work_struct *work)
8e7389c79b40ed4 Thierry Escande     2019-03-07  394  {
8e7389c79b40ed4 Thierry Escande     2019-03-07  395  	struct fastrpc_invoke_ctx *ctx =
8e7389c79b40ed4 Thierry Escande     2019-03-07  396  			container_of(work, struct fastrpc_invoke_ctx, put_work);
8e7389c79b40ed4 Thierry Escande     2019-03-07  397  
8e7389c79b40ed4 Thierry Escande     2019-03-07  398  	fastrpc_context_put(ctx);
8e7389c79b40ed4 Thierry Escande     2019-03-07  399  }
8e7389c79b40ed4 Thierry Escande     2019-03-07  400  
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  401  #define CMP(aa, bb) ((aa) == (bb) ? 0 : (aa) < (bb) ? -1 : 1)
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07 @402  static int olaps_cmp(const void *a, const void *b)
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  403  {
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  404  	struct fastrpc_buf_overlap *pa = (struct fastrpc_buf_overlap *)a;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  405  	struct fastrpc_buf_overlap *pb = (struct fastrpc_buf_overlap *)b;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  406  	/* sort with lowest starting buffer first */
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  407  	int st = CMP(pa->start, pb->start);
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  408  	/* sort with highest ending buffer first */
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  409  	int ed = CMP(pb->end, pa->end);
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  410  
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  411  	return st == 0 ? ed : st;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  412  }
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  413  
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07 @414  static void fastrpc_get_buff_overlaps(struct fastrpc_invoke_ctx *ctx)
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  415  {
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  416  	u64 max_end = 0;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  417  	int i;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  418  
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  419  	for (i = 0; i < ctx->nbufs; ++i) {
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  420  		ctx->olaps[i].start = ctx->args[i].ptr;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  421  		ctx->olaps[i].end = ctx->olaps[i].start + ctx->args[i].length;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  422  		ctx->olaps[i].raix = i;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  423  	}
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  424  
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  425  	sort(ctx->olaps, ctx->nbufs, sizeof(*ctx->olaps), olaps_cmp, NULL);
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  426  
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  427  	for (i = 0; i < ctx->nbufs; ++i) {
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  428  		/* Falling inside previous range */
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  429  		if (ctx->olaps[i].start < max_end) {
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  430  			ctx->olaps[i].mstart = max_end;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  431  			ctx->olaps[i].mend = ctx->olaps[i].end;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  432  			ctx->olaps[i].offset = max_end - ctx->olaps[i].start;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  433  
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  434  			if (ctx->olaps[i].end > max_end) {
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  435  				max_end = ctx->olaps[i].end;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  436  			} else {
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  437  				ctx->olaps[i].mend = 0;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  438  				ctx->olaps[i].mstart = 0;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  439  			}
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  440  
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  441  		} else  {
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  442  			ctx->olaps[i].mend = ctx->olaps[i].end;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  443  			ctx->olaps[i].mstart = ctx->olaps[i].start;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  444  			ctx->olaps[i].offset = 0;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  445  			max_end = ctx->olaps[i].end;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  446  		}
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  447  	}
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  448  }
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  449  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08 @450  static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  451  			struct fastrpc_user *user, u32 kernel, u32 sc,
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  452  			struct fastrpc_invoke_args *args)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  453  {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  454  	struct fastrpc_channel_ctx *cctx = user->cctx;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  455  	struct fastrpc_invoke_ctx *ctx = NULL;
977e6c8d1d18061 Srinivas Kandagatla 2019-03-07  456  	unsigned long flags;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  457  	int ret;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  458  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  459  	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  460  	if (!ctx)
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  461  		return ERR_PTR(-ENOMEM);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  462  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  463  	INIT_LIST_HEAD(&ctx->node);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  464  	ctx->fl = user;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  465  	ctx->nscalars = REMOTE_SCALARS_LENGTH(sc);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  466  	ctx->nbufs = REMOTE_SCALARS_INBUFS(sc) +
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  467  		     REMOTE_SCALARS_OUTBUFS(sc);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  468  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  469  	if (ctx->nscalars) {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  470  		ctx->maps = kcalloc(ctx->nscalars,
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  471  				    sizeof(*ctx->maps), GFP_KERNEL);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  472  		if (!ctx->maps) {
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  473  			kfree(ctx);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  474  			return ERR_PTR(-ENOMEM);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  475  		}
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  476  		ctx->olaps = kcalloc(ctx->nscalars,
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  477  				    sizeof(*ctx->olaps), GFP_KERNEL);
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  478  		if (!ctx->olaps) {
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  479  			kfree(ctx->maps);
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  480  			kfree(ctx);
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  481  			return ERR_PTR(-ENOMEM);
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  482  		}
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  483  		ctx->args = args;
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  484  		fastrpc_get_buff_overlaps(ctx);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  485  	}
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  486  
278d56f970ae6e0 Bjorn Andersson     2019-08-29  487  	/* Released in fastrpc_context_put() */
278d56f970ae6e0 Bjorn Andersson     2019-08-29  488  	fastrpc_channel_ctx_get(cctx);
278d56f970ae6e0 Bjorn Andersson     2019-08-29  489  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  490  	ctx->sc = sc;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  491  	ctx->retval = -1;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  492  	ctx->pid = current->pid;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  493  	ctx->tgid = user->tgid;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  494  	ctx->cctx = cctx;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  495  	init_completion(&ctx->work);
8e7389c79b40ed4 Thierry Escande     2019-03-07  496  	INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  497  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  498  	spin_lock(&user->lock);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  499  	list_add_tail(&ctx->node, &user->pending);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  500  	spin_unlock(&user->lock);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  501  
977e6c8d1d18061 Srinivas Kandagatla 2019-03-07  502  	spin_lock_irqsave(&cctx->lock, flags);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  503  	ret = idr_alloc_cyclic(&cctx->ctx_idr, ctx, 1,
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  504  			       FASTRPC_CTX_MAX, GFP_ATOMIC);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  505  	if (ret < 0) {
977e6c8d1d18061 Srinivas Kandagatla 2019-03-07  506  		spin_unlock_irqrestore(&cctx->lock, flags);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  507  		goto err_idr;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  508  	}
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  509  	ctx->ctxid = ret << 4;
977e6c8d1d18061 Srinivas Kandagatla 2019-03-07  510  	spin_unlock_irqrestore(&cctx->lock, flags);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  511  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  512  	kref_init(&ctx->refcount);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  513  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  514  	return ctx;
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  515  err_idr:
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  516  	spin_lock(&user->lock);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  517  	list_del(&ctx->node);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  518  	spin_unlock(&user->lock);
278d56f970ae6e0 Bjorn Andersson     2019-08-29  519  	fastrpc_channel_ctx_put(cctx);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  520  	kfree(ctx->maps);
25e8dfb83cda0a1 Srinivas Kandagatla 2019-03-07  521  	kfree(ctx->olaps);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  522  	kfree(ctx);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  523  
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  524  	return ERR_PTR(ret);
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  525  }
c68cfb718c8f97b Srinivas Kandagatla 2019-02-08  526  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
