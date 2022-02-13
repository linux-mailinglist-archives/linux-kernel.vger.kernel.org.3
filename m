Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB034B3E6B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 00:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238807AbiBMXfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 18:35:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231166AbiBMXfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 18:35:30 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53006517EA
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 15:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644795320; x=1676331320;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=SIADH+ExKv1/9070AC6ER+h76YxSGez9S2N5vSfs41U=;
  b=MK7UMXkWKMJQ06kdYV9Z+ni1yNZOePJZvbxMsD57AUrYOrhpcPlc9og2
   o/2CS96jFGnjEzWIg6oBPDUZlYVsgaew6zb58DBnQOeJSK9zmWDlo1OYT
   y6gkVA0sxyLNfjQDzotqbyRVimKkgD61ZZHh24jD45blvI1F0H56KBGB4
   dYp00bLQ24LcNEJIuiDEzOuaj5yS9AKjQ6ilcaaoCpN5HJ+Oc3MYzlPF0
   RajP+ftPTmq3GUCkGZIQkxV5iDPxxVKzL1A4SkPR/dn/BCih1HiXCboPc
   RRabF+8OIdVTowB4IoYXBrr8DJQW4JOZZnaDDmIH5wjRrhCj9LxukvJfO
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10257"; a="249929149"
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="249929149"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 15:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,366,1635231600"; 
   d="scan'208";a="634773326"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 13 Feb 2022 15:35:17 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJOOi-0007zv-J9; Sun, 13 Feb 2022 23:35:16 +0000
Date:   Mon, 14 Feb 2022 07:34:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:broonie/sound/for-5.18 33/48]
 sound/soc/sof/compress.c:91:5: error: no previous prototype for
 'sof_compr_open'
