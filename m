Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47188537ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 14:44:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbiE3MoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 08:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229841AbiE3MoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 08:44:06 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BC45D5FB
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:44:05 -0700 (PDT)
Received: from mail-yb1-f173.google.com ([209.85.219.173]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N6szR-1nkFkC1A3b-018IoF for <linux-kernel@vger.kernel.org>; Mon, 30 May
 2022 14:44:03 +0200
Received: by mail-yb1-f173.google.com with SMTP id v22so283901ybd.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 05:44:03 -0700 (PDT)
X-Gm-Message-State: AOAM5322+2JrGPL5XXW1zGKCfv8gP/EAoBGBoP5CIJQvMdiK91yGy+qQ
        WmbeBOfY9jflDoUm/BtiXsX5Ld4NZD86aWzIgNM=
X-Google-Smtp-Source: ABdhPJwGhDH7TTQEFtfKClpkV8v6MgE6/PlkkdchHiAR2sctlXWrlvyx8XgWbwbNazMHWQ8TgK10FAziIIsvzr+V4hc=
X-Received: by 2002:a25:9b89:0:b0:655:8454:dc92 with SMTP id
 v9-20020a259b89000000b006558454dc92mr25317431ybo.550.1653914642134; Mon, 30
 May 2022 05:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
 <YpIR67FMtTGCwARZ@debian> <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
 <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com>
 <CAK8P3a0-QyOQiieEvM0yQb43XbCtPmeao8UvoAsdFnjCxYPz7Q@mail.gmail.com>
 <CAHk-=whfmwzjF4eBPYS6pHFqHVzJF3m=2h=gRWSRyHks8V=ABA@mail.gmail.com>
 <87a6aztli2.fsf@intel.com> <877d63tleq.fsf@intel.com>
In-Reply-To: <877d63tleq.fsf@intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 30 May 2022 14:43:45 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0-S77QLR1dK3NT6ot7JTAD5AdojAZJr-Xi112-v5EOdw@mail.gmail.com>
Message-ID: <CAK8P3a0-S77QLR1dK3NT6ot7JTAD5AdojAZJr-Xi112-v5EOdw@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Jani Nikula <jani.nikula@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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
X-Provags-ID: V03:K1:ROt8HJLr1bE6X42SfpL5/xLh4A/NdA+fxKeNyLU6TSSMS/8JuOi
 4GyPlPLjZPA6q1wvmIxBulw4MZAQvRCrPlhQyC/ftHpdiNZBGQ7bX6gVAbbqbA5BpkFh0rV
 r/0ZS/++RDeDaxhi3VlbVElIiedKfx1x8ErTbrrLDKKRxOcjagF/Psn5V+vNi60z6yWe4pw
 ooYw7pNS7soOh8n8LMH4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bajO18H2TA4=:Cyg5l/rkTdnFK5DVgYeops
 BidFMsiwufVv1I89DYTktK8jDRBBEDkNQSiy0EMS0gvcs2KWFKA84D+r1yJcImJUL2kYPCsc3
 43hmQoR5vf4TAgdUeE/6DHlRNQmccJZtGKY22BMVp5zhuIeCIIwTmMbYSU+6nQtaVnwiJEg37
 B0DJXg5hmLMjWgc6T0BUwzpq7QQ0YnFfxOB0LmybDu3LtzeoY236hOrrP+PJCg7vl2OlZZGGB
 VxBdf6XTSb92ImYi72Yp3c9vzNOxIx1ULZlxQyK/d2HvMhCuk7mCUYuby82At+zh891E61+fN
 QbZkVufY/Sj+3PleAAdDYtjuYjVbeUo77r/koKSQ2leekjbRUqLBOA0XbqA5VpWgFDJmlvvko
 2WiTXhYHQZVcM0FZfOzG5QB8ADsuUBYdRIhNZJHCR+e9oEOKa0NqwEGfB5fpCFC858a6xVmPt
 VoD4F+BoM1S6b+IQPX9UxVtj1ZQfwFbOW2q+yaoDuTrv4wEX7iyNnXJGa0p1UGjaBytSD/A6l
 VIClFJuLhmR0mncYxCoZl8ZaU5tJp90oX07FBo+FX3Ea/sheNtV5acOqIcoGVCE9yCmVbkyDF
 DW8Kmkcp1cYYNUztGqqHBB5mErCA4bDSD4rfeQYv6UQVpSMgSkGj3T2EHpL3Ak0ecaHNC18tV
 j9LRrrr/G0GTyYyv3xoJj4fByYb7S75cahSS55M6+Dwm28BdbusQDXFUxWn4MOZR6jQSnSoIO
 AClkme2w7VLUZqUA9Q7+lg0/esD4k9E1sUBiWQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 11:33 AM Jani Nikula <jani.nikula@intel.com> wrote:
>
> That is, for EDID. Makes you wonder about all the other packed structs
> with enum members across the kernel.

It is not the 'enum' that is special here, it's the 'union' having
unpacked members,
and the same thing happens when you have nested structs: both the inner
and the outer aggregate need to be packed, either with __packed at the
end, or on each individual member that is not fully aligned to
max(sizeof(member), 4)).

I think in general, most __packed annotations we have in the kernel are
completely pointless because they do not change the structure layout on
any architecture but instead just make member access slower on
architectures that lack unaligned load/store instructions. There have
definitely been other cases though where a __packed annotation is
not needed on any sane architecture but is needed for OABI ARM.

Overall I'm not that worried because the only machines running OABI
kernels would be on really old hardware that runs a limited set of
driver code.

A completely different matter are the extraneous __packed annotations
that lead to possible problems when accessed through a misaligned
pointer. We ignore -Waddress-of-packed-member and -Wcast-align
in the kernel, so these never get caught at build time, but we have
seen bugs from gcc making incorrect assumptions about alignment
even on architectures that have unaligned load/store instructions.

      Arnd
