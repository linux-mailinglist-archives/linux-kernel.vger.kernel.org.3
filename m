Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F43050DFBB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232836AbiDYMPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiDYMPU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:15:20 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4FC7671;
        Mon, 25 Apr 2022 05:12:16 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f6so2760255wma.0;
        Mon, 25 Apr 2022 05:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hfArQsxLDPbKG60y1rxFfA0sfKPu7Sy6y67SgmgIDrE=;
        b=iKLWQ9RN5FcUHXptcwQFmAdmvwIU3KnwEGu5UpxeO9JXNTSe3gp+26wEWZZEn5BQIq
         wR8QcQCsrte9lOhLzIs3d3io2ZkLfjJgnaClODcWcuaLazGmGRaIk5ZgbrxXqZskRrTx
         TNOg54m/cAcrSJ9JkRhMVds+iwi8Op28FKGrbxTbbyd6ydOMU1oBzQS269oJY6a1AV/b
         +NGk4n2xim63lbf1rNYH28dNDkiCkhqROanJXG9sqozfYDYuQL5nQjneoEXOofM5JNTN
         WDLtYUYXzjwmIwH2rrQUR3fmkPcGxBtVt6R+aGVMi3brstrzrM71YbKy4aymCbLmejXH
         prAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hfArQsxLDPbKG60y1rxFfA0sfKPu7Sy6y67SgmgIDrE=;
        b=WoaGjX0G6D1cp049o3JovjoWyu9TiPOeHchfunRAOaVnYDeJo+crf3SUolHc/3RMLe
         U+NGejlhWv0yaWKOJqRqUzThexcsQvB1VHWv4pCbdL3BA1/k0x+m1jsmClOU5y+L5Kz2
         e9IvguY1ddp4DTQHrmnyzUsSZE0zQzpL0jLyjx6DvhVAR4rHxk14By4R1ftqdhIwLDWn
         kYiGM9c3xCv57ZtcCXutHcKKO5F6vjgK2doTVaFZ9Ofqr3ZJJQuHYT7aJ6GfMuzUghY8
         L+ygMVw4HPTXpisxvJBlbh49D1Bgn0MO0kSK6vLoxBx0BAyQQzAWYWCm7VCXUm8FKfhu
         QK5A==
X-Gm-Message-State: AOAM532cQJHt5gxcj6uQcqU7bXvvq94PfQ/LxmHL6Mk3mOVynp3Htodh
        WB6ZxHD2ZATHRzO5LcKtu00=
X-Google-Smtp-Source: ABdhPJxe6gi+jX3wdAk0cAwQiWsNQPehHNbGOPia8YoJj3YwqOp+9rGFjzm4NWMcpiS5q9Eb6YAqTw==
X-Received: by 2002:a05:600c:1e1f:b0:38e:c3eb:2d9 with SMTP id ay31-20020a05600c1e1f00b0038ec3eb02d9mr16898851wmb.90.1650888734942;
        Mon, 25 Apr 2022 05:12:14 -0700 (PDT)
Received: from [192.168.0.43] (static-35-180-85-188.ipcom.comunitel.net. [188.85.180.35])
        by smtp.gmail.com with ESMTPSA id l14-20020a05600c1d0e00b00393ed37f63bsm2017780wms.26.2022.04.25.05.12.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 05:12:14 -0700 (PDT)
Message-ID: <562f65b6-033b-9dc5-10e5-b665b7b83267@gmail.com>
Date:   Mon, 25 Apr 2022 14:12:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] arm64: dts: mediatek: pumpkin: Remove input-name property
Content-Language: en-US
To:     Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Dang Huynh <danct12@riseup.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220425064850.246228-1-danct12@riseup.net>
 <87tuah7cwg.fsf@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <87tuah7cwg.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/04/2022 11:03, Mattijs Korpershoek wrote:
> On lun., avril 25, 2022 at 13:48, Dang Huynh <danct12@riseup.net> wrote:
> 
>> This property doesn't seem to exist in the documentation nor
>> in source code, but for some reason it is defined in a bunch
>> of device trees.
>>
>> Signed-off-by: Dang Huynh <danct12@riseup.net>
> 
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 

Applied, thanks!

>> ---
>> This patch is a split of this treewide patch [1] to ease the
>> maintainers.
>>
>> [1]: https://patchwork.kernel.org/patch/12633497/
>>
>>   arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi | 1 -
>>   1 file changed, 1 deletion(-)
>>
>> diff --git a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
>> index fcddec14738d..7a717f926929 100644
>> --- a/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
>> +++ b/arch/arm64/boot/dts/mediatek/pumpkin-common.dtsi
>> @@ -25,7 +25,6 @@ optee: optee@4fd00000 {
>>   
>>   	gpio-keys {
>>   		compatible = "gpio-keys";
>> -		input-name = "gpio-keys";
>>   		pinctrl-names = "default";
>>   		pinctrl-0 = <&gpio_keys_default>;
>>   
>> -- 
>> 2.36.0
>>
>>
>> _______________________________________________
>> Linux-mediatek mailing list
>> Linux-mediatek@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-mediatek
