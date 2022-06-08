Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5E02542A04
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 10:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiFHIyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 04:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232723AbiFHIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 04:53:51 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D898426F492
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 01:14:15 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id e9so7383805pju.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 01:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=tVKr3K8ZsTtFWgbaAfwn240BDgmcuSyxxSdMd7Qzt1M=;
        b=Xd04xj/rdlW2ZzU6RaRY9EcZR0BiajnXCM5cjyMXpqjLjxhcsIGCZuJ7+/Zh7tLLJe
         l0HKpv7/1SzeJEmwlP+RQGMd/O0blyLSNTmVy6ZegD+T3zxSqhqBC11a7O4w0pKZlC1L
         YGBSZVuiu1m/HVHWpEl7bHCP5okqTh2cJzG+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=tVKr3K8ZsTtFWgbaAfwn240BDgmcuSyxxSdMd7Qzt1M=;
        b=lo8xlwV3qT7PsGs+tNxibcfCjAG88AuZdenUfqv/M5moGId/eYDnEks59r8utu25t/
         /ai+Ly/6uVL0ZjXykM2bo7c3eRovX9M8cdcSFoZKzaUr28rH7sE93jQol+0zbK2u/ll9
         VhNZEBVBmdfuGU7ahmDCSDCnvXFIivzGZdCZYfcAb9pres3TBOOWiGvj1K8j3gWiCKfC
         RBC1J+ZauSeP6TW+Q5nWOTRaMchHtHQ2WO1bA5Td6HF4rgqa+yqeNn+OmgTDC7Bhxhzw
         HSr3LS4EqMnjm/27Kr/sTQYt/ovtJs9kZn/S8VWRc49yOVihr6+GWw2Gw9uhgvynBFxs
         0DaQ==
X-Gm-Message-State: AOAM530kU38XWdZ/XMAZoYUTESYpMnYWFjJzl+BLXHJxyKLVNsJQJxIz
        Mq1yVwBH6gftOGhqoBoMJylP6g==
X-Google-Smtp-Source: ABdhPJyrNPkSXz4JDB2qOxrVoRx56mG6jDHwsaRLr7ri/bUO2XGLiQ3a64442HhwwTVv1s2Gso7gNw==
X-Received: by 2002:a17:902:ab87:b0:162:26cf:bf7a with SMTP id f7-20020a170902ab8700b0016226cfbf7amr32344421plr.168.1654676055354;
        Wed, 08 Jun 2022 01:14:15 -0700 (PDT)
Received: from [192.168.0.24] ([88.126.57.132])
        by smtp.gmail.com with ESMTPSA id u19-20020a170902e21300b00162529828aesm13947073plb.109.2022.06.08.01.14.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 01:14:13 -0700 (PDT)
Message-ID: <82c90bda-c7e5-ba7f-13f5-c43a21201b1f@broadcom.com>
Date:   Wed, 8 Jun 2022 10:14:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 1/5] dt-bindings: arm64: add bcm63158 SoC
To:     William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     joel.peshkin@broadcom.com, tomer.yacoby@broadcom.com,
        kursad.oney@broadcom.com, philippe.reynes@softathome.com,
        dan.beygelman@broadcom.com, samyon.furman@broadcom.com,
        anand.gore@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220601225654.18519-1-william.zhang@broadcom.com>
 <20220601225654.18519-2-william.zhang@broadcom.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
In-Reply-To: <20220601225654.18519-2-william.zhang@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000083b92b05e0eb4add"
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000083b92b05e0eb4add
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/2/2022 12:56 AM, William Zhang wrote:
> Add BCM63158 SoC device tree description to bcmbca binding document.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>

Applied to https://github.com/Broadcom/stblinux/commits/devicetree/next, 
thanks!
-- 
Florian

--00000000000083b92b05e0eb4add
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
u4AzaGpwhramjYYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIDrX5gqOTkBHGDI4
0e/dNxGffZejbelwAazWqHK6I4+vMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIyMDYwODA4MTQxNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCszp0B3Z9RNsxIBBArw5vB1xZBXX2l5Xjv
DHaK/1Az48UGFSPaT88rLLXbJCyTq416K8qBbQwg1MqaFGNIPSpvFDfdvj/B/CbDFM43TgbvQuhD
s6J6JGEnhQhT3iWTlCf6Eztrt4ouWMrhU5vHvQXWgREKOlOodJljpWO9ud+8yMdApFS+LPWkqSx0
qP/FGC0r5Rl+GgzKS5UMzJEbGj3y7H7lmnGjUnVeZyrGya4j2ivhpGOl4aUDtlScKIpQ5zyy62DP
tW+uSWm1J8CuT64BoOZcmF6ioYuRlIu2N1gLmWA1nNX9LUFNvR42Ueq/FIR7h0tuukGumbTXsW9b
ytyd
--00000000000083b92b05e0eb4add--
