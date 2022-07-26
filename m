Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 092095808EC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 03:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235387AbiGZBJk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 21:09:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231469AbiGZBJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 21:09:38 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059C227FE9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:09:37 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id r8so3587501plh.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 18:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=88skLQ9t5ID+YPUNG7Tps/3F68w0dkVTfXzDJ/MG9ZI=;
        b=BlHBR/kejwLNQAYa7Vc0ic3CHcmYoFgHXzh/xd8AIROfhSK5hPubJhgn85iz8Ycw0n
         XRjTza1jaVcEOy2EaTj9rVr38dV/B210HiIJsK6pu1WM7a3/aDi97hE/QAgClfTmc5Kr
         cotJ+Z6MqGP8537xx228UQV54ZNNh5KB8qzPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=88skLQ9t5ID+YPUNG7Tps/3F68w0dkVTfXzDJ/MG9ZI=;
        b=BvaQFi53g2h3XOhKUpSDlc5bv/uAl2WROvdp9gtA+CsauLHVe6/DcyFcmYLVXkP+Nr
         ww6RERzDJKzGbYl/9IKO1AGw3Pw8u0Ri/DXvq8Mdy2GJGlg0rZc8j1W8D6rdh2MMF61J
         nKGy2ZCaPv2ih3DJebgkFHQhYpVEpwxr+ZIm4lT5nafwMAcb4dQLKwD1Lbg9W6UwhHDz
         6ZDwjNXhsL2OyOQ+QVatQLNe2dIF+vwMnH34E/R1nf8bSmtXnPJJdjDu2GCkq03noug0
         yeWAfrbHLJ9npUmV15UBVO5MDo7PuWMNCa+59YLJVFdAnxTJwIVSyN2tAhbj0/SV7tiQ
         hiQg==
X-Gm-Message-State: AJIora/+fEBhCRsaHwL5K42AiBnh8eeeQpkoxKVEJcUena89mOFfpk97
        fKnoZUz1G88+ujD+9Vnw0CpievYIjm6SL0PWHSp1ogzgaKahmxxUHbS3eR3G9o8FRpQ74NsuIPu
        roDWSlUl/8KKY+QGNQwUsUzoypwrXQCAcMfwy/QAB2mm/3RkUrHjCtzcI/a0Okty36eKaXoRcTt
        l0C+GSY4rb
X-Google-Smtp-Source: AGRyM1s7BAw9OFRXxuF8rVhkxX7RzQWjP9WHU5QX5jLIEHnAJnOxLo/z9qVaeeSCffz6ZtdGDxPu8g==
X-Received: by 2002:a17:903:1252:b0:16b:a568:4f7d with SMTP id u18-20020a170903125200b0016ba5684f7dmr14850315plh.103.1658797776007;
        Mon, 25 Jul 2022 18:09:36 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a123-20020a636681000000b00415d873b7a2sm8856297pgc.11.2022.07.25.18.09.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jul 2022 18:09:35 -0700 (PDT)
Subject: Re: [PATCH v2 3/9] arm64: dts: bcmbca: update BCM4908 board dts files
To:     Rob Herring <robh@kernel.org>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, f.fainelli@gmail.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        dan.beygelman@broadcom.com, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, rafal@milecki.pl,
        krzysztof.kozlowski@linaro.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220725055402.6013-1-william.zhang@broadcom.com>
 <20220725055402.6013-4-william.zhang@broadcom.com>
 <20220725233238.GA2960972-robh@kernel.org>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <1004391f-fb6c-5f84-de28-8f76dc3471e5@broadcom.com>
Date:   Mon, 25 Jul 2022 18:09:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20220725233238.GA2960972-robh@kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000003a73c305e4aaf4af"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003a73c305e4aaf4af
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

Hi Rob,

