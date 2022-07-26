Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A764D581859
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 19:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237952AbiGZR1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 13:27:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233598AbiGZR1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 13:27:43 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B635A2B264
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:27:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id q22so8552704pgt.9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 10:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=av2Syvvlkb8CyTB1E95CDwaK14yuRnHWSoPu6qNaCD0=;
        b=HOqxEnFjtuDAE1o9ZB5PMKHSzRn+7m24cOyDiDGG9cGHX0HELRhGFHZMsOSNatvbJB
         5NJ/4yxhLttx2LNN2wWUWzM1BWz3Z5nn7Wd7fjMkKFVj8+Z2RyJeduFdIB0JETvxzm3X
         Ho7Lb21B41uvPk676P3zmwbgif+pAD3HSI3gc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=av2Syvvlkb8CyTB1E95CDwaK14yuRnHWSoPu6qNaCD0=;
        b=4H8ITx6AHoFqC4jg90BqUuM8vPeLeEeYHqL0DZlEeD2L90ZrWilieZXV7IAYwPBBaY
         d4MAscMl5lMsr1zi9p3gF9DS1xft42LKjHIk88T3S/htdpAGA1VGgCsEoVKrLCNkrVag
         9Io29q73rJUFTAc7whbt0HmDEa18L7nhCwRbj/mxbDqFCZNW44CDGHG6JLD5U/Eimpi2
         /WzOHOUdgEh7CrvOZrubYLcCPmQwEE1iQ5U8O3wvCka7QzHJEL2GY+Jw7KWEgdrdehGZ
         nkbxuwSsn3BZj6PaYsfrbwD0pjj0+57FtCdLbxIJy0l0CgPdCIL9bB+cX8/+OL5igJcU
         Oj/w==
X-Gm-Message-State: AJIora/CbPMTVaJ/Q4xgQPHRewRS55AYnAckDEPuwPLg/AvkR8fo829h
        xqsVJejUdS+/NGXqwQ2VvDkcyA==
X-Google-Smtp-Source: AGRyM1shmyvJU41YnB8ExKAyRWdyDdJKD2dsVI6YXJuySxY7oEpJ8D65K1QM1PUxtKUJ1PtnTuw4UA==
X-Received: by 2002:a63:85c6:0:b0:412:a94a:4ffc with SMTP id u189-20020a6385c6000000b00412a94a4ffcmr16025525pgd.618.1658856461188;
        Tue, 26 Jul 2022 10:27:41 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id q13-20020a65684d000000b00419cde333eesm10391306pgt.64.2022.07.26.10.27.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Jul 2022 10:27:40 -0700 (PDT)
Message-ID: <f86161ec-0b84-2d88-01b0-352ef3a71342@broadcom.com>
Date:   Tue, 26 Jul 2022 10:27:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 2/3] Documentation: sysfs: Document Broadcom STB memc
 sysfs knobs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
References: <20220722201043.2731570-1-f.fainelli@gmail.com>
 <20220722201043.2731570-3-f.fainelli@gmail.com>
 <135be705-24f9-13b8-6939-0eaa569434d7@linaro.org>
 <3d29b8fc-f183-5883-edc0-cde55b76e4fd@gmail.com>
 <2dffc393-b86c-17e2-8c11-bdd9504366c5@linaro.org>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <2dffc393-b86c-17e2-8c11-bdd9504366c5@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001edadf05e4b89e43"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001edadf05e4b89e43
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/26/22 02:34, Krzysztof Kozlowski wrote:
> On 25/07/2022 18:07, Florian Fainelli wrote:
>> On 7/23/22 10:59, Krzysztof Kozlowski wrote:
>>> On 22/07/2022 22:10, Florian Fainelli wrote:
>>>> Document the "srpd" and "frequency" sysfs attributes exposed by
>>>> the brcmstb_memc driver.
>>>>
>>>> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
>>>> ---
>>>>  .../ABI/testing/sysfs-platform-brcmstb-memc       | 15 +++++++++++++++
>>>>  1 file changed, 15 insertions(+)
>>>>  create mode 100644 Documentation/ABI/testing/sysfs-platform-brcmstb-memc
>>>>
>>>> diff --git a/Documentation/ABI/testing/sysfs-platform-brcmstb-memc b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
>>>> new file mode 100644
>>>> index 000000000000..2bf0f58e412c
>>>> --- /dev/null
>>>> +++ b/Documentation/ABI/testing/sysfs-platform-brcmstb-memc
>>>> @@ -0,0 +1,15 @@
>>>> +What:		/sys/devices/platform/*/*/*/*/srpd
>>>
>>> That's a lot of */. Are you sure it is correct path? Didn't you include
>>> here some driver-related path components? Can you paste in email full
>>> path as an example?
>>
>> Yes this is the correct path:
>>
>> /sys/devices/platform/rdb/rdb:memory_controllers/rdb:memory_controllers:memc@0/9902000.memc-ddr/
>>
>> the 'rdb' node is our top level bus node, the 'rdb:memory_controllers' is an encapsulating node that groups all of the possible memory controllers in a system (there can be between 1 and 3), the rdb:memory_controllers@0 is the first of those memory controller and finally the 9902000.memc-ddr is the sub-node that contains the register controls of interest, since the memory controller aggregates different functions (arbitration, configuration, statistics, DDR PHY SHIM layer, etc.). Maybe I should provide a more complete binding while I am it.
> 
> The path should be much more specific so include at least:
> rdb/rdb:memory_controllers/rdb:memory_controllers:memc@*/
> (or some variations of it if pieces of name change)
> 
> However looking at the driver, this is regular platform driver, thus  it
> will appear as:
> /sys/bus/platform/9902000.memc-ddr

There is a missing /devices in the path, but yet that will work too:

/sys/bus/platform/devices/9902000.memc-ddr

Thanks!
-- 
Florian

--0000000000001edadf05e4b89e43
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDHG7gDNoanCGtqaNhjANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMTAyMjIwNjU3MTBaFw0yMjA5MDUwNzA3MjNaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEAu10WSl35INx8Ma97NH54zM3XKzx8Lo/KErWP5HPBtIxzYjBL20TDg9Jmnnbs
rZjwEVNKY30HiBRJcooDpalBATQpdw3kdYEgojrrXjVz4a+YaWhLbV0OwQ54QAkwKsdYTnuUX0B4
YLYGuUBDXYkcFWZv5BiAF4L97ClbTnUUCry8bhV9SP8b/tbivOhWUSjHLsQ9gEjuLhVId3Xgs9dA
TtoyOTJVs6HDth0+/13gxSrB3BwSY4wtw7EPHshswD1fzSV1fZf7QUQedadjH8BMBaKKseIieb6M
bhjsippX2btWEJOuUFS5RkK5HFFkzcGtIQd+gltZHQHohAcopF+cSwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUIDZLMN77
IWw6rnhSvGm2V4nv3AowDQYJKoZIhvcNAQELBQADggEBADVdzyh3BQZiABHSdL7LQPNr6/6OQwg7
65j9Ggyr2Rdl2RnQIifKtGGodVlJ8e9XCYt5rCNU8PriYstIk4jlMJp6SziSN0CLE+A+FujmTqZJ
X8vEct7sdLXqdlBvR23TLvnkxbS3RwED7FDDTxpIv5j87o78e+wrZOPvDskdrYXVWGUu23xmd2IS
kYMLAXNeGrVe6HovEKCJPw07+B35iJvwdpZBXiti5hFa3q1L0+K5nGMpceIrj4dOOkSNB2ipHR6H
Q5HbB0UbWMkRv1PYpxf5eMjyDqxNigsE2JIFa1nk8ckA8hoTKbypCoALjcSuNqdZZyOnMBSKguHJ
Zz4bBBwxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgxx
u4AzaGpwhramjYYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIEtD/2v+ivdpSVMs
cdnpXN6PKHzUCMPGHFfK3YHZ+b8rMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIyMDcyNjE3Mjc0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQAA162z0AlrOhzH0s9PtB0mRJec1t50BneR
V6hvDxboekvGRBX3pwxza2MBEMQPCJStxCxf6XPozsNk1R84CzeMUbWs2vFdEYeKvtMdyrum/Pne
dHNRojtEuk7X6t8XLAwTfIA0EWUxuIvF9Shwobxuk1K6o9+kZE4fTn4gaJyuddxCIISL2/TyhxSR
kzxSFnQ2b83fhJMeoFkm1SpYz4Luz1ND+wXkNCKshafkYvRsdzdWTe7s2dum1Vxcm4O2kcF3pSQV
FN8bwMnWfzMt9rOTOjoyumNYWUj42Vm+LPxq/R+3N2EGGpMNpOFp+oHQCa9OKJjLpwmQaRN4UKk1
ROWW
--0000000000001edadf05e4b89e43--
