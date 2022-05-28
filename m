Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0FF6536E45
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 22:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiE1T6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 May 2022 15:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiE1T5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 May 2022 15:57:34 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67246E8EA
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 12:52:53 -0700 (PDT)
Received: from mail-yb1-f171.google.com ([209.85.219.171]) by
 mrelayeu.kundenserver.de (mreue009 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjSHa-1nWOMB1H1m-00l0ia for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022
 20:59:17 +0200
Received: by mail-yb1-f171.google.com with SMTP id t31so94485ybi.2
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 11:59:17 -0700 (PDT)
X-Gm-Message-State: AOAM532IoTIdL3YlAAY1mtcpbUA14sUNP/sr0uPCYWjYk4jB2GvplQID
        pp8OvBk2/pAutwtJOSVnJOVdU410Ut/7FnWJcyk=
X-Google-Smtp-Source: ABdhPJx2zeBqlc7izpQrrVjwF/YZ2kHUCwcBggRscS5P/bQsa9aebzHk1lh9EW0TvmxFzizAFsLT6XOMLriNEeOtaNI=
X-Received: by 2002:a25:31c2:0:b0:641:660f:230f with SMTP id
 x185-20020a2531c2000000b00641660f230fmr45525900ybx.472.1653764356125; Sat, 28
 May 2022 11:59:16 -0700 (PDT)
MIME-Version: 1.0
References: <YpCUzStDnSgQLNFN@debian> <CAHk-=wg0uGAX5DYZq+tY2KeUAR8DtR91YE1y9CkPMKkKOyE4jg@mail.gmail.com>
 <CADVatmNGPbSdRNQuwJEWAaPtqb3vBYRjvsuBpoRUnhEHj=X5GQ@mail.gmail.com>
 <CAHk-=wisQd8yiPX=SsK3eFiakKo713hq4SyqPWsJ-oyAmLFefQ@mail.gmail.com>
 <YpIR67FMtTGCwARZ@debian> <CAHk-=wjuyHE=1wLgHncub8FfgeyYqfWYsy4-YrhAvq9991h_Aw@mail.gmail.com>
 <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com>
In-Reply-To: <CAHk-=wi_hJV0V=Ecg2dzbe2P_H1XKTu6VP_AtCH6u=tis31ayg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Sat, 28 May 2022 20:58:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0-QyOQiieEvM0yQb43XbCtPmeao8UvoAsdFnjCxYPz7Q@mail.gmail.com>
Message-ID: <CAK8P3a0-QyOQiieEvM0yQb43XbCtPmeao8UvoAsdFnjCxYPz7Q@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
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
X-Provags-ID: V03:K1:pbdqMni1F9Kr/uNwxwNJiCYYSwnLZV1r56Wx6kglSoKJZkzZGQh
 iFjZsFfDyFpiLTW7bDRhBjN5m1hcUudlhgG3LuPxhCy/MSrbY1o0Vr+GyIVHgm9tdCJLaMK
 tTHl9QvAMLjOAQnkjBwN3jxGrVt6KN+V4VOQrgpoZ+D1ObI0Od6LoOerNeFVV0wlKDT0hj6
 nJoJjAJXopsiauY1fHb9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:99IyJvM+nWE=:apWjuN/3MWqRxPPqa22Ef0
 awyRx/MVtV4BqXWWwWlIW+UC0ur1ZegNScLExKALbMVaoJbKquF8e+wU6igK2jy3zo0IlGAPP
 qsdScwsAbKOUppSEyTyVVUjm4X0BvJt0MUoZZsXEdlVSJUWZBsFkO9d6PJ9NzEqg4gCqbLt+b
 ZryuiA5+gCFqL94xWno9yLkHSzd7IEU79R8gh6ss7RVa4Xyv6JsWbKdNRbIJQ59lhyyP7JVEK
 HsrKJpI3tsc2maYAXrLKj7153FXOJGaWadcx+a4edrd+zLBqZma7Us/UkgWlLb3WvvAwE3H+h
 lrO9jFvME2A8X8Uac0wGjMj6NVdEsOmfgo5u27uKlW7GIlCuhbNkG1xtr+Vq70mjFDLCQJO95
 YGiSwcBRvsqVkZT1Q0OK07RnyLur/+W3UYMgKbaqaenHyJaS1qx/WkPlKqGIsLpp8d1m+UVd3
 O8FvXdBMkVNjWl1PbPzBzpl7SWsoybdhD6Y5uBZZo3352iaLf83IWKOMu+wkPkCT3HWfhl3u+
 rLonqNNJptFC7yg0+rBloKtlt1Z3OIzF3YMgPp7cP/2SoBFQjV/ScCBVCSgtuPbW0WjbZMZZ1
 b+GLyzMxBDqluviTUSVh3fuAyYJkSs1u5TOlRt4ozxq9g3AjVMiTvga4XJeZ7RPKDF9RIb6yp
 99T+Uo0Z+sgFck+qjqs1nb5/zX94DL8mew2CjSrKaJAY+zHI4h8gP9ZOwOed+PA91L4KKbnC3
 ukAJsIb971OgCsqUSohmgnKWIUi9wiNVDZ0ZvbqtPLAfF7RWKOe/SxqEzX2oohLgs5RvmtqWp
 Y4DZvmuMgTIkKUg2feYF1DNv4VFW5kGH4jxfOlDxmTxbD/ttywBJoJejRWlWPFDlwB0fSIRGL
 BJt6M4aqqBmzocGvaV1Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 8:08 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Not very much tested, and I have no idea what it is that triggers this
> only on spear3xx_defconfig.
>
> Some ARM ABI issue that is triggered by some very particular ARM
> compiler flag enabled by that config?

It's CONFIG_ARM_AEABI, which is normally set everywhere. Without this
option, you the kernel is built for the old 'OABI' that forces all non-packed
struct members to be at least 16-bit aligned.

I think Russell still uses OABI kernels on his oldest machines, but it is
incompatible with all modern user space and should probably not be
in the defconfig.

Your patch looks like the correct solution to me.

      Arnd
