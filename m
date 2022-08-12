Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D10775912DE
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 17:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiHLPVL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 11:21:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbiHLPUv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 11:20:51 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80C1026E4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 08:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660317650; x=1691853650;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tiXzAiAPz+7TJwuTyFperc5ADCgpo1f1RWfH/4D+4XM=;
  b=UZDlsVSbMaW5APAQhIiF+KFDxWHpUgmSYPlNBIp/OlZcUKDJn9DYTIa0
   kh255ISgNJkbGMtVg80D/pIViI2wZPmKccmsPgdkcxiSkLP0TvkmHhou1
   tcQxK6SJPPXXopH1DEqOFaKE6cFPbr9fNXzt6UeFVwJRqrNxyC7ZB7NXu
   eYabLyapb6hRent7NceSmW7YOr391kW4lKv/7sm05Ag8GuYL64zY9b3Lg
   61FXgljtQMf6VWK1nzI82l7KN2JXoOGJjNmpCua33d7fVum8ySjSjk6r6
   6kMN3JwA5koi8CVow9VUL7eVHSWhFF2LuS7WDFEmYI9vbnyl4EQS3yKVS
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="271386119"
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="271386119"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 08:20:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="634672764"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.99.241.73]) ([10.99.241.73])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2022 08:20:33 -0700
Message-ID: <73dceca7-5244-ffa6-6ead-d4de84584b68@linux.intel.com>
Date:   Fri, 12 Aug 2022 17:20:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v8 1/2] ASoC: sunxi: Add Allwinner H6 Digital MIC driver
Content-Language: en-US
To:     Ban Tao <fengzheng923@gmail.com>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev
References: <1660229343-14133-1-git-send-email-fengzheng923@gmail.com>
From:   =?UTF-8?Q?Amadeusz_S=c5=82awi=c5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <1660229343-14133-1-git-send-email-fengzheng923@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/11/2022 4:49 PM, Ban Tao wrote:
> The Allwinner H6 and later SoCs have an DMIC block
> which is capable of capture.
> 
> Signed-off-by: Ban Tao <fengzheng923@gmail.com>
> ---

...

> +
> +#define SUN50I_DMIC_RATES (SNDRV_PCM_RATE_8000_48000)

Seeing supported rates in hw_params callback, you probably want to take 
a look at SNDRV_PCM_RATE_KNOT?

> +#define SUN50I_DMIC_FORMATS (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE)
> +
> +static struct snd_soc_dai_driver sun50i_dmic_dai = {
> +	.capture = {
> +		.channels_min = 1,
> +		.channels_max = 8,
> +		.rates = SUN50I_DMIC_RATES,
> +		.formats = SUN50I_DMIC_FORMATS,
> +		.sig_bits = 21,
> +	},
> +	.probe = sun50i_dmic_soc_dai_probe,
> +	.ops = &sun50i_dmic_dai_ops,
> +	.name = "dmic",
> +};
> +

...

