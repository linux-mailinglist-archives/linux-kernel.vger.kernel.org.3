Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF99C5A9BA1
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 17:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234249AbiIAP2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234640AbiIAP1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 11:27:41 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE94075FC5
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 08:27:15 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id br21so19172944lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 08:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=X9KQ23b6CvSbegXXQiEOeHHhGVk1r4ic1U1zcBzHBjQ=;
        b=x7muZOPkg4SgHhIWNKhSTA8hJ5qf6JsZ1FtLBCLQNPmIprnxeVezHos4XOOrwXlG2q
         1JgFHTKsEzZaWhZSsxxdhCPeFl0BVLtNAiJ+eIii/j6SH8ri017pnM/ZMYL5AgQ5mVqa
         aOAgAEJ2PaawpMFlQyz2lB9ZlscdDjYsnJcmBfJQzD/rJgnzAJZjSyIV+1U6fgnOvtPN
         39SzIXq2fNdLrUL78tc5oGrZLDsYMwOYj61SOjckeBIXhcC5+QtQ952vS0nWFCwlJ6N2
         RNWkpfVh9ZkW0cLoob9eWON+UiXwhhaR4Glc+zxlvTxHgIE6U5dpwV+tAzvQ2dsgdEy+
         9vPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=X9KQ23b6CvSbegXXQiEOeHHhGVk1r4ic1U1zcBzHBjQ=;
        b=wnYDVrEaGVMwAaGkwbbaRTFieTTWWbjUV+ZIpsTnpHSE7vk/l6hEBW4Pj1MqV86a0S
         Oer5lMrO2XNK8FVeeVv8XWczw7pTsyD/nHNaW9Nr87oj6euZ7rKTrqC+mYUOEQskIgee
         pZh7FcTssKzXaIgbathjexODlYK71X4OPZB0k4zxJRl4+LIp5PCOaPVFMN9RGIfHTgLV
         nN8aIbtQ5RHa/tXAMgLSJpu3zQ+lQohzSDRZclHN9Ka0ho1nChkGFlw8Wcs9LOImPirv
         KdXvlaJ7ycCyrHxSipKLl3Qyt0fL/HOEUG2E/kecSaHqGY1DOB9hvCWemr+x2824Bn0f
         01Lg==
X-Gm-Message-State: ACgBeo23d6Zyy7H0NTSJgbl8BLDUGCNKvGDlekm+Wn3SwNpj9ALqrb20
        YKwT/GgzwGme1ah8FsnFxX40PA==
X-Google-Smtp-Source: AA6agR5yDs47h1XiyylqH70T9giJrRSzSDTycq9pkfnz/O9YBvml92ksajeOGkGt8Agra79qHKLMcw==
X-Received: by 2002:a19:5f03:0:b0:494:66fc:c24a with SMTP id t3-20020a195f03000000b0049466fcc24amr6707097lfb.54.1662046033918;
        Thu, 01 Sep 2022 08:27:13 -0700 (PDT)
Received: from [192.168.28.124] (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id v10-20020a2ea60a000000b0025e4ab170e0sm2565191ljp.3.2022.09.01.08.27.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Sep 2022 08:27:13 -0700 (PDT)
Message-ID: <4ca517a4-c4a1-2359-7b60-86ac529ed741@linaro.org>
Date:   Thu, 1 Sep 2022 18:27:12 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH 2/4] soc: qcom: icc-bwmon: add support for sc7280 LLCC
 BWMON
Content-Language: en-US
To:     Rajendra Nayak <quic_rjendra@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20220901124730.19460-1-quic_rjendra@quicinc.com>
 <20220901124730.19460-3-quic_rjendra@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220901124730.19460-3-quic_rjendra@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2022 15:47, Rajendra Nayak wrote:
> Add support for sc7280 BWMON instance measuring traffic between LLCC and
> memory with the v5 register layout.
> 
> Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
> ---
>  drivers/soc/qcom/icc-bwmon.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/soc/qcom/icc-bwmon.c b/drivers/soc/qcom/icc-bwmon.c
> index 47c2c3e7bb3f..44a10009b45e 100644
> --- a/drivers/soc/qcom/icc-bwmon.c
> +++ b/drivers/soc/qcom/icc-bwmon.c
> @@ -656,6 +656,18 @@ static const struct icc_bwmon_data sdm845_llcc_bwmon_data = {
>  	.regmap_cfg = &sdm845_llcc_bwmon_regmap_cfg,
>  };
>  
> +static const struct icc_bwmon_data sc7280_llcc_bwmon_data = {
> +	.sample_ms = 4,
> +	.count_unit_kb = 64,

This makes me wonder if I put correct count unit for SDM845 LLCC...

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof
