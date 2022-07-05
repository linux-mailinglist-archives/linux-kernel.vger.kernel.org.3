Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B365665B3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiGEI71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbiGEI65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:58:57 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3AF713F83
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:58:10 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h17so3387558wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 01:58:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Q/ncPyAf/LHAOE0FbL9Wvqu7kD562XsX+/ux2dlxkU=;
        b=dAHHRn7QYGxYmpLieiRF+9dolkO094/7rMAMv5J2OYNYc8SynuEK+UCCYOvwMtjV9Z
         OdhgF2JdyHIxd9Rfq1LGEq1DiYC44G5+buJ6+c/nSUSf+9dZMLg5+Xsv4tsrebJ86h6H
         890qjPfoQu/MrF/7KyncJ3iqvEbcoA2YFA7qRxclZDUJVQ2LrVHxrXPXfAuU3hkFa+J0
         iEh5e0my+aBBqJiy01ciM8nXhPVE/Q9NpxGRlFEgOztOYugPOXZiwpPmpwlr26/FrwFA
         nrQ+nynkMPaVbSDFTzbXd+lvbIA0aiGnTKeuzKLCi2KNdhyg7AG+qWpdpvkhzzWLD4dr
         J4sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Q/ncPyAf/LHAOE0FbL9Wvqu7kD562XsX+/ux2dlxkU=;
        b=1SUWZHNkcau2InfAvpl8HUSapBlUqSBtVmImw4YusCEhS13XN+aj60ewvhxoME3e3j
         9HpuJqV6T88CJlgI2n++2p5evZAWutisfsEbP/F7JdDCADepNNsRzWrYn//EdMul5iKZ
         Srf8tOnkgrdHpj8BXE5QTMHEQTHJkOJLsPjQroKqyda10nCrvkV10AOeY9GvsCB28dtq
         pwYidL4t8qjBKJl41Rk7g2udo4kROerK+GrfiwCDAooaGVJFxcWhqMi0WN52YU84nwgr
         WRgIJ+0qLzcOpf0quLHViLzmfGUHBkgdyGc2CDAB2/wRvQUS8s+E4sLPysLrzvAajn/l
         Nwig==
X-Gm-Message-State: AJIora9ceKBvlF6eaXYSqYQnnR+mD4rF83ql4ArDDaTS1eFQtWixhZU1
        PExZIfoRjVETV4g7Y9w9oaY8bBY2oG+SjhSsi/Ve6Q==
X-Google-Smtp-Source: AGRyM1tWg1Yv6mY879/hY+vaCyyznYSukKIeA+o/XUOlWC0jsNVsM68gSSoV7MLk9mHrTMYvV0VQ2C/gmBjtmfFbeBY=
X-Received: by 2002:a05:6000:144d:b0:21b:b3cc:162e with SMTP id
 v13-20020a056000144d00b0021bb3cc162emr31706534wrx.433.1657011489178; Tue, 05
 Jul 2022 01:58:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220405125540.2135d81d@canb.auug.org.au> <20220705091352.15150c7f@canb.auug.org.au>
In-Reply-To: <20220705091352.15150c7f@canb.auug.org.au>
From:   David Gow <davidgow@google.com>
Date:   Tue, 5 Jul 2022 16:57:58 +0800
Message-ID: <CABVgOSkhSb1oVo90h8vOALZzJFCE-1GaiADFEEpXEYqrvHTS=g@mail.gmail.com>
Subject: Re: linux-next: manual merge of the kunit-next tree with the apparmor tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     John Johansen <john.johansen@canonical.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ricardo Ribalda <ribalda@chromium.org>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000385c6b05e30b0dcf"
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

