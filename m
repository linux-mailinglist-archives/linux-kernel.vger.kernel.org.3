Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FC657F946
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 08:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbiGYGA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 02:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiGYGAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 02:00:55 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347ED5FE5
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:00:54 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so9310466pjl.0
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 23:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=1ztNV+a05uKifKzIS7E5ntA4tX+KkgB0XwPiulP/aRw=;
        b=QwNEOGYOmpq7eh7Hrk7MCeAMtbyYm2d1j5Tf8Z+4ZZ7GOjOpqHKTferHSJ0fx9PDRA
         J7BL1d/wnBAc6HuKBD61pTpZQ/oQgJSEP5ZJT22+IykXaEhCO77R8IXZObZEQQF7Drof
         gM7NQ8ExqBYdpyVY53qgQg/cwVRRvUkvHQDSw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=1ztNV+a05uKifKzIS7E5ntA4tX+KkgB0XwPiulP/aRw=;
        b=5tTelKqNOLvMIsyZQ8d56aHFveik9ksa6ErUdiNS5Toj2OA2YpFAbMKdB8vSulI1Vg
         66D8YJJ/53wZHuH0/gmXszi36LAe4orHqYKlHi5ItpYJ1JTtYC6O/4R0ZA6jKhkBpbLQ
         aAT9UU0pe7PN8TskH/CODfzIbkRBibbmvHX2HnhW5RqNNU/u6lEVyZ5fsHqiXOYwkVFo
         QRN/tkittoJhpaneas4WzTCT9mPyQ7HSzobSBKYF4TzvpIbJsWBKALJTMKP7oYL0Nb0d
         pqMnWtMyg8YktEp8i/82WKNKVpAUXs/RSW6REifAhOCoOUtLRPsQRrulNn1X1T00H3Ua
         xfnw==
X-Gm-Message-State: AJIora9LXPQ/Q7ec9FgR7t8gsAtASwY+hI9HYHkHPiF8fIYDerXBJjbT
        nQxzPwIJTgkGaXKrAVqCbTuqlMkCXtzZiVpU4l3Gi647seBcPSK0mMFp6zWN+39ywjMvEJGi4Lg
        nKXV/xSY/6cOZ+ug1m9+u5ugieVPNVFUhTMBWxHLkwCbNEtS7vz1zQdzHFJ3+dOQq0wagO96E2q
        06th8M1GDm
X-Google-Smtp-Source: AGRyM1sXUyh1W4dR2j6+ZnuoG77JUIVR2y4yjiVW6sdxpWy0f8VbS3Kw+a77eyARZypqTKehWUvuJQ==
X-Received: by 2002:a17:90b:3841:b0:1f2:534d:a292 with SMTP id nl1-20020a17090b384100b001f2534da292mr12415059pjb.174.1658728853129;
        Sun, 24 Jul 2022 23:00:53 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id i66-20020a626d45000000b00525373aac7csm8533402pfc.26.2022.07.24.23.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Jul 2022 23:00:52 -0700 (PDT)
Subject: Re: [RESEND PATCH 2/9] dt-bindings: arm64: bcmbca: Update BCM4908
 description
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Cc:     Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        joel.peshkin@broadcom.com, dan.beygelman@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20220721000658.29537-1-william.zhang@broadcom.com>
 <a635754e-bf41-4058-5fbb-57ead36b7128@linaro.org>
 <883c2ad4c36220b488519a8902ad72bc@milecki.pl>
 <193845cb-6149-1ae6-5eb6-6b01ffcf763b@linaro.org>
 <4b5100e4a6e9e581f4b8ab58e5ca4927@milecki.pl>
 <c5b37e68-dc1f-cdae-83e4-23aa0216db69@linaro.org>
 <1d39bbba3f267086eb2884ffcbf4807b@milecki.pl>
 <e5f3474c-ba7f-7107-064b-74a04b11d7af@gmail.com>
 <15e4a51c-a89f-79ef-1364-ddca6b6f7b83@broadcom.com>
 <522433ce-7a3d-73a3-cdf0-4e69edbf3de6@linaro.org>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <526ab5ca-c730-b1ce-9a40-c0de7cf7a747@broadcom.com>
Date:   Sun, 24 Jul 2022 23:00:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <522433ce-7a3d-73a3-cdf0-4e69edbf3de6@linaro.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000001b3aad05e49ae8cd"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001b3aad05e49ae8cd
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit



