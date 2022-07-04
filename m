Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1960565922
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbiGDO5v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGDO5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:57:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AA111C13
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656946643; x=1688482643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZKLiAWk+H1XBmiTsrrlG7iFkrk1JyypPAdX3bL8bSF0=;
  b=jl9N+AEZI/zuuWmdoypD/cN+ASvNA4NCKEhHSsh8CEobKJE/gYAPzPzR
   0AnYl2uh/BArTkyV0AhuoVGSoEhX2qa5d/GM0IfBEF5c6WisRwzQaUv36
   Zdc7TkvDkqfO1hZ5vC9FqR1If/Z7UbI6jTjn7jSh22gYdLz5FtQQoJ1YF
   IMRebcTI2B0XnWrwZb1pEWkwCud1qxpogmK+8A1DMo42531oUFnUNX/IN
   Df2dMkNEteOXgOcBTanVYTvii1BS4wojJii/A06pU+woZNfjHQ+L/qeTB
   9Sj5/hc4jjrSaGKFBkdPa8QAbT72hxQcSTAQ9lIXEOc5RlmIPnVTlqjEd
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="283877409"
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="283877409"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:57:22 -0700
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="619320137"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.83]) ([10.99.241.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 07:57:21 -0700
Message-ID: <684b0081-5dc7-73c1-67c0-b707941b7043@linux.intel.com>
Date:   Mon, 4 Jul 2022 16:57:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RESEND V2 2/3] ASoC: amd: add Machine driver for Jadeite
 platform
Content-Language: en-US
To:     Vijendar Mukunda <Vijendar.Mukunda@amd.com>, broonie@kernel.org,
        alsa-devel@alsa-project.org
Cc:     Sunil-kumar.Dommati@amd.com,
        open list <linux-kernel@vger.kernel.org>,
        Basavaraj.Hiregoudar@amd.com, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Alexander.Deucher@amd.com,
        zhuning@everest-semi.com
References: <20220704140837.1215534-1-Vijendar.Mukunda@amd.com>
 <20220704140837.1215534-2-Vijendar.Mukunda@amd.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20220704140837.1215534-2-Vijendar.Mukunda@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/2022 4:08 PM, Vijendar Mukunda wrote:
> Add Machine driver for Jadeite platform which uses ES8336 codec.
> 
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> 
> Changes since v1:
>        - as sysclk is fixed, moved code to startup() callback.
>        - Removed unused macros (ST_PLAT_CLK & ST_ES8336_GPIO_QUIRK) from code.
> ---
>   sound/soc/amd/acp-es8336.c | 324 +++++++++++++++++++++++++++++++++++++
>   1 file changed, 324 insertions(+)
>   create mode 100644 sound/soc/amd/acp-es8336.c
> 
> diff --git a/sound/soc/amd/acp-es8336.c b/sound/soc/amd/acp-es8336.c
> new file mode 100644
> index 000000000000..eec3d57092fa
> --- /dev/null
> +++ b/sound/soc/amd/acp-es8336.c
> @@ -0,0 +1,324 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Machine driver for AMD Stoney platform using ES8336 Codec
> + *
> + * Copyright 2022 Advanced Micro Devices, Inc.
> + */
> +
> +#include <sound/core.h>
> +#include <sound/soc.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/soc-dapm.h>
> +#include <sound/jack.h>
> +#include <linux/gpio.h>
> +#include <linux/device.h>
> +#include <linux/dmi.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/machine.h>
> +#include <linux/i2c.h>
> +#include <linux/input.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +
> +#include "../codecs/es8316.h"

Any reason to include this header? From quick check I see that it only 
defines ES8316_* defines and those don't seem to be used anywhere in 
this driver?

(...)

> +
> +static int st_es8336_remove(struct platform_device *pdev)
> +{
> +	return 0;
> +}

No need to provide .remove handler when it only returns.

