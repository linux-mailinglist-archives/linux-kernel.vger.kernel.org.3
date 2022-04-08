Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38BB04F922B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbiDHJpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:45:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbiDHJpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:45:17 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687ED7DE1F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649410994; x=1680946994;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=dMonRFNXsdTcwW+lHPLYDBAXGbs2N6NHhKu2HHFtTmU=;
  b=gKfVOTZfFCx0sMPFiYKFvnx5eGRXXcMIf6w3RUicqhfDd/qA4HyJywhK
   5CqqvELWe3DU/tPmK21J1LKA2qYLdrqq4Ak2s+7TCImzKwOQqfuCPf/ez
   RlNZaR4v7HUCtVVjG5KxQY+liyRq8HaD1+rWqkkYMO9q7qEWgPbgwX99J
   z0zPUeGycyeVC4aEa7cj3gRoDS9vvohqoZ34YnrU+xizhPIpvth+QuYuC
   FaJi1kwaQ0ndnUT8NxboyJCC7DkSwZWK81VaHNK63tUpw4QU1XpDQeFZ1
   miPzBaP+8R1GbOvzmklN383PalGhRBHOrFyoYf2tPaxnrphch8FDruoUm
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="261247353"
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="261247353"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 02:43:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,244,1643702400"; 
   d="scan'208";a="723330883"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 08 Apr 2022 02:43:12 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncl95-00007l-GN;
        Fri, 08 Apr 2022 09:43:11 +0000
Date:   Fri, 8 Apr 2022 17:42:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Dom Cobley <popcornmix@gmail.com>
Subject: [l1k:smsc95xx_5.17 281/887]
 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:731:1: warning: no previous
 prototype for 'vc_sm_cma_import_dmabuf_internal'
