Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FD6857D2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 19:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231263AbiGURyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 13:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiGURyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 13:54:23 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6347589675
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:54:22 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 17so2473062pfy.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 10:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=5M9wqKER//0rDN866usNTE9YPEHR4cKE3LFskHfasMo=;
        b=WzjsSMYRF5fwrG+LKBKYpLUeX4t8devtyHZ8FTcumK9M3eabwfvAKxEXy4L4BfuzTm
         VfsE5mbwQb+JzlbSEtyHoiOVyTHn7kGuO81v5qbo/eoS0LJDuZr7M1g1sS5QG08c6/o3
         bhoQFBxFj7GiHanpRytV3yMP8hf1fgD4E+kg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=5M9wqKER//0rDN866usNTE9YPEHR4cKE3LFskHfasMo=;
        b=nTb7uJzVrU64AqdwVzQmN/T4arug2p3PgmSdEAW/h2CjeO0B8BADyH9QONt2kLSlox
         wx0okazK011a3pbbhvyqRS/09EB3HtMcbzsOcdDil5HdZaqv7IiwrtAT/7/SVLRoduW5
         fWNb1IgnSBuTi8HPl/WtA6l/iL3hezscFlDVGQMQPFnDZopTMfLkL1H6z6lgDeKGU3d8
         CTmMtYGeHOiEQAgdGxkymYHBDfvMX0SiWXBI8zu4Sr5UBi0lEq4WTWD1J3y8CgdJUqKX
         5xGn0gkXxm5FkEQd2/x/+T+Ubej+Xc2FkaEC5H7yNKSl1ucmAfGQ4WrfBLXvmXNXg026
         18VQ==
X-Gm-Message-State: AJIora9aUKAfydCxgG83M50YvqJnq6FLKy3b0eN2MahBydB+xRUOH+Hf
        VimuHoiQ4bytOeAw+TmPjT9e6pJEObOQ0skOK6KvswVLXmmGLTS1/TNkj3i++yUcas7EIrMVbx5
        ItxngMj/ybnJuNCxPFBHFnAhE82YpPj6JqQPmA76pV5LQVUd129kojdZQWd6cyrL1J87k2fwTsg
        j6j4ZNAN5I
X-Google-Smtp-Source: AGRyM1ub0NIgEn3RjZTSnlDQ4XF6OpmrgJLTmcOTQ/DZHT6plXxGSxAOIphOjRK4bcZ0dbivv3E3RQ==
X-Received: by 2002:a63:c158:0:b0:41a:6685:59de with SMTP id p24-20020a63c158000000b0041a668559demr8139294pgi.95.1658426061390;
        Thu, 21 Jul 2022 10:54:21 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id w1-20020a17090a028100b001f216a9d021sm3918909pja.40.2022.07.21.10.54.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 10:54:20 -0700 (PDT)
Subject: Re: [RESEND PATCH 3/9] arm64: dts: bcmbca: update BCM4908 board dts
 files
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220721000707.29557-1-william.zhang@broadcom.com>
 <07a566d45cf48baff70f027e52264aa8@milecki.pl>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <62efc265-aeea-4394-2844-d54fdb0e05b7@broadcom.com>
Date:   Thu, 21 Jul 2022 10:54:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <07a566d45cf48baff70f027e52264aa8@milecki.pl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004f777d05e4546853"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000004f777d05e4546853
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 07/20/2022 11:15 PM, Rafał Miłecki wrote:
> On 2022-07-21 02:07, William Zhang wrote:
>> Append "brcm,bcmbca" to compatible strings based on the new bcmbca
>> binding rule for BCM4908 family based boards. This will break drivers
>> that use the old compatible string for binding. Fortunately there is no
>> such usage in linux and u-boot.
> 
> Why should an extra "compatible" value break anything? I don't think it
> will happen unless some driver does some really crazy stuff (like
> checking full list of "compatible" values).
> 
Yes anything along those lines will break. But there is no such 
craziness in linux and u-boot(wouldn't be accepted in first place).  But 
Krzysztof suggested to add that to the commit message.  I would prefer 
not to add that either.

> 
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> 
> Other than confusing commit message:
> 
> Acked-by: Rafał Miłecki <rafal@milecki.pl>
> 
> 
>> ---
>>
>>  arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts | 2 +-
>>  .../dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts     | 2 +-
>>  arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts | 2 +-
>>  .../arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git
>> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
>> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
>> index 2dd028438c22..d8b60575eb4f 100644
>> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
>> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-netgear-r8000p.dts
>> @@ -7,7 +7,7 @@
>>  #include "bcm4906.dtsi"
>>
>>  / {
>> -    compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908";
>> +    compatible = "netgear,r8000p", "brcm,bcm4906", "brcm,bcm4908", 
>> "brcm,bcmbca";
>>      model = "Netgear R8000P";
>>
>>      memory@0 {
>> diff --git
>> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
>> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
>> index 064f7f549665..296393d4aaab 100644
>> --- 
>> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
>> +++ 
>> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4906-tplink-archer-c2300-v1.dts
>> @@ -7,7 +7,7 @@
>>  #include "bcm4906.dtsi"
>>
>>  / {
>> -    compatible = "tplink,archer-c2300-v1", "brcm,bcm4906", 
>> "brcm,bcm4908";
>> +    compatible = "tplink,archer-c2300-v1", "brcm,bcm4906",
>> "brcm,bcm4908", "brcm,bcmbca";
>>      model = "TP-Link Archer C2300 V1";
>>
>>      memory@0 {
>> diff --git
>> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
>> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
>> index 04f8524b5335..787c7ddf9102 100644
>> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
>> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-asus-gt-ac5300.dts
>> @@ -6,7 +6,7 @@
>>  #include "bcm4908.dtsi"
>>
>>  / {
>> -    compatible = "asus,gt-ac5300", "brcm,bcm4908";
>> +    compatible = "asus,gt-ac5300", "brcm,bcm4908", "brcm,bcmbca";
>>      model = "Asus GT-AC5300";
>>
>>      memory@0 {
>> diff --git
>> a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
>> b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
>> index 3c2cf2d238b6..23b96c663239 100644
>> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
>> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908-netgear-raxe500.dts
>> @@ -3,7 +3,7 @@
>>  #include "bcm4908.dtsi"
>>
>>  / {
>> -    compatible = "netgear,raxe500", "brcm,bcm4908";
>> +    compatible = "netgear,raxe500", "brcm,bcm4908", "brcm,bcmbca";
>>      model = "Netgear RAXE500";
>>
>>      memory@0 {

--0000000000004f777d05e4546853
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIP4ibY+gCLHmsTqykum3flxGixic
3d2unqCFgIzrQ1PGMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcyMTE3NTQyMVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAeIt7mfmIbkmApi8eAzhEp6Gw2z+ZSR1mEaPLBDcGRp6dh
/EbdJnDGpLNaZWgHe2bVqZ8mhHSb4yWeUtd9x68/7ITCaE09QDpOVtGn1KNWfVWegekGTvgYfpzk
5De2ODKi9hxtj+B9snjFVcNI1atFjykh5VMXKel3Uzst9uEJ7EuHPsnDWBOtWAq+ZOwRmMPaywI9
5J9GFodLOaBd8xHT8SqJzYOWReZhHV86k/QlZ0AkbPiDlnWqBybJQnY6LHQJ37Q7UqDFalkC+9/Z
hW2H7VO9CdJFr5XQ5Hy2J5iGR9pIwzPKELn58qb6h4vuQIgKLrF7KUDhqivPQ270ZeTW
--0000000000004f777d05e4546853--
