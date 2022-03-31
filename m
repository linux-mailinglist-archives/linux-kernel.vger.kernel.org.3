Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AB24EDAE0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 15:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237019AbiCaNuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 09:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237008AbiCaNuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 09:50:10 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39D71DA60;
        Thu, 31 Mar 2022 06:48:19 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g22so17155064edz.2;
        Thu, 31 Mar 2022 06:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1FmWFtFPrGFw3jPfN32jgX8K91mK4Fw6kVZq2e3W06A=;
        b=GuBynw1bR30DfiMh5e8Nh5WD+dkT0noit+4UtYMJK3iKZ35qa0dPkAbev0Ox7RYOms
         3dBIoSRbPCMsJy1VhC68ogz6X3AZc3fGy3Bps2B4GzDsKbcccaO9aFOV7Xfrl/AJfwOL
         Lf54fxuRDFulTu4JdbLWUzLAhvd9LSrSizfBOGHs8NE+MDdhNX2w/W2kdJ4TdpWS9DBO
         KR/oQpoQRKLEiJYlThLZXpJ95lZRtKRA0zscywXTz9B7D+9HhuaCLPhf7O83sgaEeWH1
         AWbglg8K0D4RQ/zFbM2+L4koc/6hHCvbtiRVXLetfX+GXEtcDjosdBlNbdwGNCckPyhV
         Tkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1FmWFtFPrGFw3jPfN32jgX8K91mK4Fw6kVZq2e3W06A=;
        b=vZkfZJtLRgNe5kgMuVGeGC09rMKxzqSPHxUyH7jZqAmeMvRLlmpD2qM8m22eGQUqlr
         lm0QaUKPITkmp0SF+3uYmVrz+vmFRgMM5mVhNoaymn1tIsoS9ewddvTD7u+PThVbxqL/
         vOYTDqqGXlHyxJtMF2ghUtYupB8B1PMq+x8oz+OATgly5uk12fNuUPGD1eV5sRXrwoEB
         mrddtTwySsT8fuK1yEgBwE6QTyFhnKmo2wMjBLf6bnfbvf3tfaA9/Z4f/pK+6C8QfyOI
         J7p49ZMVmURoQUv8bcnHOavvgAEDJxjJhiyS8cwajj4ZLwo2e1zPWjJbgP7HwMSzLryL
         vUMw==
X-Gm-Message-State: AOAM530vBUsKwjoVHS5d35ACVT66imREBnjt4S3cnz0V2MdJUYDuj/yJ
        8ZZU7K4WSlLCxi3TivZlFPd6riAAfVVEbG7oyyg=
X-Google-Smtp-Source: ABdhPJzgmF3q9RuLnrcHquNydyMYB8kqL9v5TvHww44KBOahY3umU53CaQRZK2bfteXGp/QRBvjn0bir8PkTUp3+a1k=
X-Received: by 2002:a05:6402:27d4:b0:419:5105:f7e7 with SMTP id
 c20-20020a05640227d400b004195105f7e7mr16672565ede.356.1648734498411; Thu, 31
 Mar 2022 06:48:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220323135601.42435-1-ariel.dalessandro@collabora.com>
 <CAOMZO5D4_WboF4S0dgSLD1m15a13c2irK2yjDV4C77_Wb15=2w@mail.gmail.com>
 <d9f14221-b0ad-9853-e9c8-a35d9111549b@collabora.com> <3e3b223f-7d05-f439-625a-a15afb44b95f@collabora.com>
In-Reply-To: <3e3b223f-7d05-f439-625a-a15afb44b95f@collabora.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 31 Mar 2022 10:48:07 -0300
Message-ID: <CAOMZO5D8UHkkyJE9uJ4yBmf+ajjbzJOrLM57OHpyAiATvMNXcw@mail.gmail.com>
Subject: Re: [PATCH v4] arm64: dts: imx8mn-bsh-smm-s2pro: Add tlv320aic31xx
 audio card node
To:     "Ariel D'Alessandro" <ariel.dalessandro@collabora.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
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

Hi Ariel,

On Thu, Mar 31, 2022 at 10:35 AM Ariel D'Alessandro
<ariel.dalessandro@collabora.com> wrote:
>
> Hi Fabio, Shawn,
>
> Can we merge this please?

Shawn will probably start picking the patches for the next cycle after
5.18-rc1 is released.
