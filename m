Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6914751C1C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 15:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380288AbiEEOC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 10:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbiEEOCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 10:02:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A3C23159;
        Thu,  5 May 2022 06:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1651759125; x=1683295125;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GMVMpKDn0PDDw4iO5jpTyKJm/l58XPckDe3I2ZWI29o=;
  b=KJ8ABJlinMKizBTmRWT257bLB4kloc10qkE5DX6BzPYVkhHUn82IVNzM
   hCu33xi5+qeTwQJXmblefNaowh3Bgjgc6XnAhr6xD+aQp765kh7o7YWOQ
   5QNqRqIbTcEd0gS6FAUWsAAU2NeLPnorGEp+ZmAxDdIFP75LaTwVK4jpS
   r1NVhnwHYx7mtmazNZxcpQpr0j4taaLxBMwRkzfyRHFAJ5GfgpiDkoaqM
   T7Iu2fpu1CftRU/V963NdJnvwQyzviY1uWoZmUPEqmSpMwHucqlsZhBoq
   dhsztjSkm9mRg/UiTJBIjP1njiBv4UJ7+mSfpU+NrK1OmCGXsz11Asvzw
   g==;
X-IronPort-AV: E=Sophos;i="5.91,201,1647327600"; 
   d="scan'208";a="94666318"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 May 2022 06:58:44 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 5 May 2022 06:58:44 -0700
Received: from [10.159.245.112] (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Thu, 5 May 2022 06:58:41 -0700
Message-ID: <d84e0e48-cf35-ae1a-e384-067d361457ba@microchip.com>
Date:   Thu, 5 May 2022 15:58:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 6/6] ARM: configs: at91: sama7_defconfig: add MCHP PDMC
 and DMIC drivers
Content-Language: en-US
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <lars@metafoo.de>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
References: <20220307122202.2251639-1-codrin.ciubotariu@microchip.com>
 <20220307122202.2251639-7-codrin.ciubotariu@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220307122202.2251639-7-codrin.ciubotariu@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2022 at 13:22, Codrin Ciubotariu wrote:
> Enable drivers needed for Microchip's PDMC and PDM microphones.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
> 
> Changes in v2,v3:
>   - none;
> 
>   arch/arm/configs/sama7_defconfig | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/configs/sama7_defconfig b/arch/arm/configs/sama7_defconfig
> index 0368068e04d9..bc29badab890 100644
> --- a/arch/arm/configs/sama7_defconfig
> +++ b/arch/arm/configs/sama7_defconfig
> @@ -138,6 +138,8 @@ CONFIG_SND_SOC_MIKROE_PROTO=m
>   CONFIG_SND_MCHP_SOC_I2S_MCC=y
>   CONFIG_SND_MCHP_SOC_SPDIFTX=y
>   CONFIG_SND_MCHP_SOC_SPDIFRX=y
> +CONFIG_SND_MCHP_SOC_PDMC=y
> +CONFIG_SND_SOC_DMIC=y

I'm fine with that, but I see that some Kconfig entries "select" this 
SND_SOC_DMIC directly (amd, intel, mediatek, stm).
If it's absolutely needed for PDMC to work, what about doing the same as 
it would prevent some broken configurations?

Regards,
   Nicolas

>   CONFIG_SND_SOC_PCM5102A=y
>   CONFIG_SND_SOC_SPDIF=y
>   CONFIG_SND_SIMPLE_CARD=y


-- 
Nicolas Ferre
