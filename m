Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9646E562E30
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbiGAI2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237034AbiGAI2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:28:16 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DB173925
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:27:12 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id ej4so1993042edb.7
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=v/Zxb9W8O8eRVs5/InMAsyQTUlGI/gryyZcdLf1NOHY=;
        b=L4fMdargZ8xcfVXz6mNXitWSJTViGJv5eiUCXzkwy377I87uPo4UCG2yAVi2ceMV39
         wb1WtjigHk/ie6BZQl4gGH2rX7a0ksABSn/XW8NlTmAbO/xapLc7p7uMkAmvm6VekWbV
         gVDrmxiMazZioK8nfFKqfQq9wtTNmsz1GJd9dazzBZoKykagkA8qhsECI7lCBSjOIkyF
         6+fc+KwbYu0aAt5LyDLQRJzVrqASGVKj7eQrVfh2Dlyw4vOpIRCHirFkmWRk4SRUvEYQ
         ZsPvF1rS7SDTdZaF4siqubFwHtbIY6L0wJMGdUBnywhpA+6YVlZKysRuNTJliE/iQULz
         bKig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=v/Zxb9W8O8eRVs5/InMAsyQTUlGI/gryyZcdLf1NOHY=;
        b=huYCNxiQLEo7wso9Le8rvs+f3iW3DwesLphGcV/pU1Z8RplcxbNwFpEnw9KRSL/n4z
         eSrlmjPl3kg5FASlt+N4hfhmabWwvZLlH9Z0Joc1aEhmNXAthx5T+6FI331J35+CWvfX
         wRoP4oAjPRSpOsQLwOewBxugD66n/r4U0lnoZvlUPW3dpb/DkZ7+/f0hJq1Im91erFZh
         /xZw9smQxGwmlRw9Odmpr052aD3+yFqUQM3hjjP6iDKYvqhE+gf9mnMNQBVWZBvScyIa
         6fpr/lWSZSrOHfhnRZ+/Uyl8gPWXKPZ7IQLBeVh33R+WWjfaKN1M5iXMRWnUPb/iGoYW
         qwNQ==
X-Gm-Message-State: AJIora+MJ28eU+ceMKzMrtmvnwY9qZvHrK4cGRtUJzhg70/QJiQkKVUv
        2NE4/wWQAZUjg6NQxksa3D63+w==
X-Google-Smtp-Source: AGRyM1tScn7KIU+3W84vLEUFBbrstXRj8Nc/Bkxh/DrTf137hHWP/YmAXJJ0PaNhzaZzFdcMbhkQ+Q==
X-Received: by 2002:aa7:c38c:0:b0:435:8013:41e7 with SMTP id k12-20020aa7c38c000000b00435801341e7mr17133597edq.206.1656664030658;
        Fri, 01 Jul 2022 01:27:10 -0700 (PDT)
Received: from [192.168.0.190] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id k12-20020a17090666cc00b007041e969a8asm10180161ejp.97.2022.07.01.01.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Jul 2022 01:27:10 -0700 (PDT)
Message-ID: <a9be8f4c-ec35-1457-742b-fdef55640fe6@linaro.org>
Date:   Fri, 1 Jul 2022 10:27:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: ti,adc128s052: Add adc08c and
 adc10c family
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Nishanth Menon <nm@ti.com>,
        Angelo Compagnucci <angelo.compagnucci@gmail.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <nuno.sa@analog.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Alexandru Ardelean <ardeleanalex@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
Cc:     Florian Eckert <fe@dev.tdt.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-iio@vger.kernel.org
References: <20220701042919.18180-1-nm@ti.com>
 <20220701042919.18180-2-nm@ti.com>
 <5dbf57e4-7573-fa63-d8f1-6ecde08a0875@linaro.org>
In-Reply-To: <5dbf57e4-7573-fa63-d8f1-6ecde08a0875@linaro.org>
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

On 01/07/2022 08:38, Krzysztof Kozlowski wrote:
> On 01/07/2022 06:29, Nishanth Menon wrote:
>> The adcxx4s communicates with a host processor via an SPI/Microwire Bus
>> interface. The device family responds with 12bit data, of which the LSB
>> bits are 0 for the lower resolution devices. I have been able to test
>> adc102s051, hence adding just the missing ones in that family.
>>
>> Lets reuse the binding to support the family of devices with name
>> ADC<bb><c>S<sss>, where
>> * bb is the resolution in number of bits (8, 10, 12)
>> * c is the number of channels (1, 2, 4, 8)
>> * sss is the maximum conversion speed (021 for 200 kSPS, 051 for 500 kSPS
>>   and 101 for 1 MSPS)
>>
>> Complete datasheets are available at TI's website here:
>>   https://www.ti.com/lit/gpn/adc<bb><c>s<sss>.pdf
>>
>> Handling of 8, 10 and 12 bits converters are the same, the
>> unavailable bits are 0 in LSB :)
>>
>> Inspired-by: drivers/hwmon/adcxx.c
>>
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> ---
>>
>> Checkpatch does complain with Inspired-by: insisting it to be an email
>> address.. but I was really inspired by the hwmon driver.. Don't know
>> what else to say here.. we could probably drop it?
> 
> Drop it or convert to just test.

This should be:

Drop it or convert to just text sentence.

Best regards,
Krzysztof
