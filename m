Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0684FA718
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 13:14:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241552AbiDILQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 07:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241541AbiDILQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 07:16:22 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D9F2DA93;
        Sat,  9 Apr 2022 04:14:15 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2ebf3746f87so25632827b3.6;
        Sat, 09 Apr 2022 04:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPEF53AYfxfAhRCA4CJkt0abN81bbmJ7If+TUSs8zj4=;
        b=FvdOTWPbf4r5PIlRt24bqjz8X02YzQ/CJ2lTyQZ1DM0mHFbLmfz1qC+QZEuua3YABn
         2BbX9NCA205D8BERUlLaZHa8CryFQ9narmtCkZJE6TQD7SqO2eWyU35/HKfGb5l7V7gh
         Czpdr+PeXXuOY+0+IKwuuuqwVw9SOCS9gADLSJ80LWb+EF6t0s/aWCAfk839e8xRPCeg
         hbNrFD4wxTYLTE1sUs8vKOKE6lSMsQRiocfZnO4lkrzqthU3gFAIMJsi/iSIegHTcSgv
         bvRTeMfVLFNLCLy7A7FwZjPqZpqRRfipiVaGET44kwY29FMZ7pPuY6nBr2iggcZVsIqf
         EiYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPEF53AYfxfAhRCA4CJkt0abN81bbmJ7If+TUSs8zj4=;
        b=UN3fQ8oyuPlk1c6BbejIXyrRXT8JpJqpYOQLenpvr+GKPxqM23hln2q6coDTo8wrBA
         4O3Gdwj3JoNbgkmDdcWv3rKWubWQEnXMIpmpSFBKdIjOkSjtMR+6SWa2hum3eyUigDRP
         AslBpp4U0Mabek21D8Y1b2jmQUZGjVoKp6olSNK7fjA2ONGDpq/CSJcjJC6uWHUHtbF7
         R+zF1Coyo5zydsaD6Sx6Te0IxKyOHZM8ccvPpPvMYLTwSurrztRQWJSEanGIaZbLOMTK
         b+SYBjKLvea+AYbOxjJg4s+MOQpj/Q4BhIUy4+FBF893ANF71Lp0Ab0C0TLXATXaaaZg
         ohmQ==
X-Gm-Message-State: AOAM5337+wwHM40GoD5abKIQkNj4oaL0XF7eGXjHkYv7VxEj1SbWa9Qg
        gWTJ+GVd/dIgKo/TlknCnDJsEv6hKRTJxI6XS+njNLz6c9fEoOKW
X-Google-Smtp-Source: ABdhPJx2xWNVGco0UwA3Pvr1pb1iwgQaYcNjp9eBRRGyd/5kNoSfQ2YE8TuZSccongnYDSrSG+TdsKCi2yiinLUcprU=
X-Received: by 2002:a81:5904:0:b0:2eb:f900:882e with SMTP id
 n4-20020a815904000000b002ebf900882emr1628744ywb.281.1649502855066; Sat, 09
 Apr 2022 04:14:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220409075147.136187-1-linux@fw-web.de> <ba60121a-a120-b717-6a2f-7883685d17e6@manjaro.org>
 <trinity-b6d141b2-264a-4a57-9707-6a38a80cea16-1649501859874@3c-app-gmx-bap35> <4559790.iIbC2pHGDl@phil>
In-Reply-To: <4559790.iIbC2pHGDl@phil>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 9 Apr 2022 07:14:04 -0400
Message-ID: <CAMdYzYqx1iUuEe9FPpUTgL0L2i=Q5Sq2+0oiSYzqkV6noQ8BFw@mail.gmail.com>
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

On Sat, Apr 9, 2022 at 7:01 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Samstag, 9. April 2022, 12:57:39 CEST schrieb Frank Wunderlich:
> > Hi
> > > Gesendet: Samstag, 09. April 2022 um 12:40 Uhr
> > > Von: "Dan Johansen" <strit@manjaro.org>
> >
> > > So the issue is only with usb 3 ports, not usb 2 ports?
> >
> > my board has no standalone usb2-ports. usb2 is integrated into the usb3 ports (dual phy). here both were not working.
> >
> > afaik rk3566 has standalone usb2 ports that may not be broken, but i have no such board for testing.

Good Morning,

>
> As far as I understand the issue now after checking the code, this
> patch actually fixes the usb3 series from Peter, right?
>
> I.e. the usb-nodes that are fixed in this patch are not yet present
> in the main rk356x dtsi and only get added in
> "arm64: dts: rockchip: add rk356x dwc3 usb3 nodes" [0]
>
> As we don't want to add broken changes, this fix should squashed
> into a next version of the patch adding the nodes.

Thank you for reporting this, I will squash this fix in and add your signed-off.

However the offending patch is in fact the clock separation patch, and
it breaks backwards compatibility with the rk3328 dtsi which is why my
series also is broken.

The rockchip,dwc3.yaml needs to be fixed to align with the
snps,dwc3.yaml, and both the rk3328 and rk3399 clock names updated.
Also the offending clock separation patch needs a fix to grab the old
clock names for rk3328 backwards compatibility to be retained.

This might also be a good time to look into moving rk3399 to the core
dwc3 driver?

This is a delightful mess.

>
>
> Heiko
>
> [0] https://lore.kernel.org/r/20220408151237.3165046-4-pgwipeout@gmail.com
>
>

Very Respectfully,
Peter Geis
