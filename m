Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78F185721EF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 19:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbiGLRsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 13:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiGLRsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 13:48:06 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA663CDA3A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:48:05 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t5-20020a17090a6a0500b001ef965b262eso9102557pjj.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 10:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=rgo86GQnSzHMeMGa4PPudA2hvq1JNXY7l72VirP/dRg=;
        b=GqQsXMaqI+S1mcAmlIaLug5ckpT9KHAvXEwOa9AePXCD8UYU/2eFgq/KvL09NlLCEe
         A4F1Z/X2uZb+QoBqbnMmJKAm1UCD4PvyZT7LJfeK0Fn2wLY34KugB9/Pp7oiNlfCMfoM
         Gg0CpoQYNrSNdB2LQc42WuTu+U/Z1XOMu3EWs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=rgo86GQnSzHMeMGa4PPudA2hvq1JNXY7l72VirP/dRg=;
        b=vF+SEDGlpC6q+15Y+pm+DZIU9tQ5hAVOr8Ml3RtUbDAHWbBre6xTowq+u34dOrE07A
         DYx4EzLl3Zk5ALhYdOAAzKQfkUG0+mhIt3DSkXpDXj8z8fowsMR3wRJ3XMYiYjv6DjHa
         fdB48zC2cRN4oIISreozA6XPEybkoKbyc7Buff5AQo+hnZRf4QdfeD1msLuOIB5/F+yU
         oyEfmWS3ypebxMI+/ibWdhTxeZIGyPp3T34HdPAw9YrNuZKz0FHBHMndz0Cy6oT0FZEs
         Ajk2jQhyLFn0mkIQSCUIUj7TO3llAKjXLXtUIRqNaF50Z8DjNL/cXYxW7EDwiCfUy02i
         ploA==
X-Gm-Message-State: AJIora8ensDw0HY2809DIwezrvs63ZuUAi2Mi18OSMHQJWGnWc/czHGo
        ukLf+a6SYmFrZLBf1TlDVlzWkw==
X-Google-Smtp-Source: AGRyM1v2WJkdPibXfvMSAYPp4ndfMxx3A8lOHEccIeHIpGcXHtlA47NnBE5AGbPZJYd5O6/sPhMNfA==
X-Received: by 2002:a17:90a:8c0a:b0:1ef:7c95:3f00 with SMTP id a10-20020a17090a8c0a00b001ef7c953f00mr5500535pjo.180.1657648085200;
        Tue, 12 Jul 2022 10:48:05 -0700 (PDT)
Received: from [10.0.2.15] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902780400b0016c42929f70sm5091677pll.87.2022.07.12.10.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Jul 2022 10:48:04 -0700 (PDT)
Message-ID: <9bc3e0b6-833e-375e-70d6-1dbd036ef25a@broadcom.com>
Date:   Tue, 12 Jul 2022 10:48:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [RFC PATCH 3/3] arm64: dts: bcmbca: update bcm4808 board dts file
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     kursad.oney@broadcom.com, anand.gore@broadcom.com,
        dan.beygelman@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        joel.peshkin@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220712021144.7068-1-william.zhang@broadcom.com>
 <20220712021144.7068-4-william.zhang@broadcom.com>
 <d93e55fa-3359-2609-aad5-c80eca78f380@linaro.org>
 <900ac3ed-a77c-3cc0-f5ab-c45267a1a4ba@gmail.com>
 <6b7bab04-90ce-6111-35bd-42cb3a1f73f8@linaro.org>
