Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A901D4CE72C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 22:12:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiCEVNj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 16:13:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiCEVNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 16:13:37 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7751164BFF
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 13:12:47 -0800 (PST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4A3373F614
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 21:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1646514766;
        bh=c7nvDWFcwUU/UCEXDJQ70xZTwc42c5nskfhluppR+58=;
        h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
         In-Reply-To:Content-Type;
        b=B2nfFygCbl/IfokpY9TqXZqYKX2OA+4PFQfgrVtdz/3QQGCkwSHGuLJv9+QhME3Hc
         dEUwwbOZXxT4fnQs7c2qOcCEQCvUPFWC3x+OQTFWzyKEXevC+V9j7UYv0AOhjy0JcL
         hiRA0kqcwIf0uJOWY8bdhjOOoBRtFQ/UZYMmWsOt1n6Yh7EPWgJQjq/3Z+cSljrKdH
         w0BLOdwWjJwMFh2+CYb/7oWOE3rof/ZgnzGe6lAB0BjRfVInnmYI29WUOxmAQWdb2k
         GNBUrWvKVjweMn1oeCJNi8/f6d/DYVTstIVOBKMPzzqW2dVwSaQyXRcRF2BWSxC02/
         OtxOmr6ZFBiYA==
Received: by mail-ej1-f69.google.com with SMTP id d7-20020a1709061f4700b006bbf73a7becso5978212ejk.17
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 13:12:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=c7nvDWFcwUU/UCEXDJQ70xZTwc42c5nskfhluppR+58=;
        b=ifn0hRD/5N5ZYkUV0l9BsdwPLnENkOHHAY4x3wUBCdAweYGtWwQwX3KuxZMjHkU4lm
         Z9SogEbsKwLpJG1ghfDLIIDZz02PGUHljKrhVcHmnURcop5FxTkBNddhtNax33XbJJLu
         SiUFZ1ent+rqxpUpQeuqrxh0UXS2u2e1fdGYxVhQp7knoWwW/vUKbTRbq94nzLohbAaa
         d53TsZ1Sl5hd4bNlwXuysL/P6a2ZfSjUMwUS/sE9SqbuAsMwWn3odlLrzpRbVeQt/0dw
         As7UKf3ONtKE0IWZ35gk4xi9v55C9ox4xpicX/9JOIDwmJGUKq/a9Oin8FK/HWO0ha8L
         j+vw==
X-Gm-Message-State: AOAM530mxY5XTO9K0hK3oSAAoe7HNrWfL6zWk6mcQC7wAhrGMCUDW4CF
        H9YTKaUxZpjdtqMxf+zgbKPVlGSD5OzA6vZ+oYP+0MlxUDD0GCt7vTEWiOmwSV9TLoQevhasjFF
        dy7FqXU6ULB+e4voJitImBJP22sWfRmYfq/zHl0Vv+A==
X-Received: by 2002:a17:906:2846:b0:6ce:21cd:5398 with SMTP id s6-20020a170906284600b006ce21cd5398mr3859161ejc.49.1646514765640;
        Sat, 05 Mar 2022 13:12:45 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQWtd1Rccv7Kbrfkpj21uOWYbCPVJQ8Isf4LoTsdDQe/XmKzNu3ITY1TALeARndSrDs8ssrg==
X-Received: by 2002:a17:906:2846:b0:6ce:21cd:5398 with SMTP id s6-20020a170906284600b006ce21cd5398mr3859151ejc.49.1646514765494;
        Sat, 05 Mar 2022 13:12:45 -0800 (PST)
Received: from [192.168.0.139] (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id o2-20020a50d802000000b00410d7f0c52csm4018060edj.8.2022.03.05.13.12.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 13:12:45 -0800 (PST)
Message-ID: <ed2c1e67-4d45-5602-7adc-be0451c7ae1f@canonical.com>
Date:   Sat, 5 Mar 2022 22:12:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 3/4] dt-bindings: firmware: qcom-scm: Document msm8976
 bindings
Content-Language: en-US
To:     Adam Skladowski <a39.skl@gmail.com>, phone-devel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220305164906.16853-1-a39.skl@gmail.com>
 <20220305164906.16853-4-a39.skl@gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220305164906.16853-4-a39.skl@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/03/2022 17:49, Adam Skladowski wrote:
> SCM driver on MSM8976 requires 3 clocks.
> Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
> ---
>  Documentation/devicetree/bindings/firmware/qcom,scm.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Same as in other patches - missing blank line before SoB.

With that fixed:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>


Best regards,
Krzysztof
