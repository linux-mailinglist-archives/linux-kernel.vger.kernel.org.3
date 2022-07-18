Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE76577D25
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 10:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbiGRIHG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 04:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233574AbiGRIHE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 04:07:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E8C1208F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:07:02 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id v16so27080wrr.6
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 01:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/d0gAdqX7kp6s3Td48J8JNGJDQ1VFtGsqBAv73ecpSo=;
        b=fAJK3EqNV9xYqEkXj8sQJWgfCqWlpfNDEXjd4jR1hzZpbdwgvk4LZ0IdzoVWzBUUmj
         H7ioN/U3mO3sbJtNSZg0nCNTafoBb3WLgEo75wFQONMDTlKUvr0CtW/Yi4pURBbzm16X
         KcZyDlSfzpAtPPMWxrQ/br33HrcfLPj1onn9Z73MwpI7L9j78pAVwjZyFguexKRWkMMW
         xA7LJyqwqNZx4G8vKFhxWh+AsvRXExz93ChxbXt7Vgij1h12775WddzYwyQR/W3x6jB/
         MXvpdbkmtFzirxUyFv2G98LPDz9BwO25+Qe0HJcq5XjlujoWyrKqWVXbD1CInO/9bntx
         mvDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=/d0gAdqX7kp6s3Td48J8JNGJDQ1VFtGsqBAv73ecpSo=;
        b=mY9Br1Ib8tfWfxiEcMuNBd1J0Olam6AXo+K+cD3x3Wx4iBlEgqc105ulpoTdYO8Wgf
         BlppZ9ZHKIz6yUl0Dnxf8iBtuPh2qYihhkZmI6JTkcTyxhbmiEskY1hZs068yYgXYSve
         wbUqPcGU5WuNma5zP4iIAHO8BegGQSO4iV/pwnvnXAu65RUj+BQQgJ4ChaAwqzEdbO+f
         VYVByxEdvadXn9wqCW372XgIVnxXb2Ct5++iQb4DMamVObYP7jRpnMq6+qA6hZuYOuQu
         M8aVzW3Tfq71GID0Vwt8mddcU1May2X8Iz3S9aZI6FNVOqqybZpkx7eAQJh7lUAPAlV2
         eD8w==
X-Gm-Message-State: AJIora/K3Ci9IW4XLwxeDuO3Fax/MGici5cjx/WO3ZZ5ErwRutZcyqjn
        rLLkETAU2XAEpKgEct9qskMXDQ==
X-Google-Smtp-Source: AGRyM1uW0CJWxx5VocmPAmzlEgS08oxGVJkfPYPIba4jfme1slYyasuorVZ6gzstvYY9KSd6rXicTQ==
X-Received: by 2002:a5d:4fca:0:b0:21d:ed11:45d2 with SMTP id h10-20020a5d4fca000000b0021ded1145d2mr8308504wrw.375.1658131621056;
        Mon, 18 Jul 2022 01:07:01 -0700 (PDT)
Received: from ?IPV6:2001:861:44c0:66c0:a2b7:375c:fabd:3626? ([2001:861:44c0:66c0:a2b7:375c:fabd:3626])
        by smtp.gmail.com with ESMTPSA id y11-20020adfc7cb000000b0021d6924b777sm10444669wrg.115.2022.07.18.01.06.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Jul 2022 01:07:00 -0700 (PDT)
Message-ID: <e47b3052-953a-1612-6c64-e2deaaed111b@baylibre.com>
Date:   Mon, 18 Jul 2022 10:06:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 1/4] perf/amlogic: Add support for Amlogic meson G12 SoC
 DDR PMU driver
Content-Language: en-US
To:     Chris Healy <cphealy@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>
Cc:     Jiucheng Xu <jiucheng.xu@amlogic.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-amlogic@lists.infradead.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <20220712063641.2790997-1-jiucheng.xu@amlogic.com>
 <55be073b-caf1-320b-dd42-165636b45a74@arm.com>
 <db31472c-0494-309a-0ac3-cab845b4e74f@amlogic.com>
 <a0c763c0-eaa0-999e-31bb-d2dbaeb988bb@arm.com>
 <CAFXsbZqQC7Vq3bO8GtqtY2hyLjh=+C1qa49pH+9BORmFk6P9XQ@mail.gmail.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
In-Reply-To: <CAFXsbZqQC7Vq3bO8GtqtY2hyLjh=+C1qa49pH+9BORmFk6P9XQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On 17/07/2022 22:58, Chris Healy wrote:
[...]

>>
>> [...]
>>>>> +        goto err2;
>>>>> +    }
>>>>> +
>>>>> +    irq_name = of_get_property(node, "interrupt-names", NULL);
>>>>> +    if (!irq_name)
>>>>> +        irq_name = "ddr_pmu";
>>>>
>>>> That's not how the "interrupt-names" property works. If you only have
>>>> a single interrupt then there's not much need for it to be named in
>>>> the DT at all. If you do want to use named interrupts then use
>>>> platform_get_irq_byname(), and the name should probably have a bnit
>>>> more functional meaning. Either way, please don't abuse the DT like this.
>>> Okay, actually there will be multiple interrupts , but not in current
>>> G12 series.
>>
>> That's fair enough, so we should try to anticipate it in the design of
>> the DT binding. If for instance future SoCs are going to move from
>> having a single combined overflow interrupt to a separate interrupt for
>> each counter, then the driver can reasonably continue to get them by
>> index and we'll effectively only need to update maxItems in the binding.
>> If on the other hand there's still going to be one combined overflow
>> interrupt, plus some other new interrupt for something completely
>> different, then it *could* be more appropriate to have names, and thus
>> to define and use a standard "overflow" name from the beginning even
>> when it is the only one present, so that we can remain consistent later
>> once more are added.
> 
> My assumption is that the goal of having this "interrupt-names" in DT
> is to cover future cases where there is more than one DRAM controller
> instance in the SoC and you want to be able to discriminate between
> the two instances with this driver's interrupt name.  If this is true,
> as an alternative, you could do something like this:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/i2c/busses/i2c-mt65xx.c?h=v5.19-rc6&id=7fb9dc8109bf9713ffcda65617249099a1942f0f
> 
> This should result in each instance having a unique name that includes
> the base address as the prefix to the interrupt name which should be
> sufficient for determining which instance is which.

It's ok to introduce interrupt-names in the bindings for newer SoCs,
since it's useless for the current ones, there's no need to introduce it right now.

It's also why it's simpler to introduce a compatible per SoC, so we can add
different attributes in the bindings depending on the compatible.

Neil

[...]
