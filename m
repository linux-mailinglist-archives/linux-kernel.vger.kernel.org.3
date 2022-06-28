Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F1455EDD8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 21:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiF1TfK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 15:35:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231830AbiF1TcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 15:32:00 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E343AA45
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:27:19 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id r3so23948517ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 12:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=walg9+X25Qf0Q2kOl7EPuRRmD7l8R+TPYwiRkuq/taA=;
        b=r5dhjikOjoOSTxH7twYmSKEfHqErqjhxkSM9McqWoCouOgLOQB7kvkMdEEzxx/BDX6
         TQrjLVB6hMIfuOa9g8Jq2JmzE97r9+o77os7tKeNZgQG+gQR3fBWEr5T9i+X01s9wRKF
         poqPtQCKU93338RDg9n0sUG/ZEqcMMUZPZnDwkORaC63HcYlFTRnittAcohjRCM8pOOF
         g/UPD7ABIbEWrLq01pVgh4ii12ETWhUPrCA8/9LHWHuLKXXESxjWthvXPWzyjMNL6Oot
         Hlc8iuNIiurItn418+oTScTJhM5C5ncPhx/nMRn5oHIDm7HNscLwCkwchgANUMMiViBr
         lmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=walg9+X25Qf0Q2kOl7EPuRRmD7l8R+TPYwiRkuq/taA=;
        b=dYTP6WkaaPDmGZf9gTMQvCdGFfQ7cRdzfDdpDOF7PMIaSy8y6pH1Kozdjrp06zlOzf
         foY3DE3E9nJDKorOBlG9WltSTaZ0yWm/SqFQiweaoZGevOmNg1gQoE0g05FjJjOHbzaA
         4YD12SOH8MsYIxqWoPhfd36Pl5u4FTY9xzXJIT00nSJFt3z5E3FSb/m23cVkAR1LdaE5
         SUbssEbo6msOu7gHCNLJP0PprLF15vmxwTWY+IIpeWcXYHwZUEg6JWX7dFzBM500Ozsa
         ikO7RzNrzvcIK3HHp3Dr3jP6J2XDBLlMWl6OUyOnuOwRhJekfMyD0YxDwKJdj7rnJpZL
         VmYw==
X-Gm-Message-State: AJIora9K6p447G3A9CAiSJBjG8YOP848Va8eSHuEWRKgO3m26tuZycNV
        eaIWXCzeDzTRVBDQXpj6no1I0B4CRvZIB6K/hjMgxQ==
X-Google-Smtp-Source: AGRyM1tix/MDbYpAocLhXqNa2cuD1sSvJJYVbcVLzqD1nAvkTSC00uKkSWSEB65C4UY4pgJ8yatan7ZYC8uyX2aYtAw=
X-Received: by 2002:a25:e7d4:0:b0:66c:899b:49c6 with SMTP id
 e203-20020a25e7d4000000b0066c899b49c6mr21915704ybh.291.1656444414438; Tue, 28
 Jun 2022 12:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220616005224.18391-1-krzysztof.kozlowski@linaro.org> <20220616005333.18491-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220616005333.18491-4-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 21:26:43 +0200
Message-ID: <CACRpkdawFWN_3EYV0p2AAgu54Lu1s0YgqiSiV3136wOSfSGhrg@mail.gmail.com>
Subject: Re: [PATCH v3 04/40] dt-bindings: pinctrl: nuvoton,wpcm450-pinctrl:
 align key node name
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 2:54 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> gpio-keys schema requires keys to have more generic name.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
