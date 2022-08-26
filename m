Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A5D5A2308
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343646AbiHZIaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245755AbiHZIaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:30:08 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 530D4E0C5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:30:03 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id w19so1794727ejc.7
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2w7uDDGae7lPC9PBKoaaB26gLASkKWk1Ljox9Qb8l6Q=;
        b=WzlJoUzfNCpYcC/wKzgOZa08JruxJVjED39QeHg1/uZzWWP49D65DM1aFYc3qaKtvn
         Q6zinWKDzFkDnxkWbGAh3BdqVKj2p2Y8GJhTsY/Pxt17M0r3EvJJymiAQrA33yDj5s17
         X9iqJjwU09qVwnXAfOZGVQrRe+vzz3SkUiI7GmHzLQav3BjthDp7VmNiWuFuuAFntQ8c
         meb78ZzYilLV0zjJZ/sdxprNpg3psTxruUB6RB89PizXIEEFmMorRbzKW8fkamtp+eE/
         UP/DeTKxY08moOLhnrFO8NtHOaRtGKMwmVAnVvG2+YiB6+su8G33EAWTxccYf6n5zxDH
         Bt8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2w7uDDGae7lPC9PBKoaaB26gLASkKWk1Ljox9Qb8l6Q=;
        b=IrpxBTaInb5FehlIUTpTzTmkNXmaqlE7didhZhiAO7FaQ69t0BQtt/y2yoPbFTZ/7Y
         /+rDo8BD0vQjg2rp6K0mNu/1Ot/V4BUqqdOcWrfDjIMhmQiezRJp9u/1Bw56S7JsI2N3
         u+MNLzj9VSG3JNzNHN1hiXf5LcUjw7e7krSV2HfcLroCEvtP2JJ4JU1Jzb4Zmd4s898Q
         iFFRmBfl2hvIM49hVctRAbfci06VuNWupcuuJyOyo/Pu5bdkBitU6Uq+0XYJ1NeMQNLJ
         KgT3MWICRw9nCOwf/QPh4PaaWqUati6BaGFsUhVAuyxnrRC3but+RYIDvbIEih9Ya46q
         eaew==
X-Gm-Message-State: ACgBeo0C9CGPE+ZsYuPWO7sD08r7Bau2sRma8piJ4kZBkX1RbVGDlbHX
        9QEE5h2SJTNJo4+J4iN0s81N15m6zMWaLhvlCFh/ZQ==
X-Google-Smtp-Source: AA6agR5Mur9vHmJyu+/jiMMkqB3v9LgJ6NwVlpsA0j4qLjcco/mAHvxbCi0JTgMvXiCAzfETgkWpYo/C46NbmmoWnWI=
X-Received: by 2002:a17:907:6293:b0:73d:b27b:e594 with SMTP id
 nd19-20020a170907629300b0073db27be594mr4929048ejc.526.1661502601587; Fri, 26
 Aug 2022 01:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220819190054.31348-1-a-nandan@ti.com> <20220819190054.31348-3-a-nandan@ti.com>
In-Reply-To: <20220819190054.31348-3-a-nandan@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 10:29:50 +0200
Message-ID: <CACRpkdaktinAJveF_nH9NYYk7mAvnResRzoyuVDVWpwKKq6JOQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: pinctrl: k3: Introduce pinmux
 definitions for J784s4
To:     Apurva Nandan <a-nandan@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hari Nagalla <hnagalla@ti.com>
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

On Fri, Aug 19, 2022 at 9:01 PM Apurva Nandan <a-nandan@ti.com> wrote:

> Add pinctrl macros for J784s4 SoC. These macro definitions are
> similar to that of J721s2, but adding new definitions to avoid
> any naming confusions in the soc dts files.
>
> checkpatch insists the following error exists:
> ERROR: Macros with complex values should be enclosed in parentheses
>
> However, we do not need parentheses enclosing the values for this
> macro as we do intend it to generate two separate values as has been
> done for other similar platforms.
>
> Signed-off-by: Hari Nagalla <hnagalla@ti.com>
> Signed-off-by: Apurva Nandan <a-nandan@ti.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>
I guess you will merge these patches together?
Tell me if you rather want that I apply this one patch to the pinctrl tree.

Yours,
Linus Walleij
