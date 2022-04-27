Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7E7511E8F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241757AbiD0QHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 12:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241587AbiD0QGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 12:06:53 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8293BAD111
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 09:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651075381; x=1682611381;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rXX+rT71J5egDkFCr0XNgCNM2Ip7kcs7C+TCy0oaa2o=;
  b=FffLmXJs/5qFZRNJUdkuoIxA3oti9hWheD7AVoggIYYcGN1IWWPUVk9j
   51LkYK9quVzsk6nKPTUVb4gLK5WtpwWgytZNsUBDlM5uIEEqGmY8U/MsM
   FU0/i7EDJkg/RtLSB1UfkX13fASHil5AEGP5nN+mj4ilUvCVmKRAkqiii
   FflY+5PA7hwUzm2VxPsr8S1L4RpoeWBBZE2YSDxZCd5UUeNUbI0RpOn2c
   t3KXSnGydsqNuVMMWEZ32MhtGRADIZnQnYlQ3OwRvLW1q2zv+5Jpx4A57
   iuW7ZXhQbBl2+FOj5EJanYTmrLKpIZTIuY50fPSRkCCg09WnzAbmskAIy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="253360575"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="253360575"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:56:39 -0700
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="559008157"
Received: from dktowns1-mobl2.amr.corp.intel.com (HELO [10.209.20.44]) ([10.209.20.44])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 08:56:34 -0700
Message-ID: <7213fec3-6844-6913-b63e-2be8fc6df626@linux.intel.com>
Date:   Wed, 27 Apr 2022 10:39:15 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.5.0
Subject: Re: [PATCH v2] ASoC: SOF: mediatek: Fix allyesconfig build error
Content-Language: en-US
To:     Tinghan Shen <tinghan.shen@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yaochun Hung <yc.hung@mediatek.com>,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Cc:     sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220427071030.10172-1-tinghan.shen@mediatek.com>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20220427071030.10172-1-tinghan.shen@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/22 02:10, Tinghan Shen wrote:
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o:(.opd+0x18): multiple
> definition of `adsp_clock_on';
> sound/soc/sof/mediatek/mt8195/mt8195-clk.o:(.opd+0x60): first defined
> here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o: in function
> `.adsp_clock_on':
> 
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o:(.opd+0x30): multiple
> definition of `adsp_clock_off';
> sound/soc/sof/mediatek/mt8195/mt8195-clk.o:(.opd+0x78): first defined
> here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-clk.o: in function
> `.adsp_clock_off':
> 
> ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o:(.opd+0x0): multiple
> definition of `sof_hifixdsp_boot_sequence';
> sound/soc/sof/mediatek/mt8195/mt8195-loader.o:(.opd+0x0): first defined
> here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o: in function
> `.sof_hifixdsp_boot_sequence':
> 
> ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o:(.opd+0x18): multiple
> definition of `sof_hifixdsp_shutdown';
>  sound/soc/sof/mediatek/mt8195/mt8195-loader.o:(.opd+0x18): first defined
> here
> ld: sound/soc/sof/mediatek/mt8186/mt8186-loader.o: in function
> `.sof_hifixdsp_shutdown':
> 
> Fixes: 570c14dc92d5 ("ASoC: SOF: mediatek: Add mt8186 sof fw loader and
> dsp ops")
> Fixes: 210b3ab932f7 ("ASoC: SOF: mediatek: Add mt8186 dsp clock support")
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> ---
> 
> Changes since v1:
> Rebase on Mark's for-next and update "Fixes" commit id
> 
> ---
>  sound/soc/sof/mediatek/mt8186/mt8186-clk.c    |  4 ++--
>  sound/soc/sof/mediatek/mt8186/mt8186-clk.h    |  4 ++--
>  sound/soc/sof/mediatek/mt8186/mt8186-loader.c |  4 ++--
>  sound/soc/sof/mediatek/mt8186/mt8186.c        | 18 +++++++++---------
>  sound/soc/sof/mediatek/mt8186/mt8186.h        |  4 ++--
>  5 files changed, 17 insertions(+), 17 deletions(-)
