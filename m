Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A11D50075C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 09:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237604AbiDNHpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 03:45:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240708AbiDNHoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 03:44:01 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C27F5C357;
        Thu, 14 Apr 2022 00:41:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id lc2so8362984ejb.12;
        Thu, 14 Apr 2022 00:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hsjfJ6kNyOdmk849dkXwmpwJx9bBByejcTJHu02YdnI=;
        b=OOBFZscKCDVHuImiGxP4PahXd3VpmRBSqVBz0rxiuq7OgqnedoqYRC8XpPwzi4tXcf
         cUoDpUA1jZqnPD1nBNrWjqNwVroHsRrlBgKu60+gffwg97pevSxwTUphb0qSbiYeGQKa
         3YBOiLsr7YPWI7dv+QUgvUq20iYagdNq5n3kK+m8li9FDM9L4PpoYWuzERD4L5Nj3yz0
         D/9jdIhTA4Il+/5bsbmj5/Q++mWJknGQXHBELqzt3v1InF+BrXRqoWXfByJhKYRGBpm/
         SKL+eju+TOWUisO41z7uh73l2lWyZU0jcihVxK0BOnrPLb3zan7w6IJoCQIEyI+aT0fC
         iTdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hsjfJ6kNyOdmk849dkXwmpwJx9bBByejcTJHu02YdnI=;
        b=p8ixT4yY6vvDBRi2InwVWBO1e7rn+nNraRVlCrAx60uN/tfj9odCki25ea9AthM5JA
         1P0YwDfA+AbIHZfjMWvUjHwEb0b77X3LDt47/qygUV+p78jF+nMqV0k4kLE/cvhuKP2x
         4NZjKaj5VDx5TBH1Ay9NZRzZL1ZkF53ydOLcDxs/oPuId32BjInDedfjw868+i3uiWjM
         ofNthCjOHLVhqcT0vs0HFGWVKbtuYNUYh1Ym+H7ba+LdsTdhVZan8RcHBzkYACX8eZvp
         qBo3KO6wf06LPRk6oN3u4NdrIv84hXbtcf9eu7ZusFDeXwBLkG1/oWgaTJb5prjhj+YJ
         UDMg==
X-Gm-Message-State: AOAM530TgwRt2n6l+G62EwTNabxSmV6wMWf2zUF/RU+YKKW8Qfe3VO16
        rkbgU/H7YXLS3DOOi6Fb+GA=
X-Google-Smtp-Source: ABdhPJyaJYKew2SO25i61AvtBgkDD8PLjatVIn+03272639bqiiIjwjiKiJpaQuYUMWnL9efVxDhTw==
X-Received: by 2002:a17:906:7304:b0:6e0:6918:ef6f with SMTP id di4-20020a170906730400b006e06918ef6fmr1222274ejc.370.1649922070582;
        Thu, 14 Apr 2022 00:41:10 -0700 (PDT)
Received: from [192.168.0.182] ([188.24.22.234])
        by smtp.gmail.com with ESMTPSA id lb4-20020a170907784400b006e0d13f65e5sm370876ejc.167.2022.04.14.00.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 00:41:10 -0700 (PDT)
Message-ID: <0de7fcb5-0d5f-d8b3-448a-2bc14cef21ee@gmail.com>
Date:   Thu, 14 Apr 2022 10:41:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v1 2/3] iio: ABI: adc: ad4130: document
 filter_mode{,_available}
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
References: <20220413094011.185269-1-cosmin.tanislav@analog.com>
 <20220413094011.185269-2-cosmin.tanislav@analog.com>
 <CAHp75VexJBnAqoQ53=_nif=bso0-cNj4EsTbUwKGKxfNq_Fvyw@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75VexJBnAqoQ53=_nif=bso0-cNj4EsTbUwKGKxfNq_Fvyw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/13/22 17:51, Andy Shevchenko wrote:
> On Wed, Apr 13, 2022 at 4:17 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
> 
> It's good you provided documentation, but I think the part "ABI:" is
> not needed in the Subject.
> 

Then I guess I could merge this patch into the driver patch?

>> AD4130-8 is an ultra-low power, high precision,
>> measurement solution for low bandwidth battery
>> operated applications.
>>
>> The fully integrated AFE (Analog Front-End)
>> includes a multiplexer for up to 16 single-ended
>> or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip
>> reference and oscillator, selectable filter
>> options, smart sequencer, sensor biasing and
>> excitation options, diagnostics, and a FIFO
>> buffer.
> 
> Indentation issue as per patch 1.
> 
> ...
> 
>> +               Set the filter mode of the differential channel. When the filter
>> +               mode changes, the in_voltageY-voltageZ_sampling_frequency and
>> +               in_voltageY-voltageZ_sampling_frequency_available attributes
>> +               might also change to accomodate the new filter mode.
> 
> accommodate
> 
>> +               If the current sampling frequency is out of range for the new
>> +               filter mode, the sampling frequency will be changed to the
>> +               closest valid one.
> 
> 
