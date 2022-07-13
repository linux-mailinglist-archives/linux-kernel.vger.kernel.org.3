Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92358573DD7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 22:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiGMUd4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiGMUdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 16:33:54 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5AA18372
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:33:53 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so5460811pjl.4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=OqbBm+p2QZIQxA/+eAkRmYZxvBTU0PWCnvoyZzbFmfQ=;
        b=Rb6oeieL+e1D59Yp/Izrsr41HiaTf34OV5+/2nBAhPpaXUw1AK1yWZJeV4Ep3MIHOb
         7eVPe/dZJfCnCINUwrEn1qMJIMT0q/nVK2Bkp4+pCFMoD0gfsFVyQxVy1GXoa3ObYtEV
         Y1tZNyU/zWL7YFfQitZXIiNgunkwBKYBZxm0s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=OqbBm+p2QZIQxA/+eAkRmYZxvBTU0PWCnvoyZzbFmfQ=;
        b=sJObA3+83cFuipJ0KEsBPzAYBwt5GwByjMnW/jr5qE5HapL3Wf+h0hkb8Lvq/k116Q
         z9eTk9KPq9hetsHwhHAY/SxZJ9OpsHSnYZBgT0ixQdDF6PHULGSCKwsXmJu5kbugsGbv
         ftDTvnT1wAMyPL9wRKtsrERpQW6j7GtDLpJhBSJc1AWui1R7W+QJrc4OjcjpNjxkVWM5
         gHbApW1KjmWBB5OSUtfofC2SqYgmGa5maSx+asQExObzu63x7G4r/dO3Koagfgb1eJrG
         kKjYmw38Zn3IG/yfTcyKqN2fGuDopQzHNvoS7mnOdL/6cBgEQGStW2iB/CsCtBse9lzW
         TONg==
X-Gm-Message-State: AJIora91VrtgP0rL+bLqp+sWkbxZtBEBUqpdOcrK+hh1Jg6aWO4TIWzK
        Q7WsOspCbIMd/NRbBagScwyToA==
X-Google-Smtp-Source: AGRyM1t3FnoeJkrvODuKMvvkFEYFtKw7jXzQDMsBcMUjbo+GwppftG/+9wsKOxGOeKq8qWAkqcpDnw==
X-Received: by 2002:a17:902:aa0b:b0:16b:c4a6:1dc9 with SMTP id be11-20020a170902aa0b00b0016bc4a61dc9mr4768089plb.83.1657744432432;
        Wed, 13 Jul 2022 13:33:52 -0700 (PDT)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id l15-20020a17090a384f00b001ef81574355sm2055578pjf.12.2022.07.13.13.29.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 13:33:51 -0700 (PDT)
Message-ID: <38f8afe1-e333-d5ff-eff2-5659ded9c466@broadcom.com>
Date:   Wed, 13 Jul 2022 13:29:38 -0700
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
 <147bc812-3971-9832-fb39-5545e280f562@broadcom.com>
 <a2007e2b7bcac30bdd6f6b03ee9cf61b@milecki.pl>
