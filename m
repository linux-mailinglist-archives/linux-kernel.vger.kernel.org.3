Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73E6587780
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiHBHHL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235681AbiHBHGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:06:42 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DFB491F4
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 00:06:35 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s14so14673406ljh.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 00:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=YyBYmLXFn5IFerrIXB88rk828Nzxi3yZBlN5vWZi/gM=;
        b=cqShYtc7B4W7+q0vK7VkTMRnsYgBNGzLw6e2P8pZuRkHXrMnlMerLmoE/2weJs4sSA
         ocXKFpxuWtWtb1fhSYbnxLu9yBchBRsggPdcY+GsiMqQxQzl00PcrID3nMwsn5j9ljUn
         Q2q45sZ0s6MZWe2aMQmOCqU3abPyz7zyeyliIBvgJZlj/OJ2VmjEBuPNg2NKYSZqJV2f
         Ba5lIM6m2qZ7Q8GEkOJJ7xmwxGbFeEGtWqzPlCAIjZVbwXph3xyaIznRTbSr/mrwh18N
         idKySTQiWRH+Y6UU3DZwyzzDiy5UABGQzp8uHK8B+9SG0ZaLpx4iZXISVU0aDf2GPW/L
         sVsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YyBYmLXFn5IFerrIXB88rk828Nzxi3yZBlN5vWZi/gM=;
        b=1fq48MLZfnTseHIiNGn0xjU5HUWZnvJosAlVv38Gcqrij0X1NOBAM/k/WPQqZkm1O1
         EV1GoNvzK3mAiReMbQ4TSkTYGqCdf3WDQVk0UiEojO5r30Bk2Tuzo3bngqeCbqzCO0KQ
         x0rlHOIRRTrej0hYxJFrF4fpbvAU0O7PCcfz2uRQ8ADSHEE1i0wYECQWWKScqk5IYYCq
         NCwVLJ2hqA9PRQFDFFUZYTseCx6A9TzORCjIJZFPEz+rTHsC6zb9ueCLYvIbsX32royD
         rRMzZzUwqqybeTLkrM00tQPMTCTI6aT3f4/QWiu4onisj+PJcBV4QegCCoQLheV+meEU
         Nz4Q==
X-Gm-Message-State: AJIora8iCZQZjwia0y67DthscFTV6M063MvNm2imwAKSWP2aF9UBQW/f
        8odRfNoaIz80rREZv6+d/1isCA==
X-Google-Smtp-Source: AGRyM1vyFzsFMTCPRJxtHWx7y5a7FMF92v+tAByHTMxUB/MOjUpdCznNzN7CY7oLLyxTnSAivEK0hg==
X-Received: by 2002:a2e:bd0a:0:b0:25d:d2a3:7366 with SMTP id n10-20020a2ebd0a000000b0025dd2a37366mr6103917ljq.35.1659423993628;
        Tue, 02 Aug 2022 00:06:33 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id e1-20020a05651236c100b0048afa5daaf3sm629717lfs.123.2022.08.02.00.06.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Aug 2022 00:06:33 -0700 (PDT)
Message-ID: <43d19449-cf06-2302-b536-4ade5f79c5fd@linaro.org>
Date:   Tue, 2 Aug 2022 10:06:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 2/5] clk: qcom: Allow custom reset ops
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
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1659172664-10345-1-git-send-email-quic_akhilpo@quicinc.com>
 <20220730144713.2.I4b69f984a97535179acd9637426a1331f84f6646@changeid>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220730144713.2.I4b69f984a97535179acd9637426a1331f84f6646@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/07/2022 12:17, Akhil P Oommen wrote:
> Add support to allow soc specific clk drivers to specify a custom reset
> operation. A consumer-driver of the reset framework can call
> "reset_control_reset()" api to trigger this.
> 
> Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
> ---
> 
>   drivers/clk/qcom/reset.c | 6 ++++++
>   drivers/clk/qcom/reset.h | 2 ++
>   2 files changed, 8 insertions(+)
> 
> diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
> index 819d194..4782bf1 100644
> --- a/drivers/clk/qcom/reset.c
> +++ b/drivers/clk/qcom/reset.c
> @@ -13,6 +13,12 @@
>   
>   static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
>   {
> +	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
> +	const struct qcom_reset_map *map = &rst->reset_map[id];
> +
> +	if (map->op)
> +		return map->op(map);

This looks like a hack. For example, assert() and deassert() would still 
follow the usual pattern of updating the bits. Please at least make them 
return -EOPNOTSUP if map->op is defined.

A slightly better solution would be to make qcom_reset implementation 
optional (and depending on desc->num_resets being greater than 0). Then 
you can register your own reset controller implementation from the gpucc 
driver.


> +
>   	rcdev->ops->assert(rcdev, id);
>   	udelay(1);
>   	rcdev->ops->deassert(rcdev, id);
> diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
> index 2a08b5e..295deeb 100644
> --- a/drivers/clk/qcom/reset.h
> +++ b/drivers/clk/qcom/reset.h
> @@ -11,6 +11,8 @@
>   struct qcom_reset_map {
>   	unsigned int reg;
>   	u8 bit;
> +	int (*op)(const struct qcom_reset_map *map);
> +	void *priv;
>   };
>   
>   struct regmap;


-- 
With best wishes
Dmitry
