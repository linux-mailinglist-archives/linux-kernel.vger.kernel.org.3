Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46DD55624FC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 23:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237440AbiF3VR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 17:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237483AbiF3VR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 17:17:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E84133E32;
        Thu, 30 Jun 2022 14:17:24 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id q18so467629pld.13;
        Thu, 30 Jun 2022 14:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EnTvSgePrhZFZaFA+2vKdGcqExajag+7cCIQmnEgyew=;
        b=bjk8OnY7U11eIZMBhp3vNNXPhem7A1k/Hi4MA2rhKBbqaNqBkk1iqFOneaRWc9q5/3
         z9vLJXiU2lTROIarHTFAYWdH4wNAFvElaJFGhSgr1qSVVJNco8VX0dRnZiG7UObpAd+G
         cIaXpDkPyV4T6UhGlL7zktFXFxov0HB+KdGA/AXR4UbGDpvbZSzVy4wEZRJB5F4TyxIk
         U2DtiTfh/Ut1cw81B6H7VwzRw17+INs8BbR/hQ5/N7l+J7bZn0mpKCyfEuH0w/vSeUq7
         CIynOo0cLiE2oMWpDyw6h5idtsaSvqjROoz60YTDF316pYKuN6pEwAcLRjWT0DazBo2M
         tdHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EnTvSgePrhZFZaFA+2vKdGcqExajag+7cCIQmnEgyew=;
        b=ClljQnOwjrthPGxc0FKq3gqX7CVRWsBZVul1SDVrAVNrhVDq+N5pBg0w6jUgE1AsOw
         RSSFrhwDNGLRCgxUkNW7Stbkv87sSb9D/yfHUhwjA2dO0vdXGEpXFW6kiEHdpAxcGQMX
         kWTgVpw8mZbx8pFCwkEEe4JJr8t0IjYb04W5qoJwWwFCJQkDXEuRO4gREUh05fiHyH+Z
         MWIIcP6jHS2QkmSsEpjtdhRH3ya3MiNj6ZWdcC8PPLvKJ7uiOca2UR66Dwco82yX33nd
         9TfqGCAjXMaxzKdGaQJTo4S3S8UF8x9otO5PrNm9rq9PDaUxoINneQ/CXqQrdHge7AQp
         TU5Q==
X-Gm-Message-State: AJIora8NMwDkj8XVmLKBxQ4+nGod3+DREjC1qMDDMnuUMbGDafOonDnU
        y7S1HEfAbFYUdVrebJD31N4+InHjUmnQ++ttv2k=
X-Google-Smtp-Source: AGRyM1vDBqhj2OxY6I/jEe7NDmicgN5u0qhJW6F86uSrh4ePqT8HV5n1Y4MixJh4nUoBdYYphPXooSKsm1LfMjPGOoQ=
X-Received: by 2002:a17:903:328e:b0:16b:8745:bb77 with SMTP id
 jh14-20020a170903328e00b0016b8745bb77mr17422936plb.70.1656623843711; Thu, 30
 Jun 2022 14:17:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220630210327.4645-1-kris@embeddedTS.com>
In-Reply-To: <20220630210327.4645-1-kris@embeddedTS.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 30 Jun 2022 18:17:11 -0300
Message-ID: <CAOMZO5DJBQxc9ewO7R_uoHy3_kKq9mGShQn-oJiGyNwWxobsEg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: imx6qdl-ts7970: Fix ngpio typo and count
To:     Kris Bahnsen <kris@embeddedts.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Featherston <mark@embeddedts.com>
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

Hi Kris,

On Thu, Jun 30, 2022 at 6:03 PM Kris Bahnsen <kris@embeddedts.com> wrote:
>
> Device-tree incorrectly used "ngpio" which caused the driver to
> fallback to 32 ngpios.
>
> This platform has 62 GPIO registers.
>
> Fixes: 9ff8e9fccef9 ("ARM: dts: TS-7970: add basic device tree")
> Signed-off-by: Kris Bahnsen <kris@embeddedTS.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
