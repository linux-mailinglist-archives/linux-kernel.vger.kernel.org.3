Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFD555FBFD
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 11:28:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiF2J2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 05:28:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbiF2J20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 05:28:26 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729C93898;
        Wed, 29 Jun 2022 02:28:25 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ge10so31332296ejb.7;
        Wed, 29 Jun 2022 02:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=OcjlEA+4dS73Cz+a5jVwrlBiB9UB3IJkomavNYdn3KE=;
        b=CSJ8pKHssY81NHEo37dQakuHxjhhT72ifL3/WNSt4UG7uRbllRpC6LqsumzrysrNj1
         2J7XeAWjQGy9zW2uqWtZj50hKVwnOyUVMJf/aZpijpzhi0eP/cSUZJJ12rm5XNsfP0e6
         4+Zq29EnY25bBjwhUDk4wWcbxguIDwgp6wJ2NWjAyyUk9X2EFlKIWEi7ALMnokOJuadd
         noHBqcMzta0Dr+8sWng04yjdaipXFj08YE0nP28p/KzrGsOsKtk7IQChBBQCKjXbzQxS
         4jyKq/r2HdjKExfm5FQlst3qYI9GsFqOQriEm0sObNJ1KUOkbQjcJVo4z7f5sh0KY8y9
         nPRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=OcjlEA+4dS73Cz+a5jVwrlBiB9UB3IJkomavNYdn3KE=;
        b=2oQ6L/YcIT0fHNH1KHm+pR9WeMaUz3BmAQd8NiQIg1ZM714YAdl59V9Y6+BKLgaB2S
         T3QkGcTPAJ/g8Q3B3WfDBzIgMS4EYiqglZ5k5SU6cFAVwCjG3NspxgsxAnOCHTgTOjFC
         oQGz+hwvA0+S+8ibfRtI51CT8GqgLw4R/mbX+H3ZAJo8YGiDC+YlOLpyf7pUlPJGaHBi
         X1r/m8Fi/uGAG+2hoE3/qikj7XxYxmhTper6HpfHF2B0sIefcgxJlGmAM2CF7gz4klwF
         U222D8iC+4S5vSCaQEANlhwkm+4QmKYmJc1fwvwXPaL539zKj/Lfv2endEvHzxmBhLxH
         7T9g==
X-Gm-Message-State: AJIora/HDa/sgeQTJYFkDGeD+MB0+T1rufChihAbFHK5hy/Vtwk1jPCV
        3xEW+vRkVG2lGp2yf0v2wB8=
X-Google-Smtp-Source: AGRyM1vs4gqfTQsGQHWewAwgtxD9xFaOVCxxUvBfBmWTRQabLQMl0/F/6JP8pjgYGhxg9n+kBDFMrA==
X-Received: by 2002:a17:906:ce:b0:715:705e:52fb with SMTP id 14-20020a17090600ce00b00715705e52fbmr2278219eji.303.1656494903920;
        Wed, 29 Jun 2022 02:28:23 -0700 (PDT)
Received: from [192.168.0.182] ([79.119.98.153])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm7499978ejd.196.2022.06.29.02.28.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jun 2022 02:28:23 -0700 (PDT)
Message-ID: <7fc0292d-1d93-4ae8-2947-9444ef48a19e@gmail.com>
Date:   Wed, 29 Jun 2022 12:28:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v7 2/2] iio: adc: ad4130: add AD4130 driver
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
References: <20220628144649.3957286-1-cosmin.tanislav@analog.com>
 <20220628144649.3957286-3-cosmin.tanislav@analog.com>
 <CAHp75Ve6f0dfMmctAwZ3UTA98MDs_injKik2C=wXpJ1zJyiPxA@mail.gmail.com>
From:   Cosmin Tanislav <demonsingur@gmail.com>
In-Reply-To: <CAHp75Ve6f0dfMmctAwZ3UTA98MDs_injKik2C=wXpJ1zJyiPxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/28/22 22:17, Andy Shevchenko wrote:
> On Tue, Jun 28, 2022 at 4:49 PM Cosmin Tanislav <demonsingur@gmail.com> wrote:
>>
>> AD4130-8 is an ultra-low power, high precision, measurement solution for
>> low bandwidth battery operated applications.
>>
>> The fully integrated AFE (Analog Front-End) includes a multiplexer for up
>> to 16 single-ended or 8 differential inputs, PGA (Programmable Gain
>> Amplifier), 24-bit Sigma-Delta ADC, on-chip reference and oscillator,
>> selectable filter options, smart sequencer, sensor biasing and excitation
>> options, diagnostics, and a FIFO buffer.
> 
> It would be respectful, if you include given tags. Why didn't you do
> that? Any significant change that has to be re-reviewed?
> 

Sorry, I sometimes forget about picking up tags. Maybe Jonathan will do
it if everything else is good.
