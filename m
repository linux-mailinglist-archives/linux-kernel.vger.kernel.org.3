Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C57514E67
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377969AbiD2O44 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352746AbiD2O4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:56:54 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895A9BCB64
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:53:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id n14so14458114lfu.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ieX4ERtpLD9xXlnppJiXnBM5MolbjWhutaLWoLmtuWI=;
        b=WJasDlX+L7lTDi5DRlU/Iore/2d+AmazQHpymgaYf5mJzUIoye3IFFkLJAvwLqSY4X
         YMpcGw9iVNUQUc5I2Pb2d0hcYhjJ+1Uu8gxuVBehkJKOImZwR5rp0bJvdYwuWUAsP2JB
         lOa5a8Hkl5croJBMPERWm8+LGDIL588sdVkMELH5PQ9nZyIZLr0SGJGk2a0bKTVeG64+
         2sLbtxRJp+9YBzOndjhgj0bZI9u5ma4lZO58ltKUR2Xxb7eWsmiHG8RrrpsO9B9oZ7OT
         riTIR2WQujE/PXMZX5xg6rVVD5QSKYKXGl8NjROU6MjKf5rk/KJxHq0SZAMZS8GGCHV6
         Ftgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ieX4ERtpLD9xXlnppJiXnBM5MolbjWhutaLWoLmtuWI=;
        b=JJ5kVzkPIZvKfUOnw3ICYWYCXp3wsN9TD01ncJo0O/1/s77x32NOGfcT9LMBuo3kPE
         IAII3um7cTTvdWkEPA16PGUq6VpdFv+cGlrZ4JOBHWHjB5krtglj3JuWJYzUbhvQa173
         nmQfaFNuTU1nDCq3y7Kykaot6v5TA5CTVoH9AO7TC03q6sGVx6COaI2zuwvPRmoSomGO
         VAgqg0sTcc/xtSwS0ALCW3YIMPe7y2VhdK/w8Q80yDQDZcP1tTmQx8qilQz4Bm4Mi5KK
         epqzTC8WsDHF8Tj++97dOdOiBMtDSRaOIaCGVsDMoMs0MaW/AAn7Cv/sSQDpkVMlC06W
         zXNw==
X-Gm-Message-State: AOAM530TSxWzvr18VEccIOpfv5S2g0g+HkjyxTBmnoeI6UxyBToU+m/l
        8mZv9hD6h7l2w3EnNnfnBPuYag==
X-Google-Smtp-Source: ABdhPJzSI2kOIfH8vfPEQ4hDiW6Y4SzEOOnLZqvrg4nFXU0ts2KCEezMrgV4P/DO5KsC3zUS5mFBNQ==
X-Received: by 2002:a05:6512:3c8a:b0:472:2513:db16 with SMTP id h10-20020a0565123c8a00b004722513db16mr10659036lfv.497.1651244013521;
        Fri, 29 Apr 2022 07:53:33 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id bd6-20020a05651c168600b0024f3d1daeb5sm283625ljb.61.2022.04.29.07.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:53:33 -0700 (PDT)
Message-ID: <b7de49e0-c0cf-5062-8426-dcb54272d350@linaro.org>
Date:   Fri, 29 Apr 2022 17:53:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 3/4] clk: qcom: clk-krait: add hw_parent check for
 div2_round_rate
Content-Language: en-GB
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sricharan R <sricharan@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220429120108.9396-1-ansuelsmth@gmail.com>
 <20220429120108.9396-4-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429120108.9396-4-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 15:01, Ansuel Smith wrote:
> Check if hw_parent is present before calculating the round_rate to
> prevent kernel panic. On error -EINVAL is reported.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

I see that other clock drivers do not perform this check. Which path 
leads to this oops?

> ---
>   drivers/clk/qcom/clk-krait.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
> index 90046428693c..6c367ad6506a 100644
> --- a/drivers/clk/qcom/clk-krait.c
> +++ b/drivers/clk/qcom/clk-krait.c
> @@ -84,7 +84,12 @@ EXPORT_SYMBOL_GPL(krait_mux_clk_ops);
>   static long krait_div2_round_rate(struct clk_hw *hw, unsigned long rate,
>   				  unsigned long *parent_rate)
>   {
> -	*parent_rate = clk_hw_round_rate(clk_hw_get_parent(hw), rate * 2);
> +	struct clk_hw *hw_parent = clk_hw_get_parent(hw);
> +
> +	if (!hw_parent)
> +		return -EINVAL;
> +
> +	*parent_rate = clk_hw_round_rate(hw_parent, rate * 2);
>   	return DIV_ROUND_UP(*parent_rate, 2);
>   }
>   


-- 
With best wishes
Dmitry
