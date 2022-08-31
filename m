Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249DB5A7F07
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 15:37:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbiHaNhw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 09:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiHaNhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 09:37:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40027DF77
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:37:35 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id cu2so28500273ejb.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 06:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=dhKWzXlcJrkucw4E9XlBh2sQw8VM81WRBA3yVsWxLAs=;
        b=bC17zqAcmasnjOJACvtPcIEI2TSiftb9S3WX+p/LPClI2nhjzIFqZsEce7mlgssuSr
         ThKTCts2QFnzvH7u/+ztkcplrewQgGM7xIaQBJhTkHsu0delmVMcJKJ4h4swEmXGkZUz
         wxuNRX8jeF1GnRre5xz8qPa7BuwwYDKG0v2LQXpjmCBAzuaspd9PVuDEbcOHzYlK/ox3
         QOstzdiVJkBfkbtzgt5++9vdQ2+L+eognp6lIAB9b2uBE8q8aAcUmqA6Q+4JaDLtDevN
         XmYIV3LKMyt36/Fnj2tKDWCzhO+OepKr8dPnVASjMFbwjs3EhimLRRoKvDFLBOd0g6Oh
         0SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=dhKWzXlcJrkucw4E9XlBh2sQw8VM81WRBA3yVsWxLAs=;
        b=iMdAiHg/QFD8Yr1X218cnKLnc2OIMO/WN9zNABA0KFNmW/81mHbUbTf+aK7xb1swOC
         ypc1UK7fGMoiB8nM0wgo7wTdZ1SR+a9+sXGHBBleSUg442lH8qR5HnwcDiisCYmurkoI
         45ZkdQNOD4omfWhMSVoIoyjDRDMo/eczbkh2jbIIb+/HQ+++n1sYtVa2yw/Qv2eTtQ6E
         DoVtOx+rVim79zLU95dCqxH/CWyXrEXLXpXE5Rj9cFZRA2iAkWPT4eLtKQi3GT3ByduL
         M5WG5lIpp3wAwQb/I6xA6XCkUT9KtnhH/K6fVHGOS0hf7VYT+Gc64Rk1WP0xh8zULWcZ
         a6/Q==
X-Gm-Message-State: ACgBeo3NEEdyt0D/vLWhF7SnT4sqGbGbzkE6xOmOd0HHl9tgnzFf1OiQ
        66+t/9EEkphBRmZldxwayCxcVdIDThakkuhMTjR8Hg==
X-Google-Smtp-Source: AA6agR4yjiaueChqK13MiVSlIUaNIc8Rq7ecgJ8lP3gaHv+r5NtCEmup6ST0xMg8LZZEi3eSboTaS611sTB1kFmyftE=
X-Received: by 2002:a17:907:1c89:b0:741:4453:75be with SMTP id
 nb9-20020a1709071c8900b00741445375bemr14455843ejc.208.1661953053499; Wed, 31
 Aug 2022 06:37:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220829082200.241653-1-vigneshr@ti.com> <20220829082200.241653-3-vigneshr@ti.com>
In-Reply-To: <20220829082200.241653-3-vigneshr@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 31 Aug 2022 15:37:22 +0200
Message-ID: <CACRpkdZvEtbXvVZuBQZcqjC57DPGKfnVemaM3BJZYML=z6baTg@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions for AM62A
To:     Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bryan Brattlof <bb@ti.com>
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

On Mon, Aug 29, 2022 at 10:22 AM Vignesh Raghavendra <vigneshr@ti.com> wrote:

> Add pinctrl macros for AM62AX SoCs. These macro definitions are similar
> to that of previous platforms, but adding new definitions to avoid any
> naming confusions in the SoC dts files.
>
> checkpatch insists the following error exists:
> ERROR: Macros with complex values should be enclosed in parentheses
>
> However, we do not need parentheses enclosing the values for this
> macro as we do intend it to generate two separate values as has been
> done for other similar platforms.
>
> Signed-off-by: Vignesh Raghavendra <vigneshr@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
I suppose you will merge this through the ARM SoC tree.

Yours,
Linus Walleij
