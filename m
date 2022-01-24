Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0929549A030
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1842467AbiAXXBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 18:01:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457247AbiAXVzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:55:04 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E0EC07E29C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:36:15 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id s6-20020a0568301e0600b0059ea5472c98so8171695otr.11
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 12:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=PkiyCREFdDaGIz9ootXkRn4vBH0SG43WzFjcqohSdxE=;
        b=biOqTlThtS/kKRPHpFYqWrxAwuQaMZI15zc24si1Wm+TD/mrKND7TxExKoLi2+9kp0
         FcdKYe5w1fL/KrNuHAszHjMF5cLUTcYTjpC3AhiqtQBy2K9FJa2FroQF7dtYyh2lJjIs
         h/KYnGpCPUjgUVSn7HLCzgEVPJlCyZqISWZsU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=PkiyCREFdDaGIz9ootXkRn4vBH0SG43WzFjcqohSdxE=;
        b=IA36Ewr6SirPvbJmBo+R9PRnj/aV1XFAKp8ivrLI4DII0SpM3/8urdoZJ5O4MUFuF9
         bcPQ8tLzpZGP4Ac2ycK9JAsDQel/H69eu0SoO/REZ4Q55CpOtFRVJAbMXFgWRgIZViWQ
         2mJgtQj+umOwZZ5NpCu6MCGl5v2ng26N87kJGHPxnct7DmAzGfTkehvnAYTPfYW5A9gB
         x8Sg5rtUCqD8X0SL22btt4KmfeEf2ch3vyYMWAi50uFQz0QC5Fcj1R8TI2tkI4qaLqTP
         u3Qp6qsMIXt1isn5NI9k3PmPUrRg/EYupSzygHNX4deyu98ttYp5nCVBYvYKGQoSXhen
         d8wQ==
X-Gm-Message-State: AOAM533RUj+sSYzOT35FbG1LA+poY4S4a8KFsAV1akSqLqA+yQzD7v82
        VzfaYuY2iJhbfont+H7x770qBK/itJv+93K5v8qefA==
X-Google-Smtp-Source: ABdhPJyxhFIp4/kCVNQxrNu/5xh5KN6eRGvC7N5UC82evKraUAWIo6YaGg5L86kMXzG26rnOtUUc/TxoeGmN9iLqz7o=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr6147866ots.159.1643056574994;
 Mon, 24 Jan 2022 12:36:14 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Jan 2022 12:36:14 -0800
MIME-Version: 1.0
In-Reply-To: <CAD=FV=X3+MDOMEidLbdgvcHVSObO=_x3KSLe31hr-TP6B2jCEg@mail.gmail.com>
References: <20220124165745.16277-1-tdas@codeaurora.org> <CAD=FV=X3+MDOMEidLbdgvcHVSObO=_x3KSLe31hr-TP6B2jCEg@mail.gmail.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Mon, 24 Jan 2022 12:36:14 -0800
Message-ID: <CAE-0n50aF9tvYFy+_zV1R00KG1T4oKsrNt6LLL5Hi_uiLFVCNA@mail.gmail.com>
Subject: Re: [PATCH v1] arm64: dts: qcom: sc7280: Add lpasscore & lpassaudio
 clock controllers
To:     Doug Anderson <dianders@chromium.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Doug Anderson (2022-01-24 12:33:06)
> Hi,
>
> On Mon, Jan 24, 2022 at 8:58 AM Taniya Das <tdas@codeaurora.org> wrote:
> >
> > Add the low pass audio clock controller device nodes.
> >
> > Signed-off-by: Taniya Das <tdas@codeaurora.org>
> > ---
> > Dependent onLPASS clock controller change: https://lkml.org/lkml/2022/1/24/772
> >
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 43 ++++++++++++++++++++++++++++
> >  1 file changed, 43 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index 937c2e0e93eb..0aa834ce6b61 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -8,6 +8,8 @@
> >  #include <dt-bindings/clock/qcom,dispcc-sc7280.h>
> >  #include <dt-bindings/clock/qcom,gcc-sc7280.h>
> >  #include <dt-bindings/clock/qcom,gpucc-sc7280.h>
> > +#include <dt-bindings/clock/qcom,lpassaudiocc-sc7280.h>
> > +#include <dt-bindings/clock/qcom,lpasscorecc-sc7280.h>
>
> Presumably using these two include files means a dependency on things
> landing in the clk tree [1]. Unless Stephen and Bjorn want to work
> something out, I'd guess you'll need to re-post with just hardcoded
> numbers for now?
>

Bjorn will apply both patches so the dts patch can live atop the clk
one.
