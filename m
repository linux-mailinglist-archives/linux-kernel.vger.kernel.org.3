Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CB558DB52
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 17:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244455AbiHIPqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 11:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243303AbiHIPqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 11:46:10 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D83A1162
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 08:46:09 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bq11so17580765lfb.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 08:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=CUedU6kMASw5REsAcuy2rO2+Wp5ASMICS1gAQM+BXYY=;
        b=P1QkEOL1WUP4tnuF7Y1xar4/FEns/eDHcVaXALqbiZj+gZh03Zd9CncqLUbsqGDeNT
         yriUelceut0gw2L6IliSMNBkjt7XrqlycfxJR97uEcPzCIaBquqRdjZ5ej7SA7v2urjX
         Gu52fMzfMUmmSPOdtRCIHTqagbWXZ60mWYdtn5FGEJJinmg9Fmf7qSaFsy0B/IJqtpke
         aH68xD7YBmH1MnpMx/6WlW2NwUjdCzb0zzEutqOpgivm1KEE1MhSRzgfsT1hc0jNVKok
         DUmgtqM/s2fGxLtChxHkvY0hGHFwDJQXxewMDHIm5lu+2dapjkgrD8TclBV+h+w2RKLw
         YvEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CUedU6kMASw5REsAcuy2rO2+Wp5ASMICS1gAQM+BXYY=;
        b=gMNYOgfjKKJR+SxbVxaQIIRmsDcwKa7kOnaQ04hoBm5pZ1G7M5gpEzoKads+kGy9/C
         WHYl28JIz+SKLJQUaweDHQbbBHM1gKcDE6r6488kkC1LaDo6+HcaKRbbl0IU+vLDMoOu
         91Ozzra4r2SGChFSAcMIKyJvKsCCVH8O2ZikJvFDZLV9jpbYWyl21HvEqCs+Qy6Jf07v
         0n80IzZh2SKtpOmgTVAK/LikZCUZQj8yZ7hlHbfSN9NgMq5SagBDbB8lRZIGUK3KmZvK
         8ZUl+zGr8yKIhbT4UDOZWTi1S3WvPLucVlUxjHsMGu22qXLQiOPLDKHUws9wKd45kVUS
         S4GA==
X-Gm-Message-State: ACgBeo30OQAGsItPubC26UYZoxBkmhb7PKf2Ud3nmGImaecVt0fyMt4Y
        Pg+On77KicLQttDnlgWuzO1SWQ==
X-Google-Smtp-Source: AA6agR4rsgnglfBObga0gxJ1sKawFYHi0syINQ0jiop/OCEHI1VG//5n8L7ed33EWhXywjENTTaFtQ==
X-Received: by 2002:a19:f007:0:b0:48a:f479:af01 with SMTP id p7-20020a19f007000000b0048af479af01mr8209712lfc.59.1660059967109;
        Tue, 09 Aug 2022 08:46:07 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id c18-20020a05651221b200b0048afa5daaf3sm13026lft.123.2022.08.09.08.46.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 08:46:06 -0700 (PDT)
Message-ID: <400b78db-17ac-b9d8-fcf9-3a4dc7821ea8@linaro.org>
Date:   Tue, 9 Aug 2022 18:46:04 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] dt-bindings: marvell: Update Armada 37xx platform
 bindings
Content-Language: en-US
To:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220713200123.22612-1-pali@kernel.org>
 <20220808202352.iimhb2q6yawi35y6@pali>
 <20a349c9-a479-ad5b-fe33-4758a773972e@linaro.org>
 <20220809131357.u3dfsy3gu3iamiv7@pali>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220809131357.u3dfsy3gu3iamiv7@pali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/2022 16:13, Pali Rohár wrote:
> On Tuesday 09 August 2022 08:58:50 Krzysztof Kozlowski wrote:
>> On 08/08/2022 23:23, Pali Rohár wrote:
>>> PING?
>>>
>>> On Wednesday 13 July 2022 22:01:23 Pali Rohár wrote:
>>>> Distinguish between Armada 3700 family, Armada 3710 SoC and Armada 3720 SoC.
>>>> Armada 3720 DB is name of the board with Armada 3720 SoC, so correctly
>>>> indicate SoC in example.
>>>>
>>>> Signed-off-by: Pali Rohár <pali@kernel.org>
>>>> ---
>>>>  .../devicetree/bindings/arm/marvell/armada-37xx.txt        | 7 ++++++-
>>>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>>>> index f6d6642d81c0..d2ca008de266 100644
>>>> --- a/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>>>> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-37xx.txt
>>>> @@ -4,6 +4,11 @@ Marvell Armada 37xx Platforms Device Tree Bindings
>>>>  Boards using a SoC of the Marvell Armada 37xx family must carry the
>>>>  following root node property:
>>>>  
>>>> + - compatible: must contain "marvell,armada3700"
>>>> +
>>>> +In addition, boards using the Marvell Armada 3710 SoC shall have the
>>>> +following property before the previous one:
>>>> +
>>
>> The change is an ABI break, which looks reasonable, but still platform
>> maintainer should comment on it. Especially on the aspect why the
>> marvell,armada3710 fallback was chosen at the first place.
> 
> I do not think this is ABI break but rather incorrect documentation and
> bug in some board dts files.

This documentation is the ABI, especially if actually implemented in the
DTS files, therefore by all definitions of DT ABI this is an ABI break.

What you are saying about "incorrect documentation and bug in some DTS
files" is a good reason to break the ABI, but it is still a break.

Best regards,
Krzysztof
