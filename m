Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A12E587768
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234736AbiHBHDE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:03:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbiHBHC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:02:59 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FD11EC73
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:02:57 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e11so14663159ljl.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=uPIE0DvOSHMXit1jmkLwyZQysttuDQSfP5UeIHQUUqI=;
        b=IXx1qRJE6nDUs27fpGtUJ2VR2du0AzgKQv4ljCBjX5cpfOd2vdBaQ2bYHwmkS8iIt0
         rnXUIBwZ6gdVEBxvR0LkqxXH2LZ+6u1CaQYvB+Pc2+hLdE3SUJmEqu8TpM7BG+r9hD+0
         W7uBKHOs3bFovvY1jYrkrgQbClKIU4p5NN2Odkz7LXcZCQ1uoS0RmhVLnslPNXWQs3pN
         7xLl9CUAaFTl2N1kwbBKX8+02GHDSoBG7JHSOvbLsSukiPhVKZ/Qn+149On5ymFk1ZMN
         IIU8DJH1V3dogD1q/grozvDT3IBcI56G4qnzCbY3Cwv3NAh9FIjIEuzfoMui5aL6dngk
         MpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uPIE0DvOSHMXit1jmkLwyZQysttuDQSfP5UeIHQUUqI=;
        b=KiFYmxg14LP8jz0FJkHFJHyoW3vVPlxwPnRSmEBNTThKGXFrMwGS+k2MWQ4B29+JRH
         2pWXQTzfR+vojE6TmnljjFgi5m+7HDkBnc41BVXlSLrVbYNLxSDM6B64swaFOEMHQ5Fh
         zbakJShbm5WwlBxFt6e5nn9nzTCxfdJdVJrqMisDh3AOPuRBJXdiQhhbH+ToS4UgAfwn
         MkEaHb/+P587/1fngs8tUjth5TswmbXD7drSua0hq3FC4WzBNFR5wMl+5Ij3JUXPpEFf
         DCHazcsrFxkLrPTMwrxscAieWaFbSEfH2ORDoLWzjjCAT7aI56wKGexd+3mU5j1F5avD
         HLVw==
X-Gm-Message-State: ACgBeo3KM97VpHUM4LAK31eS0rKv6PkPUcxC90yiOFkSqmbXqSY+cxyk
        llQk9PN3E4a/4WMlUk+8oUhKzg==
X-Google-Smtp-Source: AA6agR5dt356YyFOcD1+pyoDhGjAY8tfrUgU4K+3aRTPoYYfoZxGFDq8wAjVyquuNMnOReurxMVYSg==
X-Received: by 2002:a05:651c:335:b0:25e:4ac0:86e2 with SMTP id b21-20020a05651c033500b0025e4ac086e2mr3326877ljp.427.1659423775966;
        Tue, 02 Aug 2022 00:02:55 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id b22-20020a05651c033600b0025e4cdd9771sm716904ljp.117.2022.08.02.00.02.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:02:55 -0700 (PDT)
Message-ID: <c5f6c092-e7ce-2f69-f712-2b8a0a959f32@linaro.org>
Date:   Tue, 2 Aug 2022 10:02:54 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 3/5] clk: qcom: gpucc-sc7280: Add cx collapse reset
 support
Content-Language: en-GB
To:     Akhil P Oommen <quic_akhilpo@quicinc.com>,
        freedreno <freedreno@lists.freedesktop.org>,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1659172664-10345-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730144713.3.I5e64ff4b77bb9079eb2edeea8a02585c9e76778f@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220730144713.3.I5e64ff4b77bb9079eb2edeea8a02585c9e76778f@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2022 12:17, Akhil P Oommen wrote:
> Allow a consumer driver to poll for cx gdsc collapse through Reset
> framework.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
>   drivers/clk/qcom/gpucc-sc7280.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/clk/qcom/gpucc-sc7280.c b/drivers/clk/qcom/gpucc-sc7280.c
> index 9a832f2..f5df51d 100644
> --- a/drivers/clk/qcom/gpucc-sc7280.c
> +++ b/drivers/clk/qcom/gpucc-sc7280.c
> @@ -433,12 +433,18 @@ static const struct regmap_config gpu_cc_sc7280_regmap_config = {
>   	.fast_io = true,
>   };
>   
> +static const struct qcom_reset_map gpucc_sc7280_resets[] = {
> +	[GPU_CX_COLLAPSE] = { .op = gdsc_wait_for_collapse, .priv = &cx_gdsc },

This will break bisectability. Please swap this one and the patch 4.

> +};
> +
>   static const struct qcom_cc_desc gpu_cc_sc7280_desc = {
>   	.config = &gpu_cc_sc7280_regmap_config,
>   	.clks = gpu_cc_sc7280_clocks,
>   	.num_clks = ARRAY_SIZE(gpu_cc_sc7280_clocks),
>   	.gdscs = gpu_cc_sc7180_gdscs,
>   	.num_gdscs = ARRAY_SIZE(gpu_cc_sc7180_gdscs),
> +	.resets = gpucc_sc7280_resets,
> +	.num_resets = ARRAY_SIZE(gpucc_sc7280_resets),
>   };
>   
>   static const struct of_device_id gpu_cc_sc7280_match_table[] = {


-- 
With best wishes
Dmitry
