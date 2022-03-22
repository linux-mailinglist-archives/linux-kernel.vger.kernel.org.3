Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B9D4E3C38
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 11:11:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232790AbiCVKNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 06:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbiCVKNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:13:06 -0400
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D97D3237CC;
        Tue, 22 Mar 2022 03:11:38 -0700 (PDT)
Received: by mail-wm1-f50.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so1091005wmb.3;
        Tue, 22 Mar 2022 03:11:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Wfhu1CSV3zn98iQVKtYyekWe4LUUvowP2lTHlaYZsg4=;
        b=7wEnSyWQ2L3CO8I0z0BL/9OehhtuD5IcdqkkmIGFGdRMndYe2rpJVRJmjsZMiTRtHO
         ovU8FVkynP+8mQiEFrxgoSOSzmlvynFXHS5ljkQr5ndvkEv3iUd347NkjtO07poSPx6y
         4gBEfzE7IfVh1g7RttY/XUG24WkbFU7efIsizmJx4v+laAzQBHDSSW1RbZgOov1jvUF0
         6J6cy43/U8pMV973E4tNaWAgq7RvjedYC2wWda4aRZeK3ESjYAKHxC+mq1V3GjfG/aVn
         UfzaOkl/j7ytixZ9lmKNncepg3JGKA/oTgKAI2OiyFYBNzpbJmV1DyUV9KgSRAzzfVzS
         0TpQ==
X-Gm-Message-State: AOAM530LcH346sIdO88axgxjYzZX8+NQxtWPgjOQYp5VABjdXsHs0gIR
        UwBvAiISs0jVjfex7NDW5yo=
X-Google-Smtp-Source: ABdhPJw2eSKQ40kfHH4/obdrsq52+J1jn/jywYsqAYGLcQtmvdukg4qua1/zAOEj2uu5oWGwR02ivQ==
X-Received: by 2002:a05:600c:1909:b0:389:ee24:caf6 with SMTP id j9-20020a05600c190900b00389ee24caf6mr3157959wmq.158.1647943897408;
        Tue, 22 Mar 2022 03:11:37 -0700 (PDT)
Received: from [192.168.0.17] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.googlemail.com with ESMTPSA id v14-20020a7bcb4e000000b0034492fa24c6sm1533196wmj.34.2022.03.22.03.11.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 03:11:36 -0700 (PDT)
Message-ID: <7f44490d-1b5a-cdf7-280c-d37ec2765450@kernel.org>
Date:   Tue, 22 Mar 2022 11:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v6 16/18] dt-bindings: arm: msm: Convert kpss-acc driver
 Documentation to yaml
Content-Language: en-US
To:     Ansuel Smith <ansuelsmth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20220321231548.14276-1-ansuelsmth@gmail.com>
 <20220321231548.14276-17-ansuelsmth@gmail.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20220321231548.14276-17-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/2022 00:15, Ansuel Smith wrote:
> Convert kpss-acc driver Documentation to yaml.
> The original Documentation was wrong all along. Fix it while we are
> converting it.
> The example was wrong as kpss-acc-v2 should only expose the regs but we
> don't have any driver that expose additional clocks. The kpss-acc driver
> is only specific to v1. For this exact reason, limit all the additional
> bindings (clocks, clock-names, clock-output-names and #clock-cells) to
> v1 and also flag that these bindings should NOT be used for v2.
> 
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  .../bindings/arm/msm/qcom,kpss-acc.txt        | 49 ----------
>  .../bindings/arm/msm/qcom,kpss-acc.yaml       | 94 +++++++++++++++++++
>  2 files changed, 94 insertions(+), 49 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/msm/qcom,kpss-acc.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>


Best regards,
Krzysztof
