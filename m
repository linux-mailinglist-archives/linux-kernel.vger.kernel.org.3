Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81DAA58B837
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 22:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiHFU0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 16:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiHFU03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 16:26:29 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C68AF5B2
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 13:26:28 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id e15so7786426lfs.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Aug 2022 13:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=ROYvf8g259PGwFxDxBtSZpunTSjof4WFaayVaRYHt6s=;
        b=YyIiRHEiDcm4t8olsQ7JXPjWvimPvxqSO4a0uMonk2AWyV0py44U4CnfElvXQ+dsWf
         Em9yY3ngkfhhXLSFEFkE+GAb3bcMKdbZVqgGit+fb/YKczs95IEbJkUOjVs2gF2M0xJh
         gH13ghOjyYKk19oGjQfDyVbncJKgReavpB6espV1Z9R59+jRh6jRykH5iMps4QfDeJ8I
         IE0Qi/Lj/bnstyoLUEsqeEeONd+sm0Xi0qHw96QQIWINbb6D5V6TAcglKgO2rwKbYqWT
         bQig78PJjdibXCv1lIOL3FhmudO0ztA/+RMXAcDepVhluosKKHvQvqSJMxo+usSv2lYO
         YcLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=ROYvf8g259PGwFxDxBtSZpunTSjof4WFaayVaRYHt6s=;
        b=RORCjBkH12j7/lWGOtPjqXSc7IZBYNb9KHfDeAO+lz8VovK70dAyX9vQABUc5nM+i7
         JuiC1fTXb8BEAhuUoYNwKhLyEdKyhVeAmADgpQIvpfp8Do60q2gV7AHu7m5/zS9EEIHP
         rgurOvqHQOaT2RqibgyyK6cNJ9HK9uY2FF7UkBR0N3lxi9AE1ODgbw+VGpA3C86P2Cj9
         Iil+OMeh3hXVOeV0+oX9ROXuh4XvZZrs5P0zxuE55ueqDL4Op0bx/akTPIDVt5ECsNMR
         B2LKWdZ7hH2FHjMYlwAw4rHzq19LKP2pWL3c0qe00kK8W0DZJo5PnTapuejImmso2C37
         NEXw==
X-Gm-Message-State: ACgBeo0EKxexRsn3pZ7QHOTIadqEKVf95/huydBY7i2SjnWVAANHTg9/
        PzyaV9z9MjRZJh86UKACw2jLhQ==
X-Google-Smtp-Source: AA6agR5jirJciuwIXYIOI2zYJj3CGahbCPgxcpB0S3yRhZMr/rkIxUNwZe9S3GiZP/CRKwuxAJbpng==
X-Received: by 2002:ac2:4e15:0:b0:48b:7a5f:923c with SMTP id e21-20020ac24e15000000b0048b7a5f923cmr2132926lfr.134.1659817586613;
        Sat, 06 Aug 2022 13:26:26 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id cf40-20020a056512282800b0047f84ecae2esm862310lfb.236.2022.08.06.13.26.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 06 Aug 2022 13:26:26 -0700 (PDT)
Message-ID: <0ed40651-1638-3701-f310-cd50102ae763@linaro.org>
Date:   Sat, 6 Aug 2022 23:26:25 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 5/8] remoteproc: qcom: Add efuse evb selection control
Content-Language: en-GB
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        linux-remoteproc@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        devicetree@vger.kernel.org
References: <1659536480-5176-1-git-send-email-quic_srivasam@quicinc.com>
 <1659536480-5176-6-git-send-email-quic_srivasam@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1659536480-5176-6-git-send-email-quic_srivasam@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/08/2022 17:21, Srinivasa Rao Mandadapu wrote:
> Add efuse evb selection control and enable it for starting ADSP.
> 
> Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>

Is the lpass_efuse region used solely by the ADSP or is it shared with 
anybody else (e.g. other sound-related devices)? If the latter is true, 
then please use syscon for the lpass_efuse region.

> ---
>   drivers/remoteproc/qcom_q6v5_adsp.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> index a9fcb5c..201cc21 100644
> --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> @@ -56,6 +56,7 @@
>   
>   #define LPASS_BOOT_CORE_START	BIT(0)
>   #define LPASS_BOOT_CMD_START	BIT(0)
> +#define LPASS_EFUSE_Q6SS_EVB_SEL 0x0
>   
>   struct adsp_pil_data {
>   	int crash_reason_smem;
> @@ -85,6 +86,7 @@ struct qcom_adsp {
>   	struct clk_bulk_data *clks;
>   
>   	void __iomem *qdsp6ss_base;
> +	void __iomem *lpass_efuse;
>   
>   	struct reset_control *pdc_sync_reset;
>   	struct reset_control *restart;
> @@ -366,6 +368,9 @@ static int adsp_start(struct rproc *rproc)
>   	/* Program boot address */
>   	writel(adsp->mem_phys >> 4, adsp->qdsp6ss_base + RST_EVB_REG);
>   
> +	if (adsp->lpass_efuse)
> +		writel(LPASS_EFUSE_Q6SS_EVB_SEL, adsp->lpass_efuse);
> +
>   	/* De-assert QDSP6 stop core. QDSP6 will execute after out of reset */
>   	writel(LPASS_BOOT_CORE_START, adsp->qdsp6ss_base + CORE_START_REG);
>   
> @@ -520,6 +525,11 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
>   		return PTR_ERR(adsp->qdsp6ss_base);
>   	}
>   
> +	adsp->lpass_efuse =  devm_platform_ioremap_resource_byname(pdev, "lpass_efuse");
> +	if (IS_ERR(adsp->lpass_efuse)) {
> +		adsp->lpass_efuse = NULL;
> +		dev_dbg(adsp->dev, "failed to map LPASS efuse registers\n");
> +	}
>   	syscon = of_parse_phandle(pdev->dev.of_node, "qcom,halt-regs", 0);
>   	if (!syscon) {
>   		dev_err(&pdev->dev, "failed to parse qcom,halt-regs\n");


-- 
With best wishes
Dmitry
