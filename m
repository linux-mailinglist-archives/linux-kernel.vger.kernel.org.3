Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A4C569504
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbiGFWHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230334AbiGFWHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:07:50 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 090F2A1B0
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 15:07:49 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id y141so15578185pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 15:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=elvek2GWUPi7f+aJcLa3gAdL5aLhEJVmABZzXow+vRE=;
        b=HUB3xscXMJcfFjyrm0TbVAbSzLROu74FPlRPQGw8icXuiyE+U72hfx0EE+ZEfwrJyJ
         r0EtIja3H1uF7D3rijJiEFxpbW8sV+VHeepnBJsXaEXN/zll/oha1iNNrt7uJLB2MNXa
         cPGNrCA4TPuWubrIK1mIGmlwBUi0Elj0YHAz8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=elvek2GWUPi7f+aJcLa3gAdL5aLhEJVmABZzXow+vRE=;
        b=1LK35JZa1whm9iOTvbR4LRRRLiz23qIHCZ4cXcZMmPeSj4oSHDZ+3SRq0EdPyrSM2E
         7TYw3JGF2c/RH7bSCZjPW4Ts6jU720/xhNWI4dnA0TF7ZBjn9nvkmSUrVloJIj+HX+nj
         SFPSQDlPMtvpiByS5Gzk7vPc/q4z8R8acGy1vzFE8A2Z1DSu2ksbd+8Tfd3YdENXA8Yl
         ogT8HW4tVEc3N3Wd1sBesb9GIOZQr0u30+BvbuQ8LnTicG1RuFA5UKJ904R/JT6mXkiq
         nqGiucUW52P6/FAfB89qCPZ9FYaTvREH2LjcffnvhnTvfbUb0xHetW6DNnbT1niFE6MN
         JpsA==
X-Gm-Message-State: AJIora9cpSTFpMdzJjXkuJ1gpMdo6hodpJR8T0CoI6uhjy3ORZuZ9yte
        yQpSM5lSv3h61QcCP9fe9RVsDA==
X-Google-Smtp-Source: AGRyM1uH42gZqv+YrGkXSXNOY37X13sy6cCM9xydgyGFaRKx8BVHLWnaQfHmLhNBU7+weC6DS02TDA==
X-Received: by 2002:a65:6054:0:b0:411:5e12:21b2 with SMTP id a20-20020a656054000000b004115e1221b2mr35556526pgp.222.1657145268341;
        Wed, 06 Jul 2022 15:07:48 -0700 (PDT)
Received: from [192.168.52.129] ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id ft22-20020a17090b0f9600b001ef917f1c30sm5597871pjb.6.2022.07.06.15.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Jul 2022 15:07:47 -0700 (PDT)
Message-ID: <27b3a1b7-a5ce-fc98-99d6-824ca6f67d9d@broadcom.com>
Date:   Wed, 6 Jul 2022 15:07:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH 3/9] ARM: dts: update dts files for bcmbca SoC BCM63138
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     joel.peshkin@broadcom.com, kursad.oney@broadcom.com,
        f.fainelli@gmail.com, anand.gore@broadcom.com,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        philippe.reynes@softathome.com, dan.beygelman@broadcom.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220705172613.21152-1-william.zhang@broadcom.com>
 <20220705172613.21152-4-william.zhang@broadcom.com>
 <326247d4-28ae-87ca-6929-0833eafad3a0@linaro.org>
From:   William Zhang <william.zhang@broadcom.com>
In-Reply-To: <326247d4-28ae-87ca-6929-0833eafad3a0@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001678f005e32a33a9"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001678f005e32a33a9
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 7/6/22 00:54, Krzysztof Kozlowski wrote:
> On 05/07/2022 19:26, William Zhang wrote:
>> Update compatible string and UART node and clock name based on device tree
>> binding documents.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> ---
>>
>>   arch/arm/boot/dts/bcm63138.dtsi    | 18 +++++++++---------
>>   arch/arm/boot/dts/bcm963138dvt.dts |  8 ++++----
>>   2 files changed, 13 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/bcm63138.dtsi b/arch/arm/boot/dts/bcm63138.dtsi
>> index cca49a2e2d62..bec13ed9f73b 100644
>> --- a/arch/arm/boot/dts/bcm63138.dtsi
>> +++ b/arch/arm/boot/dts/bcm63138.dtsi
>> @@ -9,13 +9,13 @@
>>   / {
>>   	#address-cells = <1>;
>>   	#size-cells = <1>;
>> -	compatible = "brcm,bcm63138";
>> -	model = "Broadcom BCM63138 DSL SoC";
>> +	compatible = "brcm,bcm63138", "brcm,bcmbca";
> 
> Changing compatibles affects ABI, so you should not combine it with some
> node renaming/cleanup patch. Split these.
> 
>> +	model = "Broadcom BCM963138 Reference Board";
>>   	interrupt-parent = <&gic>;
>>   
>>   	aliases {
>> -		uart0 = &serial0;
>> -		uart1 = &serial1;
>> +		serial0 = &uart0;
>> +		serial1 = &uart1;
>>   	};
>>   
>>   	cpus {
>> @@ -174,7 +174,7 @@ sata_phy0: sata-phy@0 {
>>   	};
>>   
>>   	/* Legacy UBUS base */
>> -	ubus@fffe8000 {
>> +	bus@fffe8000 {
>>   		compatible = "simple-bus";
>>   		#address-cells = <1>;
>>   		#size-cells = <1>;
>> @@ -185,21 +185,21 @@ timer: timer@80 {
>>   			reg = <0x80 0x3c>;
>>   		};
>>   
>> -		serial0: serial@600 {
>> +		uart0: serial@600 {
>>   			compatible = "brcm,bcm6345-uart";
>>   			reg = <0x600 0x1b>;
>>   			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>>   			clocks = <&periph_clk>;
>> -			clock-names = "periph";
>> +			clock-names = "refclk";
>>   			status = "disabled";
>>   		};
>>   
>> -		serial1: serial@620 {
>> +		uart1: serial@620 {
>>   			compatible = "brcm,bcm6345-uart";
>>   			reg = <0x620 0x1b>;
>>   			interrupts = <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
>>   			clocks = <&periph_clk>;
>> -			clock-names = "periph";
>> +			clock-names = "refclk";
> 
> This is even more confusing. You now rename clock-names. How is this
> related to board compatible or to node names?
Not related to board compatible string but it is the same board dts file 
that require some updates.  Anyway I don't have to change anything else 
other than the compatible string for this patchset.  So I will revert 
those changes.
> 
> 
> 
> Best regards,
> Krzysztof

--0000000000001678f005e32a33a9
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIB7/qG2+UkMeYpOY1iDIb2pHR4XY
kvfJ4o+BqIg2Q/eIMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcwNjIyMDc0OFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQDZzmF/0AGFvFaRWHojUJg66AGbFSYqgH4NsG36COtU1M+o
01ltfePIc3sdrK4LbF7OeSkqZsR97QSXhRATCdY6KMW3+7UVdUDAoDRgQDtBKMfMQuwy8B0pKR1z
UD8YbtLbrPSe3yb5Erwms5QgxeAchbs7YG2nxaLoXAUA3wprFrJs7ghGW/mlqH6VZjaVD2lAYJ8p
f13kZPwP3ZBe9zRcVNn0hSUcDRzBxlnEopd800tX69pkD99q/CaKVSML+uVHrLqQwFopwt7h83iE
zf8aJ1EgVqGD5XtJR7CNYybI5CmCp+DMbhDsP3ee2NYgMdZyhPUOOrpvU+3yHOzb21H8
--0000000000001678f005e32a33a9--
