Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F2F4DC07A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 08:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiCQHyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 03:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCQHyM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 03:54:12 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E7EF5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 00:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647503575; x=1679039575;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1RZ0TiHSkRxRbxcvhlG51/Hh3byR5PJb7XEwK3r3WhY=;
  b=CTp0im4zXpPVcYE3wVnhPXHQSM9rG60o8v1BPqRIaB139IWrbiOJW4eK
   AM6hbjmv5faOi2xMyLt4xP3qXX+eIYxHuTGEPzGgNrqXFc7cRv22Gc+Wt
   1IHNI30n9wiX7fFSriUOcNfTaBXIejwHudQ7e4HQZA5/R5bm2ZwwnMXIL
   gniOxmwZFUdXphCLtKU4HNXWDiND6Fxw0/CIelarFPsNa+SCs0/esP3wU
   b11PbELdfIVXozs7eZb396lN4FJN1E8DvnJ7bVUOqtfO6Tuhsj9LGesPm
   jkvyUXYU1wg30vGj+7b2ZbFwI7eF2yCrEjukAoAK6xb6gG+Q93U03C/W4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256536844"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="256536844"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 00:52:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="646963525"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 17 Mar 2022 00:52:52 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUkwF-000DSQ-88; Thu, 17 Mar 2022 07:52:51 +0000
Date:   Thu, 17 Mar 2022 15:52:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [mingo-tip:sched/headers 2166/2308]
 drivers/media/v4l2-core/v4l2-jpeg.c:598:1: error: type defaults to 'int' in
 declaration of 'EXPORT_SYMBOL_GPL'