From:   William Zhang <william.zhang@broadcom.com>
In-Reply-To: <6b7bab04-90ce-6111-35bd-42cb3a1f73f8@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004cb60b05e39f4591"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004cb60b05e39f4591
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/12/22 08:50, Krzysztof Kozlowski wrote:
> On 12/07/2022 17:36, Florian Fainelli wrote:
>> On 7/12/22 00:47, Krzysztof Kozlowski wrote:
>>> On 12/07/2022 04:11, William Zhang wrote:
>>>> Update compatible string based on the new bcmbca binding rule
>>>> for BCM4908 famliy based boards
>>>
>>> Typo - family
>>>
>>> Please explain why breaking the ABI (and users of these DTS_ is acceptable.
>>
>> This will be largely targeted towards Rafal who supports these kinds of
>> devices with an upstream kernel. My understanding is that this is OK
>> because we will always ship a DTB matching the Linux kernel, and I
>> believe this is true for both the way that William and his group support
>> these devices, as well as how OpenWrt, buildroot or other build systems
>> envision to support these devices.
Yes that is correct for bca group.

>>
>> Rafal, does that sound about right?
> 
> I am fine, just maybe mention it in the commit because it literally
> breaks the DTSes.
> 
> I assume you considered all possible uses outside of Linux like U-Boot,
> BSD etc?
> 
> Best regards,
> Krzysztof

The reason for this patch is to keep the bcmbca board dts in the same 
format and keep everything in the same yaml file. Understand 4908 was 
already upstream but luckily there is no driver in linux and u-boot that 
uses these 4908 compatible strings. They are only used in the board dts 
as far as I can see.  So it does not really break anything in the end, 
unless someone use them in any driver but never upstream their code...

Rafal,  please let us know if this is okay with you or any 
concern/possible break of existing system.

--0000000000004cb60b05e39f4591
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQcAYJKoZIhvcNAQcCoIIQYTCCEF0CAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3HMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA5MTYwMDAwMDBaFw0yODA5MTYwMDAwMDBaMFsxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBS
MyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
vbCmXCcsbZ/a0fRIQMBxp4gJnnyeneFYpEtNydrZZ+GeKSMdHiDgXD1UnRSIudKo+moQ6YlCOu4t
rVWO/EiXfYnK7zeop26ry1RpKtogB7/O115zultAz64ydQYLe+a1e/czkALg3sgTcOOcFZTXk38e
aqsXsipoX1vsNurqPtnC27TWsA7pk4uKXscFjkeUE8JZu9BDKaswZygxBOPBQBwrA5+20Wxlk6k1
e6EKaaNaNZUy30q3ArEf30ZDpXyfCtiXnupjSK8WU2cK4qsEtj09JS4+mhi0CTCrCnXAzum3tgcH
cHRg0prcSzzEUDQWoFxyuqwiwhHu3sPQNmFOMwIDAQABo4IB2jCCAdYwDgYDVR0PAQH/BAQDAgGG
MGAGA1UdJQRZMFcGCCsGAQUFBwMCBggrBgEFBQcDBAYKKwYBBAGCNxQCAgYKKwYBBAGCNwoDBAYJ
KwYBBAGCNxUGBgorBgEEAYI3CgMMBggrBgEFBQcDBwYIKwYBBQUHAxEwEgYDVR0TAQH/BAgwBgEB
/wIBADAdBgNVHQ4EFgQUljPR5lgXWzR1ioFWZNW+SN6hj88wHwYDVR0jBBgwFoAUj/BLf6guRSSu
TVD6Y5qL3uLdG7wwegYIKwYBBQUHAQEEbjBsMC0GCCsGAQUFBzABhiFodHRwOi8vb2NzcC5nbG9i
YWxzaWduLmNvbS9yb290cjMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjMuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yMy5jcmwwWgYDVR0gBFMwUTALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgEo
CjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAN
BgkqhkiG9w0BAQsFAAOCAQEAdAXk/XCnDeAOd9nNEUvWPxblOQ/5o/q6OIeTYvoEvUUi2qHUOtbf
jBGdTptFsXXe4RgjVF9b6DuizgYfy+cILmvi5hfk3Iq8MAZsgtW+A/otQsJvK2wRatLE61RbzkX8
9/OXEZ1zT7t/q2RiJqzpvV8NChxIj+P7WTtepPm9AIj0Keue+gS2qvzAZAY34ZZeRHgA7g5O4TPJ
/oTd+4rgiU++wLDlcZYd/slFkaT3xg4qWDepEMjT4T1qFOQIL+ijUArYS4owpPg9NISTKa1qqKWJ
jFoyms0d0GwOniIIbBvhI2MJ7BSY9MYtWVT5jJO3tsVHwj4cp92CSFuGwunFMzCCA18wggJHoAMC
AQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUAMEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9v
dCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5
MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEgMB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENB
IC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0E
XyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuul9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+J
J5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJpij2aTv2y8gokeWdimFXN6x0FNx04Druci8u
nPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTv
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBU8wggQ3oAMCAQICDDbx5fpN++xs1+5IgzANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwODA1MjJaFw0yMjA5MDUwODEwMTZaMIGQ
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xFjAUBgNVBAMTDVdpbGxpYW0gWmhhbmcxKTAnBgkqhkiG9w0B
CQEWGndpbGxpYW0uemhhbmdAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIB
CgKCAQEA4fxIZbzNLvB+7yJE8mbojRaOoaK1uZy1/etc55NzisSJJfY36BAlb7LlMDsza2/BcjXh
lSACuzeOyI8sy2pKHGt5SZCMHeHaxP8q4ZNR6EGz7+5Lopw6ies8fkDoZ/XFIHpfU2eKcIYrxI25
bTaYAPDA50BHTPDFzPNkWEIIQaSBBkk55bndnMmB/pPR/IhKjLefDIhIsiWLrvQstTiSf7iUCwMf
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICKkCHjphC/yPrAgfs0Mpjl16aZe
SMhRgw8g5RKsGg0TMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcxMjE3NDgwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQB80XhziPbMs4WIP1KTI2x3AMMcvu3fdmLFas1D+HVLN9V4
REJ4FoWWUq80kI5aRJx7iwO3jCNxp6UQ2sS5fqW1PCVz7UXL0cIXTAOC9jsj3XpMxNNoYoqv6j1s
PZTqh8NklsP5XxVc9OaH0WMpHLOwmW8sl+0eH9kolwIzqzfH14PYEMQh31LniEIIY3zIp7PE/KRh
7YWVjvYCsZFAFoFj2IdbQGaXV2aSa6xZvRhiAwB+dJ7uwwe+iGXtDppC04CLgEnJe2QaAlh2cWSM
632cJVcdxgx8oO+1frTTtz0RpDUP2A5T/c0xDiljbTFbCxL9FUK9GHpzzhm20I9q0aRE
--0000000000004cb60b05e39f4591--
