Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5485D4FE4DE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 17:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347041AbiDLPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244365AbiDLPj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 11:39:26 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EB655839A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:37:09 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s14-20020a17090a880e00b001caaf6d3dd1so3298339pjn.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=wx244VC3F9wJRvDXfm8wpKmGDADdRMqLT4ju6hw5xlo=;
        b=YwvRF7bgGjdHCXeQOCkEmlTBdoCI/jPXHl14QYkOkAmIgB4qozhyJcE1SYbfPHTILh
         GJEM6Bo39eb3PLRgF5Oyeyts6rJ2i86172/2qztiMfpHs+Mltma4yHBIJf5UQlwuMLZ0
         FwpY1aIuPogPZ1lpBCkoffhG28e6xhYL9JSHs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=wx244VC3F9wJRvDXfm8wpKmGDADdRMqLT4ju6hw5xlo=;
        b=qFzcVhTi+KTwPv+2eP9mI+AO+1tJjl35F1boC+r8pzCeU9ZHLJbo9Y/DvY+Gb09KrF
         wbviF18af1gIC+ule9cx2jkbuMJj3sYH3Q3ajV6Xfa/0JIN1REKi4nsOYD7NfIDWIg8d
         etJopSOw2OWFQdCFZ/ebjxgIhBWBlmSk2I0JRminBVd4iaDZbSLpaXwJOpwk6GFBjbKH
         6SAuzzuYFmyAfJjGVQ5kKk0UExLVFIECrfN14gsBmQBgEWc4KtO/CJ3PrNS0GGR/Ayrv
         hIfat0Ig9Zff552ySdWIse31YXpfEskEd6+y4dh9N/q0PDtLK+aWyxtyOP0k6jzbgplO
         OeqA==
X-Gm-Message-State: AOAM533/pmIjst1U1V812hImGcm3ywL1iV56juvezvDXf235PKfa/xm6
        rxsVULx3jPQNcV5cykuJ4EQJZg==
X-Google-Smtp-Source: ABdhPJxXkmNMyrBS7rdEW9tdWYTwEVTxYQlvmxO7A02xYaE1WjhoTuGnscpGfaUgkaKMS8olFDar3A==
X-Received: by 2002:a17:902:7c01:b0:158:3dd6:d1ba with SMTP id x1-20020a1709027c0100b001583dd6d1bamr16147613pll.120.1649777828370;
        Tue, 12 Apr 2022 08:37:08 -0700 (PDT)
Received: from [10.67.99.21] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 21-20020a630115000000b00382a0895661sm3249305pgb.11.2022.04.12.08.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 08:37:04 -0700 (PDT)
Message-ID: <147e23b6-c5a3-a9fa-c0e1-defe906e42a9@broadcom.com>
Date:   Tue, 12 Apr 2022 08:37:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 3/5] ARM: dts: add dts files for bcmbca soc 47622
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>
Cc:     Samyon Furman <samyon.furman@broadcom.com>,
        Joel Peshkin <joel.peshkin@broadcom.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Dan Beygelman <dan.beygelman@broadcom.com>,
        Tomer Yacoby <tomer.yacoby@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        soc@kernel.org
References: <20220411172815.20916-1-william.zhang@broadcom.com>
 <20220411172815.20916-4-william.zhang@broadcom.com>
 <ed806d35-3613-4f9c-54ba-b31fc5ed91c8@linaro.org>
From:   William Zhang <william.zhang@broadcom.com>
In-Reply-To: <ed806d35-3613-4f9c-54ba-b31fc5ed91c8@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000072cde905dc76d572"
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000072cde905dc76d572
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Krzysztof,

