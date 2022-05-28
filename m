Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2D9536E84
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 23:10:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiE1VJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 17:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbiE1VJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 17:09:19 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08BADDC23E
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:09:13 -0700 (PDT)
Received: from mail-yb1-f179.google.com ([209.85.219.179]) by
 mrelayeu.kundenserver.de (mreue109 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M1HmG-1nwhJN46XK-002qij for <linux-kernel@vger.kernel.org>; Sat, 28 May
 2022 23:09:12 +0200
Received: by mail-yb1-f179.google.com with SMTP id f34so243502ybj.6
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 14:09:11 -0700 (PDT)
X-Gm-Message-State: AOAM531pk2Zul7NBOdAWRsUvkg/DrFImupst5RWbG54btPWLFSqHk/KE
        ihEA0o1JHSyvDOoVcHdD2p0u5t/I6WbsCPJ22fk=
X-Google-Smtp-Source: ABdhPJzYWcxVMSVO35SjnuTA/wM3uXbL0KS/JIGSkpi4QT9U3HrCaqV40mr9DwdV/Jk6nh6hQeh9t/VVFkm1NyZMo88=
X-Received: by 2002:a25:db8a:0:b0:65c:b04a:f612 with SMTP id
 g132-20020a25db8a000000b0065cb04af612mr2641390ybf.106.1653772150854; Sat, 28
 May 2022 14:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
 <YpIR67FMtTGCwARZ@debian> <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
 <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com>
 <CAK8P3a0-QyOQiieEvM0yQb43XbCtPmeao8UvoAsdFnjCxYPz7Q@mail.gmail.com> <CAHk-=whfmwzjF4eBPYS6pHFqHVzJF3m=2h=gRWSRyHks8V=ABA@mail.gmail.com>
In-Reply-To: <CAHk-=whfmwzjF4eBPYS6pHFqHVzJF3m=2h=gRWSRyHks8V=ABA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 28 May 2022 23:08:54 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2DRBrDmfhz2GbMOqNBufNKS7K7XyeE1Px3AhqAuSZD4A@mail.gmail.com>
Message-ID: <CAK8P3a2DRBrDmfhz2GbMOqNBufNKS7K7XyeE1Px3AhqAuSZD4A@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Jani Nikula <jani.nikula@intel.com>,
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
X-Provags-ID: V03:K1:LIXoI/tffUZbQoiOmHLO2DPSVcCUQYDnvIRnB/9lzZfeK4GvTKb
 zY9XTydRF64x4Dim+fm/Hu49TLxxAWJAJ/GihRPh87zUXZztIFWcrr1M65chSCBCyPYVMwE
 IoxcOxDOL2Bz5nsBzO1pIQdCEm4dMzDMTINpxLfe//QRfDgL7rDiAYGUYhL0r/9Z5RTDoKP
 SKDSLteSCcuHgtgHeK6Nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:cmAGbJWAj6Y=:s/Y43WCfHdabfHghVA7zP1
 M2DrcO7qLLvvxPk9GScr3xjgMqbG8zaYb8BG36k5iU6VCL+VXRpwumDHJzZlg8zNxX1+qwtDG
 HqbTgiIOuOwMQHPUXgH009OdawdG9h6VBpsfXwv76xG1mhjsvwrLP2JR9/2EdqZHL3v9qmsfJ
 VOyRwD8k9gFmty8UCIq7c8RoH8cL+UHsg3xhv2BAm02flSfiGfdDU/PisiiypssI88v9LbhCQ
 15EbbMp99R/5Ty4fHHk5gJgnlBRxtRgJ0I/iNbE0dCQMQZnrhyhnbz1wxJx7Q5uvc3K2e7gbF
 TK5rVjxMgNP7CrOfgP5uya3rBJj5rcSc3nfqNmqIg1t2Y4PJHuuvCGFbdxh6JVHIXNmS2A4BG
 wjj/7mMcFNtKG+IzwYCnEiuJM9QHPUtUmvU6YHCdwEBK+DFoRQBpQuH8AHemLdZvBS3wU0yMU
 rJdc1HWS95WvPNCMsz744FpNNVxiVejJ1bk34FlK2Gcr+56DHFc1aIVd06ZFcXLYGT3yTpaix
 6e7ONoQQzueUx9lYG1zwJKuc8HqbtAxdvjDPAW/BUnrjQcjkZerOGENfbN8quB5qGhUAZAkwg
 NsdK7pNMk9NXX5LXGwW4K1+blT6YXw7Y0y/IpMfG6YeAvN/FWhgNhHpwrrRa/dxn0ESxewIsj
 4HyoFymlF7tOfoX0tb5LR3hJu9ONX6EU/I06r+9P7rHPOBJpTopTbLuk1iCQqFj4Xtg/Kf7QQ
 xeLHKptxmSk5+hXwOVzoHkhJYOvVZBrdgJ1wvQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 10:31 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Sat, May 28, 2022 at 11:59 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > It's CONFIG_ARM_AEABI, which is normally set everywhere. Without this
> > option, you the kernel is built for the old 'OABI' that forces all non-packed
> > struct members to be at least 16-bit aligned.
>
> Looks like forced word (32 bit) alignment to me.

Ah, of course, I keep mixing it up with the odd structure alignment of m68k,
which does the opposite and aligns struct members to no more than 16 bits.

        Arnd
