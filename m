Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08E8B55E749
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346998AbiF1Nz7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346012AbiF1Nz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:55:57 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1531528
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:55:56 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-317710edb9dso118413087b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kxOhQolvwduRWfHp8nzmrFY1G8WxOuz7AW66OC89GlU=;
        b=aIvg8hbrgemKNvg22KLNdqF1iZoyHZJHvQ+cI+1v3vreL1Y0S/gmjfQZRi5rozr2NI
         n3Mg0QxI1maN80y0myC76XImJj4HD1RLw+ZsrntlrYTIRfINOWrtKjFTl9j9pEHxTRIH
         CaBkZBYNtfv0LqzNEIAyMsaDTCLdG2X6M1ur4zd4FD3M5OM94hTv3E7iOtT+YeLF4fcX
         JYs2H7JNSAHpqyUrfpPnrRfedI/SjA36/E3kp3426It+zCbbrtRlghG2I36Tpgby2rLC
         H7jxp/FZGvL0IT50hh9/1jInVjASJeRXbayWWnpkHzeO4EHnOwgTCJxIv8xpsKUGrzDx
         kxTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kxOhQolvwduRWfHp8nzmrFY1G8WxOuz7AW66OC89GlU=;
        b=1K1HyoPU08IMZtkUHrPBHZb1ShFX6jBpPbVUemVj9SlvhyDoCagjRKFgeTfukN4VfH
         bzk/0hi1S8QohrTkA0J27GKux0tAx83DQaBpyFpgs+eAsRTCb3X683yaNqJUip2O17qH
         H71/dNOR/zwDuatympUo5Q2uw2Djo+CfnbR70wX5cwvlRHAPKkdUryfdZtlL4JZt2OLm
         HgL3vqOjwP/XyIcjA4SsN7YPmPQYgQm8chTXp2qOkCAsQgAGUlf3kNOtEfwLA7C7KvRQ
         75J3rXsw7zRgGkmhCiScLmPupDhDhMb2e5E/SafWs22OEA6spqOBqq+j3oHtmih9ADXc
         osXQ==
X-Gm-Message-State: AJIora/ypr67RDO5WYftMS4m5xG7Wja3kCszoolaUdTCADy8b2N2BBrB
        MZ7q4IO2krYRLNoc8tAxPM/N3V8ydQaZbdJtsP1vIw==
X-Google-Smtp-Source: AGRyM1szGG02RfG3EL5P+6lP1i3HtBscAKZM0qaNbzmp3Aol7aLOgPMpcWX50uoxmoqOY7esyzE1BBj3sY16WXS+L74=
X-Received: by 2002:a0d:e20a:0:b0:317:ce36:a3a0 with SMTP id
 l10-20020a0de20a000000b00317ce36a3a0mr22354878ywe.448.1656424555304; Tue, 28
 Jun 2022 06:55:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220624081022.32384-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220624081022.32384-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 15:55:44 +0200
Message-ID: <CACRpkdabjb45WNLPa6gRDiCDm0u1swDpYq3D1pju4HmcCetoYA@mail.gmail.com>
Subject: Re: [GIT PULL][PATCH] pinctrl: samsung: do not use bindings header
 with constants
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org
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

On Fri, Jun 24, 2022 at 10:10 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The Samsung SoC pin controller driver uses only three defines from the
> bindings header with pin configuration register values, which proves
> the point that this header is not a proper bindings-type abstraction
> layer with IDs.
>
> Define the needed register values directly in the driver and stop using
> the bindings header.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Chanho Park <chanho61.park@samsung.com>
> Acked-by: Rob Herring <robh@kernel.org>
> Link: https://lore.kernel.org/r/20220605160508.134075-8-krzysztof.kozlowski@linaro.org

Patch applied.

Yours,
Linus Walleij
