Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABF64F23F1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 09:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbiDEHKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 03:10:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230097AbiDEHKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:10:31 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E3B8AE68;
        Tue,  5 Apr 2022 00:08:31 -0700 (PDT)
Received: from mail-wm1-f52.google.com ([209.85.128.52]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N2mS2-1o0gYU13vQ-0138sv; Tue, 05 Apr 2022 09:08:30 +0200
Received: by mail-wm1-f52.google.com with SMTP id h16so7369089wmd.0;
        Tue, 05 Apr 2022 00:08:30 -0700 (PDT)
X-Gm-Message-State: AOAM533uF+b4xAa6Ic2bQpbYjoG/RGOkmn+3taMPbMxBhp2EX5An+Xmo
        rYi6zYE+2gSbnT9p+vHCWNu2AhFJO18VuGt1jJs=
X-Google-Smtp-Source: ABdhPJxPvBD3liGjE4wcwAU/5uhv3UpZs9CP1VYRV8xEB/qANbka4xub+huj1JgZoNT228F8duYYmCMymQ3lWUBTDoI=
X-Received: by 2002:a05:600c:4ecc:b0:38e:354d:909 with SMTP id
 g12-20020a05600c4ecc00b0038e354d0909mr1768472wmq.33.1649142509779; Tue, 05
 Apr 2022 00:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wg6FWL1xjVyHx7DdjD2dHZETA5_=FqqW17Z19X-WTfWSg@mail.gmail.com>
 <20220404074734.1092959-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2204041006230.1941618@ramsan.of.borg>
 <20220404092655.GR1544202@dread.disaster.area> <CAMuHMdWgqdR1o3wT9pjB=w8z=2xaDFv5DJX58-HPHOFRm3Tr8Q@mail.gmail.com>
 <CAK8P3a0QrihBR_2FQ7uZ5w2JmLjv7czfrrarCMmJOhvNdJ3p9g@mail.gmail.com>
 <20220404221605.GS1544202@dread.disaster.area> <CAMuHMdWak-zarKA_eCxWm5uhejWAXi0XkAuekfpAKRczLfhq3g@mail.gmail.com>
In-Reply-To: <CAMuHMdWak-zarKA_eCxWm5uhejWAXi0XkAuekfpAKRczLfhq3g@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 5 Apr 2022 09:08:13 +0200
X-Gmail-Original-Message-ID: <CAK8P3a1JArChbzRDFU0YPCy-7QZgqSoHe8JTH4g0yOz_Mi_MEA@mail.gmail.com>
Message-ID: <CAK8P3a1JArChbzRDFU0YPCy-7QZgqSoHe8JTH4g0yOz_Mi_MEA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.18-rc1
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Dave Chinner <david@fromorbit.com>, Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:v9JTIi8qJtPG3PIp92ZT1BP7xmoboLcO+2N58Y0rG8EUhOm7Txw
 FajvsKKlzhdlcaQTsyIaUM9+ML0BjbRuHavN4q8FSwUzJTTJZoGPOucY4nJLuNxRD3agKmV
 ZgLJvxMlCM3sXqoOLPU6f3WLfLUdVomfUMidgtlZAXRZq+SYumE+t+Z3zkFyEcjlKtj1j2O
 zjLCHmOP1uoXs2JAYWOmQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F6FWl9H0mQY=:mOtSjqg6Xn4k4DEScVdk+i
 eP6YitvK+wB5dVoo6IPKnGVQ0bfZqOg0Px1eh4RgNlvtK57Z2UXVwF8ilqEfS2yoIX54o/4tR
 nl5w5y5QluOsKaS9DlSLRgArTckW5TxPeOJYhBFo6zE5TaIes9hbwoRRpY9yWTBUjCxjzIzlP
 w+l5k8hAPcjeiHaM+GsU/zmSEYGVPKQ/6dypB+nlFwqoUFDUhap9Kv9h/HVCYza0efskXOKjq
 OChO11lkYvU0K8woTHHS8QfK9jXxYpNCc+Y3T3dzGHe22+zb86C6dd3hWdoGnNxxz3Xkrcef9
 eeY87vUWZ+CfmX5fY9VRyxg064V4BEodsPkssn0FTnBzWXZdYUIAas5/gilcDo4o4/22Jfyfd
 s0Pav7lxpHwLoAGKSFOMAr039TjniDo8goTEiI8LqsA4/duZIRgaXddEre4H6hSKTB9SvyT2W
 IIgSP6egsS/uhMHRwi6kIDETHGC3Q8z7j3pkHZY5fuXVpj3t+yOekpRYuSNu8i3pBLKQG2r4F
 jAmFyvnolPZaI7pcrhgQNY8ShbsEOCoeUf41S3LjjyBV9AsyvuBL/ohESvIDzzxz1XO1ZHY2p
 +1DbeOI4WXHwTtuBlR5+XOS1v6h6D6HjHig1YdEL1IvAL7Hb4onVpfk1AgaRD+WhclR2ZF0mH
 sZPFstixJXm5WwVOgSTfEVy4fQoZvVIQTVAstJbtFFg7nNZYkU4ZxEiVqCLtDRt2wOEdEJOVF
 peC5Vt2EtABLN6SkGnWJmmIo26QN7iOuVFUtvpqbBoOot0HqUWCfqTg6D2dSLWjlAxusCiH5J
 Q0E4ToUVgfOX8ictrwEugfM7VBvSXW6u/6TRa97HcDNxbfEj/E=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

?On Tue, Apr 5, 2022 at 8:47 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Tue, Apr 5, 2022 at 12:16 AM Dave Chinner <david@fromorbit.com> wrote:
> > So XFS only uses these flags in unsigned int fields that are
> > typed via:
> >
> > typedef unsigned int xfs_buf_flags_t;
> >
> > So on the surface, declaring the flag values as ULONG and then writing
> > them into a UINT field is not a nice thing to be doing.
> >
> > I really don't want to change the xfs_buf_flags_t type to an
> > unsigned long, because that changes the packing of the first
> > cacheline of the struct xfs_buf and the contents of that cacheline
> > are performance critical for the lookup fastpath....
>
> Hence just use "1u << n" instead of "1ul << n"?

Right, that avoids the error as well. I picked '1ul' to match the type of
the variable it's assigned to, but as Dave said the intended type is
'u32', so '1u' is better here.

> > Looking at __print_flags, the internal array type declaration is:
> >
> > struct trace_print_flags {
> >         unsigned long           mask;
> >         const char              *name;
> > };
> >
> > and that's the source of the problem.  I notice __print_flags_u64()
> > exists, but __print_flags_u32() does not. Should it?

It's not the source of the error, as there is no signed integer
overflow when assigning an unsigned int to an unsigned long.

It may be helpful to add a __print_flags_u32(), but it's unrelated
to the problem at hand.

       Arnd