Message-ID: <202203171532.HqdLTtES-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git sched/headers
head:   ef90a8d1de7ff54bfd0fcfe6371c20f544b14d6d
commit: e6abc8c3b547dec2b9b7065e586c212dca8b1c7d [2166/2308] headers/deps: modules: Optimize <linux/buildid.h> dependencies, remove <linux/mm_types.h> inclusion
config: sparc64-randconfig-r032-20220317 (https://download.01.org/0day-ci/archive/20220317/202203171532.HqdLTtES-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=e6abc8c3b547dec2b9b7065e586c212dca8b1c7d
        git remote add mingo-tip git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git
        git fetch --no-tags mingo-tip sched/headers
        git checkout e6abc8c3b547dec2b9b7065e586c212dca8b1c7d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc64 SHELL=/bin/bash drivers/media/v4l2-core/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/media/v4l2-core/v4l2-jpeg.c:598:1: warning: data definition has no type or storage class
     598 | EXPORT_SYMBOL_GPL(v4l2_jpeg_parse_header);
         | ^~~~~~~~~~~~~~~~~
>> drivers/media/v4l2-core/v4l2-jpeg.c:598:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
>> drivers/media/v4l2-core/v4l2-jpeg.c:598:1: warning: parameter names (without types) in function declaration
   drivers/media/v4l2-core/v4l2-jpeg.c:617:1: warning: data definition has no type or storage class
     617 | EXPORT_SYMBOL_GPL(v4l2_jpeg_parse_frame_header);
         | ^~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-jpeg.c:617:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
   drivers/media/v4l2-core/v4l2-jpeg.c:617:1: warning: parameter names (without types) in function declaration
   drivers/media/v4l2-core/v4l2-jpeg.c:636:1: warning: data definition has no type or storage class
     636 | EXPORT_SYMBOL_GPL(v4l2_jpeg_parse_scan_header);
         | ^~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-jpeg.c:636:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
   drivers/media/v4l2-core/v4l2-jpeg.c:636:1: warning: parameter names (without types) in function declaration
   drivers/media/v4l2-core/v4l2-jpeg.c:657:1: warning: data definition has no type or storage class
     657 | EXPORT_SYMBOL_GPL(v4l2_jpeg_parse_quantization_tables);
         | ^~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-jpeg.c:657:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
   drivers/media/v4l2-core/v4l2-jpeg.c:657:1: warning: parameter names (without types) in function declaration
   drivers/media/v4l2-core/v4l2-jpeg.c:678:1: warning: data definition has no type or storage class
     678 | EXPORT_SYMBOL_GPL(v4l2_jpeg_parse_huffman_tables);
         | ^~~~~~~~~~~~~~~~~
   drivers/media/v4l2-core/v4l2-jpeg.c:678:1: error: type defaults to 'int' in declaration of 'EXPORT_SYMBOL_GPL' [-Werror=implicit-int]
   drivers/media/v4l2-core/v4l2-jpeg.c:678:1: warning: parameter names (without types) in function declaration
   cc1: some warnings being treated as errors


vim +598 drivers/media/v4l2-core/v4l2-jpeg.c

b8035f7988a82c Mirela Rabulea 2021-03-11  481  
50733b5b9102da Philipp Zabel  2020-03-18  482  /**
a4184b4f99019f Hans Verkuil   2021-03-03  483   * v4l2_jpeg_parse_header - locate marker segments and optionally parse headers
50733b5b9102da Philipp Zabel  2020-03-18  484   * @buf: address of the JPEG buffer, should start with a SOI marker
50733b5b9102da Philipp Zabel  2020-03-18  485   * @len: length of the JPEG buffer
50733b5b9102da Philipp Zabel  2020-03-18  486   * @out: returns marker segment positions and optionally parsed headers
50733b5b9102da Philipp Zabel  2020-03-18  487   *
50733b5b9102da Philipp Zabel  2020-03-18  488   * The out->scan_header pointer must be initialized to NULL or point to a valid
50733b5b9102da Philipp Zabel  2020-03-18  489   * v4l2_jpeg_scan_header structure. The out->huffman_tables and
50733b5b9102da Philipp Zabel  2020-03-18  490   * out->quantization_tables pointers must be initialized to NULL or point to a
50733b5b9102da Philipp Zabel  2020-03-18  491   * valid array of 4 v4l2_jpeg_reference structures each.
50733b5b9102da Philipp Zabel  2020-03-18  492   *
50733b5b9102da Philipp Zabel  2020-03-18  493   * Returns 0 or negative error if parsing failed.
50733b5b9102da Philipp Zabel  2020-03-18  494   */
50733b5b9102da Philipp Zabel  2020-03-18  495  int v4l2_jpeg_parse_header(void *buf, size_t len, struct v4l2_jpeg_header *out)
50733b5b9102da Philipp Zabel  2020-03-18  496  {
50733b5b9102da Philipp Zabel  2020-03-18  497  	struct jpeg_stream stream;
50733b5b9102da Philipp Zabel  2020-03-18  498  	int marker;
50733b5b9102da Philipp Zabel  2020-03-18  499  	int ret = 0;
50733b5b9102da Philipp Zabel  2020-03-18  500  
50733b5b9102da Philipp Zabel  2020-03-18  501  	stream.curr = buf;
50733b5b9102da Philipp Zabel  2020-03-18  502  	stream.end = stream.curr + len;
50733b5b9102da Philipp Zabel  2020-03-18  503  
50733b5b9102da Philipp Zabel  2020-03-18  504  	out->num_dht = 0;
50733b5b9102da Philipp Zabel  2020-03-18  505  	out->num_dqt = 0;
50733b5b9102da Philipp Zabel  2020-03-18  506  
ccbea178db47bf Mirela Rabulea 2021-03-11  507  	/* the first bytes must be SOI, B.2.1 High-level syntax */
ccbea178db47bf Mirela Rabulea 2021-03-11  508  	if (jpeg_get_word_be(&stream) != SOI)
50733b5b9102da Philipp Zabel  2020-03-18  509  		return -EINVAL;
50733b5b9102da Philipp Zabel  2020-03-18  510  
b8035f7988a82c Mirela Rabulea 2021-03-11  511  	/* init value to signal if this marker is not present */
b8035f7988a82c Mirela Rabulea 2021-03-11  512  	out->app14_tf = V4L2_JPEG_APP14_TF_UNKNOWN;
b8035f7988a82c Mirela Rabulea 2021-03-11  513  
50733b5b9102da Philipp Zabel  2020-03-18  514  	/* loop through marker segments */
50733b5b9102da Philipp Zabel  2020-03-18  515  	while ((marker = jpeg_next_marker(&stream)) >= 0) {
50733b5b9102da Philipp Zabel  2020-03-18  516  		switch (marker) {
50733b5b9102da Philipp Zabel  2020-03-18  517  		/* baseline DCT, extended sequential DCT */
50733b5b9102da Philipp Zabel  2020-03-18  518  		case SOF0 ... SOF1:
50733b5b9102da Philipp Zabel  2020-03-18  519  			ret = jpeg_reference_segment(&stream, &out->sof);
50733b5b9102da Philipp Zabel  2020-03-18  520  			if (ret < 0)
50733b5b9102da Philipp Zabel  2020-03-18  521  				return ret;
50733b5b9102da Philipp Zabel  2020-03-18  522  			ret = jpeg_parse_frame_header(&stream, marker,
50733b5b9102da Philipp Zabel  2020-03-18  523  						      &out->frame);
50733b5b9102da Philipp Zabel  2020-03-18  524  			break;
50733b5b9102da Philipp Zabel  2020-03-18  525  		/* progressive, lossless */
50733b5b9102da Philipp Zabel  2020-03-18  526  		case SOF2 ... SOF3:
50733b5b9102da Philipp Zabel  2020-03-18  527  		/* differential coding */
50733b5b9102da Philipp Zabel  2020-03-18  528  		case SOF5 ... SOF7:
50733b5b9102da Philipp Zabel  2020-03-18  529  		/* arithmetic coding */
50733b5b9102da Philipp Zabel  2020-03-18  530  		case SOF9 ... SOF11:
50733b5b9102da Philipp Zabel  2020-03-18  531  		case SOF13 ... SOF15:
50733b5b9102da Philipp Zabel  2020-03-18  532  		case DAC:
50733b5b9102da Philipp Zabel  2020-03-18  533  		case TEM:
50733b5b9102da Philipp Zabel  2020-03-18  534  			return -EINVAL;
50733b5b9102da Philipp Zabel  2020-03-18  535  
50733b5b9102da Philipp Zabel  2020-03-18  536  		case DHT:
50733b5b9102da Philipp Zabel  2020-03-18  537  			ret = jpeg_reference_segment(&stream,
50733b5b9102da Philipp Zabel  2020-03-18  538  					&out->dht[out->num_dht++ % 4]);
50733b5b9102da Philipp Zabel  2020-03-18  539  			if (ret < 0)
50733b5b9102da Philipp Zabel  2020-03-18  540  				return ret;
819f3ea51d476d Mirela Rabulea 2021-03-11  541  			if (!out->huffman_tables) {
819f3ea51d476d Mirela Rabulea 2021-03-11  542  				ret = jpeg_skip_segment(&stream);
819f3ea51d476d Mirela Rabulea 2021-03-11  543  				break;
819f3ea51d476d Mirela Rabulea 2021-03-11  544  			}
50733b5b9102da Philipp Zabel  2020-03-18  545  			ret = jpeg_parse_huffman_tables(&stream,
50733b5b9102da Philipp Zabel  2020-03-18  546  							out->huffman_tables);
50733b5b9102da Philipp Zabel  2020-03-18  547  			break;
50733b5b9102da Philipp Zabel  2020-03-18  548  		case DQT:
50733b5b9102da Philipp Zabel  2020-03-18  549  			ret = jpeg_reference_segment(&stream,
50733b5b9102da Philipp Zabel  2020-03-18  550  					&out->dqt[out->num_dqt++ % 4]);
50733b5b9102da Philipp Zabel  2020-03-18  551  			if (ret < 0)
50733b5b9102da Philipp Zabel  2020-03-18  552  				return ret;
819f3ea51d476d Mirela Rabulea 2021-03-11  553  			if (!out->quantization_tables) {
819f3ea51d476d Mirela Rabulea 2021-03-11  554  				ret = jpeg_skip_segment(&stream);
819f3ea51d476d Mirela Rabulea 2021-03-11  555  				break;
819f3ea51d476d Mirela Rabulea 2021-03-11  556  			}
50733b5b9102da Philipp Zabel  2020-03-18  557  			ret = jpeg_parse_quantization_tables(&stream,
50733b5b9102da Philipp Zabel  2020-03-18  558  					out->frame.precision,
50733b5b9102da Philipp Zabel  2020-03-18  559  					out->quantization_tables);
50733b5b9102da Philipp Zabel  2020-03-18  560  			break;
50733b5b9102da Philipp Zabel  2020-03-18  561  		case DRI:
50733b5b9102da Philipp Zabel  2020-03-18  562  			ret = jpeg_parse_restart_interval(&stream,
50733b5b9102da Philipp Zabel  2020-03-18  563  							&out->restart_interval);
50733b5b9102da Philipp Zabel  2020-03-18  564  			break;
b8035f7988a82c Mirela Rabulea 2021-03-11  565  		case APP14:
b8035f7988a82c Mirela Rabulea 2021-03-11  566  			ret = jpeg_parse_app14_data(&stream,
b8035f7988a82c Mirela Rabulea 2021-03-11  567  						    &out->app14_tf);
b8035f7988a82c Mirela Rabulea 2021-03-11  568  			break;
50733b5b9102da Philipp Zabel  2020-03-18  569  		case SOS:
50733b5b9102da Philipp Zabel  2020-03-18  570  			ret = jpeg_reference_segment(&stream, &out->sos);
50733b5b9102da Philipp Zabel  2020-03-18  571  			if (ret < 0)
50733b5b9102da Philipp Zabel  2020-03-18  572  				return ret;
50733b5b9102da Philipp Zabel  2020-03-18  573  			ret = jpeg_parse_scan_header(&stream, out->scan);
50733b5b9102da Philipp Zabel  2020-03-18  574  			/*
50733b5b9102da Philipp Zabel  2020-03-18  575  			 * stop parsing, the scan header marks the beginning of
50733b5b9102da Philipp Zabel  2020-03-18  576  			 * the entropy coded segment
50733b5b9102da Philipp Zabel  2020-03-18  577  			 */
50733b5b9102da Philipp Zabel  2020-03-18  578  			out->ecs_offset = stream.curr - (u8 *)buf;
50733b5b9102da Philipp Zabel  2020-03-18  579  			return ret;
50733b5b9102da Philipp Zabel  2020-03-18  580  
50733b5b9102da Philipp Zabel  2020-03-18  581  		/* markers without parameters */
50733b5b9102da Philipp Zabel  2020-03-18  582  		case RST0 ... RST7: /* restart */
50733b5b9102da Philipp Zabel  2020-03-18  583  		case SOI: /* start of image */
50733b5b9102da Philipp Zabel  2020-03-18  584  		case EOI: /* end of image */
50733b5b9102da Philipp Zabel  2020-03-18  585  			break;
50733b5b9102da Philipp Zabel  2020-03-18  586  
50733b5b9102da Philipp Zabel  2020-03-18  587  		/* skip unknown or unsupported marker segments */
50733b5b9102da Philipp Zabel  2020-03-18  588  		default:
50733b5b9102da Philipp Zabel  2020-03-18  589  			ret = jpeg_skip_segment(&stream);
50733b5b9102da Philipp Zabel  2020-03-18  590  			break;
50733b5b9102da Philipp Zabel  2020-03-18  591  		}
50733b5b9102da Philipp Zabel  2020-03-18  592  		if (ret < 0)
50733b5b9102da Philipp Zabel  2020-03-18  593  			return ret;
50733b5b9102da Philipp Zabel  2020-03-18  594  	}
50733b5b9102da Philipp Zabel  2020-03-18  595  
50733b5b9102da Philipp Zabel  2020-03-18  596  	return marker;
50733b5b9102da Philipp Zabel  2020-03-18  597  }
50733b5b9102da Philipp Zabel  2020-03-18 @598  EXPORT_SYMBOL_GPL(v4l2_jpeg_parse_header);
50733b5b9102da Philipp Zabel  2020-03-18  599  

:::::: The code at line 598 was first introduced by commit
:::::: 50733b5b9102da5b2415e3497aa89588396e4f20 media: add v4l2 JPEG helpers

:::::: TO: Philipp Zabel <p.zabel@pengutronix.de>
:::::: CC: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
