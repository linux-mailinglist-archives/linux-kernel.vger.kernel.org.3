Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 193EA573C99
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 20:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiGMSh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 14:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231986AbiGMShX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 14:37:23 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F6012ED49
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:37:22 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id i8-20020a17090a4b8800b001ef8a65bfbdso5031399pjh.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 11:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=IPY2oh6eVEuVaZnGRonlFV/5Rgr4Yf/gbjz5OD65DG8=;
        b=Iv7gnvCyNDrcc1M8DugtfETb1qQxdCx4YeV+3U++SqjxgCFYG48dRVRoZyURmUAGJ+
         XQvxoAG+8879FZjDH/l6vUwhu9PWfZUfST+t6bIbCj6Fq4APbRafSu+198Rav/WkXcXP
         Z/2HzkOl7/k9O19bdCc1apbQty3x+QAXkWPhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=IPY2oh6eVEuVaZnGRonlFV/5Rgr4Yf/gbjz5OD65DG8=;
        b=bG2voF1VUnLNVEWDEX0c7yu6qmvllwQQAJPpE9Vsc/cC3sbTPJOjNDpHBN8EsKLD+p
         s9v+xvX1EL9xfGxC61pmby+SEmtaPR+sCsHFO9DL04AiexXzszykMHlYXfGgALXpvUVj
         mqEhsqyWFrL72YygcaAy8Uw1XdKZKBlpKrcTzR+knmMS0PEJ6oQaNlL6NI9zP+mXQO5b
         BEhzQcBvaydw1qVvGYoM1seATSmHR9DVfYW3R6ze6oEXM4IIghK5budiTck86QhiDvDO
         TNju2ymFU7OgPufhnB0LMqv74Wc8lCcVBse6UsXzEBS5wOvkhd3FQpyc9Fw+6hIvqn2H
         UgNw==
X-Gm-Message-State: AJIora8ko25ckI5JWHuiR+ikHRKJMQhy0iw2QScT0w4M4CGUlN5OgEYB
        hR3YLSRs819ELu2glzsHq6WCDA==
X-Google-Smtp-Source: AGRyM1sycxjzKvrZ0VixAB/NS5Fx+N+iik5ZjeSajG8eh2uhgZxyyrDC5vmp8MFPZatwVWC6ovPkZg==
X-Received: by 2002:a17:902:9692:b0:16c:4f81:b7 with SMTP id n18-20020a170902969200b0016c4f8100b7mr4352525plp.92.1657737441783;
        Wed, 13 Jul 2022 11:37:21 -0700 (PDT)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id t11-20020a17090a510b00b001efb45d6209sm1962006pjh.20.2022.07.13.11.37.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 11:37:20 -0700 (PDT)
Message-ID: <147bc812-3971-9832-fb39-5545e280f562@broadcom.com>
Date:   Wed, 13 Jul 2022 11:37:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 1/3] dt-bindings: arm64: bcmbca: Merge BCM4908 into
 BCMBCA
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-2-william.zhang@broadcom.com>
 <ca8c3003-1bcb-6658-592c-566609fd7bd2@linaro.org>
 <94b0ab39-279d-d3c2-98a4-054c10ad041c@broadcom.com>
 <c40f20c7-59ee-99f4-9a11-e928b41eda9f@linaro.org>
 <6efb1cfe-6129-276a-eeb3-44147304d211@broadcom.com>
 <e4356c5e89492eb690e3dc863ba281bd@milecki.pl>
 <85219d59e2906534409fc24ad2e5e4c9@milecki.pl>
From:   William Zhang <william.zhang@broadcom.com>
In-Reply-To: <85219d59e2906534409fc24ad2e5e4c9@milecki.pl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005eaf1305e3b41355"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005eaf1305e3b41355
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Rafal,

