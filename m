Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F845060FB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240738AbiDSAeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237339AbiDSAeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:34:18 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8362B252BB;
        Mon, 18 Apr 2022 17:31:37 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z2so12129970oic.6;
        Mon, 18 Apr 2022 17:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l3P9PjhfHuCpvqzF+ZqNPQTIIRdb3ybkqU2a6dT8SNQ=;
        b=ZKIcCztaaPhkBFN1gl78sGCxj6Mb7Jn84jMDAql+zxv3HIpncAEJ+kuJuk8c3CY9N3
         ih0Z4aWAbJ2ho10+w5mGoMKUt1un/O1y1rEXtVOzhFBoVPkvDRInrfF7vtnzI7Ym5ukS
         pOsvYa16wLMpO5AlpNuMAFhsUW8tlQKkadKLlGYBpIJPIhEA9WsuSaTYBW3aSZ1b8vVF
         48EcyUCQJaeK+xDXOakW86hlUjCGfcUrxAmgxcO7BbSmLGSt8gi/DSM5BRtbC3Llsr+t
         EQKkd2j2VUZzmrDLiSJ3eCJL43cV/dv1mMvlRSsmIRbGQK9sQMED3kCstBQH6wGnpwts
         Y2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=l3P9PjhfHuCpvqzF+ZqNPQTIIRdb3ybkqU2a6dT8SNQ=;
        b=xG9kbrEWr72mI4njrXnmwVZjrM23et4Z3zqBXA7scLqgSPd6mqxQVPRZHi6R7lqQy8
         PUfG/e1lG8fK5U0HSd7tZVeNTFiP48WymW16Q8RFHtdXpiVk6jLQ0BvYTPRXzoW6icIX
         6iEzAjYeXIPh1Pyjq+7Hyo2khJBtHKJ1Noyl8Se/In/6SxrObLBporjbPnsRgWoRIw+6
         MhP6VHbdgp1cf0sbPs8+tTKeGREwcVve4k+gKu7kKaa2IH31N4ka3uLR1SwLNbCLjE/n
         JfibPLV0xPdBpiTLljvCvncOgHi80wR8d0zuG8o/2h/l7oFqztfwrMwdriotW/oQbA8z
         sEHw==
X-Gm-Message-State: AOAM531xxkjSebvQx8zOncjzivXM8GeMtvjD/fVyVpQlj/U5hrJnII+2
        GilnXGFlr8m8OGBuCTxRTJg=
X-Google-Smtp-Source: ABdhPJwduSb9kwZxv56nBz6qFZLyepDIgaQZkBx/777OXZhLguqJzbldn5cCB1iBPakA8XT2OTe7Ow==
X-Received: by 2002:a05:6808:ec2:b0:2f7:34db:691e with SMTP id q2-20020a0568080ec200b002f734db691emr8284352oiv.252.1650328296848;
        Mon, 18 Apr 2022 17:31:36 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e22-20020a9d5616000000b005ceb68be2f6sm4827697oti.63.2022.04.18.17.31.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 17:31:36 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <11b9d3a6-74c0-6375-002b-ae5d2b69122d@roeck-us.net>
Date:   Mon, 18 Apr 2022 17:31:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v4 0/4] hwmon: add lan9668 driver
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220401214032.3738095-1-michael@walle.cc>
 <95a2e996285649dadba673f2f0614192@walle.cc>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <95a2e996285649dadba673f2f0614192@walle.cc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 10:44, Michael Walle wrote:
> Hi,
> 
> Am 2022-04-01 23:40, schrieb Michael Walle:
>> Add a temperature and fan controller driver for the Microchip LAN9668 SoC.
>>
>> The temperature sensor uses a polynomial to calculate the actual
>> temperature. Fortunately, the bt1-pvt already has such a calculation.
>> It seems that the LAN9668 uses the same Analog Bits sensor as the
>> BT1 although with a different characteristic. To be able to reuse the
>> code move it to lib/ as it seems pretty generic to calculate any
>> polynomial using integers only, which might also be used by other parts
>> of the kernel. Another option might be to move the code to hwmon-poly.c,
>> I'm not sure. Thoughts?
>>
>> I also plan on submitting patches to add temperature sensor support for
>> the GPYxxx and LAN8814 PHYs which also use polynomial_calc().
>>
>> The last two patches adds the actual driver and the dt-binding for it.
>>
>> changes since v3:
>>  - validate input frequency in lan966x_hwmon_write_pwm_freq()
>>  - enable sensor before registering hwmon device
>>  - automatically disable sensor when driver is removed
>>  - set the required clock devider in case someone changed the
>>    hardware default before the driver is loaded
>>  - remove extra empty lines
>>
>> changes since v2:
>>  - strip unwanted copy pasta.. oops
>>  - use "select REGMAP" instead of "depends on"
>>
>> changes since v1:
>>  - add doc string to polynomial_calc(), moved the comment
>>    into the function.
>>  - add missing "select POLYNOMIAL" to the bt1_pvt driver
>>    Kconfig symbol
>>  - add hwmon driver documentation
>>  - cache sys_clk rate during probe
>>  - add missing ERR_CAST()
>>  - adapted comment for the PPS->RPM calculation
>>  - add temporary variable in lan966x_hwmon_read_pwm_freq()
>>
>> Michael Walle (4):
>>   lib: add generic polynomial calculation
>>   hwmon: (bt1-pvt) use generic polynomial functions
>>   dt-bindings: hwmon: add Microchip LAN966x bindings
>>   hwmon: add driver for the Microchip LAN966x SoC
> 
> Any news here? Or did I miss anything?
> 
> -michael


Just way behind with everything

Guenter
