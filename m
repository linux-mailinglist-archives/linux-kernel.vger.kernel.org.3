Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320254985DC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244120AbiAXRG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:06:56 -0500
Received: from mga05.intel.com ([192.55.52.43]:32113 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244092AbiAXRGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:06:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643044011; x=1674580011;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=kOz22zrg9aIMLQL8y2yq5wofp1SYFDGdSsPY13x3hio=;
  b=Sswxdsbq3IcCA5q1j/g3gIScvIbfTQLkf/bC9WYXVlt6zWjVZWoVt9uh
   PzWAUwbwWpBsYeEnvS/RTxj/3duO38JV12UNqD4Y8mFUD+Xmo5bXWg9ve
   mbpyd8AvyT3NFaOrrmSO9PNsuvfdrmilu/3pwHUVjzL8dlTtYq1f5E4cq
   +VM9TxSvslyVgjQVDTI3MltbX3F8wsyVpGS747bjGkiTlo2CDZ/O89Cz2
   qOJ2j0y6fsOubBr8visxhKMPqprybGdnyrJmqy5YY4nsbAbsAY1T8tK6N
   kzSqs/UuUSQ2MGlLu72Va5sBO/3JATB19+4Hp5RwG+/9AcOAd32pIWj37
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="332448550"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332448550"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 09:06:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="532139668"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 Jan 2022 09:05:58 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nC2mz-000Iep-Ls; Mon, 24 Jan 2022 17:05:57 +0000
Date:   Tue, 25 Jan 2022 01:05:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Farzad Farshchi <farzadfr@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Emil Renner Berthing <kernel@esmil.dk>,
        kernel test robot <lkp@intel.com>
Subject: [esmil:visionfive 57/63] drivers/nvdla/sdp.c:265:18: warning:
 variable 'atom_size' set but not used
Message-ID: <202201250115.BCWxnuvp-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/esmil/linux visionfive
head:   fdbe623707a8f3f9b9d2cb3c4c240299a12b8302
commit: 1858f8a7f96cbdd6c84d58ef025852d3538c7f3b [57/63] nvdla: add NVDLA driver
config: csky-allyesconfig (https://download.01.org/0day-ci/archive/20220125/202201250115.BCWxnuvp-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/esmil/linux/commit/1858f8a7f96cbdd6c84d58ef025852d3538c7f3b
        git remote add esmil https://github.com/esmil/linux
        git fetch --no-tags esmil visionfive
        git checkout 1858f8a7f96cbdd6c84d58ef025852d3538c7f3b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=csky SHELL=/bin/bash drivers/net/ethernet/mellanox/mlx5/core/ drivers/nvdla/ drivers/staging/android/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/nvdla/sdp.c: In function 'processor_sdp_program':
>> drivers/nvdla/sdp.c:265:18: warning: variable 'atom_size' set but not used [-Wunused-but-set-variable]
     265 |         uint32_t atom_size;
         |                  ^~~~~~~~~
--
   drivers/nvdla/engine_isr.c: In function 'dla_isr_handler':
>> drivers/nvdla/engine_isr.c:38:18: warning: variable 'mask' set but not used [-Wunused-but-set-variable]
      38 |         uint32_t mask;
         |                  ^~~~
--
   drivers/nvdla/nvdla_core_callbacks.c: In function 'dla_debug':
>> drivers/nvdla/nvdla_core_callbacks.c:83:9: warning: function 'dla_debug' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      83 |         vprintk(pr_fmt(str), args);
         |         ^~~~~~~
   drivers/nvdla/nvdla_core_callbacks.c: In function 'dla_info':
>> drivers/nvdla/nvdla_core_callbacks.c:91:9: warning: function 'dla_info' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      91 |         vprintk(str, args);
         |         ^~~~~~~
   drivers/nvdla/nvdla_core_callbacks.c: In function 'dla_warn':
>> drivers/nvdla/nvdla_core_callbacks.c:99:9: warning: function 'dla_warn' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
      99 |         vprintk(str, args);
         |         ^~~~~~~
   drivers/nvdla/nvdla_core_callbacks.c: In function 'dla_error':
>> drivers/nvdla/nvdla_core_callbacks.c:107:9: warning: function 'dla_error' might be a candidate for 'gnu_printf' format attribute [-Wsuggest-attribute=format]
     107 |         vprintk(str, args);
         |         ^~~~~~~
--
>> drivers/nvdla/engine.c:92: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Get DMA data cube address
   drivers/nvdla/engine.c:113: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Read input buffer address
--
>> drivers/nvdla/bdma.c:125: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Program BDMA slot for transfer
--
>> drivers/nvdla/scheduler.c:432: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Dequeue next operation of same type from list of operations
   drivers/nvdla/scheduler.c:579: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Handle operation completion notification
   drivers/nvdla/scheduler.c:723: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Read network configuration from DRAM, network descriptor address
   drivers/nvdla/scheduler.c:1060: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
    * Execute task selected by task scheduler


vim +/atom_size +265 drivers/nvdla/sdp.c

   256	
   257	static int32_t
   258	processor_sdp_program(struct dla_processor_group *group)
   259	{
   260		int32_t ret = 0;
   261		uint64_t src_addr = -1, x1_addr = -1, x2_addr = -1;
   262		uint64_t  y_addr = -1, dst_addr = -1;
   263		uint32_t reg, high, low;
   264		uint8_t fly;
 > 265		uint32_t atom_size;
   266		struct dla_sdp_op *x1_op;
   267		struct dla_sdp_op *x2_op;
   268		struct dla_sdp_op *y_op;
   269		uint8_t x1_rdma_ena;
   270		uint8_t x2_rdma_ena;
   271		uint8_t y_rdma_ena;
   272		uint8_t out_dma_ena;
   273		struct dla_lut_param lut;
   274		struct dla_engine *engine = dla_get_engine();
   275		struct dla_sdp_op_desc *sdp_op;
   276		struct dla_sdp_surface_desc *sdp_surface;
   277	
   278		dla_trace("Enter: %s", __func__);
   279		atom_size = engine->config_data->atom_size;
   280	
   281		sdp_op = &group->operation_desc->sdp_op;
   282		sdp_surface = &group->surface_desc->sdp_surface;
   283	
   284		fly = sdp_surface->src_data.type == DLA_MEM_HW;
   285		out_dma_ena = sdp_surface->dst_data.type != DLA_MEM_HW;
   286		x1_op = &sdp_op->x1_op;
   287		x2_op = &sdp_op->x2_op;
   288		y_op = &sdp_op->y_op;
   289		x1_rdma_ena = x1_op->enable && x1_op->type != SDP_OP_NONE;
   290		x2_rdma_ena = x2_op->enable && x2_op->type != SDP_OP_NONE;
   291		y_rdma_ena  = y_op->enable && y_op->type != SDP_OP_NONE;
   292	
   293		/* load address */
   294		if (!fly) {
   295			ret = dla_read_input_address(&sdp_surface->src_data,
   296							&src_addr,
   297							group->op_desc->index,
   298							group->roi_index,
   299						    1);
   300			if (ret)
   301				goto exit;
   302			CHECK_ALIGN(src_addr, atom_size);
   303		}
   304	
   305		if (out_dma_ena) {
   306			dla_get_dma_cube_address(engine->driver_context,
   307						engine->task->task_data,
   308						sdp_surface->dst_data.address,
   309						sdp_surface->dst_data.offset,
   310						(void *)&dst_addr,
   311						DESTINATION_DMA);
   312			CHECK_ALIGN(dst_addr, atom_size);
   313		}
   314	
   315		if (sdp_op->lut_index >= 0) {
   316			group->lut_index = sdp_op->lut_index;
   317			dla_read_lut(engine, sdp_op->lut_index, (void *)&lut);
   318			dla_debug_lut_params(&lut);
   319		}
   320	
   321	
   322		x1_rdma_ena &= (x1_op->mode != SDP_OP_PER_LAYER);
   323		x2_rdma_ena &= (x2_op->mode != SDP_OP_PER_LAYER);
   324		y_rdma_ena &= (y_op->mode != SDP_OP_PER_LAYER);
   325	
   326		if (x1_rdma_ena) {
   327			dla_get_dma_cube_address(engine->driver_context,
   328						engine->task->task_data,
   329						sdp_surface->x1_data.address,
   330						sdp_surface->x1_data.offset,
   331						(void *)&x1_addr,
   332						DESTINATION_DMA);
   333			CHECK_ALIGN(x1_addr, atom_size);
   334		}
   335		if (x2_rdma_ena) {
   336			dla_get_dma_cube_address(engine->driver_context,
   337						engine->task->task_data,
   338						sdp_surface->x2_data.address,
   339						sdp_surface->x2_data.offset,
   340						(void *)&x2_addr,
   341						DESTINATION_DMA);
   342			CHECK_ALIGN(x2_addr, atom_size);
   343		}
   344		if (y_rdma_ena) {
   345			dla_get_dma_cube_address(engine->driver_context,
   346						engine->task->task_data,
   347						sdp_surface->y_data.address,
   348						sdp_surface->y_data.offset,
   349						(void *)&y_addr,
   350						DESTINATION_DMA);
   351			CHECK_ALIGN(y_addr, atom_size);
   352		}
   353	
   354		reg = (map_fly[0] << SHIFT(SDP_RDMA_D_FEATURE_MODE_CFG_0, FLYING_MODE));
   355		sdp_rdma_reg_write(D_FEATURE_MODE_CFG, reg);
   356	
   357		reg = (map_ena[1] << SHIFT(SDP_RDMA_D_BRDMA_CFG_0, BRDMA_DISABLE));
   358		sdp_rdma_reg_write(D_BRDMA_CFG, reg);
   359		reg = (map_ena[1] << SHIFT(SDP_RDMA_D_NRDMA_CFG_0, NRDMA_DISABLE));
   360		sdp_rdma_reg_write(D_NRDMA_CFG, reg);
   361		reg = (map_ena[1] << SHIFT(SDP_RDMA_D_ERDMA_CFG_0, ERDMA_DISABLE));
   362		sdp_rdma_reg_write(D_ERDMA_CFG, reg);
   363	
   364		reg = (map_fly[fly] <<
   365				SHIFT(SDP_RDMA_D_FEATURE_MODE_CFG_0, FLYING_MODE)) |
   366		(map_wg[sdp_op->conv_mode == CONV_MODE_WINOGRAD] <<
   367				SHIFT(SDP_RDMA_D_FEATURE_MODE_CFG_0, WINOGRAD)) |
   368		(map_precision[sdp_op->src_precision] <<
   369				SHIFT(SDP_RDMA_D_FEATURE_MODE_CFG_0, IN_PRECISION)) |
   370		(map_precision[sdp_op->dst_precision] <<
   371				SHIFT(SDP_RDMA_D_FEATURE_MODE_CFG_0, OUT_PRECISION)) |
   372		(map_proc_precision[sdp_op->dst_precision][sdp_op->src_precision] <<
   373				SHIFT(SDP_RDMA_D_FEATURE_MODE_CFG_0, PROC_PRECISION)) |
   374		((sdp_op->batch_num-1) <<
   375				SHIFT(SDP_RDMA_D_FEATURE_MODE_CFG_0, BATCH_NUMBER));
   376		sdp_rdma_reg_write(D_FEATURE_MODE_CFG, reg);
   377	
   378		if (group->is_rdma_needed) {
   379	
   380			sdp_rdma_reg_write(D_DATA_CUBE_WIDTH,
   381						sdp_surface->src_data.width - 1);
   382			sdp_rdma_reg_write(D_DATA_CUBE_HEIGHT,
   383						sdp_surface->src_data.height - 1);
   384			sdp_rdma_reg_write(D_DATA_CUBE_CHANNEL,
   385						sdp_surface->src_data.channel - 1);
   386	
   387			/* config SDP source info */
   388			if (!fly) {
   389				/**
   390				 * if not on-the-fly, we have to config
   391				 * the source cube info
   392				 */
   393				high = HIGH32BITS(src_addr);
   394				low = LOW32BITS(src_addr);
   395				sdp_rdma_reg_write(D_SRC_BASE_ADDR_LOW, low);
   396				sdp_rdma_reg_write(D_SRC_BASE_ADDR_HIGH, high);
   397				sdp_rdma_reg_write(D_SRC_LINE_STRIDE,
   398						sdp_surface->src_data.line_stride);
   399				sdp_rdma_reg_write(D_SRC_SURFACE_STRIDE,
   400						sdp_surface->src_data.surf_stride);
   401				sdp_rdma_reg_write(D_SRC_DMA_CFG,
   402					map_ram_type[sdp_surface->src_data.type]);
   403			}
   404	
   405			/* config x1 source info */
   406			reg = (map_ena[x1_rdma_ena] <<
   407					SHIFT(SDP_RDMA_D_BRDMA_CFG_0,
   408					BRDMA_DISABLE)) |
   409				(map_op_type[x1_op->type] <<
   410					SHIFT(SDP_RDMA_D_BRDMA_CFG_0,
   411					BRDMA_DATA_USE)) |
   412				(map_element_size[x1_op->precision] <<
   413					SHIFT(SDP_RDMA_D_BRDMA_CFG_0,
   414					BRDMA_DATA_SIZE)) |
   415				(map_op_mode[x1_op->mode] <<
   416					SHIFT(SDP_RDMA_D_BRDMA_CFG_0,
   417					BRDMA_DATA_MODE)) |
   418				(map_ram_type[sdp_surface->x1_data.type] <<
   419					SHIFT(SDP_RDMA_D_BRDMA_CFG_0,
   420					BRDMA_RAM_TYPE));
   421			sdp_rdma_reg_write(D_BRDMA_CFG, reg);
   422	
   423			if (x1_rdma_ena) {
   424				high = HIGH32BITS(x1_addr);
   425				low = LOW32BITS(x1_addr);
   426				sdp_rdma_reg_write(D_BS_BASE_ADDR_LOW,
   427						low);
   428				sdp_rdma_reg_write(D_BS_BASE_ADDR_HIGH,
   429						high);
   430				sdp_rdma_reg_write(D_BS_LINE_STRIDE,
   431						sdp_surface->x1_data.line_stride);
   432				sdp_rdma_reg_write(D_BS_SURFACE_STRIDE,
   433						sdp_surface->x1_data.surf_stride);
   434			}
   435	
   436			/* config x2 source info */
   437			reg = (map_ena[x2_rdma_ena] <<
   438						SHIFT(SDP_RDMA_D_NRDMA_CFG_0,
   439						NRDMA_DISABLE)) |
   440				(map_op_type[x2_op->type] <<
   441						SHIFT(SDP_RDMA_D_NRDMA_CFG_0,
   442						NRDMA_DATA_USE)) |
   443				(map_element_size[x2_op->precision] <<
   444						SHIFT(SDP_RDMA_D_NRDMA_CFG_0,
   445						NRDMA_DATA_SIZE)) |
   446				(map_op_mode[x2_op->mode] <<
   447						SHIFT(SDP_RDMA_D_NRDMA_CFG_0,
   448						NRDMA_DATA_MODE)) |
   449				(map_ram_type[sdp_surface->x2_data.type] <<
   450						SHIFT(SDP_RDMA_D_NRDMA_CFG_0,
   451						NRDMA_RAM_TYPE));
   452	
   453			sdp_rdma_reg_write(D_NRDMA_CFG, reg);
   454	
   455			if (x2_rdma_ena) {
   456				high = HIGH32BITS(x2_addr);
   457				low = LOW32BITS(x2_addr);
   458				sdp_rdma_reg_write(D_BN_BASE_ADDR_LOW,
   459						low);
   460				sdp_rdma_reg_write(D_BN_BASE_ADDR_HIGH,
   461						high);
   462				sdp_rdma_reg_write(D_BN_LINE_STRIDE,
   463						sdp_surface->x2_data.line_stride);
   464				sdp_rdma_reg_write(D_BN_SURFACE_STRIDE,
   465						sdp_surface->x2_data.surf_stride);
   466			}
   467	
   468			/* config y source info */
   469			reg = (map_ena[y_rdma_ena] <<
   470					SHIFT(SDP_RDMA_D_ERDMA_CFG_0,
   471					ERDMA_DISABLE)) |
   472				(map_op_type[y_op->type] <<
   473					SHIFT(SDP_RDMA_D_ERDMA_CFG_0,
   474					ERDMA_DATA_USE)) |
   475				(map_element_size[y_op->precision] <<
   476					SHIFT(SDP_RDMA_D_ERDMA_CFG_0,
   477					ERDMA_DATA_SIZE)) |
   478				(map_op_mode[y_op->mode] <<
   479					SHIFT(SDP_RDMA_D_ERDMA_CFG_0,
   480					ERDMA_DATA_MODE)) |
   481				(map_ram_type[sdp_surface->y_data.type] <<
   482					SHIFT(SDP_RDMA_D_ERDMA_CFG_0,
   483					ERDMA_RAM_TYPE));
   484	
   485			sdp_rdma_reg_write(D_ERDMA_CFG, reg);
   486			if (y_rdma_ena) {
   487				high = HIGH32BITS(y_addr);
   488				low = LOW32BITS(y_addr);
   489				sdp_rdma_reg_write(D_EW_BASE_ADDR_LOW,
   490						low);
   491				sdp_rdma_reg_write(D_EW_BASE_ADDR_HIGH,
   492						high);
   493				sdp_rdma_reg_write(D_EW_LINE_STRIDE,
   494						sdp_surface->y_data.line_stride);
   495				sdp_rdma_reg_write(D_EW_SURFACE_STRIDE,
   496						sdp_surface->y_data.surf_stride);
   497			}
   498		}
   499	
   500		if (sdp_op->lut_index >= 0)
   501			update_lut(SDP_S_LUT_ACCESS_CFG_0, &lut,
   502						sdp_op->src_precision);
   503	
   504		sdp_reg_write(D_DATA_CUBE_WIDTH, sdp_surface->src_data.width - 1);
   505		sdp_reg_write(D_DATA_CUBE_HEIGHT, sdp_surface->src_data.height - 1);
   506		sdp_reg_write(D_DATA_CUBE_CHANNEL, sdp_surface->src_data.channel - 1);
   507	
   508		if (out_dma_ena) {
   509			high = HIGH32BITS(dst_addr);
   510			low = LOW32BITS(dst_addr);
   511			sdp_reg_write(D_DST_BASE_ADDR_HIGH,
   512					high);
   513			sdp_reg_write(D_DST_BASE_ADDR_LOW,
   514					low);
   515			sdp_reg_write(D_DST_LINE_STRIDE,
   516					sdp_surface->dst_data.line_stride);
   517			sdp_reg_write(D_DST_SURFACE_STRIDE,
   518					sdp_surface->dst_data.surf_stride);
   519		}
   520	
   521		/* Config BS module */
   522		reg = (map_bypass[x1_op->enable] <<
   523				SHIFT(SDP_D_DP_BS_CFG_0,
   524				BS_BYPASS)) |
   525			(map_bypass[x1_op->type != SDP_OP_MUL &&
   526					x1_op->type != SDP_OP_NONE] <<
   527				SHIFT(SDP_D_DP_BS_CFG_0,
   528				BS_ALU_BYPASS)) |
   529			(map_alu_op[x1_op->alu_type] <<
   530				SHIFT(SDP_D_DP_BS_CFG_0,
   531				BS_ALU_ALGO)) |
   532			(map_bypass[x1_op->type != SDP_OP_ADD &&
   533				x1_op->type != SDP_OP_NONE] <<
   534				SHIFT(SDP_D_DP_BS_CFG_0,
   535				BS_MUL_BYPASS)) |
   536			(map_prelu[x1_op->act == ACTIVATION_PRELU]
   537				<< SHIFT(SDP_D_DP_BS_CFG_0,
   538				BS_MUL_PRELU)) |
   539			(map_bypass[x1_op->act == ACTIVATION_RELU] <<
   540				SHIFT(SDP_D_DP_BS_CFG_0,
   541				BS_RELU_BYPASS));
   542		sdp_reg_write(D_DP_BS_CFG, reg);
   543	
   544		if (x1_op->enable) {
   545			if (x1_op->type == SDP_OP_ADD ||
   546					x1_op->type == SDP_OP_BOTH) {
   547				reg = (map_alu_src[x1_op->mode == SDP_OP_PER_LAYER] <<
   548						SHIFT(SDP_D_DP_BS_ALU_CFG_0,
   549						BS_ALU_SRC)) |
   550					(x1_op->shift_value <<
   551						SHIFT(SDP_D_DP_BS_ALU_CFG_0,
   552						BS_ALU_SHIFT_VALUE));
   553				sdp_reg_write(D_DP_BS_ALU_CFG, reg);
   554			}
   555	
   556			if (x1_op->mode == SDP_OP_PER_LAYER) {
   557				sdp_reg_write(D_DP_BS_ALU_SRC_VALUE,
   558						x1_op->alu_operand);
   559				sdp_reg_write(D_DP_BS_MUL_SRC_VALUE,
   560						x1_op->mul_operand);
   561			}
   562	
   563			/**
   564			 * MUL truncate will take effect no matter
   565			 * MUL is bypassed or not
   566			 */
   567			reg = (map_alu_src[x1_op->mode == SDP_OP_PER_LAYER] <<
   568				SHIFT(SDP_D_DP_BS_MUL_CFG_0,
   569				BS_MUL_SRC)) |
   570			(x1_op->truncate <<
   571				SHIFT(SDP_D_DP_BS_MUL_CFG_0,
   572				BS_MUL_SHIFT_VALUE));
   573			sdp_reg_write(D_DP_BS_MUL_CFG, reg);
   574		}
   575	
   576		/* Config BN module */
   577		reg = (map_bypass[x2_op->enable] <<
   578				SHIFT(SDP_D_DP_BN_CFG_0,
   579				BN_BYPASS)) |
   580			(map_bypass[x2_op->type != SDP_OP_MUL &&
   581				x2_op->type != SDP_OP_NONE] <<
   582				SHIFT(SDP_D_DP_BN_CFG_0,
   583				BN_ALU_BYPASS)) |
   584			(map_alu_op[x2_op->alu_type] <<
   585				SHIFT(SDP_D_DP_BN_CFG_0,
   586				BN_ALU_ALGO)) |
   587			(map_bypass[x2_op->type != SDP_OP_ADD &&
   588				x2_op->type != SDP_OP_NONE] <<
   589				SHIFT(SDP_D_DP_BN_CFG_0,
   590				BN_MUL_BYPASS)) |
   591			(map_prelu[x2_op->act == ACTIVATION_PRELU]
   592				<< SHIFT(SDP_D_DP_BN_CFG_0,
   593				BN_MUL_PRELU)) |
   594			(map_bypass[x2_op->act == ACTIVATION_RELU]
   595				<< SHIFT(SDP_D_DP_BN_CFG_0,
   596				BN_RELU_BYPASS));
   597		sdp_reg_write(D_DP_BN_CFG, reg);
   598	
   599		if (x2_op->enable) {
   600			if (x2_op->type == SDP_OP_ADD ||
   601				x2_op->type == SDP_OP_BOTH) {
   602				reg = (map_alu_src[x2_op->mode == SDP_OP_PER_LAYER] <<
   603						SHIFT(SDP_D_DP_BN_ALU_CFG_0,
   604						BN_ALU_SRC)) |
   605					(x2_op->shift_value <<
   606						SHIFT(SDP_D_DP_BN_ALU_CFG_0,
   607						BN_ALU_SHIFT_VALUE));
   608				sdp_reg_write(D_DP_BN_ALU_CFG, reg);
   609			}
   610	
   611			if (x2_op->mode == SDP_OP_PER_LAYER) {
   612				sdp_reg_write(D_DP_BN_ALU_SRC_VALUE,
   613						x2_op->alu_operand);
   614				sdp_reg_write(D_DP_BN_MUL_SRC_VALUE,
   615						x2_op->mul_operand);
   616			}
   617	
   618			reg = (map_alu_src[x2_op->mode == SDP_OP_PER_LAYER] <<
   619					SHIFT(SDP_D_DP_BN_MUL_CFG_0,
   620					BN_MUL_SRC)) |
   621				(x2_op->truncate <<
   622					SHIFT(SDP_D_DP_BN_MUL_CFG_0,
   623					BN_MUL_SHIFT_VALUE));
   624			sdp_reg_write(D_DP_BN_MUL_CFG, reg);
   625		}
   626	
   627		/* Config EW module */
   628		reg = (map_bypass[y_op->enable] <<
   629				SHIFT(SDP_D_DP_EW_CFG_0,
   630				EW_BYPASS)) |
   631			(map_bypass[y_op->type != SDP_OP_MUL &&
   632				y_op->type != SDP_OP_NONE] <<
   633				SHIFT(SDP_D_DP_EW_CFG_0,
   634				EW_ALU_BYPASS)) |
   635			(map_alu_op[y_op->alu_type] <<
   636				SHIFT(SDP_D_DP_EW_CFG_0,
   637				EW_ALU_ALGO)) |
   638			(map_bypass[y_op->type != SDP_OP_ADD &&
   639				y_op->type != SDP_OP_NONE] <<
   640				SHIFT(SDP_D_DP_EW_CFG_0,
   641				EW_MUL_BYPASS)) |
   642			((map_prelu[y_op->act == ACTIVATION_PRELU]) <<
   643				SHIFT(SDP_D_DP_EW_CFG_0,
   644				EW_MUL_PRELU)) |
   645			(map_bypass[y_op->act == ACTIVATION_LUT] <<
   646				SHIFT(SDP_D_DP_EW_CFG_0,
   647				EW_LUT_BYPASS));
   648		sdp_reg_write(D_DP_EW_CFG, reg);
   649	
   650		if (y_op->enable) {
   651			if (y_op->type == SDP_OP_ADD || y_op->type == SDP_OP_BOTH) {
   652				reg = (map_alu_src[y_op->mode == SDP_OP_PER_LAYER] <<
   653						SHIFT(SDP_D_DP_EW_ALU_CFG_0,
   654						EW_ALU_SRC)) |
   655					(map_bypass[y_op->cvt.alu_cvt.enable] <<
   656						SHIFT(SDP_D_DP_EW_ALU_CFG_0,
   657						EW_ALU_CVT_BYPASS));
   658				sdp_reg_write(D_DP_EW_ALU_CFG, reg);
   659	
   660				if (y_op->mode == SDP_OP_PER_LAYER) {
   661					sdp_reg_write(D_DP_EW_ALU_SRC_VALUE,
   662							y_op->alu_operand);
   663				} else {
   664					sdp_reg_write(D_DP_EW_ALU_CVT_OFFSET_VALUE,
   665							y_op->cvt.alu_cvt.offset);
   666					sdp_reg_write(D_DP_EW_ALU_CVT_SCALE_VALUE,
   667							y_op->cvt.alu_cvt.scale);
   668					sdp_reg_write(D_DP_EW_ALU_CVT_TRUNCATE_VALUE,
   669							y_op->cvt.alu_cvt.truncate);
   670				}
   671			}
   672	
   673			if (y_op->type == SDP_OP_MUL || y_op->type == SDP_OP_BOTH) {
   674				reg = (map_alu_src[y_op->mode == SDP_OP_PER_LAYER] <<
   675						SHIFT(SDP_D_DP_EW_MUL_CFG_0,
   676						EW_MUL_SRC)) |
   677					(map_bypass[y_op->cvt.mul_cvt.enable] <<
   678						SHIFT(SDP_D_DP_EW_MUL_CFG_0,
   679						EW_MUL_CVT_BYPASS));
   680				sdp_reg_write(D_DP_EW_MUL_CFG, reg);
   681	
   682				if (y_op->mode == SDP_OP_PER_LAYER) {
   683					sdp_reg_write(D_DP_EW_MUL_SRC_VALUE,
   684							y_op->mul_operand);
   685				} else {
   686					sdp_reg_write(D_DP_EW_MUL_CVT_OFFSET_VALUE,
   687							y_op->cvt.mul_cvt.offset);
   688					sdp_reg_write(D_DP_EW_MUL_CVT_SCALE_VALUE,
   689							y_op->cvt.mul_cvt.scale);
   690					sdp_reg_write(D_DP_EW_MUL_CVT_TRUNCATE_VALUE,
   691							y_op->cvt.mul_cvt.truncate);
   692				}
   693			}
   694	
   695			sdp_reg_write(D_DP_EW_TRUNCATE_VALUE, y_op->truncate);
   696		}
   697	
   698		reg = (map_fly[sdp_surface->src_data.type == DLA_MEM_HW] <<
   699				SHIFT(SDP_D_FEATURE_MODE_CFG_0,
   700				FLYING_MODE)) |
   701			(map_dst[sdp_surface->dst_data.type == DLA_MEM_HW] <<
   702				SHIFT(SDP_D_FEATURE_MODE_CFG_0,
   703				OUTPUT_DST)) |
   704			(map_wg[sdp_op->conv_mode == CONV_MODE_WINOGRAD] <<
   705				SHIFT(SDP_D_FEATURE_MODE_CFG_0,
   706				WINOGRAD)) |
   707			((sdp_op->batch_num - 1) <<
   708				SHIFT(SDP_D_FEATURE_MODE_CFG_0,
   709				BATCH_NUMBER));
   710		sdp_reg_write(D_FEATURE_MODE_CFG, reg);
   711		sdp_reg_write(D_DST_DMA_CFG,
   712				map_ram_type[sdp_surface->dst_data.type]);
   713		if (sdp_op->batch_num > 1)
   714			sdp_reg_write(D_DST_BATCH_STRIDE, sdp_op->batch_stride);
   715	
   716		reg =
   717		(map_proc_precision[sdp_op->dst_precision][sdp_op->src_precision] <<
   718				SHIFT(SDP_D_DATA_FORMAT_0,
   719				PROC_PRECISION)) |
   720			(map_precision[sdp_op->dst_precision] <<
   721				SHIFT(SDP_D_DATA_FORMAT_0,
   722				OUT_PRECISION));
   723		sdp_reg_write(D_DATA_FORMAT, reg);
   724		sdp_reg_write(D_CVT_OFFSET, sdp_op->out_cvt.offset);
   725		sdp_reg_write(D_CVT_SCALE, sdp_op->out_cvt.scale);
   726		sdp_reg_write(D_CVT_SHIFT, sdp_op->out_cvt.truncate);
   727	
   728	exit:
   729		dla_trace("Exit: %s", __func__);
   730		RETURN(ret);
   731	}
   732	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