On 7/13/22 03:58, Rafał Miłecki wrote:
> On 2022-07-13 12:50, Rafał Miłecki wrote:
>> On 2022-07-13 02:57, William Zhang wrote:
>>> On 7/12/22 11:18, Krzysztof Kozlowski wrote:
>>>> On 12/07/2022 19:37, William Zhang wrote:
>>>>>>> +      - description: BCM4908 Family based boards
>>>>>>> +        items:
>>>>>>> +          - enum:
>>>>>>> +              # BCM4908 SoC based boards
>>>>>>> +              - brcm,bcm94908
>>>>>>> +              - asus,gt-ac5300
>>>>>>> +              - netgear,raxe500
>>>>>>> +              # BCM4906 SoC based boards
>>>>>>> +              - brcm,bcm94906
>>>>>>> +              - netgear,r8000p
>>>>>>> +              - tplink,archer-c2300-v1
>>>>>>> +          - enum:
>>>>>>> +              - brcm,bcm4908
>>>>>>> +              - brcm,bcm4906
>>>>>>> +              - brcm,bcm49408
>>>>>>
>>>>>> This is wrong.  brcm,bcm94908 followed by brcm,bcm4906 does not look
>>>>>> like valid list of compatibles.
>>>>>>
>>>>> For 4908 board variant, it will need to be followed by 4908 chip. 
>>>>> Sorry
>>>>> for the basic question but is there any requirement to enforce this 
>>>>> kind
>>>>> of rule?  I would assume dts writer know what he/she is doing and 
>>>>> select
>>>>> the right combination.
>>>>
>>>> The entire point of DT schema is to validate DTS. Combination like 
>>>> above
>>>> prevents that goal.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>> Understand the DT schema purpose. But items property allows multiple
>>> enums in the list which gives a lot of flexibility but make it hard to
>>> validate. I am not familiar with DT schema, is there any directive to
>>> specify one enum value depending on another so dts validation tool can
>>> report error if combination is wrong?
>>>
>>> This is our preferred format of all bcmbca compatible string
>>> especially when we could have more than 10 chip variants for the same
>>> chip family and we really want to work on the chip family id.  We will
>>> make sure they are in the right combination in our own patch and patch
>>> from other contributors. Would this work? If not, I will probably have
>>> to revert the change of 4908(maybe append brcm,bcmbca as this chip
>>> belongs to the same bca group) and use "enum board variant", "const
>>> main chip id", "brcm,bca" for all other chips as our secondary choice.
>>
>> I'm not sure why I didn't even receive 1/3 and half of discussion
>> e-mails.
>>
>> You can't just put all strings into a single bag and allow mixing them
>> in any combos. Please check how it's properly handled in the current
>> existing binding:
>> Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml
>>
>> Above binding enforces that non-matching compatible strings are not used
>> together.
> 
> I just noticed you're actually removing brcm,bcm4908.yaml in the 2/3 so
> you must be aware of that file.
> 
> So you see a cleanly working binding in the brcm,bcm4908.yaml but
> instead copying it you decided to wrote your own one from scratch.
> Incorrectly.
> 
> This smells of NIH (not invented here). Please just use that binding I
> wrote and move if it needed.

Not mean to discredit any of your work and I did copy over your binding 
and combine them into one SoC entry to the new bcmbca.yaml and add you 
as one of the maintainer to this file. As this change would certainly 
concern you, that's why I sent RFC first.  As I explained in the cover 
letter, the purpose of the change is to reduce the number of compatible 
strings and keep one entry for one chip family due to possible large 
number of chip variants.  But since there is no way to validate the 
combination, I will copy the existing 4908 bindings as they are now but 
I would propose to append "brcm, bcmbca" as it is part of bcmbca chip. 
And for the other chips, we would just use enum "board variant", const 
"main chip id", const "brcm,bca".  Does that sound good to you?

--0000000000005eaf1305e3b41355
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
TltlrAeBKRJ1M9O/DY5v7L1Yrs//7XIRg/d2ZPAOSGBQzFYjYTFWwNBiR1s1zP0m2y56DPbS5gwj
fqAN/I4PJHIvTh3zUgHXNKadYoYRiPHXfaTWO9UhzysOpQIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUohM5GmNlGWe5wpzDxzIy
+EgzbRswDQYJKoZIhvcNAQELBQADggEBACKu9JSQAYTlmC+JTniO/C/UcXGonATI/muBjWTxtkHc
abZtz0uwzzrRrpV+mbHLGVFFeRbXSLvcEzqHp8VomXifEZlfsE9LajSehzaqhd+np+tmUPz1RlI/
ibZ7vW+1VF18lfoL+wHs2H0fsG6JfoqZldEWYXASXnUrs0iTLgXxvwaQj69cSMuzfFm1X5kWqWCP
W0KkR8025J0L5L4yXfkSO6psD/k4VcTsMJHLN4RfMuaXIT6EM0cNO6h3GypyTuPf1N1X+F6WQPKb
1u+rvdML63P9fX7e7mwwGt5klRnf8aK2VU7mIdYCcrFHaKDTW3fkG6kIgrE1wWSgiZYL400xggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgw28eX6TfvsbNfu
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIKC8v9dqt/OYKBUX8HMYoNWGSM4l
7f4QlzcHhgZpC0nRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcxMzE4MzcyMlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQA3Po1B4datYO1GMrzSu3YnuseGUPKj3P3JLOWnHA2Yooue
7YqXsG9LU2eDw7ovX52AwK/bXFPVR5qKV/oitbR1Se3Q4YHPguWhx2gszkpRyoCz5tGMyAH/guql
s4O3bGn1+++aPPRinERqZmx4TgxIrKNBZ+7oupw7BLabd+8s3wwFREgl8poZB8TIEzjNi1m2QzLb
tmKqChSX1p3MrbYSwXl0qY7L1iSJ304hVFVVYXHFQGzpjzIrugX44+EAPeAtAW3RZxOGyYO1Vz8i
A4GoN6rZ1TY/4MXSoPR4Ke0Vqf8VE8OlTzoBLbFGgpIGi0NcsX08+80LHN6Pm0x/oP2G
--0000000000005eaf1305e3b41355--