--000000000000385c6b05e30b0dcf
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 5, 2022 at 7:14 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Tue, 5 Apr 2022 12:55:40 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Today's linux-next merge of the kunit-next tree got a conflict in:
> >
> >   security/apparmor/policy_unpack_test.c
> >
> > between commit:
> >
> >   d86d1652ab13 ("apparmor: test: Remove some casts which are no-longer required")
> >
> > from the apparmor tree and commit:
> >
> >   5f91bd9f1e7a ("apparmor: test: Use NULL macros")
> >
> > from the kunit-next tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
> >
> > diff --cc security/apparmor/policy_unpack_test.c
> > index 399dce3781aa,5c18d2f19862..000000000000
> > --- a/security/apparmor/policy_unpack_test.c
> > +++ b/security/apparmor/policy_unpack_test.c
> > @@@ -408,8 -408,8 +408,8 @@@ static void policy_unpack_test_unpack_u
> >
> >       size = unpack_u16_chunk(puf->e, &chunk);
> >
> >  -    KUNIT_EXPECT_EQ(test, size, (size_t)0);
> >  +    KUNIT_EXPECT_EQ(test, size, 0);
> > -     KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
> > +     KUNIT_EXPECT_NULL(test, chunk);
> >       KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->end - 1);
> >   }
> >
> > @@@ -430,8 -430,8 +430,8 @@@ static void policy_unpack_test_unpack_u
> >
> >       size = unpack_u16_chunk(puf->e, &chunk);
> >
> >  -    KUNIT_EXPECT_EQ(test, size, (size_t)0);
> >  +    KUNIT_EXPECT_EQ(test, size, 0);
> > -     KUNIT_EXPECT_PTR_EQ(test, chunk, NULL);
> > +     KUNIT_EXPECT_NULL(test, chunk);
> >       KUNIT_EXPECT_PTR_EQ(test, puf->e->pos, puf->e->start + TEST_U16_OFFSET);
> >   }
> >
>
> This is now a conflict between the apparmor tree and Linus' tree.
>

