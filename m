Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852F657B763
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 15:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234773AbiGTNY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 09:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiGTNY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 09:24:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7444C61F;
        Wed, 20 Jul 2022 06:24:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658323496; x=1689859496;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4gxar5AEPCnR9+FK95tI+w/Lpiv0BWnqimOZ6dlY+h8=;
  b=MHVCXt0rCS4H6gVwgARu1xsy9HFAiXILhrGDGcnGw331lENH6BgCpr4l
   33BuJinX9++vTeVK5eDiaL6qX0/jrssD/2evwPJIEUDjALvdca48KyTOa
   n7A3Ceb9uqQlJlW6AtXoYGmM/Jg8dOYRDsUt6DgVi32h1ZnfN9ECNyA8C
   b5dewrIpTbnIJvp4Iwhwl9EGbK8dkpMkURl8OGwdVcsAGXCSfU70ZYl7F
   iabM/OOaDbCDpPbmPxxRO4BQk3jnNYFn6pCQsWIBnTI9AkJ+7LW0A8OxR
   Ybh1RqrC5Ph4x/ye368RnDtwlI0gjsBqJCA4m3ZyU2JmHn5b9TZfSqDtZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10414"; a="287522273"
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="287522273"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:24:55 -0700
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="573303123"
Received: from tgeorge1-mobl.amr.corp.intel.com (HELO [10.212.79.208]) ([10.212.79.208])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2022 06:24:53 -0700
Message-ID: <8c839963-4244-3e22-3dea-f060603883c1@linux.intel.com>
Date:   Wed, 20 Jul 2022 08:24:52 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] ASoC: SOF: imx: Add i.MX8ULP HW support
Content-Language: en-US
To:     Shengjiu Wang <shengjiu.wang@gmail.com>
Cc:     Shengjiu Wang <shengjiu.wang@nxp.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        peter.ujfalusi@linux.intel.com, yung-chuan.liao@linux.intel.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
References: <1658208367-24376-1-git-send-email-shengjiu.wang@nxp.com>
 <a2fd9907-d098-7a38-c423-aeb167ab6d37@linux.intel.com>
 <CAA+D8AM3xwacUg2C-W-TFB4AHbvqd-4bSqRqeFAsmFKseT0zVA@mail.gmail.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <CAA+D8AM3xwacUg2C-W-TFB4AHbvqd-4bSqRqeFAsmFKseT0zVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/20/22 03:57, Shengjiu Wang wrote:
>     > +static int imx8ulp_resume(struct snd_sof_dev *sdev)
>     > +{
>     > +     struct imx8ulp_priv *priv = (struct imx8ulp_priv
>     *)sdev->pdata->hw_pdata;
>     > +     int i;
>     > +
>     > +     imx8_enable_clocks(sdev, priv->clks);
>     > +
>     > +     for (i = 0; i < DSP_MU_CHAN_NUM; i++)
>     > +             imx_dsp_request_channel(priv->dsp_ipc, i);
>     > +
>     > +     return 0;
> 
>     is the assymetry between suspend and resume intentional? You are missing
>     the update_bit for EXECUTE_BIT?
> 
> 
> Yes, intentional. After resume the firmware is reloaded and  EXECUTE_BIT
> will be updated at trigger DSP start.

That's worthy of a comment to help reviewers, thanks.
