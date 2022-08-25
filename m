Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE745A0B3A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237076AbiHYIV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238053AbiHYIV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:21:56 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FA69E0D7
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:21:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id k22so4008952ljg.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 01:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=5ngialnJweWTxFhnpS3C9ddQCugujDSZYGR0J8FTnHk=;
        b=rvGQEUqW0aqnj4g1kHRRzHHqlMVtjORIUuoL99n5tztXvYQ1FqengLIcpF/CE4LkYd
         /A5dX+AuvNVj8NyUiyA2ObQuqaIAMikguTsvB8dSlUfAgfn8Qazy6/bZhVRzYztl0mjk
         1nKb9AL+hyG+fw23Mvb7zVRRIPqXyLfzRe7zMmBA84NtTJPPyxxUtB+rln+3F9Wl3STt
         5mgv0hUK58wVfIIOQ/A+aVWceH58Egv8idp/ywj1Vd6nErZhjHleuGjunZr9IxMauUVU
         5P5nJj1ul2KKrW33/ZNCihGHkEqz/L8qRjj4knDNA9l+4TYNeqMFWvV+Wg9103Mqrmg3
         Ez8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=5ngialnJweWTxFhnpS3C9ddQCugujDSZYGR0J8FTnHk=;
        b=WsIyL6YZ1UJfvQwr6l4X+sUWtjbRyCR6Bl0PviaEeMMdwuGZ2Ejq2Rh4obOTOV3bML
         xRtKWWTFIuYhBTas+dVPAjmy4SMHyAGMdBNq2WZ67uITEgMj7EyMFvP1rEMqvu1mR5dI
         rIe0zDbLUvLK0X0HNjtSulnSC0PdmM8bF76uchRfqGKTbN0H1vwCbD3eSVFcMz3CW95a
         v0E7kRWMv2oCI0uMyfPU8zNdsFgsBzAIyUfwtSOJ/3Ec8N8L9ibIake35n/1hJF7GM2g
         D9Qzt9k8tE1yYm6wKSoqprZnSCkRD1YELZzIbY4LOsUF26+zGy4f+DHuBzv11+Y1kiYx
         b+ZQ==
X-Gm-Message-State: ACgBeo030B6AKVdb/uQJPG79sNYkIuUwxs4GtEaETj53HF+nWTZHYUbM
        /RnU8CVJ8HjxK1saXCfl7RJY7w==
X-Google-Smtp-Source: AA6agR7uT7Su4lHGAOiQyY9ljhllP8dx9Y2jhf2/BSPJmxMpA6d0kWUyMQOHjKrcw3F7GMJy7Oyt4g==
X-Received: by 2002:a05:651c:a04:b0:25e:753b:db42 with SMTP id k4-20020a05651c0a0400b0025e753bdb42mr737611ljq.529.1661415712008;
        Thu, 25 Aug 2022 01:21:52 -0700 (PDT)
Received: from [192.168.0.71] (82.131.98.15.cable.starman.ee. [82.131.98.15])
        by smtp.gmail.com with ESMTPSA id o18-20020a05651205d200b0048afe02c925sm363108lfo.219.2022.08.25.01.21.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Aug 2022 01:21:51 -0700 (PDT)
Message-ID: <022a60e0-17a4-cf13-d8d6-af342468acab@linaro.org>
Date:   Thu, 25 Aug 2022 11:21:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] dt-bindings: phy: Add missing
 (unevaluated|additional)Properties on child nodes
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
References: <20220823145649.3118479-14-robh@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220823145649.3118479-14-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2022 17:56, Rob Herring wrote:
> In order to ensure only documented properties are present, node schemas
> must have unevaluatedProperties or additionalProperties set to false
> (typically).


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
