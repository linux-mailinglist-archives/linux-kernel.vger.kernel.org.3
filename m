Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 689074F9053
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiDHIFA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:05:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230336AbiDHIEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:04:54 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D0447041
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 01:02:51 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id bq8so15666307ejb.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 01:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=R9Md63+7fr/H3jBSeDn6jW2GcrFtPS6wpqfkErlWzYs=;
        b=wXNxS+sXTeFjGclx/evzx327C3xVpMS4QBc7+yw9rYbeVDC6oSkDRn2RkOVSaDK1TG
         8oUK0NAPDSS9UkzMn/f/WFIEszV7CK8uaO0JW/+RpG6BS1CbB8x9HdS0iRJanDEOGIp9
         2TT8iErw0dgR2GNxrXRIM1iJPzExQIlNw4C5D3OGi11+813vRdDoUgQAMOv6P6KC3e/r
         MdwjRfX6NvAkIZbttaCDTBtxgD+zAN9AcqJRFUiindDTpv+99wYVETna4uuzl5aflirm
         QWep79zBfnF+J+YcL7EPP4o8guH7DcN6oJlpXVBbr2EhX8DXWyvxHSvam/gu5XdKE941
         RVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=R9Md63+7fr/H3jBSeDn6jW2GcrFtPS6wpqfkErlWzYs=;
        b=FogyASPxAoCiFccEcSCmG/OEEFIOCRFFdju/EXbrnnlsJV5AUlueTu1MEtTVn1F6No
         0kdimR1N+kkt4BJARjV2TjKBKXwty3uSq2XjdRZp5T8x8Bf4HfVSfmkrVMcuW0RDUgDK
         iWw1VKgim9iJufPIrrym405gO0V/A2bOvtgd4jNlKzXE6p0jKMikWJBBVO06mj5FEjlZ
         qFZxLuQIcB6w2r+d9hy0A8v2LOB+ORawLFb2qKMXeCrRHmEDVQbBgqbV4wOaqQdyx4NK
         kUTPOd9jRQuA5BRXBy+JjYNzS7X0rIH4bX0YhsEvCP/wGOTK5PF5mqwDyCe+BkuWRzLw
         ek1w==
X-Gm-Message-State: AOAM530QTpa46U/N3dRN4fJ7m7grdSn+w/PsN0K9zr0s60BgCRRvW5RV
        Dgd8BV76GCvvh5Snr93wAdBMIA==
X-Google-Smtp-Source: ABdhPJw2gfzBuf2XdCtgNaMTM0ghNsz5J1dYtRJ4Ror0ozVjlCbuufkcCCmi2st+vP5tn+jNhrRFWw==
X-Received: by 2002:a17:907:1c0c:b0:6e0:9b15:29d5 with SMTP id nc12-20020a1709071c0c00b006e09b1529d5mr17347893ejc.416.1649404969626;
        Fri, 08 Apr 2022 01:02:49 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id d7-20020a170906174700b006e80a7e3111sm3826217eje.17.2022.04.08.01.02.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 01:02:49 -0700 (PDT)
Message-ID: <d3cd6d0c-26b7-c870-ee30-361ef4e11f35@linaro.org>
Date:   Fri, 8 Apr 2022 10:02:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 3/4] clocksource/drivers/exynos_mct: Support
 local-timers property
Content-Language: en-US
To:     Vincent Whitchurch <vincent.whitchurch@axis.com>,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     kernel@axis.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
        devicetree@vger.kernel.org, robh+dt@kernel.org
References: <20220407074432.424578-1-vincent.whitchurch@axis.com>
 <20220407074432.424578-4-vincent.whitchurch@axis.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220407074432.424578-4-vincent.whitchurch@axis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 09:44, Vincent Whitchurch wrote:
