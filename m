Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EAB55F8E8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 09:28:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbiF2H2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 03:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiF2H16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 03:27:58 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C3835A95
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:27:57 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id m184so8764648wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 00:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qRzfau0wL5rj9K8VkscGluLRnLm0hW7rcByJvUUW2kA=;
        b=IkXCjWzNB1wyG7BSw92vKZ4kvDQ7eqoUIZ5fy0ZH+LHjs6OF9EVExGzh3XvpHepuWT
         M4UaWi+4bL3oYuMEIOwEMTMZPx0XLRIQzJZe/d6Q36lL6h3C1gNkpw4RjVTFvA89jaY3
         f8I/7vlyQgHxC7lO+iBDH6PXUleup8O/zXwL7tdFxRDE9Mw7khqgXQpeord+AF4XodlW
         V0yi7zm7u2C7AmNeOURwbBP4aBcSsKK3FlJpTBJ9pvD858tnWY48FyPwJqUCMxQUhhu7
         H1l53tUJqnpk+MMCmBbth6wD1YCzaRKQUh4Q2m3DwFFITP3iMWbwYdXcbFw6OvNG2oDG
         yfWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qRzfau0wL5rj9K8VkscGluLRnLm0hW7rcByJvUUW2kA=;
        b=ACM8G/Dh/5nrNgTeZ1YjHLvUUe8USKiHGnkR8I/HEGXJBbu8FZEARlX4G1K6yMuqSl
         uGv8KNzZQzobjWuK+284JjVnP1bennDESUm0fA+lIFRaAiyGe9ek0S6VDqY5M+kSBqBN
         +xLAOfFEnRkW8eJIOZ3NEtiyjp/Xq/jb1nVghYaxJ873KBn5RdOVM+ghfglLGzXAQm8P
         dSxjLtH6ozHAzgD8WAEWAMOOw6oHD578EbVnaexG3KaShPIcv3rsnuan8ySolGzzAjwG
         kA99YqxC5HHNR52VVkKVsCUCRSKw6s5RPVdt2jrX6D5cSbmCHvXJYCXIRQVmm6wTKNNG
         fu0w==
X-Gm-Message-State: AJIora/spfLABJg6Hn34U2/4I2aMXsF7aBV9pwdCFAqDKFAg80gijqzY
        clZLiXOHwwFTUbAD/DIR4nHidtPsqiF9pMysatZxnw==
X-Google-Smtp-Source: AGRyM1vX1et5X5mz0TfiUQfGt5r42MlS9P5AoEouVG6iSmiDWIia4jsISXgoMGQVb/dfN3A8JHdaEjmq7n7Mwbv7CFs=
X-Received: by 2002:a7b:ce06:0:b0:3a0:39e0:b322 with SMTP id
 m6-20020a7bce06000000b003a039e0b322mr3968614wmc.55.1656487675643; Wed, 29 Jun
 2022 00:27:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220627161132.33256-1-jose.exposito89@gmail.com>
In-Reply-To: <20220627161132.33256-1-jose.exposito89@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Wed, 29 Jun 2022 15:27:44 +0800
Message-ID: <CABVgOSmC6WJxMo58VH0WSD7wdLn7_TmTktm=6txrn0ECXCNJZQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] KUnit tests for RGB565 conversion
To:     =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?UTF-8?B?TWHDrXJhIENhbmFs?= <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000080bb7e05e29117df"
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

--00000000000080bb7e05e29117df
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 28, 2022 at 12:13 AM Jos=C3=A9 Exp=C3=B3sito
<jose.exposito89@gmail.com> wrote:
>
> Hello everyone,
>
> This series is a follow up of the XRGB8888 to RGB332 conversion KUnit tes=
ts.
>
> The first 3 patches refactor the existing test to make them agnostic of t=
he target format and add support for "swab".
>
> The last patch adds the RGB565 conversion values, and shows how more form=
ats will be easily added in the future.
>
> Thank you very much in advance for your feedback,
> Jos=C3=A9 Exp=C3=B3sito
>
> Jos=C3=A9 Exp=C3=B3sito (4):
>   drm/format-helper: Rename test cases to make them more generic
>   drm/format-helper: Transform tests to be agnostic of target format
>   drm/format-helper: Add support for conversion functions with swab
>   drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb565()
>
>  .../gpu/drm/tests/drm_format_helper_test.c    | 231 +++++++++++++++---
>  1 file changed, 196 insertions(+), 35 deletions(-)
>
>
> base-commit: 6fde8eec71796f3534f0c274066862829813b21f
> prerequisite-patch-id: 8a16f4c8004d6161035eaea275c8eafaa0ac927e
> prerequisite-patch-id: 53fded2a49e6212b546db76ec52563a683752e65
> prerequisite-patch-id: 294b0ca27a6ee57096c8f097c0572336b8a2d583
> prerequisite-patch-id: 5e05bfc5287d16c207bfc616b2776ad72eb4ab29
> prerequisite-patch-id: e94560be85dffb62a5b3cf58d1f0fc3d278ad806
> prerequisite-patch-id: a471df39c7b32c69dd2b138a7d0af015ea42e00a
> --
> 2.25.1
>