Message-ID: <202202140753.sthmNjlK-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-5.18
head:   e7c799e76f070b4ac13498e532574466064ad6a5
commit: 6324cf901e14c6662be508f30485e0f09c54694d [33/48] ASoC: SOF: compr: Add compress ops implementation
config: nios2-randconfig-r011-20220213 (https://download.01.org/0day-ci/archive/20220214/202202140753.sthmNjlK-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/ammarfaizi2/linux-block/commit/6324cf901e14c6662be508f30485e0f09c54694d
        git remote add ammarfaizi2-block https://github.com/ammarfaizi2/linux-block
        git fetch --no-tags ammarfaizi2-block broonie/sound/for-5.18
        git checkout 6324cf901e14c6662be508f30485e0f09c54694d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash sound/soc/sof/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the ammarfaizi2-block/broonie/sound/for-5.18 HEAD e7c799e76f070b4ac13498e532574466064ad6a5 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> sound/soc/sof/compress.c:91:5: error: no previous prototype for 'sof_compr_open' [-Werror=missing-prototypes]
      91 | int sof_compr_open(struct snd_soc_component *component,
         |     ^~~~~~~~~~~~~~
>> sound/soc/sof/compress.c:127:5: error: no previous prototype for 'sof_compr_free' [-Werror=missing-prototypes]
     127 | int sof_compr_free(struct snd_soc_component *component,
         |     ^~~~~~~~~~~~~~
>> sound/soc/sof/compress.c:161:5: error: no previous prototype for 'sof_compr_set_params' [-Werror=missing-prototypes]
     161 | int sof_compr_set_params(struct snd_soc_component *component,
         |     ^~~~~~~~~~~~~~~~~~~~
>> sound/soc/sof/compress.c:224:5: error: no previous prototype for 'sof_compr_get_params' [-Werror=missing-prototypes]
     224 | int sof_compr_get_params(struct snd_soc_component *component,
         |     ^~~~~~~~~~~~~~~~~~~~
>> sound/soc/sof/compress.c:233:5: error: no previous prototype for 'sof_compr_trigger' [-Werror=missing-prototypes]
     233 | int sof_compr_trigger(struct snd_soc_component *component,
         |     ^~~~~~~~~~~~~~~~~
>> sound/soc/sof/compress.c:273:5: error: no previous prototype for 'sof_compr_copy' [-Werror=missing-prototypes]
     273 | int sof_compr_copy(struct snd_soc_component *component,
         |     ^~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/sof_compr_open +91 sound/soc/sof/compress.c

    90	
  > 91	int sof_compr_open(struct snd_soc_component *component,
    92			   struct snd_compr_stream *cstream)
    93	{
    94		struct snd_soc_pcm_runtime *rtd = cstream->private_data;
    95		struct snd_compr_runtime *crtd = cstream->runtime;
    96		struct snd_compr_tstamp *tstamp;
    97		struct snd_sof_pcm *spcm;
    98		int dir;
    99	
   100		tstamp = kzalloc(sizeof(*tstamp), GFP_KERNEL);
   101		if (!tstamp)
   102			return -ENOMEM;
   103	
   104		spcm = snd_sof_find_spcm_dai(component, rtd);
   105		if (!spcm) {
   106			kfree(tstamp);
   107			return -EINVAL;
   108		}
   109	
   110		dir = cstream->direction;
   111	
   112		if (spcm->stream[dir].cstream) {
   113			kfree(tstamp);
   114			return -EBUSY;
   115		}
   116	
   117		spcm->stream[dir].cstream = cstream;
   118		spcm->stream[dir].posn.host_posn = 0;
   119		spcm->stream[dir].posn.dai_posn = 0;
   120		spcm->prepared[dir] = false;
   121	
   122		crtd->private_data = tstamp;
   123	
   124		return 0;
   125	}
   126	
 > 127	int sof_compr_free(struct snd_soc_component *component,
   128			   struct snd_compr_stream *cstream)
   129	{
   130		struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
   131		struct snd_compr_tstamp *tstamp = cstream->runtime->private_data;
   132		struct snd_soc_pcm_runtime *rtd = cstream->private_data;
   133		struct sof_ipc_stream stream;
   134		struct sof_ipc_reply reply;
   135		struct snd_sof_pcm *spcm;
   136		int ret = 0;
   137	
   138		spcm = snd_sof_find_spcm_dai(component, rtd);
   139		if (!spcm)
   140			return -EINVAL;
   141	
   142		stream.hdr.size = sizeof(stream);
   143		stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_FREE;
   144		stream.comp_id = spcm->stream[cstream->direction].comp_id;
   145	
   146		if (spcm->prepared[cstream->direction]) {
   147			ret = sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd,
   148						 &stream, sizeof(stream),
   149						 &reply, sizeof(reply));
   150			if (!ret)
   151				spcm->prepared[cstream->direction] = false;
   152		}
   153	
   154		cancel_work_sync(&spcm->stream[cstream->direction].period_elapsed_work);
   155		spcm->stream[cstream->direction].cstream = NULL;
   156		kfree(tstamp);
   157	
   158		return ret;
   159	}
   160	
 > 161	int sof_compr_set_params(struct snd_soc_component *component,
   162				 struct snd_compr_stream *cstream, struct snd_compr_params *params)
   163	{
   164		struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
   165		struct snd_soc_pcm_runtime *rtd = cstream->private_data;
   166		struct snd_compr_runtime *crtd = cstream->runtime;
   167		struct sof_ipc_pcm_params_reply ipc_params_reply;
   168		struct snd_compr_tstamp *tstamp;
   169		struct sof_ipc_pcm_params pcm;
   170		struct snd_sof_pcm *spcm;
   171		int ret;
   172	
   173		tstamp = crtd->private_data;
   174	
   175		spcm = snd_sof_find_spcm_dai(component, rtd);
   176	
   177		if (!spcm)
   178			return -EINVAL;
   179	
   180		cstream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV_SG;
   181		cstream->dma_buffer.dev.dev = sdev->dev;
   182		ret = snd_compr_malloc_pages(cstream, crtd->buffer_size);
   183		if (ret < 0)
   184			return ret;
   185	
   186		ret = create_page_table(component, cstream, crtd->dma_area, crtd->dma_bytes);
   187		if (ret < 0)
   188			return ret;
   189	
   190		memset(&pcm, 0, sizeof(pcm));
   191	
   192		pcm.params.buffer.pages = PFN_UP(crtd->dma_bytes);
   193		pcm.hdr.size = sizeof(pcm);
   194		pcm.hdr.cmd = SOF_IPC_GLB_STREAM_MSG | SOF_IPC_STREAM_PCM_PARAMS;
   195	
   196		pcm.comp_id = spcm->stream[cstream->direction].comp_id;
   197		pcm.params.hdr.size = sizeof(pcm.params);
   198		pcm.params.buffer.phy_addr = spcm->stream[cstream->direction].page_table.addr;
   199		pcm.params.buffer.size = crtd->dma_bytes;
   200		pcm.params.direction = cstream->direction;
   201		pcm.params.channels = params->codec.ch_out;
   202		pcm.params.rate = params->codec.sample_rate;
   203		pcm.params.buffer_fmt = SOF_IPC_BUFFER_INTERLEAVED;
   204		pcm.params.frame_fmt = SOF_IPC_FRAME_S32_LE;
   205		pcm.params.sample_container_bytes =
   206			snd_pcm_format_physical_width(SNDRV_PCM_FORMAT_S32) >> 3;
   207		pcm.params.host_period_bytes = params->buffer.fragment_size;
   208	
   209		ret = sof_ipc_tx_message(sdev->ipc, pcm.hdr.cmd, &pcm, sizeof(pcm),
   210					 &ipc_params_reply, sizeof(ipc_params_reply));
   211		if (ret < 0) {
   212			dev_err(component->dev, "error ipc failed\n");
   213			return ret;
   214		}
   215	
   216		tstamp->byte_offset = sdev->stream_box.offset + ipc_params_reply.posn_offset;
   217		tstamp->sampling_rate = params->codec.sample_rate;
   218	
   219		spcm->prepared[cstream->direction] = true;
   220	
   221		return 0;
   222	}
   223	
 > 224	int sof_compr_get_params(struct snd_soc_component *component,
   225				 struct snd_compr_stream *cstream, struct snd_codec *params)
   226	{
   227		/* TODO: we don't query the supported codecs for now, if the
   228		 * application asks for an unsupported codec the set_params() will fail.
   229		 */
   230		return 0;
   231	}
   232	
 > 233	int sof_compr_trigger(struct snd_soc_component *component,
   234			      struct snd_compr_stream *cstream, int cmd)
   235	{
   236		struct snd_sof_dev *sdev = snd_soc_component_get_drvdata(component);
   237		struct snd_soc_pcm_runtime *rtd = cstream->private_data;
   238		struct sof_ipc_stream stream;
   239		struct sof_ipc_reply reply;
   240		struct snd_sof_pcm *spcm;
   241	
   242		spcm = snd_sof_find_spcm_dai(component, rtd);
   243		if (!spcm)
   244			return -EINVAL;
   245	
   246		stream.hdr.size = sizeof(stream);
   247		stream.hdr.cmd = SOF_IPC_GLB_STREAM_MSG;
   248		stream.comp_id = spcm->stream[cstream->direction].comp_id;
   249	
   250		switch (cmd) {
   251		case SNDRV_PCM_TRIGGER_START:
   252			stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_START;
   253			break;
   254		case SNDRV_PCM_TRIGGER_STOP:
   255			stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_STOP;
   256			break;
   257		case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
   258			stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_PAUSE;
   259			break;
   260		case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
   261			stream.hdr.cmd |= SOF_IPC_STREAM_TRIG_RELEASE;
   262			break;
   263		default:
   264			dev_err(component->dev, "error: unhandled trigger cmd %d\n", cmd);
   265			break;
   266		}
   267	
   268		return sof_ipc_tx_message(sdev->ipc, stream.hdr.cmd,
   269					  &stream, sizeof(stream),
   270					  &reply, sizeof(reply));
   271	}
   272	
 > 273	int sof_compr_copy(struct snd_soc_component *component,
   274			   struct snd_compr_stream *cstream,
   275			   char __user *buf, size_t count)
   276	{
   277		struct snd_compr_runtime *rtd = cstream->runtime;
   278		unsigned int offset, n;
   279		void *ptr;
   280		int ret;
   281	
   282		if (count > rtd->buffer_size)
   283			count = rtd->buffer_size;
   284	
   285		div_u64_rem(rtd->total_bytes_available, rtd->buffer_size, &offset);
   286		ptr = rtd->dma_area + offset;
   287		n = rtd->buffer_size - offset;
   288	
   289		if (count < n) {
   290			ret = copy_from_user(ptr, buf, count);
   291		} else {
   292			ret = copy_from_user(ptr, buf, n);
   293			ret += copy_from_user(rtd->dma_area, buf + n, count - n);
   294		}
   295	
   296		return count - ret;
   297	}
   298	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