> If the device tree indicates that the hardware requires that the
> processor only use certain local timers, respect that.
> 
> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
> 
> Notes:
>     v3:
>     - Use array in devicetree
>     - Remove addition of global variable
>     - Split out FRC sharing changes
> 
>  drivers/clocksource/exynos_mct.c | 51 ++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
> index 12023831dedf..4093a71ff618 100644
> --- a/drivers/clocksource/exynos_mct.c
> +++ b/drivers/clocksource/exynos_mct.c
> @@ -33,7 +33,7 @@
>  #define EXYNOS4_MCT_G_INT_ENB		EXYNOS4_MCTREG(0x248)
>  #define EXYNOS4_MCT_G_WSTAT		EXYNOS4_MCTREG(0x24C)
>  #define _EXYNOS4_MCT_L_BASE		EXYNOS4_MCTREG(0x300)
> -#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * x))
> +#define EXYNOS4_MCT_L_BASE(x)		(_EXYNOS4_MCT_L_BASE + (0x100 * (x)))
>  #define EXYNOS4_MCT_L_MASK		(0xffffff00)
>  
>  #define MCT_L_TCNTB_OFFSET		(0x00)
> @@ -66,6 +66,8 @@
>  #define MCT_L0_IRQ	4
>  /* Max number of IRQ as per DT binding document */
>  #define MCT_NR_IRQS	20
> +/* Max number of local timers */
> +#define MCT_NR_LOCAL	(MCT_NR_IRQS - MCT_L0_IRQ)
>  
>  enum {
>  	MCT_INT_SPI,
> @@ -456,7 +458,6 @@ static int exynos4_mct_starting_cpu(unsigned int cpu)
>  		per_cpu_ptr(&percpu_mct_tick, cpu);
>  	struct clock_event_device *evt = &mevt->evt;
>  
> -	mevt->base = EXYNOS4_MCT_L_BASE(cpu);
>  	snprintf(mevt->name, sizeof(mevt->name), "mct_tick%d", cpu);
>  
>  	evt->name = mevt->name;
> @@ -528,7 +529,9 @@ static int __init exynos4_timer_resources(struct device_node *np)
>  }
>  

Document the arguments, especially focusing on the keys and the contents
of local_idx. The code is getting to a state with 3 or 4 variables
having similar meaning (IRQ number, local IRQ number, local IRQ index).

>  static int __init exynos4_timer_interrupts(struct device_node *np,
> -					   unsigned int int_type)
> +					   unsigned int int_type,
> +					   u32 *local_idx,

const u32 *

> +					   size_t nr_local)
>  {
>  	int nr_irqs, i, err, cpu;
>  
> @@ -561,13 +564,19 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
>  	} else {
>  		for_each_possible_cpu(cpu) {
>  			int mct_irq;
> +			unsigned int irqidx;

irq_idx

>  			struct mct_clock_event_device *pcpu_mevt =
>  				per_cpu_ptr(&percpu_mct_tick, cpu);
>  
> +			if (cpu >= nr_local)
> +				break;
> +
> +			irqidx = MCT_L0_IRQ + local_idx[cpu];
> +
>  			pcpu_mevt->evt.irq = -1;
> -			if (MCT_L0_IRQ + cpu >= ARRAY_SIZE(mct_irqs))
> +			if (irqidx >= ARRAY_SIZE(mct_irqs))
>  				break;
> -			mct_irq = mct_irqs[MCT_L0_IRQ + cpu];
> +			mct_irq = mct_irqs[irqidx];
>  
>  			irq_set_status_flags(mct_irq, IRQ_NOAUTOEN);
>  			if (request_irq(mct_irq,
> @@ -583,6 +592,15 @@ static int __init exynos4_timer_interrupts(struct device_node *np,
>  		}
>  	}
>  
> +	for_each_possible_cpu(cpu) {
> +		struct mct_clock_event_device *mevt = per_cpu_ptr(&percpu_mct_tick, cpu);
> +
> +		if (cpu >= nr_local)

It looks like an error condition, so this should not be handled silently
because later base==0 will be used. Probably old code has similar problem...


Best regards,
Krzysztof
