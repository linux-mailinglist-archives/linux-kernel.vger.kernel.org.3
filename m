Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE22A521EA4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbiEJPdL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:33:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238821AbiEJPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:32:56 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2927A455
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:25:27 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t6so24342976wra.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Xkw8x/HFyh34BRp5dxt39ynLWcmgy3/wKHs3IXpzSLM=;
        b=ICwGoJ0OUpBDHHh3WkNt+kR2tAG6jvm/qNDeZ08xb36hTHAnXYFp5PZbjH7J9C6KGo
         nZqNbW8/Z5xphRB9s3vj0NpzTD6qnbydBusPavffqjc2KxF5h/6EbJp21h4jgfOTakZm
         JbzPYxfyNb7IHANUXVwWMQkbk5GtKYQDqALMHUfkarsEYn77nWGdtBXpWNU9zkqkWs02
         tLEYQN5BV51AkzRU2ObSYdo2JCh+CoOF5IZg1Eh40WNjtoPgyhobKxyxrsAt8bMbFgYV
         pElfQfM0n/7lxaP4XFPpekD9knpSpMSks/Shvc8STufGgIZSOewrWfDN3bAFdaPKYnTm
         ynIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Xkw8x/HFyh34BRp5dxt39ynLWcmgy3/wKHs3IXpzSLM=;
        b=kKaeh+9K2eXeInFeppjyQUAOgyhIURIyrDia6cNwhm43ufB3LZDlEL8lk2ySwsxvbs
         ra8GYwsP6W65SiGM+bZ3okj7Rt7h5aU4u6baWIOjUhnnw+aNRbs+ONwst1FdKyJv3WNY
         FI/XwSDrXaHng5Xlh8h3/kMoP5xn/euNUTe7Sb1tZ3lZe1dY/682kgD9SC0G8I562+V+
         CoYaVK4wIU3ZMkS979N9xFpfs0IwoXKHzbGpVk404diuWoVIbl4PG0k4MNnD+rj9PJQF
         ehhfwftWSiyZM3qVaaaJBUpRjLeQTMsWzTVoJBwILOOmkptbsryXPE1GjYT/VCwdj5s8
         axlQ==
X-Gm-Message-State: AOAM5335s5ojlasJkzrImHsdiuxGIRinEBXZO1jvQcNvbI3Iw0XnSnKW
        MNJOqQcZ8V4gSQNJOIf0cjgj0Q==
X-Google-Smtp-Source: ABdhPJwpVJChl7iwmonUGnOdNiozvf+YImVU+PSg22XVjkM7IFbRrKWVeyF70dttGBGyulvEvEagLQ==
X-Received: by 2002:a5d:5251:0:b0:20c:d4d4:42ee with SMTP id k17-20020a5d5251000000b0020cd4d442eemr4526700wrc.382.1652196325695;
        Tue, 10 May 2022 08:25:25 -0700 (PDT)
Received: from [192.168.1.41] (176-182-171-101.abo.bbox.fr. [176.182.171.101])
        by smtp.googlemail.com with ESMTPSA id l7-20020a5d5607000000b0020c5253d904sm14131202wrv.80.2022.05.10.08.25.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 08:25:25 -0700 (PDT)
Message-ID: <d94ea6b0-e138-951d-5405-375255104adb@linaro.org>
Date:   Tue, 10 May 2022 17:25:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v6 4/4] thermal: k3_j72xx_bandgap: Add the bandgap driver
 support
Content-Language: en-US
To:     "J, KEERTHY" <j-keerthy@ti.com>, robh+dt@kernel.org,
        rui.zhang@intel.com, amitk@kernel.org, kristo@kernel.org,
        vigneshr@ti.com, krzysztof.kozlowski@linaro.org
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220427064635.24898-1-j-keerthy@ti.com>
 <20220427064635.24898-5-j-keerthy@ti.com>
 <78a3cc4d-8ce4-0dae-2f4e-7522a0a3aa0b@ti.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <78a3cc4d-8ce4-0dae-2f4e-7522a0a3aa0b@ti.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2022 05:10, J, KEERTHY wrote:
> 
> 
> On 4/27/2022 12:16 PM, Keerthy wrote:
>> Add VTM thermal support. In the Voltage Thermal Management
>> Module(VTM), K3 J72XX supplies a voltage reference and a temperature
>> sensor feature that are gathered in the band gap voltage and
>> temperature sensor (VBGAPTS) module. The band gap provides current and
>> voltage reference for its internal circuits and other analog IP
>> blocks. The analog-to-digital converter (ADC) produces an output value
>> that is proportional to the silicon temperature.
>>
>> Currently reading temperatures only is supported.  There are no
>> active/passive cooling agent supported.
>>
>> J721e SoCs have errata i2128: https://www.ti.com/lit/pdf/sprz455
>>
>> The VTM Temperature Monitors (TEMPSENSORs) are trimmed during production,
>> with the resulting values stored in software-readable registers. Software
>> should use these  register values when translating the Temperature
>> Monitor output codes to temperature values.
>>
>> It has an involved workaround. Software needs to read the error codes for
>> -40C, 30C, 125C from the efuse for each device & derive a new look up 
>> table
>> for adc to temperature conversion. Involved calculating slopes & 
>> constants
>> using 3 different straight line equations with adc refernce codes as the
>> y-axis & error codes in the x-axis.
>>
>> -40C to 30C
>> 30C to 125C
>> 125C to 150C
>>
>> With the above 2 line equations we derive the full look-up table to
>> workaround the errata i2128 for j721e SoC.
> 
> Hi Daniel,
> 
> Any feedback on this series? Let me know.

There are a few but that would be nit picking and I don't want to 
postpone this driver any longer.

How do you want to proceed? Shall I take it through my tree?


-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
