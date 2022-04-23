Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3852950C81F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 09:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234116AbiDWH4b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 03:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbiDWH40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 03:56:26 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4895E68FBE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 00:53:30 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so13922779wrh.11
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 00:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NRtDqK6YaIKiTIV74kTsKn1U9dY9sVhYZ2sTpyxQGPc=;
        b=hSOA6pIKjJO9uJPgntg+TNONWqQbQpPoMJ0ByHD/F+wynNJsMYhzj73dZ5frS7vriP
         oM4VO5++WfzyHGPhnrE1Hu65LDppcl0cXyFwhDxCbTu4UFQgtZVSGnXPlYqznkXY7oDX
         2S7UcRGKtO+XCFyED8xrRFFJ6BwXUtmGxf79aeBuAQBztJALojGASnR3o2bebzmFXpvX
         B4lP7lC4mt6KgRaqcXr3L0uH5Y+s3uk7zq18UI+T6+Uo9LTkSfN5rdcC6GtV+w1j5NRN
         mDScnWqNbyD61xB+MpTqrrDRU9V4jNokyLyLap2/Gzso2Xo952e5so4tRpLTZLLUh/Uk
         l5bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NRtDqK6YaIKiTIV74kTsKn1U9dY9sVhYZ2sTpyxQGPc=;
        b=cU20HZ+d/kiAHT6sfwgftG+CkDlJZDeULdQmevWmFSEj0BqxxxIOwvagrBfpaf7mpj
         Dr5DPtFfXsEudDGVyOjvtnzw2C9QvO+weshZ9tEtrhkvy3t1ZHpltkwiZZyOVMK0Navw
         EWrNtuoqr+Von7+kLzCMG6IL0thDCuG55mtSAT6DQJQJeesA77yJaXLzKmHGrN1MXZ0d
         ZmZKrP/AWlgGo/ldQ1o2qrcIU6THTj71Bvosf5Bkz1Z8/vCw4dIPB36D7j/mBlcm+AVd
         hl9L3sv1yQdK/GTkZOYzYU8dXQzGftUu1X8WWWaGstK/IJkUe9gpSloDUp6g3DbkH9Ri
         ilSA==
X-Gm-Message-State: AOAM532NiQ2KAuMnyA4x8998m5t56+32fzSBcippq+vjh7fnr+S3cm4/
        wTThC41jh7Eo2r6POiXToNRPlBUveJTnq2CJjgi5ew==
X-Google-Smtp-Source: ABdhPJzEt5KhdbZs/h9GuJWp8z1vxcsMVKUy48Z287ibECLkroOmnDCHtELsnhXUV7i6uUiFQ7LkCn33iI9MluJDRX0=
X-Received: by 2002:a5d:46c3:0:b0:20a:b845:f164 with SMTP id
 g3-20020a5d46c3000000b0020ab845f164mr6697785wrs.269.1650700408640; Sat, 23
 Apr 2022 00:53:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220316202622.324866-1-frowand.list@gmail.com>
 <CABVgOSmkvxhHSJx0W6BEYz=Ai9vB=nCz625dSKLLUfU0rMLkFA@mail.gmail.com> <37465a0f-7deb-bedb-1a84-90324f554ad1@gmail.com>
In-Reply-To: <37465a0f-7deb-bedb-1a84-90324f554ad1@gmail.com>
From:   David Gow <davidgow@google.com>
Date:   Sat, 23 Apr 2022 15:53:17 +0800
Message-ID: <CABVgOSm5Bc13o5UEVEiRCpzrq1Jqt11DjQ7YWPyjfj_6fBwWVw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Documentation: dev-tools: begin KTAP spec v2 process
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        "Bird, Tim" <Tim.Bird@sony.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Rae Moar <rmr167@gmail.com>,
        Guillaume Tucker <guillaume.tucker@collabora.com>,
        Daniel Latypov <dlatypov@google.com>, kernelci@groups.io,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000008274c505dd4da351"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000008274c505dd4da351
Content-Type: text/plain; charset="UTF-8"

On Sat, Apr 23, 2022 at 7:16 AM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 3/17/22 03:42, David Gow wrote:
> > On Thu, Mar 17, 2022 at 4:26 AM <frowand.list@gmail.com> wrote:
> >>
> >> From: Frank Rowand <frank.rowand@sony.com>
> >>
> >> An August 2021 RFC patch [1] to create the KTAP Specification resulted in
> >> some discussion of possible items to add to the specification.
> >> The conversation ended without completing the document.
> >>
> >> Progress resumed with a December 2021 RFC patch [2] to add a KTAP
> >> Specification file (Version 1) to the Linux kernel.  Many of the
> >> suggestions from the August 2021 discussion were not included in
> >> Version 1.  This patch series is intended to revisit some of the
> >> suggestions from the August 2021 discussion.
> >
> > Thanks for kicking this off again. There were definitely a lot of good
> > ideas in those threads which we haven't got to yet.
> >
> > I think there is an interesting line to walk between keeping KTAP
> > sufficiently "TAP-like" (particularly w/r/t being able to reuse
> > existing TAP parsers), and actually adding features, but I don't
> > recall seeing many such issues in the previous threads.
> >
> >>
> >> Patch 1 changes the Specification version to "2-rc" to indicate
> >> that following patches are not yet accepted into a final version 2.
> >
> > I'm okay with this, though I'd want us to be a little careful with the
> > timing so we don't end up with, for example, 5.18 having a KTAP spec
> > called 2-rc which is functionally indistinguishable from v1.
>
> I finally have some time to return to this.
>
> I could host a branch on my kernel.org "frowand" linux kernel.  When
> agreement is reached on a patch on this mail list, I would add it
> to the branch.  When the discussion determines that it is time to
> release a version 2 of the specification I would add one more commit
> that only updates the version.
>
> Does that sound like a good way to proceed?
>

Yeah: that sounds good to me.

-- David

--0000000000008274c505dd4da351
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
MDIwAhABQeVybOOpR4bOOXZYL5T3MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBT
2WKL+QzVxktHiy8D3jl4rbbz6uuaIFkyDlRzkKcRpzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA0MjMwNzUzMjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAAv9MR9JXYQyZ6ytBps4g
p3U+UVOOHNXUymssXT1ZaKDsoOBCf2Fe4T/RhWdDniIEUA0rJqxj/fc8NJfbREPNoevtqI34eIjA
uRlfOKPL4kWI0apZoHCcksNeadlF5vK3pptT4hRCDevx5jHjFFf6C6H4QY0qBUXSnVTZmlrYK9GB
zby9giH0pTTBqWtHGG1gb6Zlwp8m9vjALwXFjpDksxg50uPT0D9NZsyJkHkztEz6AuDthUmupV8o
sLDkPvbUNCXF2M6NpQCCvBBxyxBTO9q9OIcf05iIu6D5vyXPMeKg3Jp++6RvclNFkJm3C2/M+tia
JUy1wmLG7iPFRe8X1w==
--0000000000008274c505dd4da351--
