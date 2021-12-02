Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315C646623A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357295AbhLBLZl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346343AbhLBLZi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:25:38 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAABC061758
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 03:22:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id u1so58863585wru.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 03:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=57MihNmUyq2yL5Hp/EvWIEoULb+nvWcaJPe8Tm/kK3I=;
        b=j/lo7Y+8i3x/bYaN1cp6hiulf75jS1A+Lk0q6kayJ4J8UCI1s8URhPTKaZssoIBl6V
         2NfAp26ve0kg29/NBBarRV9zhSNVKkoEfOLiP20FJsF6t7HArfrUhpSFtzww4Y+9L6v1
         rXlBZpu85XURN3J0ZOD5R2WrsffY9LsVZiyE7SBy/6OjCSYm5SoQGzQeRuiio3ATKt6q
         13VrrojWhA7jXNuPGAT3c4wxaP0frleUZYI0fbZyDkEknjAgh8xAOx76ft5QMVHgc7hN
         8w68sya6W8sovRSW1JKTidfgaWguTV6S1pUTWVZRP2vqVkrNSXUkGI1FpJzJPIFNdaxd
         dPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=57MihNmUyq2yL5Hp/EvWIEoULb+nvWcaJPe8Tm/kK3I=;
        b=jDs9/EWh1hePBBOsGXdhtHM2OADkdZtvJWMoAq/UyB7MfGP4RlxMHe3UFrvwMiJWPE
         ficVcJ/d/J1ixWgvT0gkC31NC1w5+yZ6ZGW4/5sGch3UJ0z4upKVjXZf6WTpZMfY2nf3
         Is3vxDTpnxSGI+f6ZivX46e2TvAH+3rtiP32DgG3KT2b//1VSX1F0+EuoB+fqNI9LPs6
         rKvZmsR/M6eJdghhPSXk8jkHSl0i+A6xqyJfKBp6+i73W2IeWPdFJvHpTVFmvFlxDPsi
         TgfcoaOHRhbFuZpo54of98Vmha0ElC7OnmeuZSNYGygDBIF8lgm2PvXEFoAD4cCidECE
         4s3A==
X-Gm-Message-State: AOAM531RTeJEkU24PWuPwt0Aoa0ajphMg/37Vr47N5O/z/sESegYXW6b
        T15cE+nTP1oUvRQa3qm/QyOq7g==
X-Google-Smtp-Source: ABdhPJzv2sMtPSd0XDLh5Macj8qITjActzhDy+HoOIouRPrsCxZNACCQB+UrNGU00jKFXN2yn5bV4w==
X-Received: by 2002:adf:b35d:: with SMTP id k29mr13179787wrd.466.1638444134961;
        Thu, 02 Dec 2021 03:22:14 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id z14sm2337734wrp.70.2021.12.02.03.22.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 03:22:14 -0800 (PST)
Subject: Re: [PATCH v6 03/10] ASoC: qcom: Add register definition for codec
 rddma and wrdma
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1637928282-2819-1-git-send-email-srivasam@codeaurora.org>
 <1637928282-2819-4-git-send-email-srivasam@codeaurora.org>
 <3bb4aea6-2f47-8b6b-e7a9-1518d478e32d@linaro.org>
 <efb98b22-e56a-d193-6ca0-e950dc3c4a42@codeaurora.org>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <928c419e-ae92-38bd-3974-e81efbe301ff@linaro.org>
Date:   Thu, 2 Dec 2021 11:22:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <efb98b22-e56a-d193-6ca0-e950dc3c4a42@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2021 10:55, Srinivasa Rao Mandadapu wrote:
>>>   +/* LPAIF RXTX IRQ */
>>> +#define LPAIF_RXTX_IRQ_REG_ADDR(v, addr, port, dai_id) \
>>> +        ((dai_id == LPASS_CDC_DMA_RX0 || dai_id == 
>>> LPASS_CDC_DMA_TX3) ? \
>>> +        (v->rxtx_irq_reg_base + (addr) + v->rxtx_irq_reg_stride * 
>>> (port)) : \
>>> +        (v->va_irq_reg_base + (addr) + v->va_irq_reg_stride * (port)))
>>> +
>>> +#define LPAIF_RXTX_IRQEN_REG(v, port, dai_id) 
>>> LPAIF_RXTX_IRQ_REG_ADDR(v, 0x0, port, dai_id)
>>> +#define LPAIF_RXTX_IRQSTAT_REG(v, port, dai_id) 
>>> LPAIF_RXTX_IRQ_REG_ADDR(v, 0x4, port, dai_id)
>>> +#define LPAIF_RXTX_IRQCLEAR_REG(v, port, dai_id) 
>>> LPAIF_RXTX_IRQ_REG_ADDR(v, 0xC, port, dai_id)
>>> +
>>
>> How about doing like this:
>>
>>
>> /* LPAIF RXTX IRQ */
>> #define LPAIF_RXTX_IRQ_REG_ADDR(v, addr, port) \
>>         (v->rxtx_irq_reg_base + (addr) + v->rxtx_irq_reg_stride * (port))
>>
>> #define LPAIF_RXTX_IRQEN_REG(v, port, dai_id) 
>> LPAIF_RXTX_IRQ_REG_ADDR(v, 0x0, port)
>> #define LPAIF_RXTX_IRQSTAT_REG(v, port, dai_id) 
>> LPAIF_RXTX_IRQ_REG_ADDR(v, 0x4, port)
>> #define LPAIF_RXTX_IRQCLEAR_REG(v, port, dai_id) 
>> LPAIF_RXTX_IRQ_REG_ADDR(v, 0xC, port)
>>
>> /* LPAIF VA IRQ */
>> #define LPAIF_VA_IRQ_REG_ADDR(v, addr, port) \
>>         (v->va_irq_reg_base + (addr) + v->va_irq_reg_stride * (port))
>>
>> #define LPAIF_VA_IRQEN_REG(v, port, dai_id) LPAIF_VA_IRQ_REG_ADDR(v, 
>> 0x0, port)
>> #define LPAIF_VA_IRQSTAT_REG(v, port, dai_id) LPAIF_VA_IRQ_REG_ADDR(v, 
>> 0x4, port)
>> #define LPAIF_VA_IRQCLEAR_REG(v, port, dai_id) 
>> LPAIF_VA_IRQ_REG_ADDR(v, 0xC, port)
>>
> With this we are seeing number macros increasing. How about handling 

Its okay to add new macros, this makes them much clear to the reader and 
inline with rest of the macros in the file.


--srini
> like below.
>> lpass.h:
> 
> static inline bool is_rxtx_cdc_dma_port(int dai_id)
> {
> 
>      switch (dai_id) {
>          case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
>          case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
>              return true;
>          default:
>              return false;
>        }
> }
> 
> 
> Usage:
> 
> #define LPAIF_RXTX_IRQ_REG_ADDR(v, addr, port, dai_id) \
> is_rxtx_cdc_dma_port(dai_id) ? \
> (v->rxtx_irq_reg_base + (addr) + v->rxtx_irq_reg_stride * (port)) : \
> (v->va_irq_reg_base + (addr) + v->va_irq_reg_stride * (port))
> 
> 