On 07/25/2022 04:32 PM, Rob Herring wrote:
> On Sun, Jul 24, 2022 at 10:53:56PM -0700, William Zhang wrote:
>> Append "brcm,bcmbca" to compatible strings based on the new bcmbca
>> binding rule for BCM4908 family based boards. This will break drivers
>> that use the old compatible string for binding. Fortunately there is no
>> such usage in linux and u-boot.
> 
> How does adding an additional compatible break things?
> In theory when some crazy code tries to match the entire string. But not 
in linux, u-boot code and hopefully not in other bootloader and Os does 
that. But this does change an existing compatible string so Krzysztof 
suggested to add comment about the breakage in the commit message. I can 
remove this and send v3 if you guys think it is necessary.

>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> Acked-by: Rafał Miłecki <rafal@milecki.pl>
>>
>> ---
>>
>> Changes in v2:
>> - Add Acked-by tag
>>
>>   arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts | 2 +-
>>   .../dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts     | 2 +-
>>   arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts | 2 +-
>>   .../arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts | 2 +-
>>   4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
>> index 2dd028438c22..d8b60575eb4f 100644
>> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
>> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
>> @@ -7,7 +7,7 @@
>>   #include "bcm4906.dtsi"
>>   
>>   / {
>> -	compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908";
>> +	compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908", "brcm,bcmbca";
>>   	model = "Netgear R8000P";
>>   
>>   	memory@0 {
>> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
>> index 064f7f549665..296393d4aaab 100644
>> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
>> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
>> @@ -7,7 +7,7 @@
>>   #include "bcm4906.dtsi"
>>   
>>   / {
>> -	compatible = "tplink,archer-c2300-v1", "brcm,bcm4906", "brcm,bcm4908";
>> +	compatible = "tplink,archer-c2300-v1", "brcm,bcm4906", "brcm,bcm4908", "brcm,bcmbca";
>>   	model = "TP-Link Archer C2300 V1";
>>   
>>   	memory@0 {
>> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
>> index 04f8524b5335..787c7ddf9102 100644
>> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
>> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
>> @@ -6,7 +6,7 @@
>>   #include "bcm4908.dtsi"
>>   
>>   / {
>> -	compatible = "asus,gt-ac5300", "brcm,bcm4908";
>> +	compatible = "asus,gt-ac5300", "brcm,bcm4908", "brcm,bcmbca";
>>   	model = "Asus GT-AC5300";
>>   
>>   	memory@0 {
>> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
>> index 3c2cf2d238b6..23b96c663239 100644
>> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
>> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
>> @@ -3,7 +3,7 @@
>>   #include "bcm4908.dtsi"
>>   
>>   / {
>> -	compatible = "netgear,raxe500", "brcm,bcm4908";
>> +	compatible = "netgear,raxe500", "brcm,bcm4908", "brcm,bcmbca";
>>   	model = "Netgear RAXE500";
>>   
>>   	memory@0 {
>> -- 
>> 2.34.1
>>
> 
> 

--0000000000003a73c305e4aaf4af
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEII/XsXZ5jAOS2vOnkrLcKmxgqBt/
IwFPlL0PuMenpwYlMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcyNjAxMDkzNlowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAdXXpzDJjG+uEcjZRDILDmDhXhdWxEO/9lGMyKSFqIZ9M0
Ma9SQ/e7C0+H6h0y5kP7Iy/7t+DEQPrUSqjk+N3VI4y4+D3rwLil23kHXZlPC/P2IVefDuUCLna8
KAI9i9YAldcbCg9jC6mHWaVot53utSw/DylzckrZ0S+IaogSZKbtC45B/9SyWZd6fPscjgjqJ3TC
FRtmDpmSjlWqN/Jf/N/7PFxiIP9omSqhhLcefcQzxTbYc3jrcmO6dhBn01HIRYmGI71q7PPQ1L1A
z0dNhkT4mfLeypsxCK5MXxEUVZ1VCok/JRwNzff7pDcXC0SMrFTpZxcpN/nQ6UXOIQrZ
--0000000000003a73c305e4aaf4af--
