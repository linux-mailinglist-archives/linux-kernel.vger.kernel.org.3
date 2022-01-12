Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7A8B48C45F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 14:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353353AbiALNGL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 08:06:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:19836 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240808AbiALNGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 08:06:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641992764; x=1673528764;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=f67soXYq7QA8UWRbmngAs0UrvUnbxDENT6mKb0mnxJE=;
  b=Bbe5f7YNnYH9mp/ylNf+GMX+TUWijOdTkLzsJ5rzvNdR0XGaZL3tnlgi
   YKguXIDtQR4XkKttganrJy4aQLrjtPnurq4OzxuYPo1xxNoKTSBHJSyqv
   wTLaBsyn/bM++TwLjgyoRz6PDc/LsINUf1JqU56LW2Btnt94EoMzK9a9/
   hjMf/VDkIhbc0je9B107HeKLpQce+MnlaH1v6Em/bYKLWUHN1PMTH+i+k
   dirPIHqfQFFtLC5i+QjdqaLi2qkcCoR8cXRvjufFuXrzBYKftalyhxxcX
   WceKLuFOrZOmNHQPe0JjhmybbKAVO14RyIvTapIHHBsYQ0Yfuce7ZaEmn
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243683641"
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="243683641"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 05:05:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,282,1635231600"; 
   d="scan'208";a="613563671"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jan 2022 05:05:46 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n7dJx-0005pX-VE; Wed, 12 Jan 2022 13:05:45 +0000
Date:   Wed, 12 Jan 2022 21:04:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [pinchartl-media:rpi/next/bcm2835-isp 5/49]
 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:729:1: warning: no previous
 prototype for 'vc_sm_cma_import_dmabuf_internal'
