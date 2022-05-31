Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5A7538C7D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244641AbiEaIEo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 31 May 2022 04:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiEaIEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:04:41 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8DB91542
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:04:39 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MmU9R-1nVApw1i41-00iTmX for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022
 10:04:37 +0200
Received: by mail-yb1-f171.google.com with SMTP id h75so16599727ybg.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:04:37 -0700 (PDT)
X-Gm-Message-State: AOAM530aw5leJ1RwDe+iu2KrD5u23lSXAQBwTDKdHhikFwgQFP9S3h3j
        Avtoj69awDVwYE6+w7ajwrFyRYTlPYkMibtzkYE=
X-Google-Smtp-Source: ABdhPJzullwHURqjYFLuUbj5z3ZAXSH5S2TTm7eQzxfj3C4Cw8NUJrDyWWQCTyWhoCHKYMFfEK0FxV85gP8hLdTej/I=
X-Received: by 2002:a25:69c4:0:b0:65c:ed2b:9106 with SMTP id
 e187-20020a2569c4000000b0065ced2b9106mr8172776ybc.394.1653984276242; Tue, 31
 May 2022 01:04:36 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2Zg2QDS1_Ysn8-Zqqd+K7bbTFS7JV7gPabp6nvPiKaog@mail.gmail.com>
 <91E67F46-A3C7-4159-9E0C-C6C6306F3669@inria.fr>
In-Reply-To: <91E67F46-A3C7-4159-9E0C-C6C6306F3669@inria.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 31 May 2022 10:04:19 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2iAsemAQdbTZ_E7GGGCXAOeWbjSjLgXEsd5sg_buZWhw@mail.gmail.com>
Message-ID: <CAK8P3a2iAsemAQdbTZ_E7GGGCXAOeWbjSjLgXEsd5sg_buZWhw@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Julia Lawall <Julia.Lawall@inria.fr>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jani Nikula <jani.nikula@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Provags-ID: V03:K1:2R1P1Gj0IweJyyXJRxu8c/mrctPJm4neceddRGqn1jVAANXCgZ4
 2KJuatX4FlJj7il5QO3IZlNyWzEsYScptKwpmDUTF+C2nj08/IitVQoOd35s3ct2OiMUlRl
 J2N9t/tGr64c25lrG7sPoCXwVJ+xenKb5PyAqtuIf1NzMydw/llvcUjd//qgRizqhc/A/b4
 boU2IjVjw6yL+LhXh8JoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CxMYW/Mw3NE=:r7inTzKgFRIGDiMlPfTIZO
 SmEcu+v4ajGooG4auLhrtvHVHbznwLsU9RjpEjL4UJ+SWJ9YzXTd9QBoHZ8BTyGGGoGGjXm7O
 S+0gC9axKHKy9+Ho17Tn07K1fxSvUmS2y+XGp4wAmVPV5y6rwnR3W8yzTHz19V8JtW9Sc1yMn
 zf+9g0sNHlTkJaK3OKjy8EooC3rTolBYn64YD8LDCUU8HldXrwUAOrbD6oJJ5wuDRnYpdtLa9
 uhuz+AY+wJKHxiDvVo4XGlbJXTblf+3RlVvNGUMwcw3ULoWZ8NMAELvhk6qxZ5sq5gIdZYak/
 geArgJtmWIt5+K7yrs9EqjjVz7TU05vh5OdwtHpSf8uBQUbWaEB3Zqah2A1rCWYfw363h4m2y
 nxVPsJ0fgvXbBTY+IqMztKCvABG022a84DhvABb3v1OyiyGVPO1l6dr6GWL8DAS58vzXTwkxC
 4748TO66VDx8t3EYt9+lpFX+4uni3HNYRn/Mw8VwtxTLD+ZhJjl0mPMPz26og69iLWMMmqui5
 7FwNR1tCL+yxrVlNs2Ljy9s3FFRTZtV/XTuvTki/rwbNdfsrCwn2uk/Lh32/XA7zUJ1Lg6xQU
 svRaVVUBtwurrODXxTUIJ6S2O5GTC3hLQOrP+tmfwcGXi4OH4jXcasSLp6u6yeNWQkNC/z4/y
 F8ejrziBBT1F4SqYZApqoCzRZdiQFJM5jbcDW03+BNhfFxuLn4JaT6g+uXVrvhYw1/+VSQPIh
 cvWjpwiNiy49g4Yov3b5BBINW1AA7CGL1Q33Uw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 8:26 AM Julia Lawall <Julia.Lawall@inria.fr> wrote:
> > On 30 May 2022, at 15:27, Arnd Bergmann <arnd@arndb.de> wrote:
> > ﻿On Mon, May 30, 2022 at 4:08 PM Jani Nikula <jani.nikula@intel.com> wrote:
> >>> On Mon, 30 May 2022, Arnd Bergmann <arnd@arndb.de> wrote:
> >>> struct my_driver_priv {
> >>>       struct device dev;
> >>>       u8 causes_misalignment;
> >>>       spinlock_t lock;
> >>>       atomic_t counter;
> >>> } __packed; /* this annotation is harmful because it breaks the atomics */
> >>
> >> I wonder if this is something that could be caught with coccinelle. Or
> >> sparse. Are there any cases where this combo is necessary? (I can't
> >> think of any, but it's a low bar. ;)
> >>
...
> >>> or if the annotation does not change the layout like
> >>>
> >>> struct my_dma_descriptor {
> >>>     __le64 address;
> >>>     __le64 length;
> >>> } __packed; /* does not change layout but makes access slow on some
> >>> architectures */
> >>
> >> Why is this the case, though? I'd imagine the compiler could figure this
> >> out.
> >
> > When you annotate the entire structure as __packed without an
> > extra __aligned() annotation, the compiler has to assume that the
> > structure itself is unaligned as well. On many of the older architectures,
> > this will result in accessing the values one byte at a time. Marking
> > the structure as "__packed __aligned(8)" instead would be harmless.
> >
> > When I have a structure with a few misaligned members, I generally
> > prefer to only annotate the members that are not naturally aligned,
> > but this approach is not very common.
>
> Searching for specific types in a packed structure would be easy.

As an experiment: what kind of results would we get when looking
for packed structures and unions that contain any of these:

- spinlock_t
- atomic_t
- dma_addr_t
- phys_addr_t
- size_t
- any pointer
- any enum
- struct mutex
- struct device

This is just a list of common data types that are used in a lot of
structures but that one should never find in hardware specific
types. If the output from coccinelle is 90% actual bugs, this would
be really helpful. OTOH if there is no output at all, or all
false-positives, we don't need to look for additional types.

> Coccinelle could duplicate the structure without the packed and see if
> any offsets change, using build bug on, but that would be architecture
> specific so maybe not useful.

I would consider this a separate issue. The first one above is for identifying
structures that are marked as packed but should not be packed at
all, regardless of whether that changes the layout.

       Arnd
