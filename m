Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2B4C6F08
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 15:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbiB1OLr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 09:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232469AbiB1OLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 09:11:44 -0500
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFD853B6F;
        Mon, 28 Feb 2022 06:11:05 -0800 (PST)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-2d07ae0b1c4so109306737b3.11;
        Mon, 28 Feb 2022 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BJxYKTxrS47SVKXfCYqFiI5pez+ixoEGvmsQfyRqf6Q=;
        b=ApEem39GpGOM1/xdtRRJXGdwGh3Ko0fovA8hxdfpMCiLbVhYPtlFAcRJ0hutScp7AQ
         tZnK47q1didc5sRYdtRET0L60cDncH80+btbepYtdh8gFYmI/cOEQ3/CPS5Ri8yzHMJB
         WW/FP5kjMGLVuX/z/WNi7WJp6vWWjmcOFbcm0ki39/URvwVtEaHstIe3HKuzNi+Ra24s
         ieHj6YR4q+e4YdRGON3VEr+520JbaO27y+Ox1T66bODoUnQ8CYP+vgNe6dS6otE4nXuV
         ddOVZjFuRj60l0XsG00J9xCCDc8n+UmLUAZA433dbL1NTb3S6PLmVwlj5g6MsCqjxu3/
         i2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BJxYKTxrS47SVKXfCYqFiI5pez+ixoEGvmsQfyRqf6Q=;
        b=yYqNXGqq9eNjStW0ucvIxxrgoqTuDR9AhQhtyrNv9EdkMNq0rQkvcA6bB7chNZPy7n
         QyBTSmEmuivdpkOuslwZx4riJ0Gk+1XZGUE6LJ6BLxA1B64SETaC8zP353OY0vonNkjS
         1RqakrgCCy0YbJBEPxrH1NUr/T75OcRgu0sqTyIvRE7yf71QTqBFc2t67JRwzOi/TPf8
         KEC5D+thA15kA1DRSbVj+AH79VKgKfrQCXg7i9SAfJF0D+ptQmMHRiq71oi+9Hbd6uVc
         M18BNNMOHGx1wwokbJ/J8mb1WESFQto/cIeDVpjXqCfNJYiKy15Quw3P/nPDtUodo6hf
         AXsA==
X-Gm-Message-State: AOAM533Vt4shsSg1W+4fropoTtZwBvkOfH3ykP4IGmA1tgM/FLcnjdg6
        QV7b90SBuEPXIzS53HEiCD5FNXececp8Rdddvog=
X-Google-Smtp-Source: ABdhPJzvzulBMf956MEeHrsDwjEaCSD+FDeL+xKpBnFEob7eTPxsjcumYfxh0ZQJ6/PUjWp4ZOcdeUrRTOCV+PXzUsw=
X-Received: by 2002:a81:1613:0:b0:2d7:c68f:bf21 with SMTP id
 19-20020a811613000000b002d7c68fbf21mr20663108yww.414.1646057463684; Mon, 28
 Feb 2022 06:11:03 -0800 (PST)
MIME-Version: 1.0
References: <20220227153016.950473-1-pgwipeout@gmail.com> <20220227153016.950473-6-pgwipeout@gmail.com>
 <fdacf3eb-7892-c767-ae85-1672f85684dc@wolfvision.net> <CAMdYzYoEEY6-kGVDeWj9AoA98BL5hxnc_4CnUPiuStUnSrFXLA@mail.gmail.com>
 <56f8b74d-d9a1-7c6b-67f2-29586956670d@wolfvision.net>
In-Reply-To: <56f8b74d-d9a1-7c6b-67f2-29586956670d@wolfvision.net>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 28 Feb 2022 09:10:52 -0500
Message-ID: <CAMdYzYpiNZ1ofzWmjf-3ew1F3RMHngz_Lo72Nu56AnirZSmRPw@mail.gmail.com>
Subject: Re: [PATCH v3 5/7] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
To:     Michael Riesch <michael.riesch@wolfvision.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Johan Jonker <jbx6244@gmail.com>,
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

On Mon, Feb 28, 2022 at 8:37 AM Michael Riesch
<michael.riesch@wolfvision.net> wrote:
>
> Hi Peter,
>
> On 2/28/22 1:57 PM, Peter Geis wrote:
> > [...]
> >>> +
> >>> +&usb_host0_xhci {
> >>> +     phys = <&usb2phy0_otg>;
> >>> +     phy-names = "usb2-phy";
> >>> +     extcon = <&usb2phy0>;
> >>
> >> I wonder what the correct place for this extcon property is. You defined
> >> it on SoC (RK3566) level, in my patch for the RK3568 EVB1 it is added on
> >> board level. Is this common to all RK356x variants?
> >
> > Yes, the usb2phy is always available as an extcon unless you make a
> > device that doesn't have usb2 capability.
> > In that case you'd have to override the device anyways.
> > If we want to turn on default role otg here, we'd need this defined
> > here as well or things break.
>
> OK, so it seems to me that the extcon could or should enter the
> rk356x.dtsi (and can be removed from the rk3566.dtsi and the
> rk3568-evb1-v10.dts in this series). Is that correct?

Apologies it seems I just missed this.
Yes, this could get moved to the base dtsi.
I'd prefer to do it as part of the next series supporting otg, as I've
only been doing OTG development on the rk3566 and would prefer it be
fully tested.
However if Johan prefers I can send another revision accomplishing this now.

>
> Best regards,
> Michael
>
> > [...]
