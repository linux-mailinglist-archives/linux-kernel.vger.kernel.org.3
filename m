Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C87252E0F4
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343868AbiETABN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiETABL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:01:11 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E5D36326
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:01:08 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id v9so3639739oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=92AxFLkh/q/FX9UmsoNYgJF83tRzojToGDNuCJ24uZ0=;
        b=bo0gcGIt6u25nCUrj+KKTjCtZjursTAzZwGdLe12izgAiX4vfWUkn5zhB/fpHNZZXu
         ffV2CsDnb5kqmNvtFgBKZ6sdphsLw2DoD+tSOP9j47XZtOQhfLTzSVcMwFlXMnEo9y3A
         2Tj5duPiKtA5P5q6a9kjjzMdqWO4T+kDEcprA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=92AxFLkh/q/FX9UmsoNYgJF83tRzojToGDNuCJ24uZ0=;
        b=q+RjdbVXsHKI1gGn8eKrw6fGWS3WYKqTU7VoEotll02NMXToSI+NAUVpqFYfiHNtGV
         U3yLtrMzCMkArAC+NvHDBVSiWKgNJTkr3RcVsZigcDBjL6nrvw5l2vphGgcNTXA9MHdQ
         oSBbNiHIuventHIAN9bOHRuO57o532X9840YwqAI6bhRjmJiXqMLs+W6wihcmY+kpUs4
         dTT8JV39i7SUf3diiPGUmguPxs2xMHHCx3VBvjVIms0gE9jsmFGXrNlQZIOFI6Sc8NGS
         OebLmEA2Kqrz85CSj2+pYK6PW3VEJqp0mbgbFsc7ElRDbFGtJwL5UsxhUJn5quS3SIeQ
         psOw==
X-Gm-Message-State: AOAM530bzyobiOl/G6s11blvYjDu/959X07LENZiWE81aqPoCtStfGkH
        XDB+Cj4R2oPIVoFD0QGblLpvF9jzEP3JlcOHpkMucw==
X-Google-Smtp-Source: ABdhPJwXFVId+BJT6e8QsIMYPh5FZTQiKs/FmvmwsuevLaX6bwx6IXCj3kFOWDoz82GeH1m1xws6w7TB8qgOfVq2blU=
X-Received: by 2002:a05:6808:14c2:b0:326:c129:d308 with SMTP id
 f2-20020a05680814c200b00326c129d308mr3746471oiw.193.1653004867457; Thu, 19
 May 2022 17:01:07 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 19 May 2022 17:01:06 -0700
MIME-Version: 1.0
In-Reply-To: <20220519164914.v3.2.I6418884d8bab6956c7016304f45adc7df808face@changeid>
References: <20220519164914.v3.1.I71e42c6174f1cec17da3024c9f73ba373263b9b6@changeid>
 <20220519164914.v3.2.I6418884d8bab6956c7016304f45adc7df808face@changeid>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 19 May 2022 17:01:06 -0700
Message-ID: <CAE-0n5025-q8H944gdFNQBdZ32jUVb1WCS0MYJ64+QmpqDm37Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/5] dt-bindings: arm: qcom: Mention that Chromebooks
 use a different scheme
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Alexandru M Stan <amstan@chromium.org>,
        "Joseph S . Barrera III" <joebar@chromium.org>,
        patches@lists.linux.dev, devicetree@vger.kernel.org,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2022-05-19 16:51:06)
> The qcom.yaml bindings file has a whole description of what the
> top-level compatible should look like for Qualcomm devices. It doesn't
> match what Chromebooks do, so add a link to the Chromebook docs.
>
> Reported-by: Stephen Boyd <swboyd@chromium.org>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> The link added here will (obviously) not function until the
> documentation patch makes it to mainline. Presumably folks who want to
> read it in the meantime can find it pretty easily. If there's a better
> way to link this then please let me know.
>
> Changes in v3:
> - ("Mention that Chromebooks use a different scheme") split out for v3.
>
>  Documentation/devicetree/bindings/arm/qcom.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 5c06d1bfc046..df5230792b37 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -90,6 +90,11 @@ description: |
>    A dragonboard board v0.1 of subtype 1 with an apq8074 SoC version 2, made in
>    foundry 2.
>
> +  There are many devices in the list below that run the standard ChromeOS
> +  bootloader setup and use the open source depthcharge bootloader to boot the
> +  OS. These devices do not use the scheme described above. For details, see:
> +  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/arm/google/chromebook-boot-flow.rst

Can you use the docs.kernel.org link instead of Linus' tree? I think it
would be

	https://docs.kernel.org/arm/google/chromebook-boot-flow.html
