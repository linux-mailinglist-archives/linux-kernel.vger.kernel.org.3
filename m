Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D937D574674
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 10:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbiGNIOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 04:14:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbiGNIOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 04:14:32 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E4319022
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:14:30 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id bp17so1569132lfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 01:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JARNoFL2G2VkUztjv4GPUnCfhbF7Pat+sImzO6BCcI8=;
        b=oaD1w8HdQh+qo4eMrltrSZR1A1WnlbZYleu4SqxdMdOW4Dqej+x8HVsHUjOJx21s6m
         c+BPDJQEpW0OV7yUE4sLNo3pdolGgGIYPmye/e1cRgRD1xR3uGDCd+0JSHJGO6YP+xZ0
         aVvtOEXb8oJ8GLy25Qtdv2qH66gbDW29q2w07/xT3XojEEYAEeFBZHqOP1H/uKAFEHg+
         UZAzmWMhLGjtRz+/lgw4V+ulmvCfC1136D8UduUzmFE/tW0s6J9iK5YJqTa0Kh7GUX8P
         TEqH1U9pD20YGvqihpm83MPU1v/o5qqy6LRJSTz8sEQT//oS5NDg029H6vheTPLMfuxX
         gpPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JARNoFL2G2VkUztjv4GPUnCfhbF7Pat+sImzO6BCcI8=;
        b=0xo2r0DMXNpXJKTK1M0e3Tr4nOJEzP7Nw/wsRO3MW2B02dATNu+2t24zwDEDWteYtB
         +ClkwnF7HASGFp0xvxWbWBPMkTDnbWccFgYBll3vbjEPetiWdGj16Itte6z9QTS263j5
         sJoW7Wzrdayc4NCDTvJJuOJx5nbUVJ8estuqBIzOoS+Rv3qjMoizgVcTZW0X2YYxAyWH
         eiSGCNGhBX0aX1PXpENSfucrSQ9UrSTucSJ1t3qS1h2tBzsAeEwxsuMGiKaYrJqYMzfx
         9uiXhnD/8vy+Ka3g0SlIUSCP6LvNJIgRFxnwaYr93o0e7MUPs1dTXhuW5cr/86MBWH5g
         /+kQ==
X-Gm-Message-State: AJIora/ezCd9qsXuko5FTZpfVFquo31WGbBaPAb8AZhDAPJFTHL7VxVt
        25YiuOvtvgHBQcRSl1MlcMjYAQ==
X-Google-Smtp-Source: AGRyM1v3RcZLVT7J+Ajj2pUVxXr4VmqkQn6Qhlz9P65lZBDxNuERzBOQuayTmPFwcbjXMVG8U5s9Ew==
X-Received: by 2002:a05:6512:54e:b0:48a:19c9:2495 with SMTP id h14-20020a056512054e00b0048a19c92495mr781088lfl.496.1657786468864;
        Thu, 14 Jul 2022 01:14:28 -0700 (PDT)
Received: from [10.0.0.8] (fwa5da9-171.bb.online.no. [88.93.169.171])
        by smtp.gmail.com with ESMTPSA id bt32-20020a056512262000b0047f674838a5sm225201lfb.231.2022.07.14.01.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 01:14:28 -0700 (PDT)
Message-ID: <2e196fcf-adbe-0fa6-e70a-178e91373ef4@linaro.org>
Date:   Thu, 14 Jul 2022 10:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 2/2] dt-bindings: arm: fsl: Add Moxa UC8210/8220 series
Content-Language: en-US
To:     Jimmy Chen <u7702045@gmail.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
Cc:     Jimmy Chen <jimmy.chen@moxa.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220714030636.3000-1-jimmy.chen@moxa.com>
 <20220714030636.3000-2-jimmy.chen@moxa.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714030636.3000-2-jimmy.chen@moxa.com>
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

On 14/07/2022 05:06, Jimmy Chen wrote:
> Add DT compatible string for Moxa UC8210/8220 i.MX7D board.
> 
> Signed-off-by: Jimmy Chen <jimmy.chen@moxa.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
