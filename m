Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0126D4FE00A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 14:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352169AbiDLMIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 08:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352785AbiDLMDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 08:03:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED348230E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:00:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id lc2so15977865ejb.12
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 04:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OtcTMPrlTNXp9PoEitk/L5i1H2nBEkZl9nT/eENrV+k=;
        b=JP11LSQ8zmmCyddbwbvylUfq6jyldvILsPwHS7McGLy7YDYX1x9vn/jRHL3rf3XWju
         wPAdtWSFjJeJCTvSfu2LN0xiPGnQu245SCs7W5aC4+5sKeKu4DVj0o6bmNZ5senwX2i9
         GlyeYcYPnitR4Qpwh74fskxFTnPRBx6C0Pv+mytp2DaixRWajZvGWJOwijTbJTd9Y/cZ
         lFGzzl2DY7OGkxALK6Xo0PKHUU+1ITCmDkbL3ANYKygN3DlPIKJXlup4TeZmypXTCRMx
         sdIguhdGNRottJqWbk7hnfEvAWpVArMTtWTQcSIIb2HY+LZRpueOJ5OnuFjmL8WTzrhC
         Z4xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OtcTMPrlTNXp9PoEitk/L5i1H2nBEkZl9nT/eENrV+k=;
        b=BYeZy1o6DREt9r9MtNUheZ9bybPrII4mdstqzS6dMAb4L1HfY583vF/f/QMYfpUpbP
         W8A0uXigiYzsX2aGbflNTLRrP28vQ0LzHfRv2/XQBLEDSvhi8RdlRhm20L00IPbgL9Zl
         qD0MLt8X8DF35RXay/yigA7Uy4ziB8cvuCcvd788XSIeLLDuuzjb1xumH6lNgQSQKZwS
         HAAcIgcJRqQ2qrM5WwXRW71LS16/eVKYGcFByO29MbYdx9hyN9EKFDi0PWWn7hSfYA33
         nK/cMa3/2lA/Vbc5fONPO5uOXr+woKZxmq6nQ/1RG9RVh4chNIitA39v/azGfkmLKTGy
         zaqg==
X-Gm-Message-State: AOAM530VUVrHWWBC2IAXdIiemsERNPK+kRjgopyJRkCPb5kYZTcaPqqe
        XAwve6mcNc4a+eHhwkl9nLBZmg==
X-Google-Smtp-Source: ABdhPJzso1r/MNJ6FRO8mE1JENt7ea2m3TSMGr0XG0JAdS/nUDEI9+uadS9945xfvLwwJfuPRNVRJw==
X-Received: by 2002:a17:907:6e9e:b0:6e8:5723:bf8f with SMTP id sh30-20020a1709076e9e00b006e85723bf8fmr17926034ejc.563.1649761235531;
        Tue, 12 Apr 2022 04:00:35 -0700 (PDT)
Received: from [192.168.0.194] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id j12-20020a056402238c00b0041ce094cf47sm11268939eda.60.2022.04.12.04.00.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 04:00:34 -0700 (PDT)
Message-ID: <f64eb8c9-c597-70d4-1247-fbd39f593ece@linaro.org>
Date:   Tue, 12 Apr 2022 13:00:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: Add bosch acc board
Content-Language: en-US
To:     Philip Oberfichtner <pro@denx.de>, devicetree@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Winker Matthias <Matthias.Winker@de.bosch.com>
References: <20220412101905.514310-1-pro@denx.de>
 <20220412101905.514310-2-pro@denx.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220412101905.514310-2-pro@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2022 12:19, Philip Oberfichtner wrote:
> Add device tree binding for the Bosch ACC board, based on i.MX6 Dual.
> 
> Signed-off-by: Philip Oberfichtner <pro@denx.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
