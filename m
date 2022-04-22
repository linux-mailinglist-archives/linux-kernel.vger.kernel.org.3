Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D9E50BEF3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiDVRsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:48:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiDVRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:48:05 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8530B1DA7E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:45:11 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id z16so8647418pfh.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=zkxsR5UlAKn38KExPZ6ST0DgkEgPy8IUGc41NGlEJn8=;
        b=S7GVAq8753kpY5mQUP6lm7xhnzM9KtMftg0NtcjpjB78vaG5D5ZyxP9hB8CaSqXefe
         OPCYOltF2xHD6N1gs0HiG9DZ+Z7EfZV7wlzbGmx5aXMIDFnZ2fo19H0MI2W8sQ1QiTND
         qHTAfP75rhwWv6PMjL1tX85N4dVwutCu5z9rY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=zkxsR5UlAKn38KExPZ6ST0DgkEgPy8IUGc41NGlEJn8=;
        b=Bd8KS5h1DH7wLI6X41+jWsvIDQysLOXmu70fq7t0wNCIG/jicMr1NDrgsNhCP43XmT
         ryC4ha9pu6q4m5OFapPdn+AesqPKGtw3lvLhYEiunGRmlU+7GJ1RWHozv+BA77aL9QrJ
         tvuXnyJflIlxs2mNCqREJubvIsQ6NT/42IqLCUV2gUAnmU2cePJumHv7uVDMEmRugzRi
         3MeqAplY2bHIT0niKtS2TvY4fTd1uEVyNNPFnybwJ/v+0sQn94mlqPK6r2ysrUPWRk6p
         iAa0vAV4xBcKlQHKIQFrzsU1s/+MBrfS+KE12kQl+yVyp6l0hOLHBteOENCxkb4VaSK8
         QueQ==
X-Gm-Message-State: AOAM531hn7gZj5tK1+Ar58HLMqpmiZzaoyhb+LXRxhZc/xQKIqeiBmYL
        aeESIinrieGAp12+T3hus8vB8w==
X-Google-Smtp-Source: ABdhPJy6kUz1wk/upnTt7BdxQo8i0gHD3iHxyBqXS4qnShz6qRqly4tVuTgnKsvSVvi0/Md+M1Hlng==
X-Received: by 2002:a05:6a02:105:b0:381:fd01:330f with SMTP id bg5-20020a056a02010500b00381fd01330fmr4739772pgb.483.1650649350114;
        Fri, 22 Apr 2022 10:42:30 -0700 (PDT)
Received: from [10.67.99.21] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id n2-20020a056a00212200b0050cf6ff5005sm1186977pfj.216.2022.04.22.10.42.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 10:42:27 -0700 (PDT)
Message-ID: <aa27b58d-af62-1add-1b27-1fb30ce6b8c5@broadcom.com>
Date:   Fri, 22 Apr 2022 10:42:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] MAINTAINERS: Broadcom internal lists aren't maintainers
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Joe Perches <joe@perches.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     bcm-kernel-feedback-list@broadcom.com,
        LKML <linux-kernel@vger.kernel.org>
References: <04eb301f5b3adbefdd78e76657eff0acb3e3d87f.camel@perches.com>
 <db4b9db9-fa02-4b92-3b9a-bd866fa0e73e@gmail.com>
 <b95d9b1058eed13489adba0bccdeb600950eb153.camel@perches.com>
 <dd97ffe3-3983-fc45-469b-703900077f2f@broadcom.com>
 <feff60ee8a6d10da7d10b421d18407a5d040680e.camel@perches.com>
 <b8a5bb60-15d4-0b3b-9d96-758e5136fb46@gmail.com>
From:   William Zhang <william.zhang@broadcom.com>
In-Reply-To: <b8a5bb60-15d4-0b3b-9d96-758e5136fb46@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002f9bf705dd41c0af"
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002f9bf705dd41c0af
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 4/22/22 10:24, Florian Fainelli wrote:
> On 4/20/22 14:31, Joe Perches wrote:
>> On Wed, 2022-04-20 at 11:50 -0700, William Zhang wrote:
>>>
>>> On 4/19/22 16:11, Joe Perches wrote:
>>>> On Tue, 2022-04-19 at 12:00 -0700, Florian Fainelli wrote:
>>>>> On 4/12/2022 11:34 AM, Joe Perches wrote:
>>>>>> Convert the broadcom internal list M: and L: entries to R: as
>>>>>> exploder email addresses are neither maintainers nor mailing lists.
>>>>>>
>>>>>> Reorder the entries as necessary.
>>>> []
>>>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> []
>>>>>> @@ -3746,7 +3746,7 @@ F:    include/linux/platform_data/b53.h
>>>>>>     BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
>>>>>>     M:    Nicolas Saenz Julienne <nsaenz@kernel.org>
>>>>>> -L:    bcm-kernel-feedback-list@broadcom.com
>>>>>> +R:    Broadcom Kernel Team <bcm-kernel-feedback-list@broadcom.com>
>>>>
>>>>> There is not a "Broadcom Kernel Team", the description of R: 
>>>>> appears to
>>>>> require some kind of full name, hence the choice of L: instead of R:.
>>>>
>>>> If you don't like "Broadcom Kernel Team", perhaps
>>>> "Broadcom Kernel Reviewers" might work for you.
>>>>
>>>> I think it doesn't matter much.
>>>>
>>> I can see that we shouldn't use M as maintainer for this Broadcom
>>> mailing list email. But I honestly don't understand why we have to use
>>> R. Just for the sake of full name?  Not everyone in this distribution
>>> list is reviewer.  IMHO I would prefer to change all entries to L
>>> without a full name.
>>
>> I think "R:" is a better choice than "L:"
>>
>> "L:" Mailing list entries have archives that are publicly searchable.
>>
>> Are the broadcom bcm-kernel-feedback-list entries publicly archived?
> 
> They are not indeed.
> 
>>
>> If not, these are one-way entries, so someone sends and hopes only.
>> Replies that are sent from these entries are not visible to the public.
> 
> OK, fair enough, I will change to:
> 
> R: Broadcom internal kernel review list 
> <bcm-kernel-feedback-list@broadcom.com>
> 
> If that works for everyone?
Sounds good to me.

--0000000000002f9bf705dd41c0af
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIJ0C4V+H+0aqzS75FIOoUledPA/h
geQngja2sZQV0E1oMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDQyMjE3NDIzMFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQC4TgR3Xhu2U53U8/5GRafb3/NJXiRCRKHgFulIpf9QL/a9
G2Xeud8ZCVcDdCpAATmv/rmmS2q9AqTlg0kLTJUqsrdZC1weYVxwISC8OMMA+jPOgqroX1hTfOyx
fKguYNJhDPldPCnqTaIGG9xPxHNMySqjuSQIHLQQUOZOYs+n4jZfZu75KhgakbtHFiBuJtkshwLl
Zoy/Otd3oSZGBfJPH5agkCotnGSB+S0p4IJYBOzHq0b/GjF31GugJ2EeJwzcbuTspxYplYXWDM5o
r26WfMySqV/X7RuoR/sYwGODZgqMOX99JXzkfdN9Zk6h0LDMoJGT1cwZWarzin55bzKO
--0000000000002f9bf705dd41c0af--
