Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0BF57C6C4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 10:46:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiGUIqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 04:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiGUIq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 04:46:29 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D32183B8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:46:25 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id o7so1670058lfq.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 01:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=9DFC7DURCYpRYFYZYkyppLob9xkCwy+AEFcaVaYPfs8=;
        b=euTx6iihA4na02hBm19yonYXxMNvIx3Ol6Uv+9lmbcNSZ/9vb2mqV6dtCG72Oh2UA1
         kate/d954NuSI3iDXm+t5XnRkJoiWGK38sL83L+xyWZNXGpoZ3W9schn2a3cAtfSQpGx
         8FNDXt82/3yUs0TSrc/Fed+73RA9Ft2nhwzDa4yNsP0UTRDShNH7TxykViGUgpeumskj
         HRvGRqVme3LZPMYne/DPsDaR6X/ArzSw24+E0qs8BeIT4Va97odlVrMIDbFWWbRY/BAJ
         wimcNfmKdrLL+s8IjRdOjnNRTvzBr7M82hlc3olmIbSvusme5U9tl7fejhlZxrbkQQIo
         LXHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9DFC7DURCYpRYFYZYkyppLob9xkCwy+AEFcaVaYPfs8=;
        b=hWHtiatyGTOmWaQx7eUILCmCS2RjTLlTwTJtep1x+JHf5YNURSVP81nYtF8HHzNbJB
         wDhx6EJs5koxBAkW2DXYf9aMPDkzG9Wl7U9y+sj0F9Gg7CFP3RZauxpDfhhrGBeeLxZL
         Le/qvmSo83ndLWqiO3q31u2/JpZeLhWTL2DvxWDMyz7B1sZC10piyKeKCFh434xEgqMN
         Oczq4IE2/5mKc8FqkmAc6JzYz+SamWUCIA5q3Zka8Zd7zX23YicrbafDMDCtw0PxCSEz
         NHHFqFo1UMi+ZF+QWgf11Pc0GmdC14SI2fvSAqMq0NBCspw0D9op0tjMACwFexZgza1u
         bT5w==
X-Gm-Message-State: AJIora9HOAcHJDa8odwz1lH7IV1D5V8oJt7wXpz3MRJEAaeRKnc3fdoL
        2Geg3NQ8ZWRlh2PldXNP2xDkcCGUo8h+dtAC
X-Google-Smtp-Source: AGRyM1tOI+u3IonFCcBXlF2yOgxTJjNZ569ISXB7y6CJ2aWXrdfhLu5zMFy7KSt5m+lJ0hmX9XnbHA==
X-Received: by 2002:a05:6512:2285:b0:487:2538:f0e0 with SMTP id f5-20020a056512228500b004872538f0e0mr23613079lfu.614.1658393182475;
        Thu, 21 Jul 2022 01:46:22 -0700 (PDT)
Received: from [192.168.115.193] (89-162-31-138.fiber.signal.no. [89.162.31.138])
        by smtp.gmail.com with ESMTPSA id i19-20020a056512341300b0047968606114sm303969lfr.111.2022.07.21.01.46.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 01:46:21 -0700 (PDT)
Message-ID: <9645b7cb-2a43-3085-4caa-f6527cbc2b21@linaro.org>
Date:   Thu, 21 Jul 2022 10:46:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: add MSC Technologies
Content-Language: en-US
To:     Martyn Welch <martyn.welch@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     kernel@collabora.com, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220720150007.2168051-1-martyn.welch@collabora.com>
 <abd47815-c84b-115b-f6f2-b6ec0dbf1bef@linaro.org>
 <86de8ba0157c451fcce4ca92b6cad835e3f1e4d9.camel@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <86de8ba0157c451fcce4ca92b6cad835e3f1e4d9.camel@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2022 10:03, Martyn Welch wrote:
> On Wed, 2022-07-20 at 19:07 +0200, Krzysztof Kozlowski wrote:
>> On 20/07/2022 17:00, Martyn Welch wrote:
>>> Add "msc" vendor prefix for MSC Technologies GmbH
>>> (https://www.msc-technologies.eu).
>>
>> Does not really work - leads to Avnet, so there is no MSC anymore?
>>
> 
> It still seems to be used as branding by Avnet.
> 
>>>
>>> Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
>>> ---
>>>
>>> Changes in v2:
>>>   - New addition
>>>
>>>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>>  1 file changed, 2 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> index 0496773a3c4d..1658357bc1c4 100644
>>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>>> @@ -816,6 +816,8 @@ patternProperties:
>>>    "^mrvl,.*":
>>>      description: Marvell Technology Group Ltd.
>>>      deprecated: true
>>> +  "^msc,.*":
>>> +    description: MSC Technologies GmbH.
>>
>> This should be rather msct or msctech, but anyway in fact you maybe
>> should use avnet?
>>
> 
> My rationale for using MSC Technologies is that is how the device is
> described on the website as being a MSC device. I think the
> amalgamation of the MSC website into Avnet's has happened in the last
> year or so. I assume a new device released in the near future would be
> branded more directly as an Avnet device, or maybe not, I see that the
> i.MX 9 is being described as "MSC SM2S-IMX93".
> 
> I'll switch to msctech unless there are objections to that.
> 

We still have prefixes (and compatibles) from entities which disappeared
(e.g. Freescale) but these were added probably before the
merge/acquisition happened. In this case, I do not see a benefit of
adding a vendor prefix of non-existing vendor.

Therefore use avnet as vendor in compatible. The model name of course
can stay MSC or whatever you prefer.

Best regards,
Krzysztof
