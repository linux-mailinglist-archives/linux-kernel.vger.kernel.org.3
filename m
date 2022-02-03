Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE654A904B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 22:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349161AbiBCVzi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 16:55:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355558AbiBCVzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 16:55:35 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74929C06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 13:55:35 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 4so6188988oil.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 13:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=EKi8zmFFIs9yTKizbnsGRhz+ao0w4WrMRZ97vyp1W+Y=;
        b=IdeSykH50iytRrZJsr567YWJhlQaOMbwAS+475H/ax5nj9hbp8d2dBM5geJMdQfDIh
         eH/tsiq7YR0xjucM/lknhQk1DagoJcgAbLm1tqBNEc0/JcZ3G2r5SOuvB/DQbA+8Oir6
         mIGDg1l31FJneI+1B67klYZ5BOqEny+JXTZxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=EKi8zmFFIs9yTKizbnsGRhz+ao0w4WrMRZ97vyp1W+Y=;
        b=an5irUd4ykePK/VTUXZVmukyoV99L6saSwO+6TOae/XmlHa0z/Qf3fSeKiMKF7CnKn
         Jdaa+2YHHrw4jDA69n18qhJR8g/XkfxqVeNsBpgrfSfY7uPRrXHG/y3dQKaAfJShlt6S
         GsblK9p7fZyDZTx3daeZFidRN+E3n7+2dyDe+zHnPA0rViA5ZuS0spVg3I+CZALXWALO
         GgaQqFdWYSOeFyR3oPX/STKqfeUIT2TYiINOpoPTMbKuC5yTgBSQaELllznieOJyIwKu
         /cQNyQ2JqIle3KBaktegGgHSyJ175hQllpWLHdRuPlZ+9uDjgGre8YBAZBjvBhev0CVF
         FMqA==
X-Gm-Message-State: AOAM530QueF+wiC1OwJ5F1cpUl/33BTutwAmkmItsWYekpOx3/MHBVPP
        b2hrwKLicjL19scauVf2N++6ic6LCFZTF9YXGWvorw==
X-Google-Smtp-Source: ABdhPJwyKQMmXpDSqD4fAmi7HwLGWf6ShcFVyhK9CYPOoN2omLdzc9C1Blaz6joxLP5zb1UWMKSTUIM0pfRssLG1TdM=
X-Received: by 2002:aca:df82:: with SMTP id w124mr9157oig.112.1643925334493;
 Thu, 03 Feb 2022 13:55:34 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Feb 2022 21:55:34 +0000
MIME-Version: 1.0
In-Reply-To: <YfgRS/UtRn6Ewwhj@builder.lan>
References: <20220125224422.544381-1-dianders@chromium.org>
 <20220125144316.v2.5.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
 <CAE-0n528Bxdj+DKhi2Lan4qR_=4KHD7A1Zkr15tmu+MchryJ1A@mail.gmail.com>
 <CAD=FV=UcpKaLQ31CGKUnaNnZcYnM4N_t8VC43FPGktoYDiMfsw@mail.gmail.com>
 <YfC5i2jR5N+pmHoZ@ripper> <CAE-0n50sX9-0MxcpF+3Rwqm75jSw5=aNwdsitLwE2sEA69jLJw@mail.gmail.com>
 <YfgRS/UtRn6Ewwhj@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 3 Feb 2022 21:55:34 +0000
Message-ID: <CAE-0n52aRjBPz7txfQV_UAzOz+1qnG8BOwR3V32mnRVu8wEFpw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sc7280: Add herobrine-r1
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        kgodara@codeaurora.org, Matthias Kaehlcke <mka@chromium.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        Prasad Malisetty <pmaliset@codeaurora.org>,
        quic_rjendra@quicinc.com, Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-01-31 08:41:47)
> On Thu 27 Jan 15:16 CST 2022, Stephen Boyd wrote:
>
> > Quoting Bjorn Andersson (2022-01-25 19:01:31)
> > > On Tue 25 Jan 15:46 PST 2022, Doug Anderson wrote:
> > >
> > > > Hi,
> > > >
> > > > On Tue, Jan 25, 2022 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > > > >
> > > > > Quoting Douglas Anderson (2022-01-25 14:44:22)
> > > > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > > > > > new file mode 100644
> > > > > > index 000000000000..f95273052da0
> > > > > > --- /dev/null
> > > > > > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > > > > > @@ -0,0 +1,313 @@
> > > > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > > > +/*
> > > > > > + * Google Herobrine board device tree source
> > > > > > + *
> > > > > > + * Copyright 2022 Google LLC.
> > > > > > + */
> > > > > > +
> > > > > > +/dts-v1/;
> > > > > > +
> > > > > > +#include "sc7280-herobrine.dtsi"
> > > > > > +
> > > > > > +/ {
> > > > > > +       model = "Google Herobrine (rev1+)";
> > > > > > +       compatible = "google,herobrine", "qcom,sc7280";
> > > > >
> > > > > Can we stop adding "qcom,sc7280" to the board compatible string? It
> > > > > looks out of place. It's the compatible for the SoC and should really be
> > > > > the compatible for the /soc node.
> > > >
> > > > I don't have any objections, but I feel like this is the type of thing
> > > > I'd like Bjorn to have the final say on. What say you, Bjorn?
> > > >
> > >
> > > One practical case I can think of right away, where this matters is in
> > > cpufreq-dt-plat.c where we blocklist qcom,sc7280.
> > >
> > > I don't know if we rely on this in any other places, but I'm not keen on
> > > seeing a bunch of board-specific compatibles sprinkled throughout the
> > > implementation - it's annoying enough having to add each platform to
> > > these drivers.
> >
> > Looking at sc7180, grep only shows cpufreq-dt-plat.c
> >
>
> Good, then we handle all other platform specifics in drivers using
> platform-specific compatibles.
>
> >  $ git grep qcom,sc7180\" -- drivers
> >  drivers/cpufreq/cpufreq-dt-platdev.c:   { .compatible = "qcom,sc7180", },
> >
> > Simplest solution would be to look at / and /soc for a compatible
> > string.
> >
>
> You mean that / would contain the device's compatible and /soc the soc's
> compatible? I'm afraid I don't see how this would help you - you still
> need the compatible in the dts, just now in two places.

I'd like / to contain the board compatible string and /soc to contain
the SoC's compatible string. The two strings are different. In this case
the board compatible at the root would be "google,trogdor-lazor" and the
soc node compatible would be "qcom,sc7180".

>
>
> Either we leave it as is - which follows my interpretation of what the DT
> spec says - or we (and the DT maitainers) agree that it shouldn't be
> there (because this dtb won't run on any random qcom,sc7180 anyways) at
> all.

Sure. Hopefully DT maintainers can chime in here.

As you say, this dtb won't run on any random board that has a
qcom,sc7180 SoC placed on the PCB so having it in the root node
compatible is redundant at the least.
