Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABCD54C480F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241284AbiBYO4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:56:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242012AbiBYO4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:56:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AAC31E7455
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:55:16 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id d28so4928890wra.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jcV12AvyMWkmT/WtPheztAOVKi80es5BNiJ5b/0APo8=;
        b=VkLCzLBH/rcmv2Ufou1d1O9f6N4Ce/gBNHX5VzdxbAu8SNegWLfkX9Z/p2hT4G+tSJ
         XplgGPrJ6G79HiVQOfKhaWuts/CciWi1/Pq/cd1+Mg5Yg/ptAqW8USffWiUdsiUOO1gu
         gb4BWx4iI/sNwfvK47rkw3XO9Y3wAP5BoRIsrdBodW6GX8vKS9ER6MmaFD9BCtkZvvQL
         9RP6Xe2YDJ1/vmfu5wlaxwyoFqVdNUOs/iwJPC/b9f1nx4gSRqfpVGbVOOrbAXAkBcVk
         YVcK98U9OJicx/2PandNKLsVJAp76OPzTnD+NgKTqykXOBgygCWQ18brkP3gD6wxgklb
         CEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcV12AvyMWkmT/WtPheztAOVKi80es5BNiJ5b/0APo8=;
        b=TPSSw4GyZSwCrYRurK+YCKPO3tRdy6IBLfktWJMIsYMaHdUGt08YazDSeiL9tIbCWk
         GoATOq9lt3MFwPOV3TmltOU/6FiUruO3d8yoEiGaCAwTsBk7b+SoTpLraDB0HKIcvzIo
         35eIApXa0bzjUCNzQI9D46cw/x2zBon3S/E3D3RVYE3UtfWtgRqaMgbpK5IQpjMN39wU
         js7xcRVxFeqnaOXuveFRKY/YxM+12Lvu4hi07Iv2XGbXsXGk4R9IiBzLKE5mCGVptdej
         QtxhvJPN/qwfL5COFBjoDs9a86VN0zVBOKibUqdGlOs/P/uUNZgwcG/XaDdu+EFbvRxc
         bPvw==
X-Gm-Message-State: AOAM5302fSUxvi6V9x7P/oJcwpBaBxH3tzArmfYumMLzPGocy8VdVO+C
        zSrfeu83KbWVIxn2LAA75hUvLmphrNvAkM2WxIEbvh3q2a4PHiRL
X-Google-Smtp-Source: ABdhPJwFF93fnSyGIqiHy+Aj7ulk5p+akng58+Jc2xX2TcXsyRu39eX2WCuEKPEsZgo/5je9PuWm162qMuSILRxAFh8=
X-Received: by 2002:a5d:6346:0:b0:1ef:bde:17e0 with SMTP id
 b6-20020a5d6346000000b001ef0bde17e0mr4643323wrw.395.1645800914923; Fri, 25
 Feb 2022 06:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20220225041502.1901806-1-davidgow@google.com> <Yhiz1s35vfqC4S0v@kroah.com>
In-Reply-To: <Yhiz1s35vfqC4S0v@kroah.com>
From:   David Gow <davidgow@google.com>
Date:   Fri, 25 Feb 2022 22:55:03 +0800
Message-ID: <CABVgOSnQCCUR8ZbPUfZCQmsvXmmHZupTrfhG1rPR8Jc07dCpyQ@mail.gmail.com>
Subject: Re: [PATCH v2] firmware: google: Properly state IOMEM dependency
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000ecaa7705d8d8e2c9"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ecaa7705d8d8e2c9
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 25, 2022 at 6:47 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 25, 2022 at 12:15:02PM +0800, David Gow wrote:
> > The Google Coreboot implementation requires IOMEM functions
> > (memmremap, memunmap, devm_memremap), but does not specify this is its
> > Kconfig. This results in build errors when HAS_IOMEM is not set, such as
> > on some UML configurations:
> >
> > /usr/bin/ld: drivers/firmware/google/coreboot_table.o: in function `coreboot_table_probe':
> > coreboot_table.c:(.text+0x311): undefined reference to `memremap'
> > /usr/bin/ld: coreboot_table.c:(.text+0x34e): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/memconsole-coreboot.o: in function `memconsole_probe':
> > memconsole-coreboot.c:(.text+0x12d): undefined reference to `memremap'
> > /usr/bin/ld: memconsole-coreboot.c:(.text+0x17e): undefined reference to `devm_memremap'
> > /usr/bin/ld: memconsole-coreboot.c:(.text+0x191): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_destroy.isra.0':
> > vpd.c:(.text+0x300): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_section_init':
> > vpd.c:(.text+0x382): undefined reference to `memremap'
> > /usr/bin/ld: vpd.c:(.text+0x459): undefined reference to `memunmap'
> > /usr/bin/ld: drivers/firmware/google/vpd.o: in function `vpd_probe':
> > vpd.c:(.text+0x59d): undefined reference to `memremap'
> > /usr/bin/ld: vpd.c:(.text+0x5d3): undefined reference to `memunmap'
> > collect2: error: ld returned 1 exit status
> >
> > Signed-off-by: David Gow <davidgow@google.com>
> > Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>
> > Acked-By: Julius Werner <jwerner@chromium.org>
> > ---
>
> What commit id does this fix?
>
> thanks,
>
> greg k-h

