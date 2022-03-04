Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8324CCFCC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 09:18:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbiCDISz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 03:18:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231388AbiCDISw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 03:18:52 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE77819532D
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 00:18:04 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id u10so9824908wra.9
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 00:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=I+flpTKg5dHml1L8DmfaE4buKIPkOp2S1a3s/eAOkBk=;
        b=xJ7niO+GGxG9Panzv0vbxkO0rbOM0lt7COu6CAevUE9r3iWHD9/lR69sbvzWPrV28A
         sJ3GW41aTv/zCYJuWgvzMPPMQYlf/p24Q1oiCTnCEWcq4eA9f84VaJNT/CRkS9/9Z/MV
         Uix40rQpgdGfnoESPGEDF4HbkU296Z9rcGHxBTHSwLfWJoyokG1FnmJFONci6fo6IrWe
         WEEMKT77qGva/fyjxc56GFRlHsNqq3X1G11nXOWbVJxMaaYpcia4cbtfuL55YVzuCc9M
         XQF2WFToa/hQfnE1VClwCLrDoktrANxh5wj2MVNUkTo6qP7PEbYVb2oGxiglhmd8eCS/
         dFCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=I+flpTKg5dHml1L8DmfaE4buKIPkOp2S1a3s/eAOkBk=;
        b=qb5gPus3aNPfE/Hlllm2ZakeWoT4QlrtaS1zlP4FgYO4/RrXvHMiLhPDgXOI3nEg4g
         9SwX+67T+2BrNNjXEP51rJpI/bO1f0/BETr7TAlFBcgvDDsua+UPH0XXGmw43dYNSj/+
         YsQYU0c6zRdYisikDExCUQGFVjRwYB8RrWYvT/3Sj68/mQOnfRoPxI2Lt2tD9Fzi9AyZ
         MwS8dJSJSziSu+eg2jORD9PPV0EwXKX673RQ7RY3b/6gH6yjjOnT6Mkk4P6q0kzyh57H
         /ud+Nj0MLoMECVFKRxaELBcoMLf3jKSrQ7KKILYM3UjqfoxpkL8lVx5+sUCA3CN7wUUq
         WcaQ==
X-Gm-Message-State: AOAM533uAgki7ntIITZ71jNuW53v3SUzg3c2iG7bSJvCKkO+6/bKeBmv
        02iDzyj/NCFlBTK6dETBU71Krf1Vf8rJEg==
X-Google-Smtp-Source: ABdhPJwwa5VRS/zs4BjK6Sm7CwmQqQ2MQTaT9LIqxStSjhE7VL9P2O1NzIKlbjmvWb3BsHU4fS5Qdg==
X-Received: by 2002:adf:a39e:0:b0:1ef:b97f:ae91 with SMTP id l30-20020adfa39e000000b001efb97fae91mr17478011wrb.591.1646381883394;
        Fri, 04 Mar 2022 00:18:03 -0800 (PST)
Received: from ?IPV6:2a01:e34:ed2f:f020:551f:d79e:5d4c:9b99? ([2a01:e34:ed2f:f020:551f:d79e:5d4c:9b99])
        by smtp.googlemail.com with ESMTPSA id m5-20020a05600c3b0500b00380da3ac789sm5088894wms.1.2022.03.04.00.18.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 00:18:02 -0800 (PST)
Message-ID: <1ed3e1b6-0a75-03e1-8698-8aa1f96fe86b@linaro.org>
Date:   Fri, 4 Mar 2022 09:18:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3] dt-bindings: timer: Tegra: Convert text bindings to
 yaml
Content-Language: en-US
To:     David Heidelberg <david@ixit.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Stephen Warren <swarren@nvidia.com>
Cc:     ~okias/devicetree@lists.sr.ht, Rob Herring <robh@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
References: <20220303233307.61753-1-david@ixit.cz>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20220303233307.61753-1-david@ixit.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/2022 00:33, David Heidelberg wrote:
> Convert Tegra timer binding into yaml format.
> 
> This commit also merge 3 text bindings with almost
> identical content (differens in number of registers).
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: David Heidelberg <david@ixit.cz>

Applied, thx

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
