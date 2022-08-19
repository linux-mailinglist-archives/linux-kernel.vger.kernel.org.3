Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A95599D93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349002AbiHSOW7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:22:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348895AbiHSOW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:22:56 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BC2BC10D
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:22:54 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id s1so3538719lfp.6
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=W6XLvvBGoke5+DVCHO7jgqha7YhANK6x+3Vpkq+XWDE=;
        b=D8TRi6N573AdxP8uKx/TO+c6SXG/77vA7hDcrIL8d3gsE1xQJjQ699vUK+9c88fr/F
         PAiowGh1zHmR8r4PPKnEbTlr4WpE9O0mq9qzYs9ZQ9AAkWkFvwxlKowTS0l1rl5yCQGP
         S1qCUwCEYxBTAu/IaaflLGnomugR39kEjvFQlr8alzIst6MYdeHVmkXfldw6M0WUXGcy
         zgaHi6WX+Tqvd6U+vtNRmAA3SgLTnygrf2nBxheJ6M/W1Ms2VFTDJSoENXq/1+T20RF/
         RSy1Smu+6gHpoSmgLVKxkvlyaEB4fNrPBNQqwcekbL0mNQIxcqo+IuTGvhg5AZlXravn
         pNUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=W6XLvvBGoke5+DVCHO7jgqha7YhANK6x+3Vpkq+XWDE=;
        b=FG6tNRBXQQzvBh+gkh86eDq2EzEAXHVmu7xhIIP2U2NzZPwBewQLPX30FECHGKFpuZ
         +VVi+6qt1ndzK8gyyXdIR/SVoCvbnZTwapb4dENHLF0Z/D7asR3TgTe8QYm3q9sNNfen
         OqnbtS4tZ28NLSMm5zxI1uLn+0rqsIhg/cbtbHqW+3fQgS03t94To5H+UF//pf5Muin0
         55oAMwvMky8v5MJrSczO5ay0hzbqOeTk8sZfBLEIQKnlAhqnb6gUWgn1xoL4RP/4zLBH
         vwecVcuj207oH3w4sUgzQ4NrYe/FoGzqWOU4a4zpTrPb34LCQG5qKUouQTQLLyEPbQUV
         e/ww==
X-Gm-Message-State: ACgBeo2bBtzDNknZ7IueTi2hiiyxBjkqxpCbviZSiUsPZHvLYdGtv8sj
        wovm3lWWlK3C0FmkCIM0wHRkRg==
X-Google-Smtp-Source: AA6agR6fwp6wpOn4Rzpjtks40Fom/eMSJFk8J9dE0Zc7x0M4BR6878593MBNvSYv+LbauP3H96P2tw==
X-Received: by 2002:a05:6512:4011:b0:492:cd8a:e22 with SMTP id br17-20020a056512401100b00492cd8a0e22mr739256lfb.248.1660918973099;
        Fri, 19 Aug 2022 07:22:53 -0700 (PDT)
Received: from ?IPV6:2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5? (d1xw6v77xrs23np8r6z-4.rev.dnainternet.fi. [2001:14bb:ac:e5a8:ef73:73ed:75b3:8ed5])
        by smtp.gmail.com with ESMTPSA id u3-20020a2eb803000000b0025e5a7bd522sm630556ljo.30.2022.08.19.07.22.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 07:22:52 -0700 (PDT)
Message-ID: <4e12e8c3-2170-eaab-d910-f674bcc93f79@linaro.org>
Date:   Fri, 19 Aug 2022 17:22:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 6/6] riscv: dts: microchip: add the mpfs' fabric clock
 control
Content-Language: en-US
To:     Conor.Dooley@microchip.com, mturquette@baylibre.com,
        sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, palmer@dabbelt.com,
        Daire.McNamara@microchip.com