As best I can tell, this[1] is the most sensible answer:

Fixes: a28aad66da ("firmware: coreboot: Collapse platform drivers into
bus core")

However, I think the first actual HAS_IOMEM-dependent calls were
introduced earlier, in "firmware: google memconsole: Add coreboot
support"[2], it just (a) never caused a problem under UML due to the
ACPI requirement, and (b) this fix won't apply particularly cleanly to
anything earlier than [1] anyway.

-- David

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a28aad66da8bd19b249670d003bb9a698bdda397
[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d384d6f43d1ec3f1225ab0275fd592c5980bd830

--000000000000ecaa7705d8d8e2c9
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIPnwYJKoZIhvcNAQcCoIIPkDCCD4wCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ggz5MIIEtjCCA56gAwIBAgIQeAMYYHb81ngUVR0WyMTzqzANBgkqhkiG9w0BAQsFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMDA3MjgwMDAwMDBaFw0yOTAzMTgwMDAwMDBaMFQxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSowKAYDVQQDEyFHbG9iYWxTaWduIEF0bGFz
IFIzIFNNSU1FIENBIDIwMjAwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCvLe9xPU9W
dpiHLAvX7kFnaFZPuJLey7LYaMO8P/xSngB9IN73mVc7YiLov12Fekdtn5kL8PjmDBEvTYmWsuQS
6VBo3vdlqqXZ0M9eMkjcKqijrmDRleudEoPDzTumwQ18VB/3I+vbN039HIaRQ5x+NHGiPHVfk6Rx
c6KAbYceyeqqfuJEcq23vhTdium/Bf5hHqYUhuJwnBQ+dAUcFndUKMJrth6lHeoifkbw2bv81zxJ
I9cvIy516+oUekqiSFGfzAqByv41OrgLV4fLGCDH3yRh1tj7EtV3l2TngqtrDLUs5R+sWIItPa/4
AJXB1Q3nGNl2tNjVpcSn0uJ7aFPbAgMBAAGjggGKMIIBhjAOBgNVHQ8BAf8EBAMCAYYwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMBIGA1UdEwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFHzM
CmjXouseLHIb0c1dlW+N+/JjMB8GA1UdIwQYMBaAFI/wS3+oLkUkrk1Q+mOai97i3Ru8MHsGCCsG
AQUFBwEBBG8wbTAuBggrBgEFBQcwAYYiaHR0cDovL29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3Ry
MzA7BggrBgEFBQcwAoYvaHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvcm9vdC1y
My5jcnQwNgYDVR0fBC8wLTAroCmgJ4YlaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9yb290LXIz
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
G7p3AiuB2sgfq6cOpbO5MEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQBsL34EJkCtu9Nu
2+R6l1Qzno5Gl+N2Cm6/YLujukDGYa1JW27txXiilR9dGP7yl60HYyG2Exd5i6fiLDlaNEw0SqzE
dw9ZSIak3Qvm2UybR8zcnB0deCUiwahqh7ZncEPlhnPpB08ETEUtwBEqCEnndNEkIN67yz4kniCZ
jZstNF/BUnI3864fATiXSbnNqBwlJS3YkoaCTpbI9qNTrf5VIvnbryT69xJ6f25yfmxrXNJJe5OG
ncB34Cwnb7xQyk+uRLZ465yUBkbjk9pC/yamL0O7SOGYUclrQl2c5zzGuVBD84YcQGDOK6gSPj6w
QuBfOooZPOyZZZ8AMih7J980MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBk
ObhMw/h75gb11Z+YRyZfRhs48cXkR15z9nRdUsQ9RTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjAyMjUxNDU1MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAR13RNQjTIXnNZpDya4uq
MQu/x+hlAjv9Jq/YJ/pBP9m0wYaS0Do8SQuuZUzQhsLqSLJf6/KRNfUmocj3jAEx6zlxqsBmKwTH
Vuby/4+vwahHVj7P2sIc2R/ESdNH9qcp4+fzsoZ8y719tnOsfxNX8ATgLgOaVNqzVslmPO+r3t2C
1fHxCRjP928ICJQXpOC3ZvQSvrkeeXqS5GXC3YPSqaByuVyBMo2MUjy5JYJtppxH4W8401rEFcxI
g5LLGxPR9F1G6dHzx1JdI2ct2phmZMtT8tpnN1OY68P123DABN3mUO1GUk/3yQHS+BbGliRuyMo9
uEN9WzjCebv8KVGiAw==
--000000000000ecaa7705d8d8e2c9--
