Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6985B4AD61A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350011AbiBHLWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355475AbiBHJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 04:42:18 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5D6C03FEC1
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 01:42:17 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ka4so50380163ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 01:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cFH5Um3Vk6lWWywUkT3b2cpV2XDFUTcWLb/4zeHC0OA=;
        b=RaKIxYSNPWKV2aZvdO35uoi9j0vmIB/E4cIlt2SxPD8bymbg7JKOjOh2KAfqpvDZgQ
         Hz3hpgX8DMh2Md0X6E4YT9ajtruTCUkoHDkCPrTYjF/FRY3EkY44c4jZoQGAaJgoH6Jr
         fySkP7tgnT7oRN6i8kfkFHqqs2rpQbT2pe8aBxg3RXj8V8dMhl1uwAsd69TmMgMjDVqk
         qCnLV5MoynvovnijaWm79BtdMqGRLSlxPLtCZedCKuUgBMk3R2vAuYrVvMtA8phJBB1L
         Yxrs/V9rcpPgpmlgr+SN4V4OXb3aq6LDOOmkzMruypFnyl8O9DOvUqOkdwtrnwnBmG7p
         Gyug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cFH5Um3Vk6lWWywUkT3b2cpV2XDFUTcWLb/4zeHC0OA=;
        b=nZ2yeJ3MMheSES1/icBvL3JPl5mF9pcbTHYhUpPe8AO1afsLHKvVIDkwDNbZ2I6wk2
         /4mhx6uEZyu8oD/LHjMGp9tctDrlxFH+otuoW3SHxAGdiPPfQJT7eDz+PVLwko8I33Nj
         quCB5AP2Hj0JMbl9Cgzb0kPTODAdFOhcs8yH0JLYAi3Em0tbuUIwiZC9nusojuDdwCYE
         Q76/4RUzMl4R/cjTV8kMhIw7O4wF28XIsM2rXJjovBQDxvo9lz6c3rh+Wj3Iw+rS7Z/W
         FvbmlX0MFQQm2M7hdlJ7CCNgAyKqmc8eVR6x/WzNudvNha3Mwn9biixttxF1PDp8KaGm
         A5pw==
X-Gm-Message-State: AOAM531S895orx486P/Q/25tiDd5oL6ps7zdkHKE87fdUvWt0Vf6moZl
        21ts6K7DAFLMkZEmNdaYHijixzgfhaE9OQR/Hn8uAheKWOM=
X-Google-Smtp-Source: ABdhPJy5JV5gtW+6VU7VUEUGc0VJeEBbqD4zyP00OvC2wafBHz8mihci9cMpntW0CsymEKMgNHTswYx46nxDiwmJK+U=
X-Received: by 2002:a17:907:94c7:: with SMTP id dn7mr2920919ejc.101.1644313336458;
 Tue, 08 Feb 2022 01:42:16 -0800 (PST)
MIME-Version: 1.0
References: <20220207122530.1609009-1-peng.fan@oss.nxp.com>
In-Reply-To: <20220207122530.1609009-1-peng.fan@oss.nxp.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Tue, 8 Feb 2022 10:42:05 +0100
Message-ID: <CAMRc=Mf3QYbrKECWi8O2=uaBY6xme=c8TP7kcmmiNjwvS9f2yQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: gpio-vf610: Add imx93 compatible string
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, stefan@agner.ch,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 7, 2022 at 1:26 PM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:
>
> From: Peng Fan <peng.fan@nxp.com>
>
> Add the compatible string for i.MX93
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> index e1359391d3a4..d2c39dba56ad 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> +++ b/Documentation/devicetree/bindings/gpio/gpio-vf610.yaml
> @@ -25,7 +25,9 @@ properties:
>            - const: fsl,imx7ulp-gpio
>            - const: fsl,vf610-gpio
>        - items:
> -          - const: fsl,imx8ulp-gpio
> +          - enum:
> +              - fsl,imx93-gpio
> +              - fsl,imx8ulp-gpio
>            - const: fsl,imx7ulp-gpio
>
>    reg:
> --
> 2.25.1
>

Applied, thanks!

Bart
