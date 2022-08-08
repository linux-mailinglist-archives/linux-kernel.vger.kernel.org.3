Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F4FA58C338
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235791AbiHHGUy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229891AbiHHGUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:20:52 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE4D2273F
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:20:50 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id z25so11262756lfr.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Aug 2022 23:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=XC78ZDlakVYcKsRbmvJPak0U0EpBMvZ3QPItIdCOy78=;
        b=EkjnZok9jUlLyEZhGeMG8MpZ5jVm25V3QfaxyB7EEziQ1nzFwpQuKMJXpXqDfLkSEK
         Ttjgw74JkvtZMtQcYpbJWwkol5uPP5rU9jqMFsHixR7GxAD6dSnEOW9v8ttIkTIuqUN9
         OwXHsMK5Y0dgOyWKRRmOh1GEooU+a+xOYFS12Um9U04RHc2Wyn1uEqc3msvmOBHnuWCt
         UpGHuCT3B6orPTTaJI6aNdixX6fz4itlx9m2BeFowvzA72dEcA6J987m0qM32cfRTig+
         OJUq1E+xvsPyKkXvmqTL5AXD/JlkjEyXC2A0Gn0En+8hEgea8JzkGvZhCr2h/3mQafAF
         PFtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=XC78ZDlakVYcKsRbmvJPak0U0EpBMvZ3QPItIdCOy78=;
        b=MZqsfW8HYYWq29JTRh3KDrElOKez0ySxm56O5XYEhJ1l9cSLL2N+KDQb1EP02R4kOa
         kEZ8YZEPyJtPwqF/yy0saguRbY3B8KP/tlKS2GyriBIR0W6BNn1CWTpllZdteCH5J+lP
         1Zjt0Tqidm2BIFfAxj9RdmiAe6RE+/hAgAeRjiZsXn4ANrVd/8uFWLnpcYmGfxld3VcF
         l/Ki2ikm+IEzDRYX/HvTB9/VEom4tmZHB6d9DfPWTrFwG8msvVHgF35cqf+R+3Q5pvGR
         Pn3h4x1sjGiK0HNjLDXRHQk8325l7aayscC087KlnYnzOPC9t+BtsUzmYGlNNEsMH4m6
         K8Bw==
X-Gm-Message-State: ACgBeo3RFPNYlV+elvZHvEirPgnwCJJ8SV3ugD/ofoG60oNA/v//sOhd
        /uEEX/dSRl+ecUYMMLzcTVwLtA==
X-Google-Smtp-Source: AA6agR7OZmOpXS7+02tNqFitUFXXGQkqNUYoDp/ZzRjdPwPpDTOkj/3epSojRdpeY2k8fI2W5HiwSw==
X-Received: by 2002:a05:6512:2023:b0:48a:f7e5:8ca2 with SMTP id s3-20020a056512202300b0048af7e58ca2mr6500767lfs.592.1659939649359;
        Sun, 07 Aug 2022 23:20:49 -0700 (PDT)
Received: from [192.168.1.39] ([83.146.140.105])
        by smtp.gmail.com with ESMTPSA id f37-20020a0565123b2500b0048b29b24761sm1310605lfv.91.2022.08.07.23.20.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Aug 2022 23:20:48 -0700 (PDT)
Message-ID: <09264520-15fc-fd35-c1d6-9e9d0230ea4a@linaro.org>
Date:   Mon, 8 Aug 2022 09:20:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2] dt-binding: ipmi: add fallback to npcm845 compatible
Content-Language: en-US
To:     minyard@acm.org, Tomer Maimon <tmaimon77@gmail.com>
Cc:     avifishman70@gmail.com, tali.perry1@gmail.com, joel@jms.id.au,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, openbmc@lists.ozlabs.org,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20220804181800.235368-1-tmaimon77@gmail.com>
 <20220805115827.GG3834@minyard.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220805115827.GG3834@minyard.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/08/2022 13:58, Corey Minyard wrote:
> On Thu, Aug 04, 2022 at 09:18:00PM +0300, Tomer Maimon wrote:
>> Add to npcm845 KCS compatible string a fallback to npcm750 KCS compatible
>> string becuase NPCM845 and NPCM750 BMCs are using identical KCS modules.
>>
>> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>
>> ---
>>  Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>> index cbc10a68ddef..4fda76e63396 100644
>> --- a/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>> +++ b/Documentation/devicetree/bindings/ipmi/npcm7xx-kcs-bmc.txt
>> @@ -7,7 +7,7 @@ used to perform in-band IPMI communication with their host.
>>  Required properties:
>>  - compatible : should be one of
>>      "nuvoton,npcm750-kcs-bmc"
>> -    "nuvoton,npcm845-kcs-bmc"
>> +    "nuvoton,npcm845-kcs-bmc", "nuvoton,npcm750-kcs-bmc"
> 
> This is just wrong.  The compatible is supposed to identify the device,
> not the board the device is on.  I think compatible here should be
> "npcm7xx-kcs-bmc", and just use that everywhere.  It's fine if that is

No, because you propose to use wildcards as compatible which is not
correct. Compatibles must be specific.

Best regards,
Krzysztof
