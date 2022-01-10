Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED30489DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 17:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237833AbiAJQzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 11:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237774AbiAJQzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 11:55:53 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F6DC06173F;
        Mon, 10 Jan 2022 08:55:53 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a18so55048527edj.7;
        Mon, 10 Jan 2022 08:55:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=98sup9AskCi3qrpoRgt3k45yyLCXHbNb1fOzgOiWQkI=;
        b=Hp7as+pB7scND40+9zHOS+E/0vGqM6rA6MKw9Kg6M+3YOoLRyTiO09jylvzughqCNl
         RPfQZ2HiuaX2I4ubtPFrSBUvi+TPKHDz1pitpJvJiAAy3UNORJFRVcN4Sgl2kdPRqRJO
         IuyZfCS/R+kHZOADbXOH+WOqjqIUVlQUia3lWUTAO0f1FoY6Aw7fm/WSpZUGzeKVclQ5
         x685KEGl2QewISnn7Hd4/q2cSYYwm1p65FAc3LPnrdhvq4dHN91opjguTjSQq/+3Xg1l
         663z+AFaNqacmZna540Pt2maEFVge5sgBBOjmvw8tDS0yYyu9dysUhcUeQ8rELhf9h34
         PQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=98sup9AskCi3qrpoRgt3k45yyLCXHbNb1fOzgOiWQkI=;
        b=N2ibwQNb7UpUa01ma4f15AyBV9ArVN4sI7f4YAsxB6ubLJp04lHPP1qTwb4dtKVNuT
         MDctBzErc7Y2PuJmyHGqggKGDkqBC1D3uvx1VQ/G3gtX4RrcjVMx++rWAswrErTGMbtf
         +QCv5UdVDMiuGgt3CT6kkGbHoOo/h+pK7SxQgJpxzzDWuEFAN0OfusdLjfW6p/eknljH
         undZf/S+5ZFNDXHRAp16chzTk3Su/T9LsRkbU4dbPBU7hVz+uXxIzd+x7Czsxxk5OT5n
         qCzqZdkRjikMlHduoHw8d5c2g+K1SO56zQOI6lzYUJpNGwI6W+zabET+D1zaKkyWJf4V
         Glzw==
X-Gm-Message-State: AOAM532Hm6/1/crZOIhL2jCUoITGqnvhNZAxm5uAexi4CJmFRAgHOUA8
        MqiHAzPGbPFdXa2lmWkkLjo=
X-Google-Smtp-Source: ABdhPJycxsU5KRss6M8Wbj7exc5lQ/SLX2+xO6gdhTVoJNFRrXue40+X1zvsip5ZCR3B7BYXY6F5ig==
X-Received: by 2002:a17:906:d78a:: with SMTP id pj10mr518641ejb.72.1641833751673;
        Mon, 10 Jan 2022 08:55:51 -0800 (PST)
Received: from [192.168.0.182] ([79.119.107.253])
        by smtp.gmail.com with ESMTPSA id hs32sm2399662ejc.180.2022.01.10.08.55.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 08:55:51 -0800 (PST)
Message-ID: <953f1539-a4fc-ab8e-bcf9-287ac91ba42b@gmail.com>
Date:   Mon, 10 Jan 2022 18:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH 3/3] iio: addac: ad74413r: correct comparator gpio getters
 mask usage
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     cosmin.tanislav@analog.com, Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
References: <20220106062255.3208817-1-cosmin.tanislav@analog.com>
 <20220106062255.3208817-3-cosmin.tanislav@analog.com>
 <CAHp75Vcq76iaHHp2oXFsaE4d_+EGH87DxQRYu7Ys-adN_4mmUw@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75Vcq76iaHHp2oXFsaE4d_+EGH87DxQRYu7Ys-adN_4mmUw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/9/22 14:13, Andy Shevchenko wrote:
> On Fri, Jan 7, 2022 at 7:34 AM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>>
>> The value of the GPIOs is currently altered using offsets rather
>> than masks. Make use the BIT macro to turn the offsets into masks.
> 
> of the
> 
> ...
> 
>> -       status &= AD74413R_DIN_COMP_OUT_SHIFT_X(real_offset);
>> +       status &= BIT(real_offset);
> 
> But this is completely different.

What do you mean by this is completely different?

It was broken before, it is fixed now. Indeed, I'm missing
the Fixes tag, if that's what you meant.

> 
>> +       bitmap_zero(bits, chip->ngpio);
>> +
>>          for_each_set_bit(offset, mask, chip->ngpio) {
>>                  unsigned int real_offset = st->comp_gpio_offsets[offset];
>>
>>                  if (val & BIT(real_offset))
>> -                       *bits |= offset;
>> +                       *bits |= BIT(offset);
> 
> So, how was it working before? If it fixes, it should go with the
> Fixes tag and before patch 2.
> 
>>          }
> 
> On top of that, you may try to see if one of bitmap_*() APIs can be
> suitable here to perform the above in a more optimal way.
> (At least this conditional can be replaced with __asign_bit() call,
> but I think refactoring the entire loop may reveal a better approach)
> 

I can replace the if and bitmap_zero with __assign_bit, as you
suggested. I'm not familiar with bitmap APIs, do you have a suggestion?
