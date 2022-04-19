Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CAB506795
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 11:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350340AbiDSJWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 05:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349554AbiDSJWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:22:32 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25429114E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:19:49 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so1055545wmq.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 02:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AfuD0adMHdVdGBphmISzdkHuokPa7yMy38/SGYT3mOg=;
        b=ItWrtcCoxUOYpMXnC+OMSnDOHEWg2fruvwm9KfP91sOMKDuseMDDfBTUC0h3GVseB6
         iFJbjKWOOYqLwUo6oIEImV2ToiTAaaB1xls+faQO1R7dMgEsgM5KqfHfUNILYaaq7H1s
         g/ri7FmiNrxRVwU2V0n0NWW/q5w+i4Uvun5tdabAa4kTCDI4PRch90yE21P4RGmoT0Ki
         uLTwkVlM3+KvuWrqXMQqBIgf2pROKy4OrmCyjF+g4YaNqq+ursjTUA+S8IAolrkR0AJU
         D2CT3YBjgnwoJDQaKVRLFf1ChF35VA5Iz35V/ZQpbfVWw/NUAngBf03VTCsvYthgJ8Qb
         3SYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AfuD0adMHdVdGBphmISzdkHuokPa7yMy38/SGYT3mOg=;
        b=CRx1TOixK0il/ik9BkPNnieditQwpoOmy4i79whaKN17wsdcsv76Nn4zO7cb04dSa8
         YGIR7ZzQ474ypxNVzHHj/GV/JCYe4OiQOMf0/BdWJ/ljGWK79tjUAzc/KOpcSmlxrlZr
         jdGHu3DPsq55Jw1+XlHzjAsZ/JWKH+5PlK3h0BMjm/7Yvks4Im31BOufBwT5oFvs5qk1
         kl85KsWWpCSrjvebwHxZeYXbYEtL/vZrFDy55eIFP4DbxFNM4SjCLPJAojq/1OjHbWWm
         ZOUsHkPG6DKdXBci2tFNm+7ZnHJbRfR9sQvv76rPXE+oY1NBFIJrCK3SGejgABH74i+8
         KAdg==
X-Gm-Message-State: AOAM531XtM50fnfxUfipT2Rozb5kWOxZO/o1a62zm0x5H9HzRX7kPKCe
        390eZx5BuwNnMnMpROSsxLd2+g==
X-Google-Smtp-Source: ABdhPJxMtEy5OVKBvXQyiQaQLB+1ZlgvXxNp1br3PfkLvMXCyl08/iacL8tlG4PyVh53cioM9VNxhw==
X-Received: by 2002:a7b:c844:0:b0:38e:7c92:a9e3 with SMTP id c4-20020a7bc844000000b0038e7c92a9e3mr14569718wml.140.1650359987755;
        Tue, 19 Apr 2022 02:19:47 -0700 (PDT)
Received: from [192.168.86.34] (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.googlemail.com with ESMTPSA id o13-20020a05600c4fcd00b00392951086efsm6400282wmq.34.2022.04.19.02.19.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 02:19:47 -0700 (PDT)
Message-ID: <102ad140-dc26-d266-a716-4e22003ec601@linaro.org>
Date:   Tue, 19 Apr 2022 10:19:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ASoC: qcom: SC7280: Update machine driver startup,
 shutdown callbacks
Content-Language: en-US
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        quic_rohkumar@quicinc.com, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, swboyd@chromium.org,
        judyhsiao@chromium.org
Cc:     Venkata Prasad Potturu <quic_potturu@quicinc.com>
References: <1650352619-17370-1-git-send-email-quic_srivasam@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <1650352619-17370-1-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 08:16, Srinivasa Rao Mandadapu wrote:
> Update machine driver startup, shutdown callback functions to support
> codec DMA paths. Without this change, platforms with WCD codec is failing
> to register sound card.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
> Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
> ---
>   sound/soc/qcom/sc7280.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/sound/soc/qcom/sc7280.c b/sound/soc/qcom/sc7280.c
> index 4ef4034..d64df11 100644
> --- a/sound/soc/qcom/sc7280.c
> +++ b/sound/soc/qcom/sc7280.c
> @@ -295,6 +295,10 @@ static void sc7280_snd_shutdown(struct snd_pcm_substream *substream)
>   		break;
>   	case LPASS_DP_RX:
>   		break;
> +	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
> +	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
> +	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
> +		break;
>   	default:
>   		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
>   			cpu_dai->id);

Why not just make sc7280_snd_startup code like this:

static int sc7280_snd_startup(struct snd_pcm_substream *substream)
{
	struct snd_soc_pcm_runtime *rtd = substream->private_data;
	struct snd_soc_dai *cpu_dai = asoc_rtd_to_cpu(rtd, 0);
	int ret = 0;

	switch (cpu_dai->id) {
	case MI2S_PRIMARY:
		ret = sc7280_rt5682_init(rtd);
		break;
	default:
		break;
	}
	return ret;
}

and sc7280_snd_shutdown with something similar

--srini
> @@ -316,6 +320,10 @@ static int sc7280_snd_startup(struct snd_pcm_substream *substream)
>   		break;
>   	case LPASS_DP_RX:
>   		break;
> +	case LPASS_CDC_DMA_RX0 ... LPASS_CDC_DMA_RX9:
> +	case LPASS_CDC_DMA_TX0 ... LPASS_CDC_DMA_TX8:
> +	case LPASS_CDC_DMA_VA_TX0 ... LPASS_CDC_DMA_VA_TX8:
> +		break;
>   	default:
>   		dev_err(rtd->dev, "%s: invalid dai id 0x%x\n", __func__,
>   			cpu_dai->id);
