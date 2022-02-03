Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0D5F4A8FDF
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355042AbiBCV2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234005AbiBCV2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:28:02 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4726C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:28:02 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id y23so6094268oia.13
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=6VplieGMJAR9UNduIPc0+Hmk4xJP3Y1QDTbjYLcBmE8=;
        b=C3cZahKkdjZzC2AhHhwwKQNR1OVsiw4vU8GHVmm59kXb7HIsQ1/v9bY3Mtlps8XMXH
         XWV2aexgvt2i5tbbGQWxI07NXbsWXybbLu6DEDqBdtLAlOVU5KaeTiMscJfb1xCWfRkF
         2e4LUcdbEptCWXlNBe0GOm3sG1Q4kmwo4+SkU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=6VplieGMJAR9UNduIPc0+Hmk4xJP3Y1QDTbjYLcBmE8=;
        b=6K+To25LF4i6j+YopsY55nFGLrzrpKSPGEsF5p6XkXSZmPH9UMAAtvAed3WnbC5TgE
         djrHxtm1WgieeErAP/Y9NW9plD/lNRmPY67cP8C0UbrT2ooP/geIuXqaTv/Ey9Tt3dH8
         mr/o75RPZsAoTaXKBjazt/OclSAjhs0E7TTRs7MZfHhlfGV0TVqJ9Hd55Qnr8faCyiqQ
         l2TeRkUivqwpdjCf7WBzojnVOrwsFcU1FwLI7e4z3x2Irp/gfqAVBvD9zXSrbgZGBPro
         ds84bKPFUiqaXuEgHkprYesITgwQRio65h92l0HG4qDY8lB1InIXBit4ZUtQV9R+mH3m
         Z7dA==
X-Gm-Message-State: AOAM530/k66rJaX7blTn+3a0V8hX/aoMUi+Hew3uMFR+xJz1YToXH/Ep
        e2txJ/26lXTcYlulXchTDHN2B7Mh36S33Zh2PjSp1g==
X-Google-Smtp-Source: ABdhPJyRGGh5o3RQEE4N30LJAoPRh1VFd99uBGzTml3OZn6L9Hkq2Au4hX556EyY3v8cR0CPMV4NBudGKeghR/0q+o8=
X-Received: by 2002:aca:df82:: with SMTP id w124mr8788790oig.112.1643923682140;
 Thu, 03 Feb 2022 13:28:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:28:01 +0000
MIME-Version: 1.0
In-Reply-To: <20220202132301.v3.4.I79baad7f52351aafb470f8b21a9fa79d7031ad6a@changeid>
References: <20220202212348.1391534-1-dianders@chromium.org> <20220202132301.v3.4.I79baad7f52351aafb470f8b21a9fa79d7031ad6a@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:28:01 +0000
Message-ID: <CAE-0n50+AzZv2Q7Uda0OpEKxkbSY_-S8_CZeScjicChm94Dtjg@mail.gmail.com>
Subject: Re: [PATCH v3 04/14] arm64: dts: qcom: sc7280: Clean up sdc1 / sdc2 pinctrl
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     pmaliset@codeaurora.org, mka@chromium.org,
        quic_rjendra@quicinc.com,
        Shaik Sajida Bhanu <sbhanu@codeaurora.org>,
        kgodara@codeaurora.org, konrad.dybcio@somainline.org,
        Sankeerth Billakanti <quic_sbillaka@quicinc.com>,
        sibis@codeaurora.org, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-02-02 13:23:38)
> This patch makes a few improvements to the way that sdc1 / sdc2
> pinctrl is specified on sc7280:
>
> 1. There's no reason to "group" the sdc pins into one overarching node
> and there's a downside: we have to replicate the hierarchy in the
> board device tree files. Let's clean this up.
>
> 2. There's really not a lot of reason not to list the "pinctrl" for
> sdc1 (eMMC) in the SoC dtsi file. These aren't GPIO pins and
> everyone's going to specify the same pins.
>
> 3. Even though it's likely that boards will need to override pinctrl
> for sdc2 (SD card) to add the card detect GPIO, we can be symmetric
> and add it to the SoC dsti file.
>
> 4. Let's get rid of the word "on" from the normal config and add a
> "sleep" suffix to the sleep config. This looks cleaner to me.
>
> This is intended to be a no-op change but it could plausibly change
> behavior depending on how the pinctrl code parses things. One thing to
> note is that "SD card detect" is explicitly listed now as keeping its
> pull enabled in sleep since we still want to detect card insertions
> even if the controller is suspended (because no card is inserted). The
> pinctrl framework likely did this anyway, but it's nice to see it
> explicit.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
