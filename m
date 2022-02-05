Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4004AA618
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379077AbiBEC7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:59:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233604AbiBEC7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:59:38 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9FD8C061347
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 18:59:37 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id i5so10780163oih.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 18:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=3E97oia/JHaNqBCi+pHPXm+51pzS7ZsSOY26FuQtaE8=;
        b=Izo/qosg1QFKozQ4T+Mq4wtokc/McTYHZUY7byCX/tba8ExWdVQBoHym+aDzBmMckO
         E85lZe7Z60wZEoX7rBWCrkJ7MZ1iI0RSUiFEjzuRBrYNusE4GlsFhJQXz1E+PUt8FFD4
         6nVr9WG0S7GASSG7UtSon+Sgkl3Os+OVK4F+E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=3E97oia/JHaNqBCi+pHPXm+51pzS7ZsSOY26FuQtaE8=;
        b=W7AXhWkyHdXw7odmoIsi/KGDaO6x21DN2Kdio9EvzS8VH35B22oXQWJjiKUm7NSbBm
         JyUZcACXSIeNy26nDxKcOf2iNokn9eUBwRbaUjClRopgXvrCWDuQTCbTpu3KVd0Uf877
         1VmMBvNZC25+NIu1N1iBE8P4E0pEjchxvxQt3ePGtpUCgJ4o+mKLbNxe7ni/GKhIXrYs
         OYminL8LBiOeS5lIfIu2fP4/nBBCxKeOMfn1pQjl80IKv+gOp12MUc7IZ6Rxwv7mc6rS
         PSgs+mZCI4VPgtObgGaXBo9GeBvae54Ev1hO+td7iWIYtXPACPLJvkln5J/nX6jywIQI
         Y3Yw==
X-Gm-Message-State: AOAM530C7w1Q9XeQwZgr/2830D1Xuz5uphUGcsrLjrwUOUA65pU6PoZu
        63txHExZGJsHKwZyGxILDd/uMb9S2mJ+tPaPK/Ix5w==
X-Google-Smtp-Source: ABdhPJzBMdhfN5XAUxJYi7hcdSltX/9lXCx+IEr6KOg6sxh37lN6ibOwZV2quJu2FGLM+RKLntEyCSEkpMwxh64+z/E=
X-Received: by 2002:a05:6808:190f:: with SMTP id bf15mr2846900oib.40.1644029977069;
 Fri, 04 Feb 2022 18:59:37 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 5 Feb 2022 02:59:36 +0000
MIME-Version: 1.0
In-Reply-To: <Yf2f8Az5v1TtlAjd@builder.lan>
References: <20220202212348.1391534-1-dianders@chromium.org>
 <20220202132301.v3.13.I7924ce4592e3e75b2293804d8a3f8a4dae44646e@changeid> <Yf2f8Az5v1TtlAjd@builder.lan>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Sat, 5 Feb 2022 02:59:36 +0000
Message-ID: <CAE-0n50mJD_P6KBS9xesoVb4to=cBqBhU4cLtjUdK2Gb-cXgiw@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] arm64: dts: qcom: sc7280: Add the CPU compatible
 to the soc@0 node
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
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2022-02-04 13:51:44)
> On Wed 02 Feb 15:23 CST 2022, Douglas Anderson wrote:
>
> > We'd like to start including the CPU name as the compatible under the
> > "soc" node so that we can get rid of it from the top-level compatible
> > string.
> >
> > Suggested-by: Stephen Boyd <swboyd@chromium.org>
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > Probably needs a .yaml file somewhere?
> >
> > Changes in v3:
> > - ("sc7280: Add the CPU compatible to the soc@0 node") new for v3.
> >
> >  arch/arm64/boot/dts/qcom/sc7280.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > index 618ae0407cd6..2bfc919d4018 100644
> > --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> > @@ -573,7 +573,7 @@ soc: soc@0 {
> >               #size-cells = <2>;
> >               ranges = <0 0 0 0 0x10 0>;
> >               dma-ranges = <0 0 0 0 0x10 0>;
> > -             compatible = "simple-bus";
> > +             compatible = "qcom,sc7280", "simple-bus";
>
> To me this implies that /soc represents the sc7280, but as noted earlier
> I don't think that's accurate. E.g. if this node represents the sc7280,
> why are the cpus described outside this node?

They're outside the soc node because cpus have historically been
described at the root of the DT. The concept of an 'soc' node came after
the cpu nodes.

>
> Further more, if we look at the reg nodes on this bus it's clear that
> this is some mmio bus, which per the ranges has 36 bit address width.
> But not all buses in the sc7280 has 36 bit address width, so it's not
> inconceivable that one would actually have to split /soc into more than
> one entity with different dma-ranges. Perhaps not today, but I don't
> like the precedence it sets.
>

That should be fine. We can separate the nodes inside the soc node if we
need to by having different bus nodes underneath the soc node and then
change the dma-ranges within those bus nodes accordingly. We wouldn't
introduce another soc node to solve this problem.
