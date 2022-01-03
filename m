Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3A80482F99
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 10:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232418AbiACJqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 04:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231142AbiACJqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 04:46:37 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5115C061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 01:46:36 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f5so133750552edq.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 01:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ea7xf5nC6yWPyNoj7Bhkp/1I/wIuopHPZ7n5fRnCZOc=;
        b=DSmgIoTI7UD5K3GUSguW6HZxXH4bWaqIF4bTLO2X3FnCpEQlw0YpdTusd/Snw2e35p
         R7EWIoOlSWuZmA/OakgyJvBe8bCeM09bR2BMSE/wm647reT+jWISp6V8kDBzjhKGt9N0
         TMjjNnVUafa5mJtIGwRrsm2Q3W5KQGiygwZG5OjayxZ9/ykkkGRJP3RYjkdyZ6+EO7YN
         IKMuBK0/HWQPNYjcVreyaMXvRK56AQi/IM1gFDJFmEXsEmvAhAgeG3s4nPJ69BG5Ltg4
         +uSrsNhEUj3K5Zw/sIBfE4LEiA6ZlxlgZUAy3wUbRKb+52x51irbwMNcnDAkIsIGO+ZO
         4A/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ea7xf5nC6yWPyNoj7Bhkp/1I/wIuopHPZ7n5fRnCZOc=;
        b=yH64DHtNRsD9MzU5CsLk3Fir/WdkeSEpd+GaR/l+pTgTw2zlb3pQ8viruWt0CMsDJF
         /ODOiAUgnUxVqkwiFXxdC6b3itzG5Gf5rUVg5rhdkDg1tbkKwyy4cqNYKR59C6c9wh8M
         pb1uX+kiqBylDAuaLQ5lyLORjUT56trKPuUqjIBW8jRDZjX8Mdwy0+q7SfI5z+4dsaD8
         JV5G3kDxKntrUBzlyr8v3jIKrvuiwXU5FuSV/nUwUV+zqzC9RvBTAsumMOKRzhAtu8sj
         y2b8GU6v2tiDw9sqty6D+kNeF9HKG/M4TbQG3BjEZpgxPICdBFxzsxJOfCUf154P9wLV
         TeGA==
X-Gm-Message-State: AOAM5327rgeT6k9iPW7YCexu0xrRa6tZN8Ow4nOz3gpa3B5zwP+8M/zb
        Zallsvh94C5nT9R2XpvC7ai/FDawnW4mcSoM2XgtUg==
X-Google-Smtp-Source: ABdhPJzdvGQ86fajGJoJNUFdVLwTKrDtzW8oaNzfZearDyUR/deCOVyJl1cycKsO53HVPMnOUtY0MV97D0XMgs48ATQ=
X-Received: by 2002:a17:906:3513:: with SMTP id r19mr36607273eja.734.1641203195256;
 Mon, 03 Jan 2022 01:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20220102155653.42165-1-krzysztof.kozlowski@canonical.com>
In-Reply-To: <20220102155653.42165-1-krzysztof.kozlowski@canonical.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 3 Jan 2022 10:46:24 +0100
Message-ID: <CAMRc=MdDB+FrN+08OY+Qq+bD5cPtXOJeFMKymhnGRNPrvgT-8Q@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: gpio: samsung: drop unused bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 2, 2022 at 4:57 PM Krzysztof Kozlowski
<krzysztof.kozlowski@canonical.com> wrote:
>
> The commit 6c56c6cd8031 ("gpio: samsung: Drop support for Exynos SoCs")
> removed support for the Samsung Exynos SoC in lrgacy GPIO driver, since
> it was moved to new pinctrl driver.  Remove old, unused bindings.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
> ---

Applied, thanks!

Bart
