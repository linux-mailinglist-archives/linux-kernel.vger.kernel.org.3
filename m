Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADF904FA539
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 07:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239919AbiDIFqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 01:46:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235935AbiDIFqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 01:46:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D6CC2A03EE
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 22:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649483040; x=1681019040;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Q7fuRepbq0MeKwA4M5R50kDQF1rr0rLSCJcelyUeQZg=;
  b=cpLrI93JFvvbAQWIIlJQ2+LyZQHizN0WptMrJ0tiDPY+kPcup1Y0/oJs
   JX1mHEiuG0dKWJ96CnFICwbOhS8CEzm3ADk481yL2yOOqz+QMC7nsx5Vp
   gz4Jfwy/gcyq869PYv+novFjjiGvbyes2WSBzc/xeVrzToFcOwaYx+8sw
   m3QxoxDvuuzQV2wgf9zxPQBJs9CjPZQnnul0ranBKxo56kxE9+O1aMvIj
   aAUkhUQrvpVFkdpMKQM9ATHP281HjUDVSStogHaKXkbIQhYCQ0Yek2hst
   S+GxOK82jOexjPDWZzG/XAafcXOT8ui5TZoD5D2UcWMlmiuZzOEb1sWOX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10311"; a="260607917"
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="260607917"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 22:43:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,247,1643702400"; 
   d="scan'208";a="558097598"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 08 Apr 2022 22:43:57 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nd3t6-0000v5-Rv;
        Sat, 09 Apr 2022 05:43:56 +0000
Date:   Sat, 9 Apr 2022 13:42:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Jaska Uimonen <jaska.uimonen@linux.intel.com>,
        =?iso-8859-1?Q?P=E9ter?= Ujfalusi 
        <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Subject: [jsarha:topic/sof-dev-rebase 157/166]
 sound/soc/sof/ipc4-topology.c:935:19: error: invalid use of undefined type
 'struct nhlt_specific_cfg'
Message-ID: <202204091339.7ykKngBy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/jsarha/linux topic/sof-dev-rebase
head:   3ff7648fec76d20e7c2a7ca996977b9dc888e913
commit: f2d413f094a5d618a34f38db5309a8d374c916de [157/166] ASoC: SOF: ipc4-topology: Add support for SSP/DMIC DAI's
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220409/202204091339.7ykKngBy-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jsarha/linux/commit/f2d413f094a5d618a34f38db5309a8d374c916de
        git remote add jsarha https://github.com/jsarha/linux
        git fetch --no-tags jsarha topic/sof-dev-rebase
        git checkout f2d413f094a5d618a34f38db5309a8d374c916de
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sound/soc/sof/ipc4-topology.c: In function 'snd_sof_get_nhlt_endpoint_data':
>> sound/soc/sof/ipc4-topology.c:935:19: error: invalid use of undefined type 'struct nhlt_specific_cfg'
     935 |         *len = cfg->size >> 2;
         |                   ^~
   sound/soc/sof/ipc4-topology.c:936:26: error: invalid use of undefined type 'struct nhlt_specific_cfg'
     936 |         *dst = (u32 *)cfg->caps;
         |                          ^~


vim +935 sound/soc/sof/ipc4-topology.c

   888	
   889	static int snd_sof_get_nhlt_endpoint_data(struct snd_sof_dev *sdev, struct snd_sof_dai *dai,
   890						  struct snd_pcm_hw_params *params, u32 dai_index,
   891						  u32 linktype, u8 dir, u32 **dst, u32 *len)
   892	{
   893		struct sof_ipc4_fw_data *ipc4_data = sdev->private;
   894		struct nhlt_specific_cfg *cfg;
   895		int sample_rate, channel_count;
   896		int bit_depth, ret;
   897		u32 nhlt_type;
   898	
   899		/* convert to NHLT type */
   900		switch (linktype) {
   901		case SOF_DAI_INTEL_DMIC:
   902			nhlt_type = NHLT_LINK_DMIC;
   903			bit_depth = params_width(params);
   904			channel_count = params_channels(params);
   905			sample_rate = params_rate(params);
   906			break;
   907		case SOF_DAI_INTEL_SSP:
   908			nhlt_type = NHLT_LINK_SSP;
   909			ret = snd_sof_get_hw_config_params(sdev, dai, &sample_rate, &channel_count,
   910							   &bit_depth);
   911			break;
   912		default:
   913			return 0;
   914		}
   915	
   916		if (ret < 0)
   917			return ret;
   918	
   919		dev_dbg(sdev->dev, "%s: dai index %d nhlt type %d direction %d\n",
   920			__func__, dai_index, nhlt_type, dir);
   921	
   922		/* find NHLT blob with matching params */
   923		cfg = intel_nhlt_get_endpoint_blob(sdev->dev, ipc4_data->nhlt, dai_index, nhlt_type,
   924						   bit_depth, bit_depth, channel_count, sample_rate,
   925						   dir, 0);
   926	
   927		if (!cfg) {
   928			dev_err(sdev->dev,
   929				"no matching blob for sample rate: %d sample width: %d channels: %d\n",
   930				sample_rate, bit_depth, channel_count);
   931			return -EINVAL;
   932		}
   933	
   934		/* config length should be in dwords */
 > 935		*len = cfg->size >> 2;
   936		*dst = (u32 *)cfg->caps;
   937	
   938		return 0;
   939	}
   940	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
