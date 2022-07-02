Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0EA5640BE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 16:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiGBOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Jul 2022 10:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231958AbiGBOhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jul 2022 10:37:11 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2157E0BB
        for <linux-kernel@vger.kernel.org>; Sat,  2 Jul 2022 07:37:09 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r14so1262465wrg.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Jul 2022 07:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rBVrHbsrN1EnUSVJ9D/m8rXhbV5eRgqluHu1BFYqYkk=;
        b=iaOwduGr9D6pnBBvMd3kKUdLIjOjAovpaWxAKAWFc9SA9T9GlT99ZvbdSDWBmplTfS
         VZwXBKLhSNs3n/borKmp8tlu31kndHD7//Mula3nIRGHfAzERrMuJnh29dtlMciLGZTG
         suHi9K6R3va5ukW2wMGTQPHPRy5Lb7jyABLHg+8fwpxOo1qmKt462SPvFbTi8Sd0S4I1
         Z/0lUciYHiB1DxucwDx1v0/9eJpBsGxmOdpOPMBD02a3vzx1MqP9EAtUknftASJfg43y
         1l3oh8nJPzpTk1ha0ah1blcpkO3TYwscVHyvGugXZ8vQ/69WDalHmo3SqpsQjp8PUrNT
         MsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rBVrHbsrN1EnUSVJ9D/m8rXhbV5eRgqluHu1BFYqYkk=;
        b=HY5QrvthocMcn8JfkBOQpSEakQPxfttogcCCAgbuOd37Zle5qD0Q03vaIEvGZdx1FJ
         wQ8CQkkEuus1XZtiVl6xTMIfh4n64kvUqgWyh7lLa51DGzK00yACGz2/u8ZwuBh+5ly8
         a+SdapBD2kvRYIaml/eY9GRN2a8gCzH/Pj1g2d387Sa9/mbq73E9llonVLzUKhVwCdO5
         6yh06VukY7HA/4whllO+Ww9z1TrAWG2f68OSFlxb5c7PF3wEWsB6bAl4ErYMlyoOSUlU
         lUYdHQJjj6y4Aom8k0x8gALeVpXr+Z5j09Em8Owhx4tFyMUcZrB4+C/lRKVuW6lPy0a/
         7sWg==
X-Gm-Message-State: AJIora+8af/6HN/SM6poFMFH+udTaJ7krhCw3z0ycCEvuzMjBeEqXJT+
        wMZY0DnCP3HphRFOGp3YbAcS+A8mSBygp4CCagNwDA==
X-Google-Smtp-Source: AGRyM1tHRBD8RkN2CDxgnL2ddaH2PcZ8WC51lOikL4KHo929dtW98UdmxGwRdu64zsHeR+U3Rp6TBJf1zYcx2C4VINI=
X-Received: by 2002:a05:6000:1e0f:b0:21b:b032:6b3d with SMTP id
 bj15-20020a0560001e0f00b0021bb0326b3dmr19249672wrb.337.1656772628265; Sat, 02
 Jul 2022 07:37:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220701181723.349165-1-mairacanal@riseup.net>
 <CABVgOSn0o=b6vPYsrP+rqGaKskVVL0gw11gbsGn6qecPPKQGqA@mail.gmail.com> <ba474460-6035-90d8-651a-8b1bc60ecea9@riseup.net>
In-Reply-To: <ba474460-6035-90d8-651a-8b1bc60ecea9@riseup.net>
From:   David Gow <davidgow@google.com>
Date:   Sat, 2 Jul 2022 22:36:57 +0800
Message-ID: <CABVgOSkFKJBNt-AsWmOh2Oni4QO2xdiXJiYD1EVcS-Qz=BjJRw@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Kunit: Fix example with compilation error
To:     =?UTF-8?B?TWHDrXJhIENhbmFs?= <mairacanal@riseup.net>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Sat, Jul 2, 2022 at 9:35 PM Ma=C3=ADra Canal <mairacanal@riseup.net> wro=
te:
>
> On 7/2/22 01:32, David Gow wrote:
> > On Sat, Jul 2, 2022 at 2:17 AM Ma=C3=ADra Canal <mairacanal@riseup.net>=
 wrote:
> >>
> >> The Parameterized Testing example contains a compilation error, as the
> >> signature for the description helper function should be void(*)(struct
> >> sha1_test_case *, char *), so the struct should not be const. This is
> >> warned by Clang:
> >>
> >> error: initialization of =E2=80=98void (*)(struct sha1_test_case *, ch=
ar *)=E2=80=99
> >> from incompatible pointer type =E2=80=98void (*)(const struct sha1_tes=
t_case *,
> >> char *)=E2=80=99 [-Werror=3Dincompatible-pointer-types]
> >>     33 | KUNIT_ARRAY_PARAM(sha1, cases, case_to_desc);
> >>        |                                ^~~~~~~~~~~~
> >> ../include/kunit/test.h:1339:70: note: in definition of macro
> >> =E2=80=98KUNIT_ARRAY_PARAM=E2=80=99
> >> 1339 |                         void (*__get_desc)(typeof(__next), char=
 *) =3D get_desc; \
> >>
> >> Signed-off-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
> >> ---
> >
> > Thanks for catching this. The change to the documentation looks good,
> > but it may be better to change the array to be:
> > const struct cases[] =3D { ... }
>
> I missed that! Would you rather that I change it on a v2?
>
> Best Regards,
> - Ma=C3=ADra Canal
>

Yeah, I think that'd be best.

No need to hurry, though: Brendan et al are away for the US long weekend.

Cheers,
-- David

> > That matches most of the existing uses of this, such as the mctp test,
> > and encourages the use of const in cases (like the example) where it
> > makes sense.
> >
> > I'm okay with it either way, though: they're both valid.
> >
> > Reviewed-by: David Gow <davidgow@google.com>
> >
> > Cheers,
> > -- David
> >
> >>  Documentation/dev-tools/kunit/usage.rst | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/d=
ev-tools/kunit/usage.rst
> >> index d62a04255c2e..8e72fb277058 100644
> >> --- a/Documentation/dev-tools/kunit/usage.rst
> >> +++ b/Documentation/dev-tools/kunit/usage.rst
> >> @@ -517,7 +517,7 @@ By reusing the same ``cases`` array from above, we=
 can write the test as a
> >>         };
> >>
> >>         // Need a helper function to generate a name for each test cas=
e.
> >> -       static void case_to_desc(const struct sha1_test_case *t, char =
*desc)
> >> +       static void case_to_desc(struct sha1_test_case *t, char *desc)
> >>         {
> >>                 strcpy(desc, t->str);
> >>         }
> >> --
> >> 2.36.1
> >>
> >> --
