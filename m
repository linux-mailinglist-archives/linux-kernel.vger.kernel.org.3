Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6164A4B3899
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 00:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiBLXYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 18:24:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiBLXYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 18:24:41 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F675FF08;
        Sat, 12 Feb 2022 15:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644708277; x=1676244277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lQp3ufLwimneT4WugYp2XgpX6NjnaubtrZ0Hin9414M=;
  b=CUOiWJ5zeCfHOllj/TIBiKVUo86V29Mk3bMJ2igojKhxScJ1My1KxTmh
   WZjNB9oXT6WRxm00h7N5sbD4skx96X9tXR+xMkpStScDfoO1k5Z3UW8/A
   mfYLH+xbE6zdQ7dfnYrKxV0eHibIg0QOFfwmNJGhW2IsDgv/09LM5Pzsh
   2Stn/p0BLeeUbS1T/Ecny/Ss1c1k2OixrWE2nAAWFLocjmuH36IIxEh4u
   Hz35KAwtWxFAkLwIy4U4uWJTibSYDKQi8AX8iCcXHJF3A/jzye8DQNI8B
   zKzW9kkjEGxuSjCasvaAAK5MQ+iK2DHKwqp6PL9bLTeIFJgWAX2c41WEN
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="230548832"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="230548832"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 15:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="679829752"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 12 Feb 2022 15:24:32 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJ1km-0006kd-9m; Sat, 12 Feb 2022 23:24:32 +0000
Date:   Sun, 13 Feb 2022 07:24:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     kbuild-all@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [PATCH v11 07/10] ASoC: qcom: Add support for codec dma driver
Message-ID: <202202130736.eUu0rQGL-lkp@intel.com>
References: <1644665093-4695-8-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644665093-4695-8-git-send-email-quic_srivasam@quicinc.com>
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

Hi Srinivasa,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on v5.17-rc3 next-20220211]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Srinivasa-Rao-Mandadapu/Add-support-for-audio-on-SC7280-based-targets/20220212-192806
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: nios2-randconfig-s031-20220213 (https://download.01.org/0day-ci/archive/20220213/202202130736.eUu0rQGL-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/81d86e5446d7b811a902e4834e65730b0fb393f5
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Srinivasa-Rao-Mandadapu/Add-support-for-audio-on-SC7280-based-targets/20220212-192806
        git checkout 81d86e5446d7b811a902e4834e65730b0fb393f5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash sound/soc/qcom/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> sound/soc/qcom/lpass-platform.c:1223:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *dst @@     got void * @@
   sound/soc/qcom/lpass-platform.c:1223:52: sparse:     expected void volatile [noderef] __iomem *dst
   sound/soc/qcom/lpass-platform.c:1223:52: sparse:     got void *
>> sound/soc/qcom/lpass-platform.c:1228:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *src @@     got unsigned char *dma_buf @@
   sound/soc/qcom/lpass-platform.c:1228:56: sparse:     expected void const volatile [noderef] __iomem *src
   sound/soc/qcom/lpass-platform.c:1228:56: sparse:     got unsigned char *dma_buf

vim +1223 sound/soc/qcom/lpass-platform.c

  1209	
  1210	static int lpass_platform_copy(struct snd_soc_component *component,
  1211				       struct snd_pcm_substream *substream, int channel,
  1212				       unsigned long pos, void __user *buf, unsigned long bytes)
  1213	{
  1214		struct snd_pcm_runtime *rt = substream->runtime;
  1215		unsigned int dai_id = component->id;
  1216		int ret = 0;
  1217	
  1218		unsigned char *dma_buf = rt->dma_area + pos +
  1219					channel * (rt->dma_bytes / rt->channels);
  1220	
  1221		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
  1222			if (is_cdc_dma_port(dai_id))
> 1223				ret = copy_from_user_toio((void __force *)dma_buf, buf, bytes);
  1224			else
  1225				ret = copy_from_user((void __force *)dma_buf, buf, bytes);
  1226		} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
  1227			if (is_cdc_dma_port(dai_id))
> 1228				ret = copy_to_user_fromio(buf, dma_buf, bytes);
  1229			else
  1230				ret = copy_to_user(buf, dma_buf, bytes);
  1231		}
  1232	
  1233		return ret;
  1234	}
  1235	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
