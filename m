Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A44E5514DC7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377772AbiD2Opa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377668AbiD2OpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:45:07 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CA060AA5
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:41:43 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id bn33so10773367ljb.6
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=v2gZtm1Y9EnOM5Lz97MhvmGZH6fMaQCNcq4ssrGXHvA=;
        b=ClMCvVPqnQvsDrQSnAHoGq7Vw5jDkH20m6A/jFylwgb5q97jAdRdcW5Tq/ZaNiH+Cp
         yIg47tN6GtmlTBH5mtys7w9mDlDFu5S/h+p9aL/puwS8bYuXt/nFHomvmU3LgQAF6YSY
         r037KVH5Hozn7/KWxmUuGVfe2fRViCWWRM0skggmZKD3leNVKeniAzLHjebi28EOK5Nr
         n6giekI/b+HkE2c8faKP8PebkDDPCvZNdKFVksYUzucQrGdb9y63esEM2xL1deU8a37x
         p1AI8Br8SMlk0CuUVXdCLcjGT+EQfv9Pw3SDNLA28y2JJrwSVpHcX1QA+HZAnMN07QBG
         NwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v2gZtm1Y9EnOM5Lz97MhvmGZH6fMaQCNcq4ssrGXHvA=;
        b=1UlTjKlcQWbmrRZT9q69bREK7qgaJ0qO+05tu4fqi7u5aCrNi/agM/A6wMv7u/N+47
         64pmkiquTZZTI/OnCW3pCRbuuvk6VeOZvTYhiilChqTcQs0IqLYzjak5mVs5s4tx6tlT
         He9HQnDpvODE/u5Ks/cy8HZhxgXP+pb0fm2/Tu8V9ppKywdZ2IzckoHOmW1AZQtV1+z0
         NVl2hZibaYK7br8TaHEdkjlN8AvVaBrRTv2VR8qQXzvQTNHJV8Wl+vdsvgvtXx+S4OUJ
         jXGwG//qeCwblLYnzb92Kmvo2jkHnpIHn/T2OAZV5qxWbxzwi+NfI2dC1QP72yCr6cp1
         ULqQ==
X-Gm-Message-State: AOAM530s1R5enHepyketzuRtBUtXG9y0uy7uaJ3qJ3K9k2H5U4xqnLPj
        AZa6nzpsxKPJQqtpJYxV/GUZKErCPEDm5w==
X-Google-Smtp-Source: ABdhPJx293qUvuCappYWJV4aCE2Kp2oJ/m2hcMh6SW9WP1q60AEQCRl17k3YoPhVKTLl4IVO2KI5Mg==
X-Received: by 2002:a2e:8e98:0:b0:24f:15e9:ed39 with SMTP id z24-20020a2e8e98000000b0024f15e9ed39mr14240296ljk.460.1651243302165;
        Fri, 29 Apr 2022 07:41:42 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id h7-20020ac24d27000000b004720819b691sm255343lfk.130.2022.04.29.07.41.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 07:41:41 -0700 (PDT)
Message-ID: <beb3bd74-a550-b0c1-b6bd-99536dc9b2e1@linaro.org>
Date:   Fri, 29 Apr 2022 17:41:40 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/4] clk: qcom: clk-krait: unlock spin after mux
 completion
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
 <20220429120108.9396-3-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429120108.9396-3-ansuelsmth@gmail.com>
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
> Unlock spinlock after the mux switch is completed to prevent any corner
> case of mux request while the switch still needs to be done.
> 
> Fixes: 4d7dc77babfe ("clk: qcom: Add support for Krait clocks")
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/clk/qcom/clk-krait.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
> index 59f1af415b58..90046428693c 100644
> --- a/drivers/clk/qcom/clk-krait.c
> +++ b/drivers/clk/qcom/clk-krait.c
> @@ -32,11 +32,16 @@ static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
>   		regval |= (sel & mux->mask) << (mux->shift + LPL_SHIFT);
>   	}
>   	krait_set_l2_indirect_reg(mux->offset, regval);
> -	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
>   
>   	/* Wait for switch to complete. */
>   	mb();
>   	udelay(1);
> +
> +	/*
> +	 * Unlock now to make sure the mux register is not
> +	 * modified while switching to the new parent.
> +	 */
> +	spin_unlock_irqrestore(&krait_clock_reg_lock, flags);
>   }
>   
>   static int krait_mux_set_parent(struct clk_hw *hw, u8 index)


-- 
With best wishes
Dmitry
