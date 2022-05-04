Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B048351AE54
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 21:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355080AbiEDTyU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 15:54:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232665AbiEDTyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:54:15 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FB3559A;
        Wed,  4 May 2022 12:50:36 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so1453328wmn.1;
        Wed, 04 May 2022 12:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VyJtfn1tkiBY65vTSRos/C9zOAHIJs4WbpnrXNawJZg=;
        b=eeKLowhrCGe9AB7AbGwv3kGpf7045SOqQac87T7Gl1xOZElwtxhKdzN2N+NebcgJN7
         xJf3bS/0JB8jXKNoejf9r9w0mEaraD7TUAc5nAvfTByqFSfow1iT2oWbqmwwJ6SYyPZ9
         1O+TRpYc0+Hfs933MeSXXItqftQdkPsZ0akpmRhu9vBLM5/G52EG1guEQ/9Qg2ZK52OG
         VWeL2PDbeB6NWc5eKMacaPFEFI2sLCYfxO0p45aWlVmzUtuO+El1sLX+/S1vIReO2LYp
         8jr75zcBdsaV6oGpbWp4DjcmIYLHqShiTLAimWPOXod8GGjcsUNAi0i2Qo35S0t3g/pn
         Q+fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VyJtfn1tkiBY65vTSRos/C9zOAHIJs4WbpnrXNawJZg=;
        b=PX4iAw+4SoQLKsR5jFWSmS4xn60FgvsgJEm6JMw6sW1Z+vtpgEkiOxePnyOVr4QFik
         kfEHUuSoI+kOjnI9rLSbD1WJXNDuNNK/hxGZJz8dUPt0HK5dvVKntBaY6DUfRxVJxPvU
         2oYUWdMXf489SjBWLk/jNiCQamUlvVHIWztuHpywsQMj5+w0XkyfxHHFYSFtHG/nqpWx
         RuwQKikvgnBxhRoFKRpd7ba/EYvErNOxDWBSf5uvuN0rRfzATAn8yqO/iasz8CMyTx/4
         6k+mBLlurkPJbJknXFrA0lohAUh1Y1doom+9Lb+zdBHiIB0kHv3dzg14qB5XWBlpaQZT
         DWyA==
X-Gm-Message-State: AOAM530X67/9mw0cD1/IXB0sgDwX6gsKKrlsFKfxI9Eye1u6BArJ5fSG
        U1oKqksWsMXJ4qBCC4u3hPYdz1Ru/1g=
X-Google-Smtp-Source: ABdhPJyMlrIhxaQx1oH+TUOvIikEIIqg1tGJyAEANPJO3rLp4DtfRl4/OwS5Jc1Yx0nNPtWbhuHjTg==
X-Received: by 2002:a05:600c:4f4e:b0:394:49bc:51db with SMTP id m14-20020a05600c4f4e00b0039449bc51dbmr901022wmq.109.1651693835339;
        Wed, 04 May 2022 12:50:35 -0700 (PDT)
Received: from [192.168.35.91] ([194.39.226.133])
        by smtp.gmail.com with ESMTPSA id s29-20020adf979d000000b0020c5253d925sm12046219wrb.113.2022.05.04.12.50.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 12:50:35 -0700 (PDT)
Message-ID: <070c5650-3f48-6533-b977-b5d8a8b322b8@gmail.com>
Date:   Wed, 4 May 2022 22:50:32 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v7 0/2] Make AUX gpio pin optional for ktd2692
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220504193439.15938-1-markuss.broks@gmail.com>
 <CAHp75VeMCiwgTFFy5vGBoWYSw4mGQU6623B1eMr7apJZF_L-kg@mail.gmail.com>
From:   Markuss Broks <markuss.broks@gmail.com>
In-Reply-To: <CAHp75VeMCiwgTFFy5vGBoWYSw4mGQU6623B1eMr7apJZF_L-kg@mail.gmail.com>
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

Hi Andy,

On 5/4/22 22:44, Andy Shevchenko wrote:
> On Wed, May 4, 2022 at 9:35 PM Markuss Broks <markuss.broks@gmail.com> wrote:
>> Some appliances of ktd2692 don't have the AUX pin connected to
>> a GPIO. Specifically, Samsung Galaxy J5 (2015), which uses ktd2692
>> for driving the front flash LED, has the pin not connected anywhere on
>> schematics. Make specifying the AUX pin optional, since it is additional
>> functionality and only affects amount of current going through the LED.
> the amount
>
>> Also convert the txt device-tree bindings to yaml and pick up maintenance
>> over the yaml binding and the driver itself.
> ...
>
>> v7:
>> - drop the MAINTAINERS part
> I'm not sure why it happened.
Pavel asked me to drop the MAINTAINERS part for now.
>
> What I mentioned is to create a series out of 4 (four) patches:
> 1) fix the potential issue with the repetitive message;
Bummer, totally forgot about that, thank you for a reminder!
> 2) update DT;
> 3) switch to optional GPIO;
> 4) update MAINTAINERS.
>
>
- Markuss
