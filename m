Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558E947CAD4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 02:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhLVBiK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 20:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhLVBiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 20:38:07 -0500
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12392C061574;
        Tue, 21 Dec 2021 17:38:07 -0800 (PST)
Received: by mail-qk1-x72d.google.com with SMTP id b85so896683qkc.1;
        Tue, 21 Dec 2021 17:38:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fJAfK3DqpfiPmHQwaBI/smOBiafG0laxAPbgGyOvQTg=;
        b=NEsC0bwTrII2R5alA3OhKMtCJh6qrGtuahtPqUjey2ycLMqVZjwaz2JNlqDUDv/LSz
         ZQqLPDa9wna5XSVi0/muG0Apl+8GH4q4zGAPrcxoZX9XOmTJRnuCPjYxhATh7kTWXRyf
         gUiVLkVJypdREiMOBk6ZrWff6h4SMV81HMYzg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fJAfK3DqpfiPmHQwaBI/smOBiafG0laxAPbgGyOvQTg=;
        b=prvjwYAz+l+EluCH0U9o08m8r9/UgX9lBYTnTpEesjFz5vl9fX1n/fpPXO1vXkDpnJ
         g+EY9wV/+FQbY13C5uxOrfGf37iOfDPvUFFXXLQCtYPb6OCGog8PnWQO6ilbigy3Tfva
         QQTlb+8pLRBWATPb1yjwjxDxdP2Oi4NxhYN7h6EeC/+TyMdYg3a452I+RmfDP+FDvTu4
         uW1UJ7l3X4HUmR0Q9n4PWPxl9Y4vWgc15XVAj8GrnTl3p88WHUT0I+73IBzqHkzim8O7
         ytpEVPSwdJDE7nyDA4OEVOdG3+z3G3KqDmSTcLXSfiNFf4V3GodFntCfkdbUAruxGq+N
         tHeQ==
X-Gm-Message-State: AOAM532JNu+uFdQUpLQOoINppzZZNcgVL3h+R/bsfzh2ALGsP57HbCfN
        RIzMeLgAUktcFx4+FoRTiqyDSPVWaxpW6FCjtvs=
X-Google-Smtp-Source: ABdhPJxhiavwjj59AhM6tp4D2rXd4oQSL5w/FRsldzbqAWfZsoEC+QgYrJGyQgUTUvGjcxZ9auohlAELtVpy61lkCeg=
X-Received: by 2002:a37:94c2:: with SMTP id w185mr740322qkd.666.1640137086103;
 Tue, 21 Dec 2021 17:38:06 -0800 (PST)
MIME-Version: 1.0
References: <20211210093623.2140640-1-yulei.sh@bytedance.com>
In-Reply-To: <20211210093623.2140640-1-yulei.sh@bytedance.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Dec 2021 01:37:53 +0000
Message-ID: <CACPK8XeK977rY33Kt3-vhEbqa68iXbG6vbRAfRGYxC94tE=t_g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: g220a: Enable secondary flash
To:     Lei YU <yulei.sh@bytedance.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc <openbmc@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lei,

On Fri, 10 Dec 2021 at 09:36, Lei YU <yulei.sh@bytedance.com> wrote:
>
> Enable the secondary flash of the g220a's BMC and the wdt2.
>
> Signed-off-by: Lei YU <yulei.sh@bytedance.com>

I've applied this and the layout patch for v5.17, and to the openbmc tree.

> ---
>  arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
> index 01dace8f5e5f..05f392f42960 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-bytedance-g220a.dts
> @@ -260,6 +260,13 @@ flash@0 {
>                 spi-max-frequency = <50000000>;
>  #include "openbmc-flash-layout-64.dtsi"
>         };
> +       flash@1 {
> +               status = "okay";
> +               label = "alt-bmc";
> +               m25p,fast-read;
> +               spi-max-frequency = <50000000>;
> +#include "openbmc-flash-layout-64-alt.dtsi"
> +       };
>  };
>
>  &spi1 {
> @@ -278,6 +285,10 @@ &adc {
>         status = "okay";
>  };
>
> +&wdt2 {
> +       aspeed,alt-boot;
> +};
> +
>  &gpio {
>         status = "okay";
>         gpio-line-names =
> --
> 2.25.1
>
