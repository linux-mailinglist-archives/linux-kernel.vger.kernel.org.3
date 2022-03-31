Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC1EC4ED34B
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 07:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbiCaFhV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 01:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiCaFhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 01:37:17 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1781C13A1F8;
        Wed, 30 Mar 2022 22:35:29 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id t7so20565910qta.10;
        Wed, 30 Mar 2022 22:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FRwyhCfFURBcXBoHw/XPGOMafg7GfcP+PVhu/Z1q1Wc=;
        b=h7zuOYeL1xlzDSg/Dz9LLtGzsTkAV8ZhfdG2hlkY8DR9IR5/Cf8Cp6Rr6kGS4B70/z
         pEn6jkHLyHrIhWcg89KwLitabqR04yS0kFAUxsLIbXC9FU3xk2/ohlrxg++YbUaLiFKw
         R2Ts3e5t60p0t4zZN0HprcfVl+gjtSq4mJSv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FRwyhCfFURBcXBoHw/XPGOMafg7GfcP+PVhu/Z1q1Wc=;
        b=BIQQGQ+GAXlMhzuf85tCwsnQPV+L0Q73T2eVaQrbPqGZ1TXwAwfeei80CmHe1iSjtc
         HvXt2LO+a9BWkETPf3p2Cm5wWYp9xNOH97IL/4M1e9bIELtXdzB6trXodiMMdyrAD37v
         6A1LEGwGDTHYEdVoSmcNLCU6K97B6TZAz6gujnTJoYHNSDodKF+ee3qUfU6ocia6Qm9E
         3Vo0G5yCfJnWRT1Ang6VohRHC/xMadIFlAs4cRxIhkatHeWPYTlpoRjwjEdH0BLxGabN
         60aMa0wleTc77NjpSyOc2y397/MX0rT0W8YypVqP/hJfzUSerSUoezzJLujBNB+Vr65u
         JtlQ==
X-Gm-Message-State: AOAM532Rgsyj5ILNBRchNAP8FvauoxOViJgvF3ABovIdJYQ99rSfbGqR
        53EzkESypoiE4UhOfJOdVmzKa1szgg3PMArLidfgrpKgYS4=
X-Google-Smtp-Source: ABdhPJx3x9+Ty7fxA/kSw7b2BKr5dhZh18sbQ5KgYAsbTW/db0vNpiEu2Yno6yrZ9TmFayNUNAEDO1hCS0geM0u/hJY=
X-Received: by 2002:a05:622a:285:b0:2e1:dcda:98fd with SMTP id
 z5-20020a05622a028500b002e1dcda98fdmr2825408qtw.625.1648704928211; Wed, 30
 Mar 2022 22:35:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220331022425.28606-1-zev@bewilderbeest.net>
In-Reply-To: <20220331022425.28606-1-zev@bewilderbeest.net>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 31 Mar 2022 05:35:16 +0000
Message-ID: <CACPK8Xfg1xV6Cwb2qhu3A7-Ladj6htr45s8ZFqwApTFj4Ab2tQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: dts: aspeed: romed8hm3: Add lm25066 sense
 resistor values
To:     Zev Weiss <zev@bewilderbeest.net>
Cc:     OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Mar 2022 at 02:24, Zev Weiss <zev@bewilderbeest.net> wrote:
>
> With this property set the sensor readings from these devices can now
> be calibrated properly.
>
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>

I guess:

Fixes: a9a3d60b937a ("ARM: dts: aspeed: Add ASRock ROMED8HM3 BMC")

Reviewed-by: Joel Stanley <joel@jms.id.au>

I'll send some fixes in after -rc1.

> ---
>  arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> index e71ccfd1df63..572a43e57cac 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-asrock-romed8hm3.dts
> @@ -100,12 +100,14 @@ w83773g@4c {
>         lm25066@40 {
>                 compatible = "lm25066";
>                 reg = <0x40>;
> +               shunt-resistor-micro-ohms = <1000>;
>         };
>
>         /* 12VSB PMIC */
>         lm25066@41 {
>                 compatible = "lm25066";
>                 reg = <0x41>;
> +               shunt-resistor-micro-ohms = <10000>;
>         };
>  };
>
> --
> 2.35.1
>
