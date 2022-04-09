Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C55C34FA760
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:51:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241676AbiDILxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbiDILxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:53:41 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFCE223230;
        Sat,  9 Apr 2022 04:51:34 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-2ebebe631ccso36536777b3.4;
        Sat, 09 Apr 2022 04:51:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GoRxX4Vrj9YFq5GHeUiEKLuo6D44wrLEZyT1dPCGMGM=;
        b=Gua1DoikVWhL7UWY/L90uR4VSNW1l8s4IJJ/KfWDiiKf3rdGwOHbBo/vI4AdEo9r65
         1jFpHNtlZKQhk7lyxHKaH1iyjY621snaa/X6fQuvJumI9cpOvHy8zp/yY6E9K7Y2R8g8
         6wiJvhl0qUFO+G2lmx0mmvQP1D0VHWzwRlCzvsM3zMlVJ2YVlV2WtAc0/ZBFAwwLTV80
         iGIPVEI1oEsdcnwddRj+26+Szmc+nP3LOC2SbPK6AyTELYuw7BxFjILja6/1sqrJ+wuf
         YPj0djPcrOwzkYEt/TTgT87AkBFxqV+IjSBeN1UokVP2KdmBr27nLUPRVML54fRew/2b
         dzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GoRxX4Vrj9YFq5GHeUiEKLuo6D44wrLEZyT1dPCGMGM=;
        b=zLycnvnru1kpXT0eeldEaLcsrveB3Ijts+3SAwCe37JE7y3Sf0zDRPgLMAf0co4YQA
         Jv2t5BGT428ZghP2/nE9TUAjnqMClpEafbKiZ56lwVr7/ShgdxgzcXFYapTgViyJy+vL
         It0t1wYVkK2u8U3mIrga0T9hB+w7JqMoZGO+/2UsmNoPGe1I/ac8G753nFLVdwUnbT4x
         o0l5eKi9hc49KR/kHQyFN7VLQ3ON9AhFxk1thQTCzi7SwPbUszhLL926VBwBz+PpQekM
         tkKy0s35anLuS5GKJBVzWUxsvYqaLP5tsGVnehScI8jNILYXQFCKnmrftfPwlUc1MkNA
         C2fw==
X-Gm-Message-State: AOAM532wzVbohzeW+AdQGrAJpztHxB6vtp9O2V8c1gU5idIjodnaad90
        ZhVgC9h4N9quYO0i2wNe4blj/XKYD9t034HtjWha8u9HnJD7VA==
X-Google-Smtp-Source: ABdhPJyVQMvZtdY5qxy43OXqDQf52S4KZnA4SZgC73OgBLE0iCldD2N1V4m6ukj4oQ8puIw4qoClUYVCs5aFv1Gxe5k=
X-Received: by 2002:a0d:fa01:0:b0:2d6:595d:81d4 with SMTP id
 k1-20020a0dfa01000000b002d6595d81d4mr20126394ywf.86.1649505093452; Sat, 09
 Apr 2022 04:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220409075147.136187-1-linux@fw-web.de> <CAMdYzYqx1iUuEe9FPpUTgL0L2i=Q5Sq2+0oiSYzqkV6noQ8BFw@mail.gmail.com>
 <CAMdYzYqaGe9_GbRCvG3kvLpNsVfVqGNkg=YYgbVR90Qtcs9YSA@mail.gmail.com> <4232341.5fSG56mABF@phil>
In-Reply-To: <4232341.5fSG56mABF@phil>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 9 Apr 2022 07:51:22 -0400
Message-ID: <CAMdYzYqQXnk=8Lc5ZeAPNQd-EGb=N61FM9r+E380mk6=Mvz1Tg@mail.gmail.com>
Subject: Re: Aw: Re: Re: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Dan Johansen <strit@manjaro.org>,
        Frank Wunderlich <frank-w@public-files.de>,
        Frank Wunderlich <linux@fw-web.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 9, 2022 at 7:35 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Samstag, 9. April 2022, 13:30:44 CEST schrieb Peter Geis:
> > On Sat, Apr 9, 2022 at 7:14 AM Peter Geis <pgwipeout@gmail.com> wrote:
> > >
> > > On Sat, Apr 9, 2022 at 7:01 AM Heiko Stuebner <heiko@sntech.de> wrote:
> > > >
> > > > Am Samstag, 9. April 2022, 12:57:39 CEST schrieb Frank Wunderlich:
> > > > > Hi
> > > > > > Gesendet: Samstag, 09. April 2022 um 12:40 Uhr
> > > > > > Von: "Dan Johansen" <strit@manjaro.org>
> > > > >
> > > > > > So the issue is only with usb 3 ports, not usb 2 ports?
> > > > >
> > > > > my board has no standalone usb2-ports. usb2 is integrated into the usb3 ports (dual phy). here both were not working.
> > > > >
> > > > > afaik rk3566 has standalone usb2 ports that may not be broken, but i have no such board for testing.
> > >
> > > Good Morning,
> > >
> > > >
> > > > As far as I understand the issue now after checking the code, this
> > > > patch actually fixes the usb3 series from Peter, right?
> > > >
> > > > I.e. the usb-nodes that are fixed in this patch are not yet present
> > > > in the main rk356x dtsi and only get added in
> > > > "arm64: dts: rockchip: add rk356x dwc3 usb3 nodes" [0]
> > > >
> > > > As we don't want to add broken changes, this fix should squashed
> > > > into a next version of the patch adding the nodes.
> > >
> > > Thank you for reporting this, I will squash this fix in and add your signed-off.
> > >
> > > However the offending patch is in fact the clock separation patch, and
> > > it breaks backwards compatibility with the rk3328 dtsi which is why my
> > > series also is broken.
> > >
> > > The rockchip,dwc3.yaml needs to be fixed to align with the
> > > snps,dwc3.yaml, and both the rk3328 and rk3399 clock names updated.
> > > Also the offending clock separation patch needs a fix to grab the old
> > > clock names for rk3328 backwards compatibility to be retained.
> > >
> > > This might also be a good time to look into moving rk3399 to the core
> > > dwc3 driver?
> > >
> > > This is a delightful mess.
> >
> > In the idea of getting this series to land, if all parties agree, I'll
> > submit a patch that fixes the clock separation patch with this series
> > and leave the naming as is for now.
> > The renaming of clocks and alignment of everything can be addressed in
> > a future series once discussion on how best to handle it has happened.
> >
> > Do you concur with this?
>
> I'm not sure about that ... i.e. adding known-broken changes
> (for the rk356x) feels somewhat wrong to me.

My series as it is complies with the current dt-binding for Rockchip.
It just so happens the dt-binding describes two different devices that
are handled by two different drivers, and the binding itself was
wrong.
This becomes a whole lot more intrusive if we decide to do this now,
and the offending change still needs to be fixed if we want to retain
backwards compatibility with rk3328.dtsi

>
> Heiko
>
>