On 4/12/22 04:27, Krzysztof Kozlowski wrote:
> On 11/04/2022 19:28, William Zhang wrote:
>> Add dts for ARMv7 based broadband SoC BCM47622. bcm47622.dtsi is the
>> SoC description dts header and bcm947622.dts is a simple dts file for
>> Broadcom BCM947622 Reference board that only enable the UART port.
>>
> 
> 
> Thank you for your patch. There is something to discuss/improve.
> 
>> + */
>> +
>> +#include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/interrupt-controller/irq.h>
>> +
>> +/ {
>> +	compatible = "brcm,bcm47622";
> 
> This does not match your bindings. Even if it is not used.
Did I miss anything? But it matches one of the compatible strings in 
brcm,bcmbca.yaml.

> 
>> +	#address-cells = <1>;
>> +	#size-cells = <1>;
>> +
>> +	interrupt-parent = <&gic>;
>> +
>> +	cpus {
>> +		#address-cells = <1>;
>> +		#size-cells = <0>;
>> +
>> +		CA7_0: cpu@0 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0x0>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +		};
>> +
>> +		CA7_1: cpu@1 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0x1>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +		};
>> +		CA7_2: cpu@2 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0x2>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +		};
>> +		CA7_3: cpu@3 {
>> +			device_type = "cpu";
>> +			compatible = "arm,cortex-a7";
>> +			reg = <0x3>;
>> +			next-level-cache = <&L2_0>;
>> +			enable-method = "psci";
>> +		};
>> +		L2_0: l2-cache0 {
>> +			compatible = "cache";
>> +		};
>> +	};
>> +
>> +	timer {
>> +		compatible = "arm,armv7-timer";
>> +		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			<GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			<GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
>> +			<GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
>> +		arm,cpu-registers-not-fw-configured;
>> +	};
>> +
>> +	pmu: pmu {
>> +		compatible = "arm,cortex-a7-pmu";
>> +		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
>> +			<GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
>> +			<GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
>> +			<GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
>> +		interrupt-affinity = <&CA7_0>, <&CA7_1>,
>> +			<&CA7_2>, <&CA7_3>;
>> +	};
>> +
>> +	clocks: clocks {
>> +		periph_clk: periph_clk {
> 
> No underscores in node names.
Will update

> 
>> +			compatible = "fixed-clock";
>> +			#clock-cells = <0>;
>> +			clock-frequency = <200000000>;
>> +		};
>> +		uart_clk: uart_clk {
>> +			compatible = "fixed-factor-clock";
>> +			#clock-cells = <0>;
>> +			clocks = <&periph_clk>;
>> +			clock-div = <4>;
>> +			clock-mult = <1>;
>> +		};
>> +	};
>> +
>> +	psci {
>> +		compatible = "arm,psci-0.2";
>> +		method = "smc";
>> +		cpu_off = <1>;
>> +		cpu_on = <2>;
>> +	};
>> +
>> +	axi@81000000 {
>> +		compatible = "simple-bus";
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0x81000000 0x818000>;
>> +
>> +		gic: interrupt-controller@1000 {
>> +			compatible = "arm,cortex-a7-gic";
>> +			#interrupt-cells = <3>;
>> +			#address-cells = <0>;
>> +			interrupt-controller;
>> +			reg = <0x1000 0x1000>,
>> +				<0x2000 0x2000>;
>> +		};
>> +	};
>> +
>> +	periph-bus@ff800000 {
> 
> just "bus" to be generic?
This node represents the peripheral bus in the soc. Would prefer to use 
the specific name unless it is not allowed by the linux dts.

> 
> 
> 
> Best regards,
> Krzysztof

--00000000000072cde905dc76d572
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIL/uhiW5pGblGgXhTRd8EhurRrMg
VZySP9QmeFNlgoV+MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDQxMjE1MzcwOFowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBsQX7zEDHK4nj1jWxTLISgvzKGjk2jDI45MG5VdHd3E1fv
zh4FYVZ3rlrG3mtgJpgdLteRhKiWoVZdrUWppZNc2dJwZjtGZsqUlV261lchmtl+9mhuvjcjd9Xa
CbiiPlNTxhzs+q0e5ypJ7FwDQa08fNVr7Jg4bNXJNJAwCJ89lXXg5baZJtxEk2/watLy5jFxQe9k
470JcVYvBKVVS231UsbjE1QklL8pigEFG3dYrStIq6p/MEhALyXL4gL53ky4NnWDHaYu3YLx4Mai
/b9PxJ9hNse0yD8CXPumuZMls0i4ps+q+A/i4IpIJtf4iUV673T+BQQwryDmRosirFat
--00000000000072cde905dc76d572--
