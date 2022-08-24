Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B27A59FC63
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 15:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238843AbiHXN4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 09:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239230AbiHXNzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 09:55:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B6057FE70;
        Wed, 24 Aug 2022 06:55:07 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso908348wmb.2;
        Wed, 24 Aug 2022 06:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=+TfRFZdPPa8B51MYvjdd539ePUr6kSsCQn61FGO4GdE=;
        b=aFe6EZILPi4mhBimcUcflE/kKSW5k3aY0tETzNxA0P11eSF6STOEpvtzCCW9Uev2fN
         a4UwvQyI6/h/IQRuU+qk0IqsnJFOJuEQTq7YJ5rHOy705kyLy0xPDgWkpQ3XYPXGmq36
         OdzQseeK+dwILujmlW5M4npWAjrq14G+FAQLsUTCSZI9ESeTJauVjnLHvifH9ACzQ/tw
         dXUXYPGoKk2V8GjCwEGS1qFRrcAACizGai+V8ZzWm5nXSdl6dC9JnqmswFJni9lLyejj
         4CzvrgCrCoRPO2AZlMPi8Rzl4MXUfeJD2Pob9EIzJ7g1u4dUfw/Mqo3tPETtxZ9Zn9Y+
         IQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=+TfRFZdPPa8B51MYvjdd539ePUr6kSsCQn61FGO4GdE=;
        b=H5GLJf/CHIL2bTqim0raoyKXRsb0ufYn48rmzuOLRd+LqGc+fXATJM/V3RgAqaBNYh
         BXM6f1XjkY48/ddaeUUn6AazvZodVO8ZJOvmmWuQzVL/H61qYJdOQoTQhHF04EAE0o0R
         RY641VSJxtnouTudGfKccjnFzHnxsmKPTWhSvuxWQY0kYVwhQ/xnmOUWfEKqAO9tOUri
         bCAmG9d9R8ZoFP0ZMzk17tLeDcu2fME3Hb25KFvgMW2JvJyZ+eRkL6gDUJbmUXeqkkHi
         SPbaKHCzzkmE68KRf80Tx9GBV+MTFRQRb2aXpi4Y4rsQA6e5fJxwefSCnIWF//47rUkQ
         8ufQ==
X-Gm-Message-State: ACgBeo3dPX5786Co9SqoTZ0yMnivMjUci92r3SVC7Mnlvil3rzjsAlZJ
        lEPgItdD9IoDVz8GpCgEDVs=
X-Google-Smtp-Source: AA6agR4QxBBWMr++j4x5qmO1sVOahCNUuQT962B+1Govc61YXOhMi0sKq2jcvX6UFcV/97fPHKtdPQ==
X-Received: by 2002:a7b:cd0f:0:b0:3a5:ec59:daf0 with SMTP id f15-20020a7bcd0f000000b003a5ec59daf0mr5305484wmj.13.1661349305735;
        Wed, 24 Aug 2022 06:55:05 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v8-20020a05600c214800b003a540fef440sm2239530wml.1.2022.08.24.06.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 06:55:04 -0700 (PDT)
Message-ID: <0557c9fa-1ec4-5413-78f6-f5d78f3f9ffb@gmail.com>
Date:   Wed, 24 Aug 2022 15:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
Subject: Re: [PATCH v2 0/7] Input: mt6779-keypad - double keys support
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Fabien Parent <fparent@baylibre.com>,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Fabien Parent <parent.f@gmail.com>
References: <20220720-mt8183-keypad-v2-0-6d42c357cb76@baylibre.com>
 <YvQ3A2/Pop4YzzQ8@google.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <YvQ3A2/Pop4YzzQ8@google.com>
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



On 11/08/2022 00:53, Dmitry Torokhov wrote:
> On Tue, Jul 26, 2022 at 02:56:05PM +0200, Mattijs Korpershoek wrote:
>> The MediaTek keypad controller has multiple operating modes:
>> * single key detection (currently implemented)
>> * double key detection
>>
>> With double key detection, each (row,column) is a group that can detect
>> two keys in the key matrix.
>> This minimizes the overall pin counts for cost reduction.
>> However, pressing multiple keys in the same group will not be
>> detected properly.
>>
>> On some boards, like mt8183-pumpkin, double key detection is used.
>>
>> Signed-off-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> Applied patches 1 through 5 (leaving dts patches out), thank you.
> 

Applied 6 and 7 now. Thanks!

>>
>> ---
>> Changes in v2:
>> - bindings: add matrix-keymap justification in commit message (Krzysztof)
>> - bindings: switch from double-keys(boolean) to keys-per-group(uint32) (Krzysztof)
>> - driver: add a function pointer for row/column calculation (Angelo)
>> - Link to v1: https://lore.kernel.org/r/20220720-mt8183-keypad-v1-0-ef9fc29dbff4@baylibre.com
>>
>> ---
>> Fabien Parent (2):
>>        arm64: dts: mediatek: mt8183: add keyboard node
>>        arm64: dts: mediatek: mt8183-pumpkin: add keypad support
>>
>> Mattijs Korpershoek (5):
>>        MAINTAINERS: input: add mattijs for mt6779-keypad
>>        dt-bindings: mediatek,mt6779-keypad: use unevaluatedProperties
>>        dt-bindings: mediatek,mt6779-keypad: add mediatek,keys-per-group
>>        Input: mt6779-keypad - prepare double keys support with calc_row_col
>>        Input: mt6779-keypad - support double keys matrix
>>
>>   .../bindings/input/mediatek,mt6779-keypad.yaml     |  8 ++++-
>>   MAINTAINERS                                        |  6 ++++
>>   arch/arm64/boot/dts/mediatek/mt8183-pumpkin.dts    | 21 +++++++++++
>>   arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  9 +++++
>>   drivers/input/keyboard/mt6779-keypad.c             | 41 ++++++++++++++++++++--
>>   5 files changed, 82 insertions(+), 3 deletions(-)
>> ---
>> base-commit: 668af1b6548837b44a2bfe65dcbae6b250adbf63
>> change-id: 20220720-mt8183-keypad-20aa77106ff0
>>
>> Best regards,
>> -- 
>> Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
