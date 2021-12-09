Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C578946F710
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233923AbhLIWyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbhLIWyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:54:11 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24B03C0617A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 14:50:37 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id p23so8482043iod.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5ZRTQ7ooDwQfy9oZzqo/a73+qfonk8DtEs8N0Hj+xpQ=;
        b=IfQw828Gqg7Q/QWyzsyal4ehf1T+TN1ceMlijrcYOhf+6xYqnwQr/h17IkRy/UdzkJ
         pMZjTcvxss568kEP5fNMBEWMjVT7q7tjVocOc3fZNhq1F59gCtz3zs7Igh4rWNH9j3cX
         aUFb1PNEfIRjmbkHE2pvSn6IOgatp1argEpZY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5ZRTQ7ooDwQfy9oZzqo/a73+qfonk8DtEs8N0Hj+xpQ=;
        b=Jh2wSbeXCB6EfW/ocZx7emKXDOEbvuqe/XVQDILwrhrfxPCE3/N1llp8jPs22fI+2A
         FukqKUNYOCiDveymZ5eMKiNucRp87LKlhDDmOvjjWqqqivNUy0W+DEP2XIPQihx6SFq5
         OnJMkbIHCGnI0IGE01mF+DjaOad5Va4foK4JJMvT6bElC97f5GR4kV+mQ57LL+4wbHFu
         +CkMjW+OuaN6f2wjx6CtBmzNHEY+mY0CHGlO7OX3BIgfYSvlX3FJ2xYcHUEYN9A2+/HA
         aTuebu2FCcvq7Ugp1MwVeOqymwy8EnBQmJTLPI2BHeKT3pMHDSTBipICCoxktuIYE0rU
         ezIw==
X-Gm-Message-State: AOAM533fJPU0MbKf2E7EjQhpeoCkYS+kDaLtFZ0vdRsKLeBCFornit8P
        SSuX4viKW3PYpl+4H3OYF41acMpB/zsgOA==
X-Google-Smtp-Source: ABdhPJzhPraOXcfv5pYnlHXK4/OoDKG/bqPUcOpMpiYYjN4c6B8jLdsddf/P+zcPXRpKJ4vsTL+KKA==
X-Received: by 2002:a05:6638:24c6:: with SMTP id y6mr14096257jat.98.1639090236139;
        Thu, 09 Dec 2021 14:50:36 -0800 (PST)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com. [209.85.166.53])
        by smtp.gmail.com with ESMTPSA id w2sm868574ilv.31.2021.12.09.14.50.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 14:50:35 -0800 (PST)
Received: by mail-io1-f53.google.com with SMTP id c3so8489543iob.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 14:50:35 -0800 (PST)
X-Received: by 2002:a05:6602:26d3:: with SMTP id g19mr16449520ioo.100.1639090234684;
 Thu, 09 Dec 2021 14:50:34 -0800 (PST)
MIME-Version: 1.0
References: <20211209195112.366176-1-pmalani@chromium.org>
In-Reply-To: <20211209195112.366176-1-pmalani@chromium.org>
From:   Alexandru M Stan <amstan@chromium.org>
Date:   Thu, 9 Dec 2021 14:49:57 -0800
X-Gmail-Original-Message-ID: <CAHNYxRxKzxxx2qTjvNGXc=L6Mx3J777P=H8uJEtbuUHfrNW4mg@mail.gmail.com>
Message-ID: <CAHNYxRxKzxxx2qTjvNGXc=L6Mx3J777P=H8uJEtbuUHfrNW4mg@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: dts: mt8183: kukui: Add Type C node
To:     Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 11:51 AM Prashant Malani <pmalani@chromium.org> wrote:
>
> Add a node describing the USB Type C connector, in order to utilize the
> Chromium OS USB Type-C driver that enumerates Type-C ports and connected
> cables/peripherals and makes them visible to userspace.
>
> Cc: Alexandru M Stan <amstan@chromium.org>
> Cc: Benson Leung <bleung@chromium.org>
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>
> Changes in v2:
> - Alexandru mentioned that HW specs suggest preferred power role for
>   devices like kukui to be sink, so changed try-power-role to "sink".
>
>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> index 94c13c459194..0f9480f91261 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> @@ -886,6 +886,20 @@ usbc_extcon: extcon0 {
>                 cbas {
>                         compatible = "google,cros-cbas";
>                 };
> +
> +               typec {
> +                       compatible = "google,cros-ec-typec";
> +                       #address-cells = <1>;
> +                       #size-cells = <0>;
> +
> +                       usb_c0: connector@0 {
> +                               compatible = "usb-c-connector";
> +                               reg = <0>;
> +                               power-role = "dual";
> +                               data-role = "host";
> +                               try-power-role = "sink";
> +                       };
> +               };
>         };
>  };
>
> --
> 2.34.1.173.g76aa8bc2d0-goog
>

Thanks!

Reviewed-by: Alexandru M Stan <amstan@chromium.org>
