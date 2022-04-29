Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 215CC514E9D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378146AbiD2PEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377480AbiD2PEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:04:06 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A79249274
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:00:48 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id k12so14519894lfr.9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=NgFkGj6t89cfDU8h18lUmisWIQlxbc4WZbzdRxKCz3k=;
        b=ZM760YPSenzfkt5aBOoPjNBgfTdCSoJabilxAb31qUx0+VOyg/Rvq1RSyyfthjlack
         jaPIsBBJa9FfKzabWuy0hU0klkaaJiRUNTJv7viZZZ3rIniQFoc+fFS14Am0OE1OLc/8
         qHQUXE1OjRmio8fPFYt3y9S+tyJsChNCf56o4pb1pXd4/ITENpa9rt3zTNkXtqw5c1ul
         XWk3AaCrI/cCu7Regsnr7m0ovfUXDCv8p0BWMJ8nXO9dSNSQxNv7OCscZu/O9QL7nYIy
         8yJGyrKCFS5u2lEMCiDxO3Lfb/VA7VYF291UArHY0SWE6DC6sZgVo2lkcoT4QCQZZcDb
         aGgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=NgFkGj6t89cfDU8h18lUmisWIQlxbc4WZbzdRxKCz3k=;
        b=UeWqutRLonmtPbSswIfbiifLHYkdy43wtUfhU/6x3j3P2B6xFSRkkWJ9sya8EIRKqE
         abZ9JeaJwq/UQICaznxzOo2JftqPulfcwrTAD/Brygl861N5hKo8TTCcjUwGrCEX0vUh
         cdGz6ZfC+ipS3iXcUGQq8i9f7v2NHfJPzCmoP1q2bO7MRwPUkdRZDL02jqv9qVWa0oRl
         WJ5Y2DzZ6d7DxGB9CVeOHf0ojoFRFaducIDfRdo6SoTh6MnvLZFxgzWCUtDlOkr49jDh
         REoe2cGXD0ditGJW0auXg8Ez1GSJM00VYZKGu6Bh0UtI+liZpi7APmJsA5HEy0NlmzAq
         5lhA==
X-Gm-Message-State: AOAM530u5SL2TWPaOkzIXSIyYQAAruo03QHLqawLPUABHUs+9ntd6M+O
        tv0yYXEC66ZC6cqv98FLlAMsPg==
X-Google-Smtp-Source: ABdhPJzWIXVhuKwvYZXjinlH9r7h5lT6+559NNN6Eh6+ovZcHLnhD1b/kd0AUEPpSfSv69hOp7fAHg==
X-Received: by 2002:a05:6512:3a89:b0:471:c6ba:c522 with SMTP id q9-20020a0565123a8900b00471c6bac522mr27979319lfu.371.1651244446464;
        Fri, 29 Apr 2022 08:00:46 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id d19-20020a193853000000b0047210b434ffsm259348lfj.27.2022.04.29.08.00.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 08:00:46 -0700 (PDT)
Message-ID: <1f013429-8a5b-47c8-a146-41bb66af3f03@linaro.org>
Date:   Fri, 29 Apr 2022 18:00:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 4/4] clk: qcom: clk-krait: add apq/ipq8064 errata
 workaround
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
 <20220429120108.9396-5-ansuelsmth@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220429120108.9396-5-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 15:01, Ansuel Smith wrote:
> Add apq/ipq8064 errata workaround where the sec_src clock gating needs to
> be disabled during switching. To enable this set disable_sec_src_gating
> in the mux struct.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>   drivers/clk/qcom/clk-krait.c | 16 ++++++++++++++++
>   drivers/clk/qcom/clk-krait.h |  1 +
>   drivers/clk/qcom/krait-cc.c  |  1 +
>   3 files changed, 18 insertions(+)
> 
> diff --git a/drivers/clk/qcom/clk-krait.c b/drivers/clk/qcom/clk-krait.c
> index 6c367ad6506a..4a9b3296c45b 100644
> --- a/drivers/clk/qcom/clk-krait.c
> +++ b/drivers/clk/qcom/clk-krait.c
> @@ -18,13 +18,23 @@
>   static DEFINE_SPINLOCK(krait_clock_reg_lock);
>   
>   #define LPL_SHIFT	8
> +#define SECCLKAGD	BIT(4)
> +
>   static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
>   {
>   	unsigned long flags;
>   	u32 regval;
>   
>   	spin_lock_irqsave(&krait_clock_reg_lock, flags);
> +
>   	regval = krait_get_l2_indirect_reg(mux->offset);
> +
> +	/* apq/ipq8064 Errata: disable sec_src clock gating during switch. */
> +	if (mux->disable_sec_src_gating) {
> +		regval |= SECCLKAGD;
> +		krait_set_l2_indirect_reg(mux->offset, regval);
> +	}
> +
>   	regval &= ~(mux->mask << mux->shift);
>   	regval |= (sel & mux->mask) << mux->shift;
>   	if (mux->lpl) {
> @@ -33,6 +43,12 @@ static void __krait_mux_set_sel(struct krait_mux_clk *mux, int sel)
>   	}
>   	krait_set_l2_indirect_reg(mux->offset, regval);
>   
> +	/* apq/ipq8064 Errata: re-enabled sec_src clock gating. */
> +	if (mux->disable_sec_src_gating) {
> +		regval &= ~SECCLKAGD;
> +		krait_set_l2_indirect_reg(mux->offset, regval);
> +	}
> +
>   	/* Wait for switch to complete. */
>   	mb();
>   	udelay(1);
> diff --git a/drivers/clk/qcom/clk-krait.h b/drivers/clk/qcom/clk-krait.h
> index 9120bd2f5297..f930538c539e 100644
> --- a/drivers/clk/qcom/clk-krait.h
> +++ b/drivers/clk/qcom/clk-krait.h
> @@ -15,6 +15,7 @@ struct krait_mux_clk {
>   	u8		safe_sel;
>   	u8		old_index;
>   	bool		reparent;
> +	bool		disable_sec_src_gating;
>   
>   	struct clk_hw	hw;
>   	struct notifier_block   clk_nb;
> diff --git a/drivers/clk/qcom/krait-cc.c b/drivers/clk/qcom/krait-cc.c
> index 4d4b657d33c3..0f88bf41ec6e 100644
> --- a/drivers/clk/qcom/krait-cc.c
> +++ b/drivers/clk/qcom/krait-cc.c
> @@ -138,6 +138,7 @@ krait_add_sec_mux(struct device *dev, int id, const char *s,
>   	mux->parent_map = sec_mux_map;
>   	mux->hw.init = &init;
>   	mux->safe_sel = 0;
> +	mux->disable_sec_src_gating = true;

This has to be guarded with the of_compatible checks. Otherwise you'd 
apply this errata to all Krait CPUs, not only apq/ipq8064.

At least this should be limited to krait-cc-v1 with the note that there 
is no way to distinguish between platforms.

>   
>   	init.name = kasprintf(GFP_KERNEL, "krait%s_sec_mux", s);
>   	if (!init.name)


-- 
With best wishes
Dmitry