Message-ID: <202204081731.p3iimqPz-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/l1k/linux smsc95xx_5.17
head:   05d68ced287b30f62f18f95b5476135ef669804a
commit: 56d0cd616fe11877854ad1b0768b3be67bb30349 [281/887] staging: vc04_services: Add new vc-sm-cma driver
config: arc-allyesconfig (https://download.01.org/0day-ci/archive/20220408/202204081731.p3iimqPz-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/l1k/linux/commit/56d0cd616fe11877854ad1b0768b3be67bb30349
        git remote add l1k https://github.com/l1k/linux
        git fetch --no-tags l1k smsc95xx_5.17
        git checkout 56d0cd616fe11877854ad1b0768b3be67bb30349
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arc SHELL=/bin/bash drivers/char/broadcom/ drivers/gpio/ drivers/gpu/drm/vc4/ drivers/media/platform/rockchip/rkisp1/ drivers/staging/vc04_services/vc-sm-cma/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:731:1: warning: no previous prototype for 'vc_sm_cma_import_dmabuf_internal' [-Wmissing-prototypes]
     731 | vc_sm_cma_import_dmabuf_internal(struct vc_sm_privdata_t *private,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1114:5: warning: no previous prototype for 'vc_sm_cma_ioctl_alloc' [-Wmissing-prototypes]
    1114 | int vc_sm_cma_ioctl_alloc(struct vc_sm_privdata_t *private,
         |     ^~~~~~~~~~~~~~~~~~~~~
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c: In function 'cache_op_to_func':
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1267:24: error: 'dmac_flush_range' undeclared (first use in this function)
    1267 |                 return dmac_flush_range;
         |                        ^~~~~~~~~~~~~~~~
   drivers/staging/vc04_services/vc-sm-cma/vc_sm.c:1267:24: note: each undeclared identifier is reported only once for each function it appears in


vim +/vc_sm_cma_import_dmabuf_internal +731 drivers/staging/vc04_services/vc-sm-cma/vc_sm.c

   728	
   729	/* Import a dma_buf to be shared with VC. */
   730	int
 > 731	vc_sm_cma_import_dmabuf_internal(struct vc_sm_privdata_t *private,
   732					 struct dma_buf *dma_buf,
   733					 int fd,
   734					 struct dma_buf **imported_buf)
   735	{
   736		DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
   737		struct vc_sm_buffer *buffer = NULL;
   738		struct vc_sm_import import = { };
   739		struct vc_sm_import_result result = { };
   740		struct dma_buf_attachment *attach = NULL;
   741		struct sg_table *sgt = NULL;
   742		dma_addr_t dma_addr;
   743		int ret = 0;
   744		int status;
   745	
   746		/* Setup our allocation parameters */
   747		pr_debug("%s: importing dma_buf %p/fd %d\n", __func__, dma_buf, fd);
   748	
   749		if (fd < 0)
   750			get_dma_buf(dma_buf);
   751		else
   752			dma_buf = dma_buf_get(fd);
   753	
   754		if (!dma_buf)
   755			return -EINVAL;
   756	
   757		attach = dma_buf_attach(dma_buf, &sm_state->pdev->dev);
   758		if (IS_ERR(attach)) {
   759			ret = PTR_ERR(attach);
   760			goto error;
   761		}
   762	
   763		sgt = dma_buf_map_attachment(attach, DMA_BIDIRECTIONAL);
   764		if (IS_ERR(sgt)) {
   765			ret = PTR_ERR(sgt);
   766			goto error;
   767		}
   768	
   769		/* Verify that the address block is contiguous */
   770		if (sgt->nents != 1) {
   771			ret = -ENOMEM;
   772			goto error;
   773		}
   774	
   775		/* Allocate local buffer to track this allocation. */
   776		buffer = kzalloc(sizeof(*buffer), GFP_KERNEL);
   777		if (!buffer) {
   778			ret = -ENOMEM;
   779			goto error;
   780		}
   781	
   782		import.type = VC_SM_ALLOC_NON_CACHED;
   783		dma_addr = sg_dma_address(sgt->sgl);
   784		import.addr = (u32)dma_addr;
   785		if ((import.addr & 0xC0000000) != 0xC0000000) {
   786			pr_err("%s: Expecting an uncached alias for dma_addr %pad\n",
   787			       __func__, &dma_addr);
   788			import.addr |= 0xC0000000;
   789		}
   790		import.size = sg_dma_len(sgt->sgl);
   791		import.allocator = current->tgid;
   792		import.kernel_id = get_kernel_id(buffer);
   793	
   794		memcpy(import.name, VC_SM_RESOURCE_NAME_DEFAULT,
   795		       sizeof(VC_SM_RESOURCE_NAME_DEFAULT));
   796	
   797		pr_debug("[%s]: attempt to import \"%s\" data - type %u, addr %pad, size %u.\n",
   798			 __func__, import.name, import.type, &dma_addr, import.size);
   799	
   800		/* Allocate the videocore buffer. */
   801		status = vc_sm_cma_vchi_import(sm_state->sm_handle, &import, &result,
   802					       &sm_state->int_trans_id);
   803		if (status == -EINTR) {
   804			pr_debug("[%s]: requesting import memory action restart (trans_id: %u)\n",
   805				 __func__, sm_state->int_trans_id);
   806			ret = -ERESTARTSYS;
   807			private->restart_sys = -EINTR;
   808			private->int_action = VC_SM_MSG_TYPE_IMPORT;
   809			goto error;
   810		} else if (status || !result.res_handle) {
   811			pr_debug("[%s]: failed to import memory on videocore (status: %u, trans_id: %u)\n",
   812				 __func__, status, sm_state->int_trans_id);
   813			ret = -ENOMEM;
   814			goto error;
   815		}
   816	
   817		mutex_init(&buffer->lock);
   818		INIT_LIST_HEAD(&buffer->attachments);
   819		memcpy(buffer->name, import.name,
   820		       min(sizeof(buffer->name), sizeof(import.name) - 1));
   821	
   822		/* Keep track of the buffer we created. */
   823		buffer->private = private;
   824		buffer->vc_handle = result.res_handle;
   825		buffer->size = import.size;
   826		buffer->vpu_state = VPU_MAPPED;
   827	
   828		buffer->imported = 1;
   829		buffer->import.dma_buf = dma_buf;
   830	
   831		buffer->import.attach = attach;
   832		buffer->import.sgt = sgt;
   833		buffer->dma_addr = dma_addr;
   834		buffer->in_use = 1;
   835		buffer->kernel_id = import.kernel_id;
   836	
   837		/*
   838		 * We're done - we need to export a new dmabuf chaining through most
   839		 * functions, but enabling us to release our own internal references
   840		 * here.
   841		 */
   842		exp_info.ops = &dma_buf_import_ops;
   843		exp_info.size = import.size;
   844		exp_info.flags = O_RDWR;
   845		exp_info.priv = buffer;
   846	
   847		buffer->dma_buf = dma_buf_export(&exp_info);
   848		if (IS_ERR(buffer->dma_buf)) {
   849			ret = PTR_ERR(buffer->dma_buf);
   850			goto error;
   851		}
   852	
   853		vc_sm_add_resource(private, buffer);
   854	
   855		*imported_buf = buffer->dma_buf;
   856	
   857		return 0;
   858	
   859	error:
   860		if (result.res_handle) {
   861			struct vc_sm_free_t free = { result.res_handle, 0 };
   862	
   863			vc_sm_cma_vchi_free(sm_state->sm_handle, &free,
   864					    &sm_state->int_trans_id);
   865		}
   866		free_kernel_id(import.kernel_id);
   867		kfree(buffer);
   868		if (sgt)
   869			dma_buf_unmap_attachment(attach, sgt, DMA_BIDIRECTIONAL);
   870		if (attach)
   871			dma_buf_detach(dma_buf, attach);
   872		dma_buf_put(dma_buf);
   873		return ret;
   874	}
   875	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
