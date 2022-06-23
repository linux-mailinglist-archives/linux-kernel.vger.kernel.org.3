Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5E8557909
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbiFWLtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbiFWLtn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:49:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B8874CD7F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:49:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id i18so19258773lfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 04:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Ik3t0l4fcbio4cX8FR37ZQkgyke1x7n6Zn3wLLd1pX0=;
        b=fM0xWDs5K7teHGXOJztCHJT/llpM7zu9xuI0NnHI0hirBcCYnXJl763ue0nt3L5JRQ
         4GKgrI529bs2dRMOZrMfotgWsdpUXRsNTypUJmgGIt87Z/Na3Ancc/XA6hgMJ1rcJgBc
         K0dNESZRqFvcnrHvk8eJcbS2nb/ftJMDauYerWPHbWA98w32gqLb1LDAzkU6mQzy2f3P
         mPfZI7BuIxhDCphAI5eJ/+OyhhS3oI9lOLXbq35TSL6Jw+T3C4ehMhGD4FH/7l6YvxYM
         IbZzl93zvLHyc23QlKIn6OWQvq5uKKDHDSspY1ggFNKwwbalTDpZ3AnsksLB5IIZaojI
         quQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ik3t0l4fcbio4cX8FR37ZQkgyke1x7n6Zn3wLLd1pX0=;
        b=3dQ+XtS3lBhjFCEPz53mzhxOk8X7X1lH746DtNqHTuWZKRbJgSmi1Fcou7jQsnloOX
         JgD2Aou8OWlKHSilembhAEKxgRIlt3YBrnxgHjZp97IN35Oq/lWOm2+2RcP/pAkH6kpV
         BXMT4jd9gEnKw5HNozTJA+qQ8PwXdAd2pArGY4Fx+2I3pVO7FTkP5KlRXeu4qi2qfJs0
         jiePwiESUomgs8sLMWHWYwDjScQ0J1lNwH/FUNaEfvn8tkOP5MQkm0sXroi3Zv31pXtM
         48mOx+yZEboDK9yZlprzSYveFPxZC0duoB+NGFW74Cg5cpbRTIpLHQ2QU0u812CeKnku
         HdLw==
X-Gm-Message-State: AJIora8Ydu7C33SYKHFRDAYMEvJ+ges3ZVjg7ry6hV8HQEfBm67SsrQb
        EelDOBGhYjo0QyarWZSbfHZh9g==
X-Google-Smtp-Source: AGRyM1t4TD1Sc6F5sq9F1yH8vffHMc1UT8wQzHLHJY65aci0iWr4UtrSIZrFRYsEuvp936wciB48uQ==
X-Received: by 2002:a05:6512:686:b0:47d:b7f3:e6a4 with SMTP id t6-20020a056512068600b0047db7f3e6a4mr5207986lfe.138.1655984980388;
        Thu, 23 Jun 2022 04:49:40 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9d07000000b002556cf330e8sm2754306lji.99.2022.06.23.04.49.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 04:49:39 -0700 (PDT)
Message-ID: <80da3045-5351-5d21-ffb2-e514e0b25961@linaro.org>
Date:   Thu, 23 Jun 2022 14:49:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/3] phy: qcom-qmp: clean up v4 and v5 define order
Content-Language: en-GB
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220609120338.4080-1-johan+linaro@kernel.org>
 <20220609120338.4080-2-johan+linaro@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20220609120338.4080-2-johan+linaro@kernel.org>
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

On 09/06/2022 15:03, Johan Hovold wrote:
> Clean up the QMP v4 and v5 defines by moving a few entries that were out
> of order.
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   drivers/phy/qualcomm/phy-qcom-qmp.h | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.h b/drivers/phy/qualcomm/phy-qcom-qmp.h
> index eb5705d1e32c..626be0ccede2 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.h
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.h
> @@ -577,8 +577,8 @@
>   #define QSERDES_V4_COM_LOCK_CMP1_MODE0			0x0ac
>   #define QSERDES_V4_COM_LOCK_CMP2_MODE0			0x0b0
>   #define QSERDES_V4_COM_LOCK_CMP1_MODE1			0x0b4
> -#define QSERDES_V4_COM_DEC_START_MODE0			0x0bc
>   #define QSERDES_V4_COM_LOCK_CMP2_MODE1			0x0b8
> +#define QSERDES_V4_COM_DEC_START_MODE0			0x0bc
>   #define QSERDES_V4_COM_DEC_START_MODE1			0x0c4
>   #define QSERDES_V4_COM_DIV_FRAC_START1_MODE0		0x0cc
>   #define QSERDES_V4_COM_DIV_FRAC_START2_MODE0		0x0d0
> @@ -1106,8 +1106,8 @@
>   #define QSERDES_V5_COM_LOCK_CMP1_MODE0			0x0ac
>   #define QSERDES_V5_COM_LOCK_CMP2_MODE0			0x0b0
>   #define QSERDES_V5_COM_LOCK_CMP1_MODE1			0x0b4
> -#define QSERDES_V5_COM_DEC_START_MODE0			0x0bc
>   #define QSERDES_V5_COM_LOCK_CMP2_MODE1			0x0b8
> +#define QSERDES_V5_COM_DEC_START_MODE0			0x0bc
>   #define QSERDES_V5_COM_DEC_START_MODE1			0x0c4
>   #define QSERDES_V5_COM_DIV_FRAC_START1_MODE0		0x0cc
>   #define QSERDES_V5_COM_DIV_FRAC_START2_MODE0		0x0d0
> @@ -1134,8 +1134,8 @@
>   #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE0	0x1ac
>   #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE0	0x1b0
>   #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE1_MODE1	0x1b4
> -#define QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
>   #define QSERDES_V5_COM_BIN_VCOCAL_CMP_CODE2_MODE1	0x1b8
> +#define QSERDES_V5_COM_BIN_VCOCAL_HSCLK_SEL		0x1bc
>   
>   /* Only for QMP V5 PHY - TX registers */
>   #define QSERDES_V5_TX_RES_CODE_LANE_TX			0x34


-- 
With best wishes
Dmitry
