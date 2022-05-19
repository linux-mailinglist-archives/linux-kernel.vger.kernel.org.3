Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5066952CB20
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiESEba (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiESEbZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:31:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D80D522C4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:31:23 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id p22so6993168lfo.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :references:from:in-reply-to:content-transfer-encoding;
        bh=ykAUPANu4B9XJJmg2pnplY4MjTnWZ9pJsCZp3uk7/eg=;
        b=BgAPtJzkRnc0lxQambdyfxszWLewO5SRkQq0gFA51AIiKnINcJdV5bJlMEpnKA/mZF
         JBV7cSqiEYCbRc5x9ZpraSMGolT1JUAVATze0FdxoGUqR/7UeAKKR4W8QSmemH40bcuT
         2xkblaSeWCapxTb3LB0hzWzf56ROr6QaSx0XPaZkzaSCn5nFxwyTsoONA1sdNpZYSIni
         MDVSzfn6U5SaPFmCqcIs54jyKxaa8MZ97J1fdXRDR2p9jWDav4Egk0ZKrx5owF52lyUF
         9eSul1A5fGSIOvarKpzahDN8mJfi+9+OE7nNP2cPlSMTfMIAdWfF51QDvKBw9QPnGUzZ
         3oZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ykAUPANu4B9XJJmg2pnplY4MjTnWZ9pJsCZp3uk7/eg=;
        b=egqKTc6pebW7drl1lnGuQ56smmR5F56NtvdOp1IXP/g4RzZUnXokdHMrzwcndSqsPI
         SDF2lnLXvzX9PsSBDNhQe/XQ3ZX7xXN3tr68YHKolKzNWy5h+K3RnhdaAgWCbb3ywvCe
         qFPnJZXDR7AhQ98yVe7Pl0r6F6Sllay273G5emoloNcRdt7gM1RYFx0JQjn5qFQRdlxY
         TLjoJ5MUem8YLVzlmQIeInoRiPlmSMTWe5+PiGph6a4Cm691RMDLqjnlBe88ceVqN0Gl
         mTpz+KNd0M+/iRpnKbBG8+GqdfTvE8Tyac9sz1qhI8eCeN6Yxdip6v87cdDu8jF4c9dq
         lciA==
X-Gm-Message-State: AOAM533Wo6ZItCRFzVuzle6tvaXjjd/9tmUdju6Q8IV7FJOUTK92AmPH
        jZ8O1ZTNFYadcYH6F3MBVtHyng==
X-Google-Smtp-Source: ABdhPJzBLhtYkn9iLfgHnLIimZi8ZrrcTKRdSm09/QdmXeugoK2IHQD5ZdleTymVilW5AMPFl3eNPQ==
X-Received: by 2002:ac2:46e8:0:b0:477:ba2c:a68b with SMTP id q8-20020ac246e8000000b00477ba2ca68bmr2011664lfo.55.1652934681773;
        Wed, 18 May 2022 21:31:21 -0700 (PDT)
Received: from [192.168.1.102] (mobile-access-b04822-211.dhcp.inet.fi. [176.72.34.211])
        by smtp.gmail.com with ESMTPSA id w12-20020a05651204cc00b0047255d2119fsm138383lfq.206.2022.05.18.21.31.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 May 2022 21:31:21 -0700 (PDT)
Message-ID: <cce59517-e9f0-2e29-038b-ba2f0faa075f@linaro.org>
Date:   Thu, 19 May 2022 07:30:58 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/8] clk: qcom: alpha-pll: correct kerneldoc
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
References: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org>
From:   Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>
In-Reply-To: <20220501103520.111561-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On 5/1/22 13:35, Krzysztof Kozlowski wrote:
> Correct kerneldoc warning:
> 
>    drivers/clk/qcom/clk-alpha-pll.c:1450:
>      warning: expecting prototype for clk_lucid_pll_configure(). Prototype was for clk_trion_pll_configure() instead
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   drivers/clk/qcom/clk-alpha-pll.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
> index 4406cf609aae..969d98fca5df 100644
> --- a/drivers/clk/qcom/clk-alpha-pll.c
> +++ b/drivers/clk/qcom/clk-alpha-pll.c
> @@ -1439,7 +1439,7 @@ const struct clk_ops clk_alpha_pll_postdiv_fabia_ops = {
>   EXPORT_SYMBOL_GPL(clk_alpha_pll_postdiv_fabia_ops);
>   
>   /**
> - * clk_lucid_pll_configure - configure the lucid pll
> + * clk_trion_pll_configure - configure the lucid pll
>    *
>    * @pll: clk alpha pll
>    * @regmap: register map

this fix is done earlier, unfortunately the inclusion is still pending, in v5 series:

https://lore.kernel.org/linux-clk/20220509090143.4140999-1-vladimir.zapolskiy@linaro.org/

--
Best wishes,
Vladimir