These look pretty good overall to me, but there is one big issue
(which is actually with the previous series -- oops!), and a few small
stylistic thoughts.

For the big issue: these tests don't work on big-endian systems. The
'swab' bit in this series reminded me to check, and sure enough, all
of the tests fail (including the rgb332 ones).

I tested it on PowerPC with:
 ./tools/testing/kunit/kunit.py run
--kunitconfig=3Ddrivers/gpu/drm/tests --arch=3Dpowerpc
--cross_compile=3Dpowerpc64-linux-gnu-

So that's something which needs to be fixed.

The smaller stylistic thoughts basically all revolve around the
complexity of convert_xrgb8888_cases: there are arrays of structs with
arrays of unions of structs (with function pointers in them). This
isn't a problem: it's actually a lot more readable than that
description implies, but there are other ways it could be tackled
(which have their own tradeoffs, of course).

One possibility would be to split up the test into a separate test per
destination format. They could reuse the convert_xrgb8888_cases array,
and just each access a different result. You could make things even
clearer (IMO) by replacing the results[] array with a separate, named,
member (since you don't need to iterate over them any more), and
remove the need to have the function pointer and swab union/members by
just hardcoding those in the separate test functions. It'd also make
the results a bit clearer, as each destination format would get its
own separate set of results.

Of course, that's just an idea: I don't actually have a problem with
the existing design either (other than the endianness issue, of
course).

Cheers,
-- David

--00000000000080bb7e05e29117df
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
z/tQRXr3iPeVmZCr7nttMEwGA1UdIARFMEMwQQYJKwYBBAGgMgEoMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAwGA1UdEwEB/wQCMAAwgZoGCCsG
AQUFBwEBBIGNMIGKMD4GCCsGAQUFBzABhjJodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9jYS9n
c2F0bGFzcjNzbWltZWNhMjAyMDBIBggrBgEFBQcwAoY8aHR0cDovL3NlY3VyZS5nbG9iYWxzaWdu
LmNvbS9jYWNlcnQvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3J0MB8GA1UdIwQYMBaAFHzMCmjXouse
LHIb0c1dlW+N+/JjMEYGA1UdHwQ/MD0wO6A5oDeGNWh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20v
Y2EvZ3NhdGxhc3Izc21pbWVjYTIwMjAuY3JsMA0GCSqGSIb3DQEBCwUAA4IBAQAx+EQjLATc/sze
VoZkH7OLz+/no1+y31x4BQ3wjW7lKfay9DAAVym896b7ECttSo95GEvS7pYMikzud57WypK7Bjpi
ep8YLarLRDrvyyvBuYtyDrIewkuASHtV1oy5E6QZZe2VOxMm6e2oJnFFjbflot4A08D3SwqDwV0i
OOYwT0BUtHYR/3903Dmdx5Alq+NDvUHDjozgo0f6oIkwDXT3yBV36utQ/jFisd36C8RD5mM+NFpu
3aqLXARRbKtxw29ErCwulof2dcAonG7cd5j+gmS84sLhKU+BhL1OQVXnJ5tj7xZ5Ri5I23brcwk0
lk/gWqfgs3ppT9Xk7zVit9q8MYICajCCAmYCAQEwaDBUMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQ
R2xvYmFsU2lnbiBudi1zYTEqMCgGA1UEAxMhR2xvYmFsU2lnbiBBdGxhcyBSMyBTTUlNRSBDQSAy
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCq
0cJabth/CeC42qLPvT3QCRTydOlcP2+6Z/+0R0rrgDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA2MjkwNzI3NTZaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAB+p2fSd13zu4oeynjdVM
hk34VpErytDn0msZVF13g/ULjgE8SLzC/6U71QSOxKz6kpOtZ2pglEHyer9dkr4o1oits6L2hSpS
gA22eX2+ChbNpAN7cfcsiWCVU/yz3yNo/p4n8fXpVwegMct2gotraatwVBt2yLrCXKdrNSeGijMw
U4xb5QfgY2+0yu+RwJU175RO//GV3zx4n+hw3ZcXlMNN588sTUqGC7OPMLMWSDNap3LX/uSnSlcl
Xh1070f3Xe9biGYmke8A/s15yi4aBV3PYKxi6IT9hccX6JT9Do95D2aWcjqJZyYi9uQXrVArVmlv
eo9N+CkR0yWAHaCkkg==
--00000000000080bb7e05e29117df--
