Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D270E49ED49
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:16:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbiA0VQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbiA0VQL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:16:11 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A02C061747
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:16:11 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id e81so8437709oia.6
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 13:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=GDZUYkuMWQBBmOo2XxTmMtqXTiUx1YCMjMuFT8hErgI=;
        b=nwwb4fDuAam8HugRq7o7PNevR2WOWA9NCIKlQgWDvUmcTsZwDOAJagX02ZreUo2Kd7
         lrZI0xYGyeMV0rC/EenrDhUfiyBLrv1ZM9EK1rPa7CkxWYUfyOI9SZOjIseO4AFUCkZp
         9mMllhyXPZgnnGu/KIcdLB4t6MvxXW0eWYEg8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=GDZUYkuMWQBBmOo2XxTmMtqXTiUx1YCMjMuFT8hErgI=;
        b=JWx1B79CeKjQZVnDlWbC1ltGAagj2liqFfboP3pbzaZn2HX0q1mINtWcWCjI9PoVox
         bDmzWZVLctWAQl+PRxtFVUNJD+Ga6Hdfhqrc5u+KWzLzNcXXO16NS1YGgOdMca633Zmo
         25cVc1GI2JMU4CcwGCHyx1xkyVJybhjXDPFjTXwRsEkHHdWnaVtmGfsCfyLhYqxIA1wm
         lKQ8OBznehR8moyiIVFxATKsvWEE2PAd1XjWnuBOsqNaw19QJqnfEY7lA+tFNa3gX7db
         b2WFNX17plfMF16VFRP5cMMPl8KUy326n848BFlsmAt7wOECICl+jtD3NPYfe0MGU29P
         beAg==
X-Gm-Message-State: AOAM530C23Tqc6UwN9DzIpRWL/dBBKYxYYUC/YOT7X+CYdRreqmu9LSI
        dD9sWbgcMRcxiIJhXujf/LSTBd3vgU7zE+No0WinVA==
X-Google-Smtp-Source: ABdhPJwpc/YwbbOc6yye7rnotRaw1CCiHfJYsaO86ExMtKVQwkqbYf6ZiHO3kw25LE+yUwjAmj3G+7/HA+lyV7vqz6M=
X-Received: by 2002:a05:6808:190f:: with SMTP id bf15mr8219469oib.40.1643318170990;
 Thu, 27 Jan 2022 13:16:10 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 27 Jan 2022 13:16:10 -0800
MIME-Version: 1.0
In-Reply-To: <YfC5i2jR5N+pmHoZ@ripper>
References: <20220125224422.544381-1-dianders@chromium.org>
 <20220125144316.v2.5.I5604b7af908e8bbe709ac037a6a8a6ba8a2bfa94@changeid>
 <CAE-0n528Bxdj+DKhi2Lan4qR_=4KHD7A1Zkr15tmu+MchryJ1A@mail.gmail.com>
 <CAD=FV=UcpKaLQ31CGKUnaNnZcYnM4N_t8VC43FPGktoYDiMfsw@mail.gmail.com> <YfC5i2jR5N+pmHoZ@ripper>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Thu, 27 Jan 2022 13:16:10 -0800
Message-ID: <CAE-0n50sX9-0MxcpF+3Rwqm75jSw5=aNwdsitLwE2sEA69jLJw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: qcom: sc7280: Add herobrine-r1
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Doug Anderson <dianders@chromium.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@somainline.org>,
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

Quoting Bjorn Andersson (2022-01-25 19:01:31)
> On Tue 25 Jan 15:46 PST 2022, Doug Anderson wrote:
>
> > Hi,
> >
> > On Tue, Jan 25, 2022 at 2:58 PM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Douglas Anderson (2022-01-25 14:44:22)
> > > > diff --git a/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > > > new file mode 100644
> > > > index 000000000000..f95273052da0
> > > > --- /dev/null
> > > > +++ b/arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dts
> > > > @@ -0,0 +1,313 @@
> > > > +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> > > > +/*
> > > > + * Google Herobrine board device tree source
> > > > + *
> > > > + * Copyright 2022 Google LLC.
> > > > + */
> > > > +
> > > > +/dts-v1/;
> > > > +
> > > > +#include "sc7280-herobrine.dtsi"
> > > > +
> > > > +/ {
> > > > +       model = "Google Herobrine (rev1+)";
> > > > +       compatible = "google,herobrine", "qcom,sc7280";
> > >
> > > Can we stop adding "qcom,sc7280" to the board compatible string? It
> > > looks out of place. It's the compatible for the SoC and should really be
> > > the compatible for the /soc node.
> >
> > I don't have any objections, but I feel like this is the type of thing
> > I'd like Bjorn to have the final say on. What say you, Bjorn?
> >
>
> One practical case I can think of right away, where this matters is in
> cpufreq-dt-plat.c where we blocklist qcom,sc7280.
>
> I don't know if we rely on this in any other places, but I'm not keen on
> seeing a bunch of board-specific compatibles sprinkled throughout the
> implementation - it's annoying enough having to add each platform to
> these drivers.

Looking at sc7180, grep only shows cpufreq-dt-plat.c

 $ git grep qcom,sc7180\" -- drivers
 drivers/cpufreq/cpufreq-dt-platdev.c:   { .compatible = "qcom,sc7180", },

Simplest solution would be to look at / and /soc for a compatible
string.

 $ git grep -W 'soc[^:]*{' -- arch/arm*/boot/dts/ | grep compatible |
grep -v "simple-bus"

doesn't show many hits. The first hit is "ti,omap-infra" which is
actually inside an soc node, but even then I don't see anything that
matches the cpufreq-dt-plat.c lists.

----8<-----
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
b/drivers/cpufreq/cpufreq-dt-platdev.c
index ca1d103ec449..32bfe453f8b4 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -179,25 +179,29 @@ static bool __init cpu0_node_has_opp_v2_prop(void)
 static int __init cpufreq_dt_platdev_init(void)
 {
 	struct device_node *np = of_find_node_by_path("/");
+	struct device_node *soc_np = of_find_node_by_path("/soc");
 	const struct of_device_id *match;
 	const void *data = NULL;

-	if (!np)
+	if (!np && !soc_np)
 		return -ENODEV;

 	match = of_match_node(allowlist, np);
-	if (match) {
+	if (match || (match = of_match_node(allowlist, soc_np))) {
 		data = match->data;
 		goto create_pdev;
 	}

-	if (cpu0_node_has_opp_v2_prop() && !of_match_node(blocklist, np))
+	if (cpu0_node_has_opp_v2_prop() && !of_match_node(blocklist, np) &&
+	    !of_match_node(blocklist, soc_np))
 		goto create_pdev;

+	of_node_put(soc_np);
 	of_node_put(np);
 	return -ENODEV;

 create_pdev:
+	of_node_put(soc_np);
 	of_node_put(np);
 	return PTR_ERR_OR_ZERO(platform_device_register_data(NULL, "cpufreq-dt",
 			       -1, data,
