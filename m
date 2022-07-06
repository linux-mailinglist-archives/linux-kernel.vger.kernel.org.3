Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54985568F16
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 18:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234016AbiGFQ0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 12:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233058AbiGFQ0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:26:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEBDA26568;
        Wed,  6 Jul 2022 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657124807; x=1688660807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EQWotVkpmU3qx2QXpAetjRuhu8AIHk9LVBDD7s/q2r4=;
  b=kgH1/scOQlDSzJC2Iwb+Hm8BHRJskFzfVC5zPo+szkILqkQrexS4DeBn
   9F8Han1nGPW7H7itw1AzixPfyozruxTdshP5yhf1m6VBBTg1cUQGfVmSj
   RHvYI7cJRxTthV50DnmWV0luANuZvoTJihZAVCapxgajM9q41NLvLfkrV
   36Z4Ubbpg88GJlL1LLen/lNfgwei3cjI4heRIYXGxWuj3xFnn6Q5y3zJY
   WAP5i1PuSJrCC1Mfrn3ocQmFjuWVunzXnmSQZMLTdZhlex1MG4Dyf7YNB
   fo4150LIdGzgc8/QA4xcVtk+IkHhBcnvSWrZn9LdcyDZOOl7bwkKQJFIW
   w==;
X-IronPort-AV: E=Sophos;i="5.92,250,1650956400"; 
   d="scan'208";a="171303288"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Jul 2022 09:26:47 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Jul 2022 09:26:43 -0700
Received: from [10.171.246.77] (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2375.17 via Frontend
 Transport; Wed, 6 Jul 2022 09:26:40 -0700
Message-ID: <e43147cc-1f22-87cc-eae4-ee887fe58eac@microchip.com>
Date:   Wed, 6 Jul 2022 18:26:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v2] Fixes: 1ca81883c557 ("ARM: dts: at91: sama5d2: add
 nodes for I2S controllers")
Content-Language: en-US
To:     <Ryan.Wanner@microchip.com>, <Claudiu.Beznea@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <lgirdwood@gmail.com>,
        <devicetree@vger.kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <robh+dt@kernel.org>, <broonie@kernel.org>,
        <alsa-devel@alsa-project.org>
References: <20220706162144.66831-1-Ryan.Wanner@microchip.com>
From:   Nicolas Ferre <nicolas.ferre@microchip.com>
Organization: microchip
In-Reply-To: <20220706162144.66831-1-Ryan.Wanner@microchip.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

On 06/07/2022 at 18:21, Ryan.Wanner@microchip.com wrote:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Fixed typo in i2s1 node
> 
> Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>

The "Fixes" tag should go there in this section of the email, and not 
replace the subject.

One example of the subject could be:
"[PATCH v2] ARM: dts: at91: sama5d2: fix typo in i2s1 node"

> ---
> Changes since v1:
> 1. Corrected commit

You can place this content about changes...

> ---

Just here, below the "---", so that you don't need to add another "---".

Regards,
   Nicolas

>   arch/arm/boot/dts/sama5d2.dtsi | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 89c71d419f82..659a17fc755c 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -1124,7 +1124,7 @@ AT91_XDMAC_DT_PERID(33))>,
>   				clocks = <&pmc PMC_TYPE_PERIPHERAL 55>, <&pmc PMC_TYPE_GCK 55>;
>   				clock-names = "pclk", "gclk";
>   				assigned-clocks = <&pmc PMC_TYPE_CORE PMC_I2S1_MUX>;
> -				assigned-parrents = <&pmc PMC_TYPE_GCK 55>;
> +				assigned-clock-parents = <&pmc PMC_TYPE_GCK 55>;
>   				status = "disabled";
>   			};
>   


-- 
Nicolas Ferre