Message-ID: <202201122119.QHDMCN1z-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://linuxtv.org/pinchartl/media.git rpi/next/bcm2835-isp
head:   97975aa0732da0e2084ed69d140656c2162bec05
commit: 0cfa42bcc0795e569f1312e6ef5843c97bd36642 [5/49] staging: vc04_services: Add new vc-sm-cma driver
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20220112/202201122119.QHDMCN1z-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add pinchartl-media git://linuxtv.org/pinchartl/media.git
        git fetch --no-tags pinchartl-media rpi/next/bcm2835-isp
        git checkout 0cfa42bcc0795e569f1312e6ef5843c97bd36642
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/media/platform/atmel/ drivers/staging/vc04_services/vc-sm-cma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:729:1: warning: no previous prototype for 'vc_sm_cma_import_dmabuf_internal' [-Wmissing-prototypes]
     729 | vc_sm_cma_import_dmabuf_internal(struct vc_sm_privdata_t *private,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1112:5: warning: no previous prototype for 'vc_sm_cma_ioctl_alloc' [-Wmissing-prototypes]
    1112 | int vc_sm_cma_ioctl_alloc(struct vc_sm_privdata_t *private,
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c: In function 'cache_op_to_func':
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1265:24: error: 'dmac_flush_range' undeclared (first use in this function)
    1265 |                 return dmac_flush_range;
         |                        ^~~~~~~~~~~~~~~~
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1265:24: note: each undeclared identifier is reported only once for each function it appears in
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c: At top level:
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1463:17: error: unknown type name 'compat_uptr_t'
    1463 |                 compat_uptr_t start_address;
         |                 ^~~~~~~~~~~~~


vim +/vc_sm_cma_import_dmabuf_internal +729 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c

   726	
   727	/* Import a dma_buf to be shared with VC. */
   728	int
 > 729	vc_sm_cma_import_dmabuf_internal(struct vc_sm_privdata_t *private,
   730					 struct dma_buf *dma_buf,
   731					 int fd,
   732					 struct dma_buf **imported_buf)
   733	{
   734		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
   735		struct vc_sm_buffer *buffer = NULL;
   736		struct vc_sm_import import = { };
   737		struct vc_sm_import_result result = { };
   738		struct dma_buf_attachment *attach = NULL;
   739		struct sg_table *sgt = NULL;
   740		dma_addr_t dma_addr;
   741		int ret = 0;
   742		int status;
   743	
   744		/* Setup our allocation parameters */
   745		pr_debug("%s: importing dma_buf %p/fd %d\n", __func__, dma_buf, fd);
   746	
   747		if (fd < 0)
   748			get_dma_buf(dma_buf);
   749		else
   750			dma_buf = dma_buf_get(fd);
   751	
   752		if (!dma_buf)
   753			return -EINVAL;
   754	
   755		attach = dma_buf_attach(dma_buf, &sm_state->pdev->dev);
   756		if (IS_ERR(attach)) {
   757			ret = PTR_ERR(attach);
   758			goto error;
   759		}
   760	
   761		sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
   762		if (IS_ERR(sgt)) {
   763			ret = PTR_ERR(sgt);
   764			goto error;
   765		}
   766	
   767		/* Verify that the address block is contiguous */
   768		if (sgt->nents != 1) {
   769			ret = -ENOMEM;
   770			goto error;
   771		}
   772	
   773		/* Allocate local buffer to track this allocation. */
   774		buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
   775		if (!buffer) {
   776			ret = -ENOMEM;
   777			goto error;
   778		}
   779	
   780		import.type = VC_SM_ALLOC_NON_CACHED;
   781		dma_addr = sg_dma_address(sgt->sgl);
   782		import.addr = (u32)dma_addr;
   783		if ((import.addr & 0xC0000000) != 0xC0000000) {
   784			pr_err("%s: Expecting an uncached alias for dma_addr %pad\n",
   785			       __func__, &dma_addr);
   786			import.addr |= 0xC0000000;
   787		}
   788		import.size = sg_dma_len(sgt->sgl);
   789		import.allocator = current->tgid;
   790		import.kernel_id = get_kernel_id(buffer);
   791	
   792		memcpy(import.name, VC_SM_RESOURCE_NAME_DEFAULT,
   793		       sizeof(VC_SM_RESOURCE_NAME_DEFAULT));
   794	
   795		pr_debug("[%s]: attempt to import \"%s\" data - type %u, addr %pad, size %u.\n",
   796			 __func__, import.name, import.type, &dma_addr, import.size);
   797	
   798		/* Allocate the videocore buffer. */
   799		status = vc_sm_cma_vchi_import(sm_state->sm_handle, &import, &result,
   800					       &sm_state->int_trans_id);
   801		if (status == -EINTR) {
   802			pr_debug("[%s]: requesting import memory action restart (trans_id: %u)\n",
   803				 __func__, sm_state->int_trans_id);
   804			ret = -ERESTARTSYS;
   805			private->restart_sys = -EINTR;
   806			private->int_action = VC_SM_MSG_TYPE_IMPORT;
   807			goto error;
   808		} else if (status || !result.res_handle) {
   809			pr_debug("[%s]: failed to import memory on videocore (status: %u, trans_id: %u)\n",
   810				 __func__, status, sm_state->int_trans_id);
   811			ret = -ENOMEM;
   812			goto error;
   813		}
   814	
   815		mutex_init(&buffer->lock);
   816		INIT_LIST_HEAD(&buffer->attachments);
   817		memcpy(buffer->name, import.name,
   818		       min(sizeof(buffer->name), sizeof(import.name) - 1));
   819	
   820		/* Keep track of the buffer we created. */
   821		buffer->private = private;
   822		buffer->vc_handle = result.res_handle;
   823		buffer->size = import.size;
   824		buffer->vpu_state = VPU_MAPPED;
   825	
   826		buffer->imported = 1;
   827		buffer->import.dma_buf = dma_buf;
   828	
   829		buffer->import.attach = attach;
   830		buffer->import.sgt = sgt;
   831		buffer->dma_addr = dma_addr;
   832		buffer->in_use = 1;
   833		buffer->kernel_id = import.kernel_id;
   834	
   835		/*
   836		 * We're done - we need to export a new dmabuf chaining through most
   837		 * functions, but enabling us to release our own internal references
   838		 * here.
   839		 */
   840		exp_info.ops = &dma_buf_import_ops;
   841		exp_info.size = import.size;
   842		exp_info.flags = O_RDWR;
   843		exp_info.priv = buffer;
   844	
   845		buffer->dma_buf = dma_buf_export(&exp_info);
   846		if (IS_ERR(buffer->dma_buf)) {
   847			ret = PTR_ERR(buffer->dma_buf);
   848			goto error;
   849		}
   850	
   851		vc_sm_add_resource(private, buffer);
   852	
   853		*imported_buf = buffer->dma_buf;
   854	
   855		return 0;
   856	
   857	error:
   858		if (result.res_handle) {
   859			struct vc_sm_free_t free = { result.res_handle, 0 };
   860	
   861			vc_sm_cma_vchi_free(sm_state->sm_handle, &free,
   862					    &sm_state->int_trans_id);
   863		}
   864		free_kernel_id(import.kernel_id);
   865		kfree(buffer);
   866		if (sgt)
   867			dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
   868		if (attach)
   869			dma_buf_detach(dma_buf, attach);
   870		dma_buf_put(dma_buf);
   871		return ret;
   872	}
   873	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