Hmm... this patch -- d86d1652ab13 ("apparmor: test: Remove some casts
which are no-longer required") -- has been sitting in the
apparmor-next branch since December, but there haven't been any
AppArmor pull requests since then.

If it's easier, I'm happy to redo this and send it in via the KUnit
tree (assuming it gets removed from apparmor-next). Otherwise, I guess
this'll just have to wait for the next AppArmor PR.

-- David

--000000000000385c6b05e30b0dcf
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
LmNybDBMBgNVHSAERTBDMEEGCSsGAQQBoDIBKDA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5n
bG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzANBgkqhkiG9w0BAQsFAAOCAQEANyYcO+9JZYyqQt41
TMwvFWAw3vLoLOQIfIn48/yea/ekOcParTb0mbhsvVSZ6sGn+txYAZb33wIb1f4wK4xQ7+RUYBfI
TuTPL7olF9hDpojC2F6Eu8nuEf1XD9qNI8zFd4kfjg4rb+AME0L81WaCL/WhP2kDCnRU4jm6TryB
CHhZqtxkIvXGPGHjwJJazJBnX5NayIce4fGuUEJ7HkuCthVZ3Rws0UyHSAXesT/0tXATND4mNr1X
El6adiSQy619ybVERnRi5aDe1PTwE+qNiotEEaeujz1a/+yYaaTY+k+qJcVxi7tbyQ0hi0UB3myM
A/z2HmGEwO8hx7hDjKmKbDCCA18wggJHoAMCAQICCwQAAAAAASFYUwiiMA0GCSqGSIb3DQEBCwUA
MEwxIDAeBgNVBAsTF0dsb2JhbFNpZ24gUm9vdCBDQSAtIFIzMRMwEQYDVQQKEwpHbG9iYWxTaWdu
MRMwEQYDVQQDEwpHbG9iYWxTaWduMB4XDTA5MDMxODEwMDAwMFoXDTI5MDMxODEwMDAwMFowTDEg
MB4GA1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzAR
BgNVBAMTCkdsb2JhbFNpZ24wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDMJXaQeQZ4
Ihb1wIO2hMoonv0FdhHFrYhy/EYCQ8eyip0EXyTLLkvhYIJG4VKrDIFHcGzdZNHr9SyjD4I9DCuu
l9e2FIYQebs7E4B3jAjhSdJqYi8fXvqWaN+JJ5U4nwbXPsnLJlkNc96wyOkmDoMVxu9bi9IEYMpJ
pij2aTv2y8gokeWdimFXN6x0FNx04Druci8unPvQu7/1PQDhBjPogiuuU6Y6FnOM3UEOIDrAtKeh
6bJPkC4yYOlXy7kEkmho5TgmYHWyn3f/kRTvriBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti
+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGjQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8E
BTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5NUPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEA
S0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigHM8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9u
bG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmUY/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaM
ld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88
q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcya5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/f
hO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/XzCCBNgwggPAoAMCAQICEAGH0uAg+eV8wUdHQOJ7
yfswDQYJKoZIhvcNAQELBQAwVDELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEdsb2JhbFNpZ24gbnYt
c2ExKjAoBgNVBAMTIUdsb2JhbFNpZ24gQXRsYXMgUjMgU01JTUUgQ0EgMjAyMDAeFw0yMjA2MjAw
MjAzNTNaFw0yMjEyMTcwMjAzNTNaMCQxIjAgBgkqhkiG9w0BCQEWE2RhdmlkZ293QGdvb2dsZS5j
b20wggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCv9aO5pJtu5ZPHSb99iASzp2mcnJtk
JIh8xsJ+fNj9OOm0B7Rbg2l0+F4c19b1DyIzz/DHXIX9Gc55kfd4TBzhITOJmB+WdbaWS8Lnr9gu
SVO8OISymO6uVA0Lmkfne3zV0TwRtFkEeff0+P+MqdaLutOmOcLQRp8eAzb/TNKToSROBYmBRcuA
hDOMCVZZozIJ7T4nHBjfOrR+nJ4mjBIDRnDucs4dazypyiYiHYLfedCxp8vldywHMsTxl59Ue9Yk
RVewDw3HWvWUIMbc+Y636UXdUn4axP1TXN0khUpexMoc5qCHxpBIE/AyeS4WPASlE8uVY9Qg8dT6
kJmeOT+ZAgMBAAGjggHUMIIB0DAeBgNVHREEFzAVgRNkYXZpZGdvd0Bnb29nbGUuY29tMA4GA1Ud
DwEB/wQEAwIFoDAdBgNVHSUEFjAUBggrBgEFBQcDBAYIKwYBBQUHAwIwHQYDVR0OBBYEFDyAvtuc
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
MDIwAhABh9LgIPnlfMFHR0Die8n7MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDK
bzK6dGMWZuk91dPxpMeHb0+v5YssH7O6U6oYSOKGbDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcB
MBwGCSqGSIb3DQEJBTEPFw0yMjA3MDUwODU4MDlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUD
BAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsG
CSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEABfsMFtPi/ZSo1vhGYExm
mN4zXh9OOWDbpXO4i9eHWPbDxoITvyl/3hVWFlJ5Qykoa3aZODFhEmQjWlGfm6FAwQgP5txS9P2e
KMsY9v9Xtzq5+PlM71re9NgiW4uIZHU2T9f5MZTu7x4G8/IP/QQOnkumTqz9OuHWsZNV4RkBH24b
0G3kbKmCTwJb2VbKm+5h3GYKbm+E6tlC1SQ6pRC7yJo92IAQN0tu5xA14O3pnN++T0kDlv+QzDNU
ZA0BvOxanHCjt8vzMqJIxkGgEps801QqZd82729Rw+hkQqb3opg7bX/V7yyTKO/iBxT5oJrBTJTn
VOzWOhbVQHS+ZQiV9A==
--000000000000385c6b05e30b0dcf--
