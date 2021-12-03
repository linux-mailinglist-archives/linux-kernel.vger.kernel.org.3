Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04B60467837
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 14:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352218AbhLCNc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 08:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381004AbhLCNcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 08:32:21 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB58C06175D
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:28:57 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso4859427wmr.4
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 05:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tqXHam0hRupjD6BltYgMFP6/XYFAVKhi2uC/+Kd2U74=;
        b=TMU2RrFctLEhFkQ5uvSQoT5fboyfUdITEdWj/RTy/iAKiFgP0Mx6oJZ/US06i4NUVt
         vozav8K7/G6vTSJDvWidyAA3xDfqG+Gh/2SeY8u9Be93nnrdtQ3DRqoFSVEXsSbGm+FT
         yu8AREsjJ6m0tkhN7k1HnhdQEkPn3EFf3T+wzDhYtrslc8exOztsKKCGBwqW8bF0Voe4
         tONMu10B3Xp9Y4tTTY2kxnGnX/fRLmtfq2d9dorUuXu8I3oyoIICo/8cypbREfY9xSe9
         PgwyOKpH6DS8tyfsos7OnEDqvqVpCuldwz1eEHPHt2Sl2taFJKWcdWDtTflNal2pEP2W
         xd4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tqXHam0hRupjD6BltYgMFP6/XYFAVKhi2uC/+Kd2U74=;
        b=2P8SWnb9xok2fEdGxCIFD2VyQ1SVWme1MxQIaxwJUxBbrB+Kft0QCU5iGypOSl8Y5k
         vq+To6q8sSjzXkS1mqFGETA04Q7L0neyPAWc+1QwxoCtBvGBL5WEPlZ3oJ/DjOtwYVCp
         t3ttJxTP2YEJNTd89wcFsLyuoDEGSdqEN+MYtkWVNu7G1aVF2vMbHAunNPV0y7UMidYh
         +Zlz2maBNmC1ynrRUCz8TFWqjuEhqn4Pi9RQtJNRuWcnx9LcMbuMt6N/0tbtX4Q/BF2p
         Kzs6V5TKopC/wB7ya+hUcMRhu6KhHAC2THk6vKhDpQnStnOfkjeROdLlRLTnY3h3QTKx
         3Olw==
X-Gm-Message-State: AOAM533sD/36hblupafmxN4dDRrlaWiaRXKyV8EsZT+Z4qQU33riJkus
        rJNlmNBPod/aPZZA4wdcbEFTpA==
X-Google-Smtp-Source: ABdhPJynoBJpuHzrUIrqvjv4hzac4vAEseOcVa+V0HJn+31KaMg0hMTXgY902lTeJdoz/uYDkvyF1A==
X-Received: by 2002:a05:600c:3b1b:: with SMTP id m27mr15270752wms.125.1638538136031;
        Fri, 03 Dec 2021 05:28:56 -0800 (PST)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id l4sm2569303wrv.94.2021.12.03.05.28.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 05:28:55 -0800 (PST)
Subject: Re: [PATCH v7 03/10] ASoC: qcom: Add register definition for codec
 rddma and wrdma
To:     Srinivasa Rao Mandadapu <srivasam@codeaurora.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, plai@codeaurora.org,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        rohitkr@codeaurora.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Srinivasa Rao Mandadapu <srivasam@codeaurora.org>,
        Venkata Prasad Potturu <potturu@codeaurora.org>
References: <1638459806-27600-1-git-send-email-srivasam@codeaurora.com>
 <1638459806-27600-4-git-send-email-srivasam@codeaurora.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <87df2562-f9c0-188d-601b-d9c896b3719e@linaro.org>
Date:   Fri, 3 Dec 2021 13:28:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <1638459806-27600-4-git-send-email-srivasam@codeaurora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2021 15:43, Srinivasa Rao Mandadapu wrote:
> From: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> 
> This patch adds register definitions for codec read dma and write dma
> lpass interface.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
> Co-developed-by: Venkata Prasad Potturu <potturu@codeaurora.org>
> Signed-off-by: Venkata Prasad Potturu <potturu@codeaurora.org>

Overall the patch LGTM,
but for bisectablity reasons, pleas make sure these macros

is_rxtx_cdc_dma_port()
is_cdc_dma_port()

to be avaiable in this patch.

Once that is fixed you could add my

Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

--srini


