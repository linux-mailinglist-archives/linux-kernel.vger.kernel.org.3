Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 191E458D2B4
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 06:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234110AbiHIESo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 00:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233685AbiHIESi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 00:18:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68A619C00
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 21:18:37 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id x25so11818759ljm.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 21:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ktjbOwbUIz6JZWGLIYlF9Qv19zLsmQ14nlnBHaQqtKY=;
        b=fQbtoJUe4jFNbbbhRZa3Tv3NjHw8InWX5xP/yg0r7db2IBJyPK2LkV+4jCyhbDQxTw
         rS0bRSG/hcpK0Ii5M7QHqSc7nbfDNrH8nq39KCCP42jnpx40OMM+sayFO5PvyZL97k8k
         dJPX3sQtCrl/8Qx3b30gxzLIBFrnvQmGjPPpXLRAzFUHKw+plgD8zpAbIcjExJ3qS74q
         5pNKgzTmMakgmVu14v4B5GKshfCaFDntqrRboBU4fdj8b4KF09hpLWQ15iTdEnNKwlNN
         HQB0Ff1f5ldnZOq1TZ4UtvFSTmp5mgvhGd8oCI99ROxC6dFDMXGfpQQszUFs0uSzBXNK
         nDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ktjbOwbUIz6JZWGLIYlF9Qv19zLsmQ14nlnBHaQqtKY=;
        b=h0W8cdc/gNJ02MjcGlrTMzyIeUPjvJas9/dvnsMjTKAfs9YGNm1gVbvqo7vF+gnZC2
         +V//LwWwDnycGaPMoY82dPU8R8dQ4IovFz+h8lNSLqL0MJS7SLl0A8vKqt1wYmu4wbGf
         bOyLgM6aIQMz0E4ohxN8QidchuACMWYtyLx/2v7ddre+1JwUV1IyTooZBvtet6bxpUQD
         QyxCfhdKoUCV7VsWYdhFgeOQ3lbvawQveBtVTd6gjq1k8irn3jii4Lwvymc8LvFmRyQV
         gREyhL1xu6Hd0Js0IlA2kp8SuHAgdP49Y7GDNq5sgG47aRgQDjUGPUVso+4z3j1miDr0
         aYxg==
X-Gm-Message-State: ACgBeo1pWhoSk0uGJ199OGUdVCgVJIQ9ABqj41ptMQmyV5N0lQ282kOb
        oCceCAdLa088GW5eWQsA8oyPMg==
X-Google-Smtp-Source: AA6agR7anU7Jd1Qacvlqh82YFYxyDO1oFmXIYlQYQsIHymSU5X0Uh7ffWNrP57hUs0cBE78V8Gi8pQ==
X-Received: by 2002:a2e:bea8:0:b0:25f:e9ab:5a1b with SMTP id a40-20020a2ebea8000000b0025fe9ab5a1bmr1592141ljr.448.1660018716032;
        Mon, 08 Aug 2022 21:18:36 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id t15-20020a2e9d0f000000b0025e2e70b41fsm1529430lji.71.2022.08.08.21.18.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Aug 2022 21:18:35 -0700 (PDT)
Message-ID: <38c3977a-0196-1832-ff94-317064cbc439@linaro.org>
Date:   Tue, 9 Aug 2022 07:18:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 1/3] dt-bindings: spi: stm32: Add st,dual-flash property
 in st,stm32-qspi.yaml
Content-Language: en-US
To:     Patrice CHOTARD <patrice.chotard@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-spi@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        christophe.kerello@foss.st.com, devicetree@vger.kernel.org
References: <20220808074051.44736-1-patrice.chotard@foss.st.com>
 <20220808074051.44736-2-patrice.chotard@foss.st.com>
 <9ad4b4a8-988e-f185-f80c-6f15f341ce8c@linaro.org>
 <79fd7e19-ceef-14fb-5a83-603740735f8f@foss.st.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <79fd7e19-ceef-14fb-5a83-603740735f8f@foss.st.com>
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

On 08/08/2022 19:08, Patrice CHOTARD wrote:
> Hi Krzystof
> 
> On 8/8/22 11:01, Krzysztof Kozlowski wrote:
>> On 08/08/2022 10:40, patrice.chotard@foss.st.com wrote:
>>> From: Patrice Chotard <patrice.chotard@foss.st.com>
>>>
>>> Add new property st,dual-flash which allows to use the QSPI interface as a
>>> communication channel using up to 8 qspi line.
>>> This mode can only be used if cs-gpios property is defined.
>>>
>>> Signed-off-by: Patrice Chotard <patrice.chotard@foss.st.com>
>>> ---
>>>  Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml | 8 ++++++++
>>>  1 file changed, 8 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>>> index 6ec6f556182f..5e4f9109799e 100644
>>> --- a/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>>> +++ b/Documentation/devicetree/bindings/spi/st,stm32-qspi.yaml
>>> @@ -46,6 +46,14 @@ properties:
>>>        - const: tx
>>>        - const: rx
>>>  
>>> +  st,dual-flash:
>>> +    type: boolean
>>> +    description:
>>> +      Allows to use 8 data lines in case cs-gpios property is defined.
>>
>> It's named dual-flash, but what if you want to use QSPI to connect for
>> example to FPGA?
>>
>> Also how is this related to parallel-memories property?
> 
> I called it "dual-flash" simply because it enable the dual flash feature of the QSPI block (bit CR_DFM : Dual Flash Mode)
> which allows to use the 8 lines simultaneously of our dual QSPI block.

And how is it related to existing parallel-memories property?

Best regards,
Krzysztof