From:   William Zhang <william.zhang@broadcom.com>
In-Reply-To: <a2007e2b7bcac30bdd6f6b03ee9cf61b@milecki.pl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000000ce2e305e3b5b42c"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000ce2e305e3b5b42c
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 7/13/22 13:23, Rafał Miłecki wrote:
> On 2022-07-13 20:37, William Zhang wrote:
>> Hi Rafal,
>>
>> On 7/13/22 03:58, Rafał Miłecki wrote:
>>> On 2022-07-13 12:50, Rafał Miłecki wrote:
>>>> On 2022-07-13 02:57, William Zhang wrote:
>>>>> On 7/12/22 11:18, Krzysztof Kozlowski wrote:
>>>>>> On 12/07/2022 19:37, William Zhang wrote:
>>>>>>>>> +      - description: BCM4908 Family based boards
>>>>>>>>> +        items:
>>>>>>>>> +          - enum:
>>>>>>>>> +              # BCM4908 SoC based boards
>>>>>>>>> +              - brcm,bcm94908
>>>>>>>>> +              - asus,gt-ac5300
>>>>>>>>> +              - netgear,raxe500
>>>>>>>>> +              # BCM4906 SoC based boards
>>>>>>>>> +              - brcm,bcm94906
>>>>>>>>> +              - netgear,r8000p
>>>>>>>>> +              - tplink,archer-c2300-v1
>>>>>>>>> +          - enum:
>>>>>>>>> +              - brcm,bcm4908
>>>>>>>>> +              - brcm,bcm4906
>>>>>>>>> +              - brcm,bcm49408
>>>>>>>>
>>>>>>>> This is wrong.  brcm,bcm94908 followed by brcm,bcm4906 does not 
>>>>>>>> look
>>>>>>>> like valid list of compatibles.
>>>>>>>>
>>>>>>> For 4908 board variant, it will need to be followed by 4908 chip. 
>>>>>>> Sorry
>>>>>>> for the basic question but is there any requirement to enforce 
>>>>>>> this kind
>>>>>>> of rule?  I would assume dts writer know what he/she is doing and 
>>>>>>> select
>>>>>>> the right combination.
>>>>>>
>>>>>> The entire point of DT schema is to validate DTS. Combination like 
>>>>>> above
>>>>>> prevents that goal.
>>>>>>
>>>>>> Best regards,
>>>>>> Krzysztof
>>>>> Understand the DT schema purpose. But items property allows multiple
>>>>> enums in the list which gives a lot of flexibility but make it hard to
>>>>> validate. I am not familiar with DT schema, is there any directive to
>>>>> specify one enum value depending on another so dts validation tool can
>>>>> report error if combination is wrong?
>>>>>
>>>>> This is our preferred format of all bcmbca compatible string
>>>>> especially when we could have more than 10 chip variants for the same
>>>>> chip family and we really want to work on the chip family id.  We will
>>>>> make sure they are in the right combination in our own patch and patch
>>>>> from other contributors. Would this work? If not, I will probably have
>>>>> to revert the change of 4908(maybe append brcm,bcmbca as this chip
>>>>> belongs to the same bca group) and use "enum board variant", "const
>>>>> main chip id", "brcm,bca" for all other chips as our secondary choice.
>>>>
>>>> I'm not sure why I didn't even receive 1/3 and half of discussion
>>>> e-mails.
>>>>
>>>> You can't just put all strings into a single bag and allow mixing them
>>>> in any combos. Please check how it's properly handled in the current
>>>> existing binding:
>>>> Documentation/devicetree/bindings/arm/bcm/brcm,bcm4908.yaml
>>>>
>>>> Above binding enforces that non-matching compatible strings are not 
>>>> used
>>>> together.
>>>
>>> I just noticed you're actually removing brcm,bcm4908.yaml in the 2/3 so
>>> you must be aware of that file.
>>>
>>> So you see a cleanly working binding in the brcm,bcm4908.yaml but
>>> instead copying it you decided to wrote your own one from scratch.
>>> Incorrectly.
>>>
>>> This smells of NIH (not invented here). Please just use that binding I
>>> wrote and move if it needed.
>>
>> Not mean to discredit any of your work and I did copy over your
>> binding and combine them into one SoC entry to the new bcmbca.yaml and
>> add you as one of the maintainer to this file. As this change would
>> certainly concern you, that's why I sent RFC first.  As I explained in
>> the cover letter, the purpose of the change is to reduce the number of
>> compatible strings and keep one entry for one chip family due to
>> possible large number of chip variants.  But since there is no way to
>> validate the combination, I will copy the existing 4908 bindings as
>> they are now
> 
> Right. I believe we need that.
> 
> 
>> but I would propose to append "brcm, bcmbca" as it is
>> part of bcmbca chip. And for the other chips, we would just use enum
>> "board variant", const "main chip id", const "brcm,bca".  Does that
>> sound good to you?
> 
> Nitpicking: you meant "brcm,bcmbca" (typo) but sounds absolutely fine!
Yup its a typo.  Will append "brcm,bcmbca" and send out new patch.

--0000000000000ce2e305e3b5b42c
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIO8zDd+4I+IU/PjoSyeeyxysaicE
rHthxiRrx6TgueSFMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcxMzIwMzM1MlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQANYQJikj+2nv4md89gaXH0+PvBB3iBUyii2CBuZtcr0/MY
s6b24XnSQyCwkbWnxtl5cBaLPmlHrccbKTrgWtp9eLNTfD/Hfv7Hwm1n7STltEmDIu6Z29fCcoYh
vNCduHF3iGRrSUokHoDNL4v7wt7+DxjJXs3paCQP4l22Qq1k/rJAVc+fnU3p9IaFWCoq99WDZt1j
gpL1pa2pCOjkn85g58/CUTesezmbfZ7lIQL5uEDPlF+T//7XTNVedXNCfkIT2Rv6kUUUKWrKb2lz
7GEzaH3K5/K95MhpZDWF0E7JXoZPCBvzVYOWdL4tgSAlK0O7ZeiX+C16jTvMBod1g/Fz
--0000000000000ce2e305e3b5b42c--
