Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0675457D34A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 20:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiGUS3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 14:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231557AbiGUS3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 14:29:43 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC9288C8D6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:29:41 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id y24so2599755plh.7
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=v3TKtPiAXEV+gz+iIY0SLTr3JUg8dGIEvaEohdbYGlk=;
        b=G0GpgGKezuu+8liBk0/f5fQt4XYrWJRtObjmlx2LM0A5oZK9Rdw2ExqRzQqu6DLXKF
         Q4CH7tB1AZj2pmv//RwL5F3Ptav+UDF4J9akPAS4aQaII5EZf+Hs4S4EQOyrcnYoEclQ
         IHG1qgdLtYnNIPnZJ2BLtt/mWXEP7xLvf1XKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=v3TKtPiAXEV+gz+iIY0SLTr3JUg8dGIEvaEohdbYGlk=;
        b=MkxhLfoXnrSs+ru5BYI9cJFPERT0yVEe+BFBPtMBMORnV/K4xwJKlouJChMZEGXjTP
         nFrD5QE6m9l5AulvjR49JkpaaZKoknf5TCY1F80Nb6t1MKvxFY15nD6sksVD0XP8N7dJ
         ygFmsTM7tpYFg5/rDYv+Ys97Baz9Tf+vS4bYBbq5OIsqAezehukTfUp2obX1sBaLXxFO
         wh3zvLWaDuATgMGOkIlNUw9Xyr15uMrLLMuwII5oWyXf8FmI5of8c5WC0hBkRQv+oOdZ
         sPgs3UeX1UdXsU0uLgeD69JbODGZ2M+5OQG71ywfyG9VWbBoG++Ow/C4J0kpMeFYNcEH
         uR1A==
X-Gm-Message-State: AJIora9GRiqaGySrSMgwmK2RpdVZcZcEcYsTO6BGnmNCRk3Hxx2BbfZ3
        52ZqDGK0kBN75cRbMl9vCoolOtL85RFRthC5Z57X//SbKrmQOc542dXuAGAa5IB7Ye6lDR9p3YH
        iKQnqXAEURkedFnGdnu3ArQldtdG3Fv5ipSsUsJOxe0eis4/bhzzj9HynSOSonPYp7rxeyA1XJT
        3sNkJm+ekd
X-Google-Smtp-Source: AGRyM1vqGfXNs7pYbIAdIsfTSHXEVK6HCc+0lhKWDBip6QojA1Q64hmzdFz1wT1Tq+rqMrUQ/u9DgQ==
X-Received: by 2002:a17:903:1103:b0:16c:9a6e:d54 with SMTP id n3-20020a170903110300b0016c9a6e0d54mr42239822plh.131.1658428181001;
        Thu, 21 Jul 2022 11:29:41 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id v8-20020a17090ad58800b001f121421893sm1743645pju.53.2022.07.21.11.29.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 11:29:39 -0700 (PDT)
Subject: Re: [RESEND PATCH 5/9] arm64: dts: Add BCM4908 generic board dts
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220721000731.29597-1-william.zhang@broadcom.com>
 <4919ef26ece22db845de584e3d9b3814@milecki.pl>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <6e3bfcb2-41e8-5e67-6e17-8dc1a0dd0c07@broadcom.com>
Date:   Thu, 21 Jul 2022 11:29:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <4919ef26ece22db845de584e3d9b3814@milecki.pl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a651e005e454e6a8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000a651e005e454e6a8
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 07/20/2022 11:45 PM, Rafał Miłecki wrote:
> On 2022-07-21 02:07, William Zhang wrote:
>> Add generic bcm94908.dts file.
>>
>> Signed-off-by: William Zhang <william.zhang@broadcom.com>
>> ---
>>
>>  arch/arm64/boot/dts/broadcom/bcmbca/Makefile  |  1 +
>>  .../boot/dts/broadcom/bcmbca/bcm94908.dts     | 30 +++++++++++++++++++
>>  2 files changed, 31 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/broadcom/bcmbca/bcm94908.dts
>>
>> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
>> b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
>> index d30fa75f0611..27741b71ba9e 100644
>> --- a/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
>> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/Makefile
>> @@ -4,6 +4,7 @@ dtb-$(CONFIG_ARCH_BCMBCA) += \
>>                  bcm4906-tplink-archer-c2300-v1.dtb \
>>                  bcm4908-asus-gt-ac5300.dtb \
>>                  bcm4908-netgear-raxe500.dtb \
>> +                bcm94908.dtb \
>>                  bcm4912-asus-gt-ax6000.dtb \
>>                  bcm94912.dtb \
>>                  bcm963158.dtb \
> 
> AFAIU bcm94908 is a reference board name. I think I see some
> inconsistency in naming Broadcom's reference boards DTS files.
> 
> If you take a look at in-kernel DTS files:
> find ./arch/arm*/boot/dts/ -name "*.dts"
> 99% of them are prefixed with family/SoC name. I did the same for
> bcm4908 (and Northstar) boards. So it's
> <soc>-<manufacturer>-<model>.dts
> e.g.
> bcm4908-asus-gt-ac5300.dts
> 
> To match that I *think* you should actually call your file:
> bcm4908-bcm94908 (or bcm4908-94908 depending on actual board name)
> 
> First of all: am I correct here?
> 
I do see many dts named in the format you described here and I agree it 
is very clear.  But at Broadcom we use a slight different format for 
reference boards that we started from day 1: bcm9<soc>-<ref board 
model>.dts such as bcm963138REF.dts. And there are many in the kernel as 
well if you search "bcm9*.dts".  Many of them are Broadcom reference 
boards and some are actual consumer product.

> Secondly: could you do that? I know many DTS files named ignoring SoC/
> family prefix. Still maybe we could change it as some (this) point?
I actually was thinking to ask you if we can change all the 4908 boards 
to use bcm94908- prefix to be consistent with Broadcom board name 
convention. But at the second thought, I didn't ask because it does not 
make much benefit other than a uniform name, unless you agree and I can 
make that change. Otherwise, I would rather keep them as they are now 
because we have ton of reference boards here and we don't want to make 
that changes to remove the 9 (which will definitive cause big confusing 
internally) and there are no rule in linux for the name as far as I 
know.   What I can do is update the bcmbca.yaml to put bcmbca board name 
rule bcm9<soc>-<ref board model>.dts  for broadcom reference board and 
bcm<soc>-<manufacturer>-<model>.dts for customer board,  if that sounds 
good to you.

--000000000000a651e005e454e6a8
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIMP/qOCsK4Qb/6dKvg6YsJQCD1Zr
K0897K9lcXTfbnhZMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcyMTE4Mjk0MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQCeziZoeQ7k+cVJQt/PCwxB7PkPdRe0kwBvQfaGvoP/q6MW
+YG8hBrhtPedbtdU0KM2GKAABV9NcZ4BceYel43jISkpn0gedcar5okXzovSV59gwUb2PoXzz+5w
1J4ohYxPE1FdemxiL4LUaHmqZ8Rgo5O7eaPb2NEeI2YMUKcj76bgpUVoTvg9HN4Mw6NG9Rc/w+zi
epbw8y8Xr6a4DwwkumysQlI+gk5R9q6S4GPkIHKOBH2M5yECH+KQI2t71RaCCHdaEL2+2T0Ag/lF
6aPwDAjlWB4FNhQzvEtbJZ0Ub9Yj/flRUt8qJk8NkaLeh/2w4Mi/Gy14rg8MP7WveD4R
--000000000000a651e005e454e6a8--
