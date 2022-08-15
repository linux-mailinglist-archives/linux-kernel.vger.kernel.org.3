Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7549F594596
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 01:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350688AbiHOWkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 18:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349951AbiHOWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 18:34:40 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B7272B4D
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:49:38 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id tl27so15276419ejc.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 12:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=m67EJff98GODNT9Ex0/hz32xjPCkaX4RTb2W/H22b6A=;
        b=vZ3KSlgu2w4W+/oYxGdQqXPiH0C9jBErZhMcjLi3pYC6RObHOgwGPcH8C5rXhea5um
         84FUWrgGpfHAyKuOe3nLaTV+qpTY1Nlf1dPHwwMJE2JrGO5fyHqTUbUHqS+OdOSIbFOZ
         T+QhOu2Rj0jYqwo2Mbbj0P3dhwRWETQPJFftMThrpLpAcadF96T2VJFNevi1MpjkZYtl
         acKXd5wT89G49ASaXEzs33kqxSkURPyGT0wUi48M8vcERJqlOb5hoJ9eoJWMsSmMTxnE
         9M0Vrq688IdVfZs0gsn/6VBgK+gH9PgqPT5cliJQw2bRZcZhFeclSV3oBdjOaM0zICoS
         vkYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=m67EJff98GODNT9Ex0/hz32xjPCkaX4RTb2W/H22b6A=;
        b=2zxWWgHrUJIHr8drt3+JaKwg1kol/hDONczvNeFPHNdGhV6vVJmRPBShOjMLLSZOGe
         aLesYv8tEDuRZJKd3tdqSdEWJzzDe14/qzlfyEBsZkKsXPfaEu7L6K8ukBJqvQtlFiO+
         toD5zRdIh9nN8EmDzZ49pN8h3DKAZ72ggYrbZkNXBKFKm4+bCBgL/9razKeS5mfFAuPy
         K5vsj7qUPngVNgzxCN/n3oc0TQst9glRXvkKZCiMEarhaxBJSnPm8q5t/ZSG1KjdkBvE
         AgToOuIoPnaUshoXyc4NK8sse4rkMslJOjTiXMnhs+57N7v/Wmk691ZOj/gWSrnkH7iC
         CLBw==
X-Gm-Message-State: ACgBeo0JeNYUF9evIG2KOZG7p3lq4HY3m0kImrZAbx76EJ1LXBptgY6s
        e7vZZvKToquFQ3OWhMHlpmKsTEPRO5SOaP7bxiLEiA==
X-Google-Smtp-Source: AA6agR6q5mjwo1Y+kcRShH4sdgxadLS7IVIeRxqgxtvrwGWYPB0p9HIKRFxe3O4/pRVTR8kR2RLCstZitIhQR8D+UYA=
X-Received: by 2002:a17:906:5d0b:b0:731:3310:4188 with SMTP id
 g11-20020a1709065d0b00b0073133104188mr11564211ejt.208.1660592965944; Mon, 15
 Aug 2022 12:49:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220810111037.280959-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220810111037.280959-1-krzysztof.kozlowski@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 15 Aug 2022 21:49:14 +0200
Message-ID: <CACRpkda9_BSV+ZR0nnfv=6hFOacrE5UAtM-V-g_2Y5bWDTSvSQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: ste: ux500: align SPI node name with dtschema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 10, 2022 at 1:10 PM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:

> The node names should be generic and DT schema expects certain pattern.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Patch applied!

Yours,
Linus Walleij
