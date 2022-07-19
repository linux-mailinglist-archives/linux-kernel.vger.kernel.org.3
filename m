Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9921557A3E1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiGSQBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbiGSQA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:00:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2CB047B8D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:00:57 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id d12so25554698lfq.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 09:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=DcU8Rt07AOR5UstJNBtllWkJabCi/u3+ZCpZfNLmVjg=;
        b=KKgz0fOiz3XdAZAYPr7mXNGhI7Ac+HeN442R5+8sdARHvwqZnirD6cvM9VNsEMuhUQ
         v9ezTTbDoTiaa8TxHnv5oTv+pwUVRpJLf/VBc5yaMn8jj9/wHr2dN68vbIjetICaQbHS
         opAAxtps0XRBCJUZMk4ElaOc/nC50OEmO1SmJgEorMgXicmibLsjO7G5ftfFhcmh3ixl
         TfgFA2phkmuUyEfwKsKjOIBwqZhhx6FWj+1HJaG4lyOEamTfuWkg5+sL0fL2iF5Oav9b
         sLtgZu8pvZw1ibMqMa6gx4HGJc90nQYUeKyB16qUQ9Ae2RRpqAzQzEopUmXQ6y9OD3dk
         BMWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=DcU8Rt07AOR5UstJNBtllWkJabCi/u3+ZCpZfNLmVjg=;
        b=so8mSVV+JfKjBXbmCINyHTi7nGgrx9noiXWhLxbeKXWTcZHOj5+a1d27zw0np41gou
         Bmxkz7y6rJoQdG0Md2bgjdskMHcsmFesYiub8NtYbxPIJmrZRa7qZ7lygq+IBsau2hLf
         W26GOk9ILUSK5yn3XIALqdFzkprL+FcLNc0k5dSVhIlvUylS4UqVXoMjruQa3B6d9+ZR
         +6B8iEpusiPyZ9zcqeqkY0TQwn4miTHw9AM0ccaBerCdCJaYLeXMrymNsbPXOZGHpwIS
         2jYY9Xd95nVqG1DYH8BsmXfigOpFBWyEjh63yqkTL3E7z6Kc3b2fk8xXoo7mjsM8nUNh
         5G4w==
X-Gm-Message-State: AJIora96YjB8vhE/Y0U/0MqWle5rJWAPc2Gmn05C988SmYG1IzKkpjWh
        kg+xcj0mnJ+wP6LBmYU9PPdUcQ==
X-Google-Smtp-Source: AGRyM1upUpkQqlKsacg9me3oLB7Mf83Q41aCw8Fy1xU1gd1hjql/sr92O+sUl4uvXVp8ffHwtJV2Rw==
X-Received: by 2002:a05:6512:304a:b0:489:d7eb:82c7 with SMTP id b10-20020a056512304a00b00489d7eb82c7mr18479248lfb.314.1658246456275;
        Tue, 19 Jul 2022 09:00:56 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id a12-20020a056512200c00b00489e38c4fc4sm3265799lfb.276.2022.07.19.09.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 09:00:55 -0700 (PDT)
Message-ID: <53242a5b-0ba0-71c6-3b6c-e3a628b7eda1@linaro.org>
Date:   Tue, 19 Jul 2022 18:00:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] regmap: support regmap_field_write() on non-readable
 fields
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
References: <20220719121446.375095-1-krzysztof.kozlowski@linaro.org>
 <20220719125401.GA92394@ediswmail.ad.cirrus.com>
 <d04ef271-9404-481c-f2fa-268ff51ee3dc@linaro.org>
 <Yta0nKlqOcimEH/Q@sirena.org.uk>
 <e981f4f5-fe8f-a733-9ab3-b2c8febd0516@linaro.org>
In-Reply-To: <e981f4f5-fe8f-a733-9ab3-b2c8febd0516@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2022 16:30, Krzysztof Kozlowski wrote:
> On 19/07/2022 15:41, Mark Brown wrote:
>> On Tue, Jul 19, 2022 at 03:13:11PM +0200, Krzysztof Kozlowski wrote:
>>> On 19/07/2022 14:54, Charles Keepax wrote:
>>
>>>> I think this will break other valid use-cases, regmap_readable (I
>>>> believe) returns if the register is physically readable, however
>>>> it should still be possible to use update bits if the register is
>>>> in the cache even if it can't physically be read. So really you
>>>> need to fall into this path if it is readable or in the cache.
>>
>>> But what type of real use case this would be trying to solve? Either
>>> register is readable or not. The presence of cache is just optimization
>>> and does not change the fact that we cannot read from register thus no
>>> need to go via updates.
>>
>> The original reason for creating the cache code was to simulate
>> readability on devices that have no read support at all (think 7x9
>> format I2C devices) so we can have things like helpers to map bitfields
>> directly to subsystems (like ASoC uses extensively).  The fact that it
>> also improves performance when the hardware does support reads is nice
>> too of course.
>>
>>>> Which does I guess also raise the question if your problem would
>>>> be better solved with caching the register?
>>
>>> And how the value would appear in the cache? Since register cannot be
>>> read, I expect the cache to be filled on first update. First update
>>> would be read+write, so we are stuck again.
>>
>> This is one reason we allow cache defaults to be specified (it was the
>> original reason, we later started using them to optimise out I/O during
>> resyncs).
> 
> Thanks Mark and Charles. Let me try the cache.

cache + forced write works for me, so I guess this patch is not really
necessary.

Best regards,
Krzysztof
