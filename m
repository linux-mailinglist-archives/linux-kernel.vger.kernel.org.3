Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2D1D5A8722
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 21:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232174AbiHaT50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 15:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbiHaT5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 15:57:22 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B952EE6A1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:57:20 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id qh18so10255416ejb.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 12:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3/C402UrLcFdr+55UasuTaaa+TRTdcGT9j3EBVa3jV4=;
        b=4U2aNm2Bzl6sWFxYmpkLatmR/VIT9M4TC1wx0Hz6KqTkVCAaqUdhJHrXDM2HUeISWU
         1gj3skkD3jlLf9mYWNLSCbFU5iqJnZUEzJRPLeBqgrWLPfK3DdFHW4F+uXR7U2I+h6Iq
         LitD5cgW2roRNHIEh8XLMWtQ/h8iXF+zWOuHcYLxTMTT1Sa9Sf0eLeD2czf+5ijLTb3S
         swZ2PvazSBanHogOiTiupHKA5oTBim4W05sNNoz0PS5RRM0lh1QI6rDxkjo73fQfdjW3
         tTaXih8CgMoJ5VZwTjcjfyo0FsfiKKIgv90cljRY1FlGuaavwP93wqgZ/FfBX3lJhfyL
         rZig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3/C402UrLcFdr+55UasuTaaa+TRTdcGT9j3EBVa3jV4=;
        b=P0VLZZhTYhRkyZ1ToVRAc7wkt8RZs6Jz1yMVK8NM2bSJ/BSbo+UgRJi9EgvFz3c9Vt
         gtX1pSDDaWU8aq1NGH/THmhYVKWPdIvV8lmEH1lIpu0pfR204NItJ0IGK3bsiqSjPR5S
         WSC68ncpcUlntLJCABrKo3wHcKb99e3yMnwYtq2hB3jjslLHTunR+Fj/fUd82WumPqjx
         g0a15pUahxp9ba7RFNlwKzv/m08xa0fPkMa5qAhgnwCUsd5DDERga4QJiWHNIAADSFgJ
         Pz8tk6e3gz2Nw+L7w5qCHt++3WEgska336HhXit70EXFcs3XCzSUIv8pOprpL/f2bMQY
         Yzzg==
X-Gm-Message-State: ACgBeo3J64G5rfQBze0lt9VNkdaTKPsxEa7pD1neBVAEr/NvROC24A4C
        w23U/w1BjUyqRoDPeK4UCC1yHs9P4aNSZyIC8j2yVYsnvWM=
X-Google-Smtp-Source: AA6agR4eCcEmRzF3NJLEVzxJ5LTDTqeQtu9d8ExuzstxWQae7oIVIV99F7ZjR94wAkhLZw8SM3jUdy/xwxuuxtIc+dk=
X-Received: by 2002:a17:907:1c87:b0:741:8199:a59d with SMTP id
 nb7-20020a1709071c8700b007418199a59dmr11832796ejc.736.1661975839012; Wed, 31
 Aug 2022 12:57:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220712163345.445811-1-francesco.dolcini@toradex.com>
 <20220712163345.445811-4-francesco.dolcini@toradex.com> <20220809134836.GB44926@francesco-nb.int.toradex.com>
In-Reply-To: <20220809134836.GB44926@francesco-nb.int.toradex.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Wed, 31 Aug 2022 21:57:08 +0200
Message-ID: <CAMRc=McqfBSb+ZoD_WT-rWBqxqTCpogKUhO2uJr2R8dctTA1CA@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] dt-bindings: gpio: stmpe: Remove node name requirement
To:     Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Input <linux-input@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Tue, Aug 9, 2022 at 3:48 PM Francesco Dolcini
<francesco.dolcini@toradex.com> wrote:
>
> Hello Bartosz, can you pick this? Patches 1 and 2 were applied to MFD
> tree.
>
> On Tue, Jul 12, 2022 at 06:33:43PM +0200, Francesco Dolcini wrote:
> > STMPE driver does not require a specific node name anymore, only the
> > compatible is checked, update binding according to this.
> >
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> > ---
> >  Documentation/devicetree/bindings/gpio/gpio-stmpe.txt | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
> > index a0e4cf885213..b33f8f02c0d7 100644
> > --- a/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
> > +++ b/Documentation/devicetree/bindings/gpio/gpio-stmpe.txt
> > @@ -8,8 +8,7 @@ Optional properties:
> >   - st,norequest-mask: bitmask specifying which GPIOs should _not_ be requestable
> >     due to different usage (e.g. touch, keypad)
> >
> > -Node name must be stmpe_gpio and should be child node of stmpe node to which it
> > -belongs.
> > +Node should be child node of stmpe node to which it belongs.
> >
> >  Example:
> >       stmpe_gpio {
> > --
> > 2.25.1
> >
>

Sorry, I was off most of August and missed this one. Now applied.

Bart
