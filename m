Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74961547500
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:54:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233549AbiFKNyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbiFKNxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:53:54 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299643FBEA;
        Sat, 11 Jun 2022 06:53:53 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id u99so2987851ybi.11;
        Sat, 11 Jun 2022 06:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XBD4QmluSTtyUUhL2fAA/t1LEvKNRF+9JYNqJ8wiI8=;
        b=j7JU1GcRirXqAqhBo6OeURWiAC3D74b53mGfYrSAzXlaIm3zFbgt1F6+o01xvhyXZ1
         C94ZDbBD0jmHdorQ8P9msuQBesAMwvJ21VoS1OMbd3SGH4Sk1ro5pfSmNOwXJl2B6VC/
         peAifHJDHYiB8K1SPWFGJcworCOPsk5ScLudTy4b/gNRG1otBPKX0Wdk49XLT6LhVXLX
         iQgVX0rwqMMYu3Qr6H+DmLmjcFunDj0f5xOWF7QNmFm0ngDYd0H6j/JCZbqUXseuT1fJ
         ekwdD76N833+cNm6z8qZTqCPCTjKJUsV4LrRf0ATrP9/fKXTblDxnHnjiXNnayKDB9Gl
         +kAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XBD4QmluSTtyUUhL2fAA/t1LEvKNRF+9JYNqJ8wiI8=;
        b=Yz7mQYlegwziBOZTE/11fKvTB8UvVFXkmNJHSc8pIfRiRsX6NE6ZbQyqg5hFjQlaIf
         idmHOD3DvSdq4flSqe26s80E+CVqdqXE9kzrQiQTDjOXb30pajyAKL9tI8MTvQW5f3jE
         zw1UmgiXsqCHaa+eUZ8CGGarhPWfj2e95qlVFaH5kmNkfYYaNd/FkjB3R8P91bz114a4
         LqRcvUgs3T/Dx40QtLyW76g698gFGntgnQ0fADY1ghPGuWz5Igtgmc8Q2BiDnAanDRsy
         IYgzdIqmm4zlysZQJld1ruqD3j8O/VNCN8aMw8x3cn3R/HGq8w+7OGR5O0yMW68jlwpZ
         kwiA==
X-Gm-Message-State: AOAM532VXCiN7H736sCqVIQAVnOZBafl/60gzT8PzzAoWw501m2sVL58
        5ICsIScZv7R70C6GSTjucbHfYWAQQh2+tkJ0EGY=
X-Google-Smtp-Source: ABdhPJy6keycdZ2r43RjmcTwfJS0G4z+XhBO91RI5+nLiwpkdMfl+es9fjkSmAYV7Tv7HFAfPn6RP3634VPHNg2Kg/8=
X-Received: by 2002:a25:b29d:0:b0:664:49bb:6a60 with SMTP id
 k29-20020a25b29d000000b0066449bb6a60mr11334808ybj.173.1654955632361; Sat, 11
 Jun 2022 06:53:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220610132601.160088-1-pgwipeout@gmail.com> <CAMdYzYqJ2S8K2NCH1uQ2xDjTfLmePPv5TzgeXZa0EG6XdGQzBQ@mail.gmail.com>
 <4178848.3VsfAaAtOV@phil>
In-Reply-To: <4178848.3VsfAaAtOV@phil>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Sat, 11 Jun 2022 09:53:41 -0400
Message-ID: <CAMdYzYqRcrawKc-GsTgwnPuJBJoKTn9Arfpj_Vjnt+3DeT7k9w@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Fix SoQuartz CM4IO usb
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree <devicetree@vger.kernel.org>,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
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

On Sat, Jun 11, 2022 at 9:50 AM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Freitag, 10. Juni 2022, 16:44:23 CEST schrieb Peter Geis:
> > On Fri, Jun 10, 2022 at 9:26 AM Peter Geis <pgwipeout@gmail.com> wrote:
> > >
> > > The SoQuartz CM4-IO should support otg mode, however it currently
> > > defaults to device mode when otg is enabled. Force it to host mode to
> > > retain the previous behavior.
> >
> > It would seem the role-switch issue is more widespread than originally
> > thought, affecting other boards where automatic control should work.
> > Please hold this patch while I investigate further.
>
> ok!
>
> I guess this also applies to
>         "arm64: dts: rockchip: Fix Quartz64-A dwc3 otg port behavior"?

No, on Quartz64 Model A it can't work, the requisite pin isn't connected.
I think I've found the problem, I've requested a few people to test a fix.
Do you have a Model B or SoQuartz to test against (or any other rk356x
board that has the id pin hooked up)?

Thanks,
Peter

>
>
> Heiko
>
>
> > >
> > > Fixes: bc405bb3eeee ("arm64: dts: rockchip: enable otg/drd operation of usb_host0_xhci in rk356x")
> > >
> > > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > > ---
> > >  arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > > index e00568a6be5c..56764fae9f9d 100644
> > > --- a/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > > +++ b/arch/arm64/boot/dts/rockchip/rk3566-soquartz-cm4.dts
> > > @@ -169,6 +169,7 @@ &usb2phy0_otg {
> > >  };
> > >
> > >  &usb_host0_xhci {
> > > +       dr_mode = "host";
> > >         status = "okay";
> > >  };
> > >
> > > --
> > > 2.25.1
> > >
> >
>
>
>
>
