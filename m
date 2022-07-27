Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5AF5829E5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 17:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233511AbiG0Pou (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 11:44:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiG0Poq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 11:44:46 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACDA47B91;
        Wed, 27 Jul 2022 08:44:46 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id 70so16492736pfx.1;
        Wed, 27 Jul 2022 08:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=QlqJyCLvvK+TzxVp0Du/4sfixvkQDQzIZY8oBXbSMvI=;
        b=Bwdq8tjLd/xcPIAX/uEU4inNf7eeMUPTp9P1C+D0MChY+VIXw28n3UkSB/a1OdUNj0
         0+QFhKaZN1H0VWQDVV4xwl3vHnsEj+cnfTVGWkv5YeZjdGg5tPLjPWcJ0N1SUU1v9kBN
         ZFe5SUBKqVGeSE+tpUXxbUFrmy3y1XCjwkzIE98+N8n8A5pVcp8/jJedgnzPRquBnRkq
         dUOU6rx0R4mNCZ//8Mi79hRHJBZJ8uHiFcSKMx03ltmwyZjiKxtUWR3cqcepMKY8QsYc
         CYHsiHY2a+niuSncMud8bS/oOwb0jPlN+P/pR4tHOnRF5Rf8ZlFFToN7pdTaxb/20C8N
         ONCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QlqJyCLvvK+TzxVp0Du/4sfixvkQDQzIZY8oBXbSMvI=;
        b=4iOCBhaCUaxoHghbr2BJODEQv4JiVRPTn5zwG6qTIxXQIuYehcXFqfTWhezugRQHL4
         Bd5PjqloQ5vOcS5V26UDe7qcXi5WDLlMXyEktnNHetvuCPqrLQJyoicS3TVt0LIabkRd
         77gJf5xNY0MeeDPDcnBCyC5yOrO7F7E+13L/2Wk1XFfKOc9OqTWNfG/9zhRhJ8ETd8tE
         El50iO3b2DI1OF1BHVAmIETn3Zq8nEzCv93SSppBp+Ym/5IuFJuibwg5AcLQROeL+PJ+
         RYMSV9KRmqwlX6agvKDPTvCGz6dthfun10x8AtOsQMjxgtK845R7Girb6x7sQZA9wyUf
         0oeA==
X-Gm-Message-State: AJIora873qUNbxv4pVMZBsFEiuAB1niXk7PbXkQTQcO/3mChY2bi+zA5
        g7UKVfBN/xESXV2cKt8f+Fg=
X-Google-Smtp-Source: AGRyM1sDCBNblHpd1A/SV3TzZb8mfKld5q5VlxnaFVr0AN48IX0aLrkPmvmWp+XpPjoMYuy/0dqNWQ==
X-Received: by 2002:a63:2a95:0:b0:41a:27e5:1996 with SMTP id q143-20020a632a95000000b0041a27e51996mr19160174pgq.447.1658936685669;
        Wed, 27 Jul 2022 08:44:45 -0700 (PDT)
Received: from [10.10.20.47] (125-228-123-29.hinet-ip.hinet.net. [125.228.123.29])
        by smtp.gmail.com with ESMTPSA id d10-20020a170902654a00b0016d1e514ec5sm13849539pln.139.2022.07.27.08.44.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Jul 2022 08:44:44 -0700 (PDT)
Message-ID: <47516b38-58e1-e3c9-1ac2-7b8d8586566e@gmail.com>
Date:   Wed, 27 Jul 2022 23:44:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/1] iio: humidity: hdc100x: add manufacturer and
 device ID cehck
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Patrick Williams <patrick@stwcx.xyz>,
        Potin Lai <potin.lai@quantatw.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220727064415.940690-1-potin.lai.pt@gmail.com>
 <CAHp75VfNmq12Yv7mqVeijqK0vwRdPsSrH5wMzg9qR15+t7ArSQ@mail.gmail.com>
 <a385e266-b24e-7ffb-c083-891edd4b0b14@gmail.com>
 <CAHp75VdjvJRwzPLLdMji+_m2tQY4JLBcNwt-QFkDJTyGFUOdKg@mail.gmail.com>
From:   Potin Lai <potin.lai.pt@gmail.com>
In-Reply-To: <CAHp75VdjvJRwzPLLdMji+_m2tQY4JLBcNwt-QFkDJTyGFUOdKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Andy Shevchenko 於 7/27/2022 7:56 PM 寫道:
> On Wed, Jul 27, 2022 at 12:42 PM Potin Lai <potin.lai.pt@gmail.com> wrote:
>> On 7/27/22 18:00, Andy Shevchenko wrote:
>>> On Wed, Jul 27, 2022 at 8:46 AM Potin Lai <potin.lai.pt@gmail.com> wrote:
> ...
>
>>>> +       data = device_get_match_data(&client->dev);
>>>> +       if (data) {
>>> This check is redundant. Too much protective programming. Just oblige
>>> that matched ID has to always have an associated data.
>> Is it guaranteed that device_get_match_data will not return NULL? I find some examples in other drivers, all of them have a check on returned data.
> No, but as I said you may guarantee that by obliging developers not to
> shoot in their feet.
Thanks for the explanation, I will remove the checking part.

Potin
>> Will it be more appropriate if I move device_get_match_data to probe function, and return EINVAL when we get a NULL pointer from device_get_match_data?
> Why is this check needed? We do not like dead code.
>
>>>> +               if (!data->support_mfr_check)
>>>> +                       return true;
>>>> +       }
