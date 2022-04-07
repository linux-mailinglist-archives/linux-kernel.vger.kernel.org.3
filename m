Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E4A4F8916
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 00:14:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231184AbiDGVIe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 17:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbiDGVIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 17:08:30 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA15177D17
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 14:06:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id a2so445529wrh.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 14:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VYDGD/lRh/S3APeRLxg/uVBh3CXm8UmCkYzmr6Xm0TY=;
        b=N6uhWtFP3F3lmqbvC4tdoeq5G5+gzPYi+82xknSqaEiYQjD5S39+Z+S3+npgLuTd8p
         sBy09OhRV9U58FqxU+iRDHKxUJjA/1YCpHWdBBa+iZf5PtXaVn2ddP/k7cLBeUdi8a4n
         ZKMpK/VOaaeiCPcW5Y5hdNGIiL6OR3ayzJsY6bTXlUuM/ZMOomUHcKkwzKg7hLPNw9sJ
         CUP2mOuyh3Ktc6sZVnY1fIFqSOCO+7bYpX+Eyg/zt4YkLfgKXDkZ+4wz8SUh2e1O5hN0
         QmpO0X/QdYr0J1sZzo8gOas2C1h1fBqD4fXRq3iBGANBtGxnB1MgN1VtdCNg4UFPCjDs
         I3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VYDGD/lRh/S3APeRLxg/uVBh3CXm8UmCkYzmr6Xm0TY=;
        b=OJNBmXXpKyYJcQaOSihlDl+cRhtUsplB7pEG9CuRuyecB/qQa7pzB9TzV5UDfDIiei
         7dBFWs00KWqBYXHuFOQuoKIZilwrYTURDQ65C5rOcf1/5PHGkMpnOk7wPx3fz5HeOrvj
         rokx0SSm/+pxudd3rfpFeLAXOX8aoGiffkiUfLjgN4w809N2lUYUjtjX1MZzRehspLSQ
         fveSxXiEGprVsYfhdlEcCcQZEZrhMWBL+6KCQ2IazRCe0BWaKf8vTNYCGy9TlEGuVxQA
         OR3g7IRbGnE2LEYiFNCTXSMv7j6RElWSfsr1ENY7182cuPNmsIQS6Q/RAUj89MIbIKmM
         rBpQ==
X-Gm-Message-State: AOAM533MBOH7HzC29DYy4Sy0qTt5+CsVRYvXqVn6jhX1Otu1VG2kk12U
        9Uua11CDlXBmBODY+SBTpwYFmQ==
X-Google-Smtp-Source: ABdhPJyQiv2+i2IpnqHJGw+2b8dO4TXqtW/XLBZB8wqTI1qe3ixmX60ZJmaCzuoWpm23qRrv0x8KeA==
X-Received: by 2002:a5d:64e6:0:b0:204:975:acde with SMTP id g6-20020a5d64e6000000b002040975acdemr11872191wri.466.1649365586356;
        Thu, 07 Apr 2022 14:06:26 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id h10-20020a05600c144a00b0038ccc75a6adsm8363430wmi.37.2022.04.07.14.06.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Apr 2022 14:06:25 -0700 (PDT)
Message-ID: <200a2002-8573-efaa-774a-51dcec9cc807@linaro.org>
Date:   Thu, 7 Apr 2022 23:06:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] dt-bindings: mtd: jedec,spi-nor: remove unneeded
 properties
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220407142004.292782-1-krzysztof.kozlowski@linaro.org>
 <Yk8rpUXmfmULMVjr@robh.at.kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <Yk8rpUXmfmULMVjr@robh.at.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2022 20:21, Rob Herring wrote:
> On Thu, Apr 07, 2022 at 04:20:04PM +0200, Krzysztof Kozlowski wrote:
>> After conversion the jedec,spi-nor DT schema to reference other schemas
>> (SPI and MTD) and use unevaluatedProperties, several properties are
>> redundant.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  .../devicetree/bindings/mtd/jedec,spi-nor.yaml        | 11 -----------
>>  1 file changed, 11 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> index 4abfb4cfc157..708e7f88fd92 100644
>> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
>> @@ -50,10 +50,6 @@ properties:
>>      minItems: 1
>>      maxItems: 2
>>  
>> -  spi-max-frequency: true
>> -  spi-rx-bus-width: true
>> -  spi-tx-bus-width: true
>> -
>>    m25p,fast-read:
>>      type: boolean
>>      description:
>> @@ -74,14 +70,9 @@ properties:
>>        be used on such systems, to denote the absence of a reliable reset
>>        mechanism.
>>  
>> -  label: true
>> -
>>    partitions:
>>      type: object
>>  
>> -  '#address-cells': true
>> -  '#size-cells': true
> 
> These are needed for 'partition' nodes.
> 

I am sure I saw them in one of referenced schemas, that's why I removed
them. But now I cannot find it so probably I looked at wrong schema.

Thanks for pointing this out, I'll fix the patch.

Best regards,
Krzysztof
