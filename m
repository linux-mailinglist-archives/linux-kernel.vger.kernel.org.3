Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69360578113
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 13:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234548AbiGRLj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 07:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbiGRLjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 07:39:18 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F38526C5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:39:17 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id e28so18780507lfj.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 04:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LM/hn+OVqs3HFe+jDApgRgLmW0vQU4FyOltjDqB3/Sg=;
        b=BftAwgS+k5g/3vxqxG+3WrnB4nHH4Dq7BZDuswhBR4sT2Kue8FqghkpFrlfIHVC+P+
         U2TkIHTyeijTBJoh8cZ4S/DCr1fy7rmpG+VJUssgK5gyMAase1O+Uo4w6dmvwwCjboIA
         VUNWqFxJ7A/X3byP+PIS9xbH6/2tItBg2gcRaIRT5N9ypur1+ZjNu/5ovG4yXOSoIWvA
         0lHaFbfLSK2ZDmVITerKzNh+45X6xUEOcALAD00xsKHJ3mNpT8/AYEbwd46G2soZgZfQ
         shXWpyXa9H0x+NRGXBhiPUIZ/0XgToFO8l6GQ0pbHOoc90jR+19JHbJrQALbRnaBwBHo
         /nBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LM/hn+OVqs3HFe+jDApgRgLmW0vQU4FyOltjDqB3/Sg=;
        b=YNfnVEuNA/UcAAof+igAXD2mtX7Xced4OnzW0wEr2aLpui4yUIUWxkag8uVEEIy8qZ
         x17X0Tgq4Nk6bkQV4ZqDGsVpppQnpf+dJFtb4Km9U0Hqy33DzyNnSpgAtBYhQkuwI7Ua
         yIp/ho4mNo6gYAJw+VIXL2JKcxvaFK1DIP8fybE0aRV4MAsC1wQ5rusq8rAv4+FRfP48
         yt0T9hl0y+w/j/TUYfEH8sofhz0E+Q1yYF88lzmH69F8wlg3chVnoeIL+Hn/EPiu6bLA
         RZJdqqjQNRMn4s+v0hMy7Kgk+gZtIJqJgHdKLbNqaBDhDcCVebskQtw9C78gvv1Drknc
         j3mA==
X-Gm-Message-State: AJIora+pfyYpe6I5XgG/6SNCgJrVyF8kJXmUqs+5WQLJRdC42/nBeWqJ
        F9B+/R08+6B6KuWKd3WQF8uo4qUN1msFaJYXJ+GaXA==
X-Google-Smtp-Source: AGRyM1u7qX5AB/G++2uS/gtRhpTUCNvvrYExbLhAE2KGmAyp23WGYAhcJCO6LARGRm4eTJyZZYuNlPywKHZKt6zR2lk=
X-Received: by 2002:a05:6512:3e28:b0:48a:a4b:c474 with SMTP id
 i40-20020a0565123e2800b0048a0a4bc474mr13415274lfv.254.1658144355761; Mon, 18
 Jul 2022 04:39:15 -0700 (PDT)
MIME-Version: 1.0
References: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220714091042.22287-1-krzysztof.kozlowski@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 18 Jul 2022 13:38:39 +0200
Message-ID: <CAPDyKFoFGxjcAA7vDUzfBDzNyMfrn=g9ZJ9cnY_aX8im3G-=DQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] dt-bindings: mmc: / ARM: qcom: add MSM8998 and
 cleanup driver of_device_id
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 at 11:10, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Hi,
>
> Rationale/background:
> https://lore.kernel.org/linux-devicetree/CAD=FV=WGxQF4vPuRi7kWKoqTpe0RFsgH+J82C=sQbmncK_AFpw@mail.gmail.com/
>
> Changes since v2
> ================
> 1. Add Rb tags.
> 2. Add a comment to SDHCI driver to hopefully prevent re-adding of compatibles
> (suggested by Doug).
>
> Changes since v1
> ================
> 1. Add Rb tags.
> 2. Rework driver patch (now last in the series), after talk with Doug.
>
> Best regards,
> Krzysztof
>
> Cc: Konrad Dybcio <konrad.dybcio@somainline.org>
> Cc: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> Cc: Doug Anderson <dianders@chromium.org>
>
> Krzysztof Kozlowski (3):
>   dt-bindings: mmc: sdhci-msm: add MSM8998
>   arm64: dts: qcom: msm8998: add MSM8998 SDCC specific compatible
>   mmc: sdhci-msm: drop redundant of_device_id entries
>
>  .../devicetree/bindings/mmc/sdhci-msm.yaml    |  1 +
>  arch/arm64/boot/dts/qcom/msm8998.dtsi         |  2 +-
>  drivers/mmc/host/sdhci-msm.c                  | 29 +++----------------
>  3 files changed, 6 insertions(+), 26 deletions(-)
>

Patch 1 and patch3 applied for next, thanks!

Kind regards
Uffe