> ---
>   sound/soc/qcom/lpass-lpaif-reg.h | 127 +++++++++++++++++++++++++++++++++++++--
>   1 file changed, 121 insertions(+), 6 deletions(-)
> 
> diff --git a/sound/soc/qcom/lpass-lpaif-reg.h b/sound/soc/qcom/lpass-lpaif-reg.h
> index 2eb03ad..6d9d9d1 100644
> --- a/sound/soc/qcom/lpass-lpaif-reg.h
> +++ b/sound/soc/qcom/lpass-lpaif-reg.h
> @@ -74,6 +74,21 @@
>   #define LPAIF_IRQSTAT_REG(v, port)	LPAIF_IRQ_REG_ADDR(v, 0x4, (port))
>   #define LPAIF_IRQCLEAR_REG(v, port)	LPAIF_IRQ_REG_ADDR(v, 0xC, (port))
>   
> +/* LPAIF RXTX IRQ */
> +#define LPAIF_RXTX_IRQ_REG_ADDR(v, addr, port) \
> +		(v->rxtx_irq_reg_base + (addr) + v->rxtx_irq_reg_stride * (port))
> +
> +#define LPAIF_RXTX_IRQEN_REG(v, port) LPAIF_RXTX_IRQ_REG_ADDR(v, 0x0, port)
> +#define LPAIF_RXTX_IRQSTAT_REG(v, port) LPAIF_RXTX_IRQ_REG_ADDR(v, 0x4, port)
> +#define LPAIF_RXTX_IRQCLEAR_REG(v, port) LPAIF_RXTX_IRQ_REG_ADDR(v, 0xC, port)
> +
> +/* LPAIF VA IRQ */
> +#define LPAIF_VA_IRQ_REG_ADDR(v, addr, port) \
> +		(v->va_irq_reg_base + (addr) + v->va_irq_reg_stride * (port))
> +
> +#define LPAIF_VA_IRQEN_REG(v, port) LPAIF_VA_IRQ_REG_ADDR(v, 0x0, port)
> +#define LPAIF_VA_IRQSTAT_REG(v, port) LPAIF_VA_IRQ_REG_ADDR(v, 0x4, port)
> +#define LPAIF_VA_IRQCLEAR_REG(v, port) LPAIF_VA_IRQ_REG_ADDR(v, 0xC, port)
>   
>   #define LPASS_HDMITX_APP_IRQ_REG_ADDR(v, addr)  \
>   	((v->hdmi_irq_reg_base) + (addr))
> @@ -139,12 +154,112 @@
>   		(LPAIF_INTFDMA_REG(v, chan, reg, dai_id)) : \
>   		LPAIF_WRDMA##reg##_REG(v, chan))
>   
> -#define LPAIF_DMACTL_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, CTL, dai_id)
> -#define LPAIF_DMABASE_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, BASE, dai_id)
> -#define	LPAIF_DMABUFF_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, BUFF, dai_id)
> -#define LPAIF_DMACURR_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, CURR, dai_id)
> -#define	LPAIF_DMAPER_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, PER, dai_id)
> -#define	LPAIF_DMAPERCNT_REG(v, chan, dir, dai_id) __LPAIF_DMA_REG(v, chan, dir, PERCNT, dai_id)
> +#define LPAIF_DMACTL_REG(v, chan, dir, dai_id) \
> +	(is_cdc_dma_port(dai_id) ? \
> +	__LPAIF_CDC_DMA_REG(v, chan, dir, CTL, dai_id) : \
> +	__LPAIF_DMA_REG(v, chan, dir, CTL, dai_id))
> +#define LPAIF_DMABASE_REG(v, chan, dir, dai_id) \
> +	(is_cdc_dma_port(dai_id) ? \
> +	__LPAIF_CDC_DMA_REG(v, chan, dir, BASE, dai_id) : \
> +	__LPAIF_DMA_REG(v, chan, dir, BASE, dai_id))
> +#define LPAIF_DMABUFF_REG(v, chan, dir, dai_id) \
> +	(is_cdc_dma_port(dai_id) ? \
> +	__LPAIF_CDC_DMA_REG(v, chan, dir, BUFF, dai_id) : \
> +	__LPAIF_DMA_REG(v, chan, dir, BUFF, dai_id))
> +#define LPAIF_DMACURR_REG(v, chan, dir, dai_id) \
> +	(is_cdc_dma_port(dai_id) ? \
> +	__LPAIF_CDC_DMA_REG(v, chan, dir, CURR, dai_id) : \
> +	__LPAIF_DMA_REG(v, chan, dir, CURR, dai_id))
> +#define LPAIF_DMAPER_REG(v, chan, dir, dai_id)  \
> +	(is_cdc_dma_port(dai_id) ? \
> +	__LPAIF_CDC_DMA_REG(v, chan, dir, PER, dai_id) : \
> +	__LPAIF_DMA_REG(v, chan, dir, PER, dai_id))
> +#define LPAIF_DMAPERCNT_REG(v, chan, dir, dai_id) \
> +	(is_cdc_dma_port(dai_id) ? \
> +	__LPAIF_CDC_DMA_REG(v, chan, dir, PERCNT, dai_id) : \
> +	__LPAIF_DMA_REG(v, chan, dir, PERCNT, dai_id))
> +
> +#define LPAIF_CDC_RDMA_REG_ADDR(v, addr, chan, dai_id) \
> +	(is_rxtx_cdc_dma_port(dai_id) ? \
> +	(v->rxtx_rdma_reg_base + (addr) + v->rxtx_rdma_reg_stride * (chan)) : \
> +	(v->va_rdma_reg_base + (addr) + v->va_rdma_reg_stride * (chan)))
> +
> +#define LPAIF_CDC_RXTX_RDMACTL_REG(v, chan, dai_id) \
> +		LPAIF_CDC_RDMA_REG_ADDR(v, 0x00, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_RDMABASE_REG(v, chan, dai_id) \
> +		LPAIF_CDC_RDMA_REG_ADDR(v, 0x04, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_RDMABUFF_REG(v, chan, dai_id) \
> +		LPAIF_CDC_RDMA_REG_ADDR(v, 0x08, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_RDMACURR_REG(v, chan, dai_id) \
> +		LPAIF_CDC_RDMA_REG_ADDR(v, 0x0C, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_RDMAPER_REG(v, chan, dai_id) \
> +		LPAIF_CDC_RDMA_REG_ADDR(v, 0x10, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_RDMA_INTF_REG(v, chan, dai_id) \
> +	LPAIF_CDC_RDMA_REG_ADDR(v, 0x50, (chan), dai_id)
> +
> +#define LPAIF_CDC_VA_RDMACTL_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x00, (chan), dai_id)
> +#define LPAIF_CDC_VA_RDMABASE_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x04, (chan), dai_id)
> +#define LPAIF_CDC_VA_RDMABUFF_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x08, (chan), dai_id)
> +#define LPAIF_CDC_VA_RDMACURR_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x0C, (chan), dai_id)
> +#define LPAIF_CDC_VA_RDMAPER_REG(v, chan, dai_id) LPAIF_CDC_RDMA_REG_ADDR(v, 0x10, (chan), dai_id)
> +#define LPAIF_CDC_VA_RDMA_INTF_REG(v, chan, dai_id) \
> +	LPAIF_CDC_RDMA_REG_ADDR(v, 0x50, (chan), dai_id)
> +
> +#define LPAIF_CDC_WRDMA_REG_ADDR(v, addr, chan, dai_id) \
> +	(is_rxtx_cdc_dma_port(dai_id) ? \
> +	(v->rxtx_wrdma_reg_base + (addr) + \
> +		v->rxtx_wrdma_reg_stride * (chan - v->rxtx_wrdma_channel_start)) : \
> +	(v->va_wrdma_reg_base + (addr) + \
> +		v->va_wrdma_reg_stride * (chan - v->va_wrdma_channel_start)))
> +
> +#define LPAIF_CDC_RXTX_WRDMACTL_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x00, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_WRDMABASE_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x04, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_WRDMABUFF_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x08, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_WRDMACURR_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x0C, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_WRDMAPER_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x10, (chan), dai_id)
> +#define LPAIF_CDC_RXTX_WRDMA_INTF_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x50, (chan), dai_id)
> +
> +#define LPAIF_CDC_VA_WRDMACTL_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x00, (chan), dai_id)
> +#define LPAIF_CDC_VA_WRDMABASE_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x04, (chan), dai_id)
> +#define LPAIF_CDC_VA_WRDMABUFF_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x08, (chan), dai_id)
> +#define LPAIF_CDC_VA_WRDMACURR_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x0C, (chan), dai_id)
> +#define LPAIF_CDC_VA_WRDMAPER_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x10, (chan), dai_id)
> +#define LPAIF_CDC_VA_WRDMA_INTF_REG(v, chan, dai_id) \
> +	LPAIF_CDC_WRDMA_REG_ADDR(v, 0x50, (chan), dai_id)
> +
> +#define __LPAIF_CDC_RDDMA_REG(v, chan, dir, reg, dai_id) \
> +		(is_rxtx_cdc_dma_port(dai_id) ? LPAIF_CDC_RXTX_RDMA##reg##_REG(v, chan, dai_id) : \
> +			LPAIF_CDC_VA_RDMA##reg##_REG(v, chan, dai_id))
> +
> +#define __LPAIF_CDC_WRDMA_REG(v, chan, dir, reg, dai_id) \
> +		(is_rxtx_cdc_dma_port(dai_id) ? LPAIF_CDC_RXTX_WRDMA##reg##_REG(v, chan, dai_id) : \
> +			LPAIF_CDC_VA_WRDMA##reg##_REG(v, chan, dai_id))
> +
> +#define __LPAIF_CDC_DMA_REG(v, chan, dir, reg, dai_id) \
> +		((dir ==  SNDRV_PCM_STREAM_PLAYBACK) ? \
> +			__LPAIF_CDC_RDDMA_REG(v, chan, dir, reg, dai_id) : \
> +			__LPAIF_CDC_WRDMA_REG(v, chan, dir, reg, dai_id))
> +
> +#define LPAIF_CDC_INTF_REG(v, chan, dir, dai_id) \
> +		((dir ==  SNDRV_PCM_STREAM_PLAYBACK) ? \
> +		LPAIF_CDC_RDMA_INTF_REG(v, chan, dai_id) : \
> +		LPAIF_CDC_WRDMA_INTF_REG(v, chan, dai_id))
> +
> +#define LPAIF_INTF_REG(v, chan, dir, dai_id) \
> +		(is_cdc_dma_port(dai_id) ? \
> +		LPAIF_CDC_INTF_REG(v, chan, dir, dai_id) : \
> +		LPAIF_DMACTL_REG(v, chan, dir, dai_id))
>   
>   #define LPAIF_DMACTL_BURSTEN_SINGLE	0
>   #define LPAIF_DMACTL_BURSTEN_INCR4	1
> 
