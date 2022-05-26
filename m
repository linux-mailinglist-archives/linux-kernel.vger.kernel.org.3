Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B56B534A8B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346267AbiEZGyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346264AbiEZGx7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:53:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996495DA3F
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:53:57 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n10so1282551ejk.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=+OlWFNuXubaG+wIbcU6S2PD/trjlRQ/H0QdDAVlC7L8=;
        b=HTSbKdqa3Nz+rgnORHSDlCCrWGmPxq/uTvVIJ1mdxP93fxi23p4/iaudQGQ0yvJ9qD
         sVCbrRfo4bBZ9mQRMOESsrCFhgNGIGplr+gRzybCAWSTUbTrkEc8qWTZ4+OL34B9gBo5
         dOF8MFYMdEGZrlkLcq9wisY90Wjy5NOu5xRch0PKTnXgXXXoQiEdUGSOr8epjCyfTbVS
         Dr28G81aHk81OulVCikCIbagbO+Y4eDk0jAdcfnyEEMK2ynz5Uduj5WXS6eh/HElm7AY
         yhKdPVZCKYG7q/YHZlKZoSErjnkxy2vKC9OXBJfkrBc3mnIe3F9Jp3DD8FlhwnTPS8Hy
         kCZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=+OlWFNuXubaG+wIbcU6S2PD/trjlRQ/H0QdDAVlC7L8=;
        b=Fmw4IZFZVL1mRVDrN/rrB1LRwB+wyNfUDOXXoCi6Znij5H1V/s+hvcziJgTfNG7G/Q
         OfK0fnRgC6JIxxjP/nXQwrBmRV30x0Nsf+7wB5ZUFeO0OhD2CPl+wuuYY5JBrLkdWkPE
         ajJ0/D86vl4SKBn89Ja7J1XoqoadNuVDp/wZs3vsImOoHSgGdFaKTw+P/Eg+vdpmibys
         avZ6nFhoOQDyIjbTxK56CXqFQFEm/B23dmFybuKfxSseunA1Ee6Pi/3hAZxYzGEMalWU
         CAHAI2e+XcHv3gYCS8+RXC03Eg0k6nsSIQ4AljkUD/IzEUwn4F18bBZBShuJ5l9qfoh1
         hiFw==
X-Gm-Message-State: AOAM533mIr9NJAoxd2v4aFfj+MQw82TLYcYe7g3AAf9Re0PR8YHrPWcL
        p1B661W+ByJAKH7Od/aglZWDFQ==
X-Google-Smtp-Source: ABdhPJxK0GdBqnqhHeFKnB17hFODfbqtX8jNbVhbmw+n/G8WMqDopEGaBisjwS7Dq3PBf+ZqYanNVA==
X-Received: by 2002:a17:906:9b90:b0:6ff:a02:1f9 with SMTP id dd16-20020a1709069b9000b006ff0a0201f9mr9350097ejc.672.1653548036203;
        Wed, 25 May 2022 23:53:56 -0700 (PDT)
Received: from [192.168.0.177] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id x65-20020a50bac7000000b0042617ba63absm389060ede.53.2022.05.25.23.53.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 23:53:55 -0700 (PDT)
Message-ID: <8d2c9375-63d7-6d36-8a0b-6c5d117cc213@linaro.org>
Date:   Thu, 26 May 2022 08:53:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 11/11] arm64: dts: Add Pensando Elba SoC support
Content-Language: en-US
To:     Brad Larson <brad@pensando.io>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Mark Brown <broonie@kernel.org>,
        Serge Semin <fancer.lancer@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        David Clear <dac2@pensando.io>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220406233648.21644-1-brad@pensando.io>
 <20220406233648.21644-12-brad@pensando.io>
 <eed2f337-3d5a-3440-d19e-c5ff032409ab@linaro.org>
 <CAK9rFnzPEq1_zOnHYzTDyOOU9xRsuP-KBEFnc84cRoyfAve+Jg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAK9rFnzPEq1_zOnHYzTDyOOU9xRsuP-KBEFnc84cRoyfAve+Jg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2022 02:19, Brad Larson wrote:
> Hi Krzysztof,
> 
> On Thu, Apr 7, 2022 at 12:06 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 07/04/2022 01:36, Brad Larson wrote:
>>> Add Pensando common and Elba SoC specific device nodes
>>>
>>> +&spi0 {
>>> +     num-cs = <4>;
>>> +     cs-gpios = <0>, <0>, <&porta 1 GPIO_ACTIVE_LOW>,
>>> +                <&porta 7 GPIO_ACTIVE_LOW>;
>>> +     status = "okay";
>>> +     spi0_cs0@0 {
>>
>> Generic node name needed matching the class of a devicxe.
> 
> The device on this spi bus is a FPGA with 4 functions and looking at
> other projects I've changed it to a resource-controller node name.  On
> cs0 there is a sub-device reset-controller added in the upcoming
> patchset to enable hardware reset of the eMMC device.
> 
>>> +             compatible = "semtech,sx1301";  /* Enable spidev */
>>
>> This comment is a bit odd... did you just use random compatible from
>> spidev instead of defining proper compatible?
> 
> Yes, because adding a compatible was nacked.  We have a driver added
> (two actually, mfd and reset driver) for the next patch update.

Yeah, but using some other one is also not correct.



Best regards,
Krzysztof
