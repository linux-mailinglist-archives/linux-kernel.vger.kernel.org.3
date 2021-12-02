Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A2DF466918
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:28:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376340AbhLBRcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376261AbhLBRcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:32:14 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8951C061757
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:28:51 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id np3so278860pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 09:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=26CeGRCd68JtKjv3SM/hcjVd/dRiKGZetWjuZidyuzI=;
        b=Ahv55jCJo8eiu7Zh2FxT+ZUoKd3FPUwaS3grBkJ8l2d/OcVG5PwM7BgSdLOMz+rMeo
         UYasjU3s054aELgq0L+uCHwihZe5hyrQWrllgA3UoFzf8E3r27jqVle5VCYvHfUgmvCF
         C6ZKNuEQU/3QCpnOKq/H2CzIqmAGWdkWn5dgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=26CeGRCd68JtKjv3SM/hcjVd/dRiKGZetWjuZidyuzI=;
        b=33x2Xv+rnQUJcRtsB5Tk7KmbY/BwI987RJzo1UsYhIOqQWfBrZ0vaOctVEH8Lx2xCs
         rwDNt37g5XVr26QIFKrOcbYGOVaf1MTwKit4aXts3mMlgf9rk8CK+yZj8UWKbKFJ/B8O
         3YuFb4rS9OKrtczQs87KJiFFnR3ISFFPmF/st5S3liE5ak/GrsiJEuKjiycbYOhsIyrP
         RhkxO8PZKI5Ck9Z61iLgPZBnQKvk2mNlFEuhTMsZ/XhC9QsGTADG5e1cHtwui+gTUDCP
         rFlhdnt1ukfE82KQY4nro6MqFrwspK6177SNvwnXLLVFpvXPPvdnEBa9YoOB+IfyJpjZ
         jsKQ==
X-Gm-Message-State: AOAM531JU80d3ZOr1Kx8mN2Up8Ft4a1Ho9KZkPULdP0FK4hKx8n1qHST
        JMhXog+B8fP/4MNVqNXZsJOmhA==
X-Google-Smtp-Source: ABdhPJynqpm+ACePC6XXqju7sLq9VWRcAQe/BYC/UlUoAgraI+CoPNu1KUT1/EnmeS/ZvFFqrmCm/A==
X-Received: by 2002:a17:902:b78b:b0:143:baac:2ebc with SMTP id e11-20020a170902b78b00b00143baac2ebcmr16634221pls.77.1638466130993;
        Thu, 02 Dec 2021 09:28:50 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x9sm3026370pjq.50.2021.12.02.09.28.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 09:28:49 -0800 (PST)
Subject: Re: [PATCH 2/2] mmc: sdhci-brcmstb: "mmc1: Internal clock never
 stabilised." seen on 72113
To:     Al Cooper <alcooperx@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20211202163050.46810-1-alcooperx@gmail.com>
 <20211202163050.46810-2-alcooperx@gmail.com>
From:   Florian Fainelli <florian.fainelli@broadcom.com>
Message-ID: <faab7fad-8c42-5ad8-f5f5-f1f2996b54c6@broadcom.com>
Date:   Thu, 2 Dec 2021 09:28:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211202163050.46810-2-alcooperx@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000bd959a05d22d1f66"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000bd959a05d22d1f66
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit

On 12/2/21 8:30 AM, Al Cooper wrote:
> The problem is in the .shutdown callback that was added to the
> sdhci-iproc and sdhci-brcmstb drivers to save power in S5. The
> shutdown callback will just call the sdhci_pltfm_suspend() function
> to suspend the lower level driver and then stop the sdhci system
> clock. The problem is that in some cases there can be a worker
> thread in the "system_freezable_wq" work queue that is scanning
> for a device every second. In normal system suspend, this queue
> is suspended before the driver suspend is called. In shutdown the
> queue is not suspended and the thread my run after we stop the
> sdhci clock in the shutdown callback which will cause the "clock
> never stabilised" error. The solution will be to have the shutdown
> callback cancel the worker thread before calling suspend (and
> stopping the sdhci clock).
> 
> NOTE: This is only happening on systems with the Legacy RPi SDIO
> core because that's the only controller that doesn't have the
> presence signal and needs to use a worker thread to do a 1 second
> poll loop.
> 
> Fixes: 5b191dcba719 ("mmc: sdhci-brcmstb: Fix mmc timeout errors on S5 suspend")
> Signed-off-by: Al Cooper <alcooperx@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian

--000000000000bd959a05d22d1f66
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQeQYJKoZIhvcNAQcCoIIQajCCEGYCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg3QMIIFDTCCA/WgAwIBAgIQeEqpED+lv77edQixNJMdADANBgkqhkiG9w0BAQsFADBMMSAwHgYD
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
u4AzaGpwhramjYYwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEICWik3DScGUDpzai
/KVaIqObROKbmYaH5zizDtESeNwSMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIxMTIwMjE3Mjg1MVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCTkTLc+XbYBsKpqx6K1pvXDLNNdv3mLUiM
9Xw+J3WGj+3dsEFeUwO/cU2IrSd28JruQEnzDDpOeccv/RPr2nalLoZ8T2FGPdWkeQ3gVRLeYCGI
WC0gv22KnIQvkGz/or3xUyuRfmJLwmpEjvA0fI2DZeR56yt1OkRFZQSvaGeFHpyjXtyK4aspTKna
7hiM8K2R4lueyxO4BrxCpd/knEGkQLZKG6/7M847/mcHeN1R7PsPeLrZmHjr/c3nyfC7hyU3UMWO
tUvz5kEz15yB7S05tMx8bgmYGZvgMAw/FWiuguk259U+B1l8k8Lc9nnUHdYBDWkCHPsX6FHjJodG
Omq1
--000000000000bd959a05d22d1f66--
