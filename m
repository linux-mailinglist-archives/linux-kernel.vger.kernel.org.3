Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3374DD08E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:11:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiCQWMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiCQWM2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:12:28 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5128208C0B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:11:10 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id w127so7073220oig.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 15:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=5sPT62vwExhazgUCk/ivYsHioDzqGF10V9LYvzVa3Zw=;
        b=hEIaRhfxsaH2BSnOS6Jd9blZjhiC78egRPVelVSESldWtQ7hMwdSOLFL+qJAmunFRz
         g6vAxAkx62JONDuZd5KNmjrx2sf/hqIp4d1vzgeXSu25cS0qnUsGLk95VeIYdihdHj7/
         iLX1Qg77OfgCKLzLiwghGwICQyQeX1NI4qS1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=5sPT62vwExhazgUCk/ivYsHioDzqGF10V9LYvzVa3Zw=;
        b=srQWkXDoU3pQiZx8AYQYYJOFkRLcwuoyXYJlEHoHlVpLTkFVl0PrAMv80Mf3k+eY/t
         HB78yUzP1unkNH6OUm3ph/aUSeO6kh4Ok/h/0xGKwQ+vtDWghpcHTOVYgOclwbFUi3mg
         n5y4JZMxv7H7gNgKVbZHKrqur9IQow1RXUl0GRyucCdl3qAMkUwGaz8MEpmrSOn8z2lD
         gAmrRM5qecI/I4Cl5le9zKAoI81LtFNiqZIUC3cKlfISGoMFqlzIGs2+04Jpya1Z3MTc
         qBf8vvUyad4GY5z4OvYvYB+cHHTRa1pFrXK80k3WNtpfvH/NhIXuTb340fUd8pRmfBgr
         U5lA==
X-Gm-Message-State: AOAM531hR39n6zLP67zNQiAcxNqTgRXoO72tLrmFfkWKUyPZWAyOZ5Iq
        QoEtcpO9Y9N7cWoYQzR26/p0CGemBs/Bvn/wrESy9Hu+FVI=
X-Google-Smtp-Source: ABdhPJxbAIVAAfgMdMazm+UU2csmK/iUmwnr70F020DMBUri0c4Gholvxy5YPUe1OKnnAn7+vhqhxjsC6P5l44arwWc=
X-Received: by 2002:aca:a9c8:0:b0:2da:45b6:b796 with SMTP id
 s191-20020acaa9c8000000b002da45b6b796mr2908341oie.193.1647555070091; Thu, 17
 Mar 2022 15:11:10 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Mar 2022 18:11:09 -0400
MIME-Version: 1.0
In-Reply-To: <YjOw7sutyNWnbdRU@google.com>
References: <20220317010640.2498502-1-swboyd@chromium.org> <20220317010640.2498502-3-swboyd@chromium.org>
 <YjOw7sutyNWnbdRU@google.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 17 Mar 2022 18:11:09 -0400
Message-ID: <CAE-0n50vwqj=0qTZm2digndZ69fWbczox+2NyDHYTW__SDF23A@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: Fully describe fingerprint node on Herobrine
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Alexandru M Stan <amstan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Matthias Kaehlcke (2022-03-17 15:06:38)
> On Wed, Mar 16, 2022 at 06:06:40PM -0700, Stephen Boyd wrote:
> > Update the fingerprint node on Herobrine to match the fingerprint DT
> > binding. This will allow us to drive the reset and boot gpios from the
> > driver when it is re-attached after flashing. We'll also be able to boot
> > the fingerprint processor if the BIOS isn't doing it for us.
> >
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Cc: Matthias Kaehlcke <mka@chromium.org>
> > Cc: Alexandru M Stan <amstan@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >
> > Depends on https://lore.kernel.org/r/20220317005814.2496302-1-swboyd@chromium.org
> >
> >  arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > index 984a7faf0888..282dda78ba3f 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine.dtsi
> > @@ -396,13 +396,16 @@ ap_spi_fp: &spi9 {
> >       cs-gpios = <&tlmm 39 GPIO_ACTIVE_LOW>;
> >
> >       cros_ec_fp: ec@0 {
> > -             compatible = "google,cros-ec-spi";
> > +             compatible = "google,cros-ec-fp";
> >               reg = <0>;
> >               interrupt-parent = <&tlmm>;
> >               interrupts = <61 IRQ_TYPE_LEVEL_LOW>;
> >               pinctrl-names = "default";
> >               pinctrl-0 = <&fp_to_ap_irq_l>, <&fp_rst_l>, <&fpmcu_boot0>;
> > +             boot0-gpios = <&tlmm 68 GPIO_ACTIVE_HIGH>;
> > +             reset-gpios = <&tlmm 78 GPIO_ACTIVE_LOW>;
> >               spi-max-frequency = <3000000>;
> > +             vdd-supply = <&pp3300_fp_mcu>;
>
> IIUC userspace controls this regulator. Do you add it just for completeness
> even though the kernel doesn't use it?
>

Yes. Maybe in the future the kernel can use it by keeping the driver
bound and manually controlling the power supply during flashing. In
theory we could then power it down during suspend or when it isn't in
use too as long as we can hide the multi-second power up time.
