Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9616351C553
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381881AbiEEQvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244828AbiEEQvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:51:16 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 573EB443E0;
        Thu,  5 May 2022 09:47:36 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id m3-20020a4ac683000000b0035f13dde9ccso810942ooq.6;
        Thu, 05 May 2022 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mZ1v1Dle2stU/b+5xs8mW34KpIG2CizYWSGqBNU2Bz8=;
        b=kIU1IzWI2h67CczNZjDrAqOu+7amMiU9BNzBUsm9+8eUorQIgmZj8BUaj81G12rNlE
         68e+vrj64mqY2psH6XqJCnztqqa0PQYdUiFVwlZFCUdnB10Eq3yPNuX2et/Qb7IiyrBz
         y4P4CTgj9qHdFctipJQQLZooa5lZ6p9+t/FJlW5OsvmErxS/8SHDugMU5U/PNC8J3vyD
         1HBZIl3MmaWUixyDAUco2zkiEwyySzadAX4fbQwpaHfhPJt5wbSxkV0ayhNZoX6n7e5a
         HyZWZIVKJQiHg1IN3LnTM/Yup1dPA9d0emXF3/6nbwpE3BNPdT1+QaKsJavswdrAetPZ
         rYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mZ1v1Dle2stU/b+5xs8mW34KpIG2CizYWSGqBNU2Bz8=;
        b=aAnACA9isyJLX2Xg2uQJh+TDgOWpBcQTTM5m7EeXLU1Cz+FHBjBs93CdvKzaFiv3pW
         wYfy1mrate6Ht3hKXfo2zKklHVNILRrCXxPhB2M6bdL4upqZZIaCjwyW6xlT+mFY2eeS
         2jbufSTseuioo+IPYotC3UtkgXtp+4RTmnTgLpgrpXYTk1PWg+7hSZDMpmmOv6bZjpcF
         KwarQ3noOkmk6JHyUzqw9BUSg5aMCxukn/eAMmVD3Oepx2I9eNqD3dgV4eWzavjO0fo/
         o6uP8GnIWVWRzl6AngM8knNDxTaGMNwa1JKw8p0iPraNAOiLsreK5UH8/amlJBTV8D79
         Vasw==
X-Gm-Message-State: AOAM531KlSFacRHsNiiUgUaIywXcIpDxVxFOd2gJNOZu8ubqflCPm+cS
        wZGryqDlYgDA5GDCNUKg8Dg=
X-Google-Smtp-Source: ABdhPJx/mBD6xFVnxfzAwXo9hN2FbyZEsHhGERFB1m4oe7WTeGkz/+OsH6gYEs3iDqleRPT+1WANlg==
X-Received: by 2002:a4a:b289:0:b0:35e:7d6e:97eb with SMTP id k9-20020a4ab289000000b0035e7d6e97ebmr9583599ooo.57.1651769255626;
        Thu, 05 May 2022 09:47:35 -0700 (PDT)
Received: from [192.168.1.145] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id t28-20020a05683019fc00b0060603221260sm799519ott.48.2022.05.05.09.47.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 May 2022 09:47:35 -0700 (PDT)
Message-ID: <26c2fb0c-e58a-5864-4256-f60f948ca634@gmail.com>
Date:   Thu, 5 May 2022 18:47:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 1/2] dt-bindings: ARM: Mediatek: Remove msdc binding of
 MT8192 clock
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, matthias.bgg@kernel.org
Cc:     mturquette@baylibre.com, sboyd@kernel.org,
        allen-kh.cheng@mediatek.com, weiyi.lu@mediatek.com,
        chun-jie.chen@mediatek.com, linux-kernel@vger.kernel.org,
        ikjn@chromium.org, miles.chen@mediatek.com,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        angelogioacchino.delregno@collabora.com,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org
References: <20220429123133.28869-1-matthias.bgg@kernel.org>
 <20220429123133.28869-2-matthias.bgg@kernel.org>
 <YnGjScfQA9axBYBO@robh.at.kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <YnGjScfQA9axBYBO@robh.at.kernel.org>
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



On 03/05/2022 23:48, Rob Herring wrote:
> On Fri, Apr 29, 2022 at 02:31:31PM +0200, matthias.bgg@kernel.org wrote:
>> From: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> The msdc gate is part of the MMC driver. Delete the binding description
>> of this node.
> 
> An ABI break is okay because ...?
> 

Because the code controlling the clock gate was moved to the consumer. This node 
did never ever represent any working implementation of a peripheral. Just a 
lonely clock gate that wasn't used.

Regards,
Matthias

>> Signed-off-by: Matthias Brugger <matthias.bgg@gmail.com>
>>
>> ---
>>
>> Changes in v2:
>> - Delete compatible in binding descprition as well
>>
>>   .../bindings/arm/mediatek/mediatek,mt8192-clock.yaml      | 8 --------
>>   1 file changed, 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>> index c8c67c033f8c..b57cc2e69efb 100644
>> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
>> @@ -24,7 +24,6 @@ properties:
>>             - mediatek,mt8192-imp_iic_wrap_w
>>             - mediatek,mt8192-imp_iic_wrap_n
>>             - mediatek,mt8192-msdc_top
>> -          - mediatek,mt8192-msdc
>>             - mediatek,mt8192-mfgcfg
>>             - mediatek,mt8192-imgsys
>>             - mediatek,mt8192-imgsys2
>> @@ -107,13 +106,6 @@ examples:
>>           #clock-cells = <1>;
>>       };
>>   
>> -  - |
>> -    msdc: clock-controller@11f60000 {
>> -        compatible = "mediatek,mt8192-msdc";
>> -        reg = <0x11f60000 0x1000>;
>> -        #clock-cells = <1>;
>> -    };
>> -
>>     - |
>>       mfgcfg: clock-controller@13fbf000 {
>>           compatible = "mediatek,mt8192-mfgcfg";
>> -- 
>> 2.34.1
>>
>>