On 07/22/2022 11:22 AM, Krzysztof Kozlowski wrote:
> On 21/07/2022 21:35, William Zhang wrote:
>>
>>
>> On 07/21/2022 09:43 AM, Florian Fainelli wrote:
>>> On 7/21/22 00:50, Rafał Miłecki wrote:
>>>> On 2022-07-21 09:36, Krzysztof Kozlowski wrote:
>>>>> On 21/07/2022 09:13, Rafał Miłecki wrote:
>>>>>>> That's better argument. But what's the benefit of adding generic
>>>>>>> compatible? Devices cannot bind to it (it is too generic). Does it
>>>>>>> describe the device anyhow? Imagine someone adding compatible
>>>>>>> "brcm,all-soc-of-broadcom" - does it make any sense?
>>
>>
>>>>>>
>>>>>> OK, I see it now. I can't think of any case of handling all devices
>>>>>> covered with suc a wide brcm,bcmbca binding.
>>>>>
>>>>> Maybe there is some common part of a SoC which that generic compatible
>>>>> would express?
>>>>>
>>>>> Most archs don't use soc-wide generic compatible, because of reasons I
>>>>> mentioned - no actual benefits for anyone from such compatible.
>>>>>
>>>>> But there are exceptions. I fouun socfpga and apple. The apple sounds as
>>>>> mistake to me, because the generic "apple,arm-platform" compatible looks
>>>>> like covering all possible Apple ARM platforms. I think Apple ARM
>>>>> designs in 20 years will not be compatible at all with current design,
>>>>> so such broad compatible is not useful... but that's only my opinion.
>>>>
>>>> Let's see if William / Broadcom guys can provide a valid argument for
>>>> the brcm,bcmbca.
>>>
>>> It is common practice to provide a generic fallback compatible string for a given chip family/architecture and all of our existing in-tree (and out of tree for that matter) DTSes for Broadcom SoCs do that:
>>>
>>> - Documentation/devicetree/bindings/arm/bcm/brcm,brcmstb.txt
>>> - Documentation/devicetree/bindings/arm/bcm/brcm,ns2.yaml
>>> - Documentation/devicetree/bindings/arm/bcm/brcm,nsp.yaml
>>> - Documentation/devicetree/bindings/arm/bcm/brcm,cygnus.yaml
>>>
>>> list goes on and on, of course the counter examples are bcm2835, bcm4708 etc. although those are both chip and families technically, so I suppose the conflation is appropriate in that case. So the pattern is simple:
>>>
>>> - outside of Broadcom contributors used convention
>>> - inside of Broadcom contributors used another
>>>
>>> so if nothing else, we ought to be consistent within ourselves as Broadcom insiders, which we are doing here.
>>>
>>> While the generic fallback may not be in use, it still serves a purpose:
>>>
>>> - Broadcom likes to create a gazillion of part numbers that are hard to untangle from their original SoC architecture unless you happen to work there so it serves as documentation for others to identify what family they belong to, and what to expect from that
>>>
>>> - you never know when you might want to be matching on just the generic compatible string of a family and putting it in there costs nothing at all
>>>
>>> The point of William's patch series is to right a number of wrongs on Broadcom's side:
>>>
>>> - lack of appropriate involvements at the time Rafal submitted the 4908 support as a "standalone" family, I am to take the blame for suggesting that name in the first place, though I did not know at the time that William and others would ever be contributing upstream
>>>
>>> - avoid the proliferation of "sub" families within a larger family (BCMBCA) since that serves no purpose other than to make it harder on users to select what they should be selecting in their kernel *and* it makes us inconsistent with arch/arm64/Kconfig.platforms that attempts to reduce those
>>>
>>> I would conclude by asking you: why is this such a big issue? What *actual* problem does it causes, except maybe setting a precedent that you do not like, but for which you practically should have no reason to care as long as the binding is enforced.
>>>
>> Totally agreed.  Just want to emphasize that the main reason of this
>> change to merge all the bcmbca family chips into the same group for
>> better organization and reduce the clutter to the kernel source. Think
>> about 18 bcmbca devices with different changes to yaml, kconfig,
>> makefile, sub-directory while they actually share many common blocks,
>> drivers and dts entries.
> 
> Your commit does not explain why you are doing it at all. We have all
> this discussion, you put so many arguments, but why none of it is in the
> commit description?
> 
The purpose of the discussion was to explain to why we think appending
brcm,bcmbca is necessary and helpful and the history of this string when
we first upstream the bcmbca SoC. And I also said I totally agree to the
improvement of commit message. I just posted the v2 of this patch series
with all the requests accommodated from this discussion.

>>
>> While nobody would bind a device to brcm,bcmbca (and it can not be
>> binded because bcmbca,yaml require to prefix with a specific chip), it
>> is a great way to make it easy for people to understand what device they
>> are working and look for the bcmbca common driver and other support code
>> as well. Wouldn't this be good thing to have?
>>
>> And don't forget we introduced bcmbca awhile back with first SoC 47622
>> and have set a clear goal for the purpose we are discussing here today:
>> Please see this patch series:
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2022-April/732867.html
>> "This change introduces Broadcom's ARCH_BCMBCA architecture for
>> armv7 and armv8 based Broadband SoCs. We expect to send additional
>> patches for each SoC in the near future."
>>
>> And Krzysztof acked that yaml for brcm,bcabca here :
>> http://lists.infradead.org/pipermail/linux-arm-kernel/2022-April/732867.html
> 
> and I keep discussing, so bringing it up proves what? That new comments
> appeared?
> 
>>
>>
> 
> 
> Best regards,
> Krzysztof
> 

--0000000000001b3aad05e49ae8cd
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
SIMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIBSmlP3HYkT4T/PWzmEnDrWjap1Z
TiUKvYyTnM3GpytNMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MDcyNTA2MDA1M1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAp53/LlsBoD0gk6pscp1Zb0HcU90xnuml9ykKa2h69oqVj
JmuintBflnOf1P7aLF6hyXp69tFv4BG7MKPCk6RHZXbEvn9jWEuoYM0wYN2rtPhxNxoflFhLk/23
ZgGm2Qv2Rx1mEuP5ymj1jrsunh6KkjUl4slhLxqDotrkL349cieGjkBKVLJnPRifA4I/HU2vVEs/
t8fwBxedVfCjGWqnzR8Lm4iMbRiwT+2FtPK5wpoWDelg8yVpA5Tkz9NGFcBq24Urho9JPh2l2vTa
bx00sAHcfqJJQVc7yEXmEYen5Gdm4LWzLzlLRD0V92bpOUBx7mwsv/K+AN+LocGu6P2X
--0000000000001b3aad05e49ae8cd--
