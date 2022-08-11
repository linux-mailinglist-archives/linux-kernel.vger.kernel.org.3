Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 833CD58F786
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 08:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiHKGWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 02:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbiHKGWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 02:22:00 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557247D7B5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:21:59 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w15so18355454ljw.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 23:21:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=8hursMRXMAUUQjiQSUj1tnEyeQwqGDBpoW+39gp5mPg=;
        b=BfgQnUDurI1+TRka7634zdVW5kG0nSusGWy1dxJFfL56jhD1lQUWBkv8ImBSIMI500
         j1SxrhgzQDbbmc76vh/RjUUTg3bDkAy/Y15M0OwMjgF1mm6X0MHtFAYquZx21ggVXgQq
         vgy/quPIAgLfY0QTt4NI3QJv9rHZrrDrEm+34KE3rJmwgmy6zOt+nd1TUK3OPCZmZuJP
         0PYoktJsqDfpsUCfHhQFCPBEubFmhs8wDkXNlafgeLSMNDo037oZIw22dMAjaahATmmR
         GmM0XA9bfv5lG7pAZRYC5BgvmW0Gr+Tfd0idLtqg9gJFcPKmD9HAwZNuzH02jVGDF0Zp
         H9KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=8hursMRXMAUUQjiQSUj1tnEyeQwqGDBpoW+39gp5mPg=;
        b=TJO2t1xDDFR8D0uIRyS9C8vsbLFmmMePTXkIRkV+TC4/isc8y9DW/FG7IQMm8OwuV9
         WsU05LKN4HSqmDgTKpYFoCvoBnGOA4Vh/+qxsuSX5kDcEdIgXAA22gzkoP2+1tzW3dEP
         0ZRrhphUp4UkhXbb8EKX5AVSYGAWF3n0L1Zqkaa5dSYAnzCoClmPtxzplJJ+bJ3zbVak
         Q7Ad7DM4a9oOrAC5k9iswbasRH0W57pca0obIlVFFqkwvHfuFj8Hpwxggrefl280tOMF
         4j+neaf/hO45KkrCjyHTgYhMWz/cKviCLpCdd16K5he0WOhycZnTUIC/WOaTcVCThgme
         6gdQ==
X-Gm-Message-State: ACgBeo2ionjII8SQYxGbnLRaJYv1UdC4n7KIbAuJPr7rdUEJ3v2aibxe
        ySKAgNuiHs1TL1QsrTxuV59gSg==
X-Google-Smtp-Source: AA6agR720MOWvhibrkPPJh59VRmmw03TaKDN9hUt4FC2DPrhGE67ihwWpCEX4HtMhLVhjDlq1ZtQfg==
X-Received: by 2002:a2e:a58e:0:b0:25f:d8c5:3898 with SMTP id m14-20020a2ea58e000000b0025fd8c53898mr5715269ljp.302.1660198917599;
        Wed, 10 Aug 2022 23:21:57 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id t7-20020a2e9d07000000b0025e0c352465sm681240lji.82.2022.08.10.23.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Aug 2022 23:21:56 -0700 (PDT)
Message-ID: <d602099c-d054-d5d9-53dc-b7900f6567f8@linaro.org>
Date:   Thu, 11 Aug 2022 09:21:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: chrome: google,cros-ec-type: restrict
 allowed properties
Content-Language: en-US
To:     Prashant Malani <pmalani@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        devicetree@vger.kernel.org, chrome-platform@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220810143613.482724-1-krzysztof.kozlowski@linaro.org>
 <YvP6u8SRHswA1Iva@chromium.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <YvP6u8SRHswA1Iva@chromium.org>
Content-Type: text/plain; charset=UTF-8
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

On 10/08/2022 21:36, Prashant Malani wrote:
> Hi Krzysztof,
> 
> On Aug 10 17:36, Krzysztof Kozlowski wrote:
>> Describe exactly what properties are allowed in Google Chrome OS EC Type
>> C port, so the schema can properly validate the DTS.  Existing DTS
>> defines always connectors with unit addresses, not a sole "connector"
>> child.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Micro-nit: the tag in the commit message is missing a trailing "c" in
> "cros-ec-typec". Other than that,

Thanks.

> 
> Acked-by: Prashant Malani <pmalani@chromium.org>


Best regards,
Krzysztof
