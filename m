Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9A6053396B
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbiEYJHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiEYJFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:05:18 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E76A8DDC8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:03:34 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id a23so23721550ljd.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZtbcQaswtU2dqjmT14F4zADH8LUSwksU8SwBMe4IBPA=;
        b=opkz2jp/Z44y2hsPU1RrbzF5zxhN14QmhBsqNuW9Lf6TfUZsUmqQjM8b3sLjfIWRrO
         hNcN75Hkau6oHoZK0HCfB+dwqg5e7VHB2G+CDaHopzaKbtDzoi6Ksp8SZT6t3G8fZcWE
         F2gRZ3alg2G91mCAFdZ3U06Ne1VnkFOgAYAD485uiVB9MW3WJcSflFWaGYCu+RclKp9p
         afSZ7gzuVH1M5RS+7r0r7dK67RjSSizBh8sAX+PROnsunxjrC22p7bhMWzYA9NGZaF84
         zSThapjW/b7HyHtapuAXvkNbY/BNkN0LM62/3XAhQmH8nUvX/d/DnS6jJot3V3eN1LXg
         u95w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZtbcQaswtU2dqjmT14F4zADH8LUSwksU8SwBMe4IBPA=;
        b=blmXRsRN5SSo4cEeEIElXFuFYVFBSwpbZQ+xwwhYktWETZ7heElWPKpI4g6ANoXwoJ
         7u8/WGKzFxPnNJlbvGRtk2E9syE1abj5Q2iP1pYpj402jboWG8byHAPgwfcglXGbnUN7
         8+ntt7QIX9muGmct9/cN6hb8WnR1tGnUQH0g7bbpDVRPG84r1LdKhbQHH7JfxEbv3IhR
         mWiQAstS/iDZW+juihRZZAR7hTD8vnkeiGpRBIHZpBV7H7LSwAeTIoCx9BAPxH4QwYHT
         KRvc8u2ftywP7K3KYDNcb8Z7xVN2v0Ldm83x7Flfm7rdsPxqj/ZU85QPXn4JYbKhfXWe
         KJvg==
X-Gm-Message-State: AOAM533xRFKAPpC1e3G2tcw9/pkkCrlllpErW6dJnq23xLPhQTraKPI5
        FuNqWmAXtLC1QwdSgIQvFr04jg==
X-Google-Smtp-Source: ABdhPJxF0Rcjya/efDJd558P1BUzVdJ3r8QP+mXxGK4ViSdnITnaRGcwqag+tWvCjGDLX7COUChMWQ==
X-Received: by 2002:a2e:a447:0:b0:249:5d85:aa54 with SMTP id v7-20020a2ea447000000b002495d85aa54mr18397175ljn.528.1653469407942;
        Wed, 25 May 2022 02:03:27 -0700 (PDT)
Received: from [192.168.1.102] (88-112-131-206.elisa-laajakaista.fi. [88.112.131.206])
        by smtp.gmail.com with ESMTPSA id bd24-20020a05651c169800b00253bd515f88sm2917421ljb.68.2022.05.25.02.03.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 02:03:27 -0700 (PDT)
Message-ID: <899412f2-5ee4-cd32-393f-688fc6351437@linaro.org>
Date:   Wed, 25 May 2022 12:03:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2 1/7] media: camss: ispif: Correctly reset based on the
 VFE ID
Content-Language: en-US
To:     kholk11@gmail.com, Robert Foss <robert.foss@linaro.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, mchehab@kernel.org,
        robh+dt@kernel.org, marijns95@gmail.com, konradybcio@gmail.com,
        martin.botka1@gmail.com, linux-arm-msm@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, todor.too@gmail.com
References: <20201022174706.8813-1-kholk11@gmail.com>
 <20201022174706.8813-2-kholk11@gmail.com>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20201022174706.8813-2-kholk11@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/22/20 20:47, kholk11@gmail.com wrote:
> From: AngeloGioacchino Del Regno <kholk11@gmail.com>
> 
> Resetting the ISPIF VFE0 context is wrong if we are using the VFE1
> for dual-camera or simply because a secondary camera is connected
> to it: in this case the reset will always happen on the VFE0 ctx
> of the ISPIF, which is .. useless.
> 
> Fix this usecase by adding the ISPIF_RST_CMD_1 address and choose
> where to do the (or what to) reset based on the VFE line id.
> 
> Signed-off-by: AngeloGioacchino Del Regno <kholk11@gmail.com>
> Reviewed-by: Robert Foss <robert.foss@linaro.org>
> ---
>   .../media/platform/qcom/camss/camss-ispif.c   | 85 ++++++++++++-------
>   .../media/platform/qcom/camss/camss-ispif.h   |  2 +-
>   2 files changed, 56 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
> index db94cfd6c508..754f0d044c38 100644
> --- a/drivers/media/platform/qcom/camss/camss-ispif.c
> +++ b/drivers/media/platform/qcom/camss/camss-ispif.c
> @@ -26,6 +26,7 @@
>   #define MSM_ISPIF_NAME "msm_ispif"
>   
>   #define ISPIF_RST_CMD_0			0x008
> +#define ISPIF_RST_CMD_1			0x00c
>   #define ISPIF_RST_CMD_0_STROBED_RST_EN		(1 << 0)
>   #define ISPIF_RST_CMD_0_MISC_LOGIC_RST		(1 << 1)
>   #define ISPIF_RST_CMD_0_SW_REG_RST		(1 << 2)
> @@ -179,7 +180,10 @@ static irqreturn_t ispif_isr_8x96(int irq, void *dev)
>   	writel(0x1, ispif->base + ISPIF_IRQ_GLOBAL_CLEAR_CMD);
>   
>   	if ((value0 >> 27) & 0x1)
> -		complete(&ispif->reset_complete);
> +		complete(&ispif->reset_complete[0]);
> +
> +	if ((value3 >> 27) & 0x1)
> +		complete(&ispif->reset_complete[1]);
>   
>   	if (unlikely(value0 & ISPIF_VFE_m_IRQ_STATUS_0_PIX0_OVERFLOW))
>   		dev_err_ratelimited(to_device(ispif), "VFE0 pix0 overflow\n");
> @@ -237,7 +241,7 @@ static irqreturn_t ispif_isr_8x16(int irq, void *dev)
>   	writel(0x1, ispif->base + ISPIF_IRQ_GLOBAL_CLEAR_CMD);
>   
>   	if ((value0 >> 27) & 0x1)
> -		complete(&ispif->reset_complete);
> +		complete(&ispif->reset_complete[0]);
>   
>   	if (unlikely(value0 & ISPIF_VFE_m_IRQ_STATUS_0_PIX0_OVERFLOW))
>   		dev_err_ratelimited(to_device(ispif), "VFE0 pix0 overflow\n");
> @@ -257,33 +261,18 @@ static irqreturn_t ispif_isr_8x16(int irq, void *dev)
>   	return IRQ_HANDLED;
>   }
>   
> -/*
> - * ispif_reset - Trigger reset on ISPIF module and wait to complete
> - * @ispif: ISPIF device
> - *
> - * Return 0 on success or a negative error code otherwise
> - */
> -static int ispif_reset(struct ispif_device *ispif)
> +static int ispif_vfe_reset(struct ispif_device *ispif, u8 vfe_id)
>   {
>   	unsigned long time;
>   	u32 val;
> -	int ret;
> -
> -	ret = camss_pm_domain_on(to_camss(ispif), PM_DOMAIN_VFE0);
> -	if (ret < 0)
> -		return ret;
>   
> -	ret = camss_pm_domain_on(to_camss(ispif), PM_DOMAIN_VFE1);
> -	if (ret < 0)
> -		return ret;
> -
> -	ret = camss_enable_clocks(ispif->nclocks_for_reset,
> -				  ispif->clock_for_reset,
> -				  to_device(ispif));
> -	if (ret < 0)
> -		return ret;
> +	if (vfe_id > (to_camss(ispif)->vfe_num - 1)) {
> +		dev_err(to_device(ispif),
> +			"Error: asked reset for invalid VFE%d\n", vfe_id);
> +		return -ENOENT;
> +	}

I was stumbled upon this "vfe_num" usage, which seems unnecessary...

>   
> -	reinit_completion(&ispif->reset_complete);
> +	reinit_completion(&ispif->reset_complete[vfe_id]);
>   
>   	val = ISPIF_RST_CMD_0_STROBED_RST_EN |
>   		ISPIF_RST_CMD_0_MISC_LOGIC_RST |
> @@ -303,15 +292,50 @@ static int ispif_reset(struct ispif_device *ispif)
>   		ISPIF_RST_CMD_0_RDI_OUTPUT_1_MISR_RST |
>   		ISPIF_RST_CMD_0_RDI_OUTPUT_2_MISR_RST;
>   
> -	writel_relaxed(val, ispif->base + ISPIF_RST_CMD_0);
> +	if (vfe_id == 1)
> +		writel_relaxed(val, ispif->base + ISPIF_RST_CMD_1);
> +	else
> +		writel_relaxed(val, ispif->base + ISPIF_RST_CMD_0);
>   
> -	time = wait_for_completion_timeout(&ispif->reset_complete,
> +	time = wait_for_completion_timeout(&ispif->reset_complete[vfe_id],
>   		msecs_to_jiffies(ISPIF_RESET_TIMEOUT_MS));
>   	if (!time) {
> -		dev_err(to_device(ispif), "ISPIF reset timeout\n");
> -		ret = -EIO;
> +		dev_err(to_device(ispif),
> +			"ISPIF for VFE%d reset timeout\n", vfe_id);
> +		return -EIO;
>   	}
>   
> +	return 0;
> +}
> +
> +/*
> + * ispif_reset - Trigger reset on ISPIF module and wait to complete
> + * @ispif: ISPIF device
> + *
> + * Return 0 on success or a negative error code otherwise
> + */
> +static int ispif_reset(struct ispif_device *ispif, u8 vfe_id)
> +{
> +	int ret;
> +
> +	ret = camss_pm_domain_on(to_camss(ispif), PM_DOMAIN_VFE0);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = camss_pm_domain_on(to_camss(ispif), PM_DOMAIN_VFE1);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = camss_enable_clocks(ispif->nclocks_for_reset,
> +				  ispif->clock_for_reset,
> +				  to_device(ispif));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = ispif_vfe_reset(ispif, vfe_id);
> +	if (ret)
> +		dev_dbg(to_device(ispif), "ISPIF Reset failed\n");
> +
>   	camss_disable_clocks(ispif->nclocks_for_reset, ispif->clock_for_reset);
>   
>   	camss_pm_domain_off(to_camss(ispif), PM_DOMAIN_VFE0);
> @@ -355,7 +379,7 @@ static int ispif_set_power(struct v4l2_subdev *sd, int on)
>   			goto exit;
>   		}
>   
> -		ret = ispif_reset(ispif);
> +		ret = ispif_reset(ispif, line->vfe_id);

But in fact here is an error.

line->vfe_id is never set.

I'm unable to test any fix, since I don't have a correspondent hardware,
but I can write a fix for someone's testing.

--
Best wishes,
Vladimir