Cc:     paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20220819122259.183600-1-conor.dooley@microchip.com>
 <20220819122259.183600-7-conor.dooley@microchip.com>
 <3df8d4bd-3d38-cecd-6589-ccc1be01b886@linaro.org>
 <3ffba600-bda9-8ffa-a435-9a6f94e072b8@microchip.com>
 <f3d8be5c-737b-8c71-9926-a4036c797769@linaro.org>
 <19ca2ca1-c678-c669-4214-e92416e37191@microchip.com>
 <138af26e-8e36-63a0-d3a0-5af866318839@linaro.org>
 <f8496006-7487-7b7e-1a53-ec38492dfe70@microchip.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f8496006-7487-7b7e-1a53-ec38492dfe70@microchip.com>
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

On 19/08/2022 17:14, Conor.Dooley@microchip.com wrote:
> On 19/08/2022 15:06, Krzysztof Kozlowski wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
>>
>> On 19/08/2022 16:48, Conor.Dooley@microchip.com wrote:
>>> On 19/08/2022 14:28, Krzysztof Kozlowski wrote:
>>>>> Maybe that is me exploiting the "should", but I was not sure how to
>>>>> include the location in the devicetree.
>>>>
>>>> Neither node names nor clock names are considered an ABI, but some
>>>> pieces like to rely on them. Now you created such dependency so imagine
>>>> someone prepares a DTSI/DTS with "clock-controller" names for all four
>>>> blocks. How you driver would behave?
>>>
>>> -EEXIST, registration fails in the core.
>>>
>>>> The DTS would be perfectly valid but driver would not accept it
>>>> (conflicting names) or behave incorrect.
>>>>
>>>> I think what you need is the clock-output-names property. The core
>>>> schema dtschema/schemas/clock/clock.yaml recommends unified
>>>> interpretation of it - list of names for all the clocks - but accepts
>>>> other uses, e.g. as a prefix.
>>>
>>> So could I do `clock-output-names = "ccc_nw";`. That would work for me,
>>> with one question:
>>> How would I enforce the unique-ness of this property, since it would be
>>> a per CCC/clock-controller property? Maybe I missed something, but I
>>> gave it a shot with two different CCC nodes having "ccc_nw" & dtbs_check
>>> did not complain. Up to me to explain the restriction in the dt-bindings
>>> description?
>>
>> Uniqueness among entire DTS? I don't think you can, except of course
>> mentioning it in description. Your driver should handle such DTS -
>> minimally by gracefully failing but better behaving in some default way.
> 
> It fails not-too-gracefully at the moment, but that could easily be
> changed. Truncated base address I suppose would be a meaningful thing
> to fall back to afterwards.
> 
>>
>>>
>>> FWIW I would then have:
>>> ccc_sw: clock-controller@38400000 {
>>>        compatible = "microchip,mpfs-ccc";
>>>        reg = <0x0 0x38400000 0x0 0x1000>, <0x0 0x38800000 0x0 0x1000>,
>>>              <0x0 0x39400000 0x0 0x1000>, <0x0 0x39800000 0x0 0x1000>;
>>>        #clock-cells = <1>;
>>>        clock-output-names = "ccc_sw";
>>>        status = "disabled";
>>> };
>>>
>>> & in the binding:
>>>     clock-output-names:
>>>       pattern: ^ccc_[ns][ew]$
>>
>> Yes, although this won't enforce uniqueness.
> 
> I know :( I'll respin next week I guess, thanks again.


The issue with this is that we are getting close to tying bindings with
your Linux implementation. What if other implementation does not use
these names as prefix and instead creates some other clock names (as
clock names are not considered ABI)? Your binding would still enforce
such property with a specific pattern.

The clock names should not really matter, so if you have conflict of
names among multiple controllers, I think driver should embed unit
address in the name (as fallback of clock-output-name) and the binding
should not enforce specific pattern.

I can easily imagine a real hardware board design with
"sexy_duck_ccc_pll1_out3" clock names. :)

Best regards,
Krzysztof
