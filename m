Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046D04E59D1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 21:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243236AbiCWU2T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 16:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240196AbiCWU2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 16:28:18 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D085952
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:26:47 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-d39f741ba0so2887675fac.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CY3l8jrztmr/FmAYRC1PzFMTrDaC/FmA5umCglNQWzo=;
        b=IlojxJRbztX44z+MNWRzeHglp+pkBe0M5oL2i6Rju4lgn04LPaBdCKbcbJicv3H4jD
         Waxy6v8s3xktxMzX1+py/+mX3o6a1jjeF/atySr3zYZvWQfVQYqvwLYZ3z8AvfS1l3gL
         NUPfHl4vH2+GipPR2TsuHGkCjZgltMHc82ow7EfJxM5dv/0FWoWE3HSnShK2/CQbM6GF
         /eTftPZmpctH2pjdnvKGROplxofKGqICS7JxZzyEYkvZlETE9H38ZsuzwhuPz9rQDmK4
         xVySXS3WBuA61ZY541maNfWwuuSNorRPRGlRQZ6Fnj8z6DwuTdl58YFr09WgzEXuwQRh
         pSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CY3l8jrztmr/FmAYRC1PzFMTrDaC/FmA5umCglNQWzo=;
        b=gV30ZXzKeYLKjU5cMp6oejVF1mMXCl3DVR+GtVAPidXW6puiUNJTitOZZqlqV3XbZE
         /hXH2pB/lJgCecm+0ex2dnxsID4GUyCcKvPJieLWkoNe+zKsSPnVREDDZXRgCQAENs/F
         XaFB5LUnIxfywW+MOnhxg3QtJLu/khKP4mZeUqzrNMgICxeleTA/p8NfOkRzx/3GxM2Y
         tRpVjmIhwh9ew0q2pMCpXP7t46UyFoMqDxOTRx4+qweJqindPSznFHSzUKeDD98wHjHy
         AS+ggjL0hLiYhJvqS738ERwPZ6kuUSI6uLt3nhSblVy+fLmw/DFaAis0YdBdx5PM0p7q
         bpQA==
X-Gm-Message-State: AOAM5306TojN7+9gYWUakE67Q9qH7yC+QUxLg8CHS6aqG2UMF7apWxCZ
        ge5sfNU1XXMSlz6Lj4XjrOmhyuihP+HzQFlOpYGXkA==
X-Google-Smtp-Source: ABdhPJwGYjGEvB3uK5JSPiSaZi1AWFpDFPAHkUfpMxUdAMM7thqAGq7S5c50Og7rtJA2STFokZsz3eMKUTKBUXZI4h0=
X-Received: by 2002:a05:6870:a44c:b0:de:230:730b with SMTP id
 n12-20020a056870a44c00b000de0230730bmr906724oal.48.1648067207061; Wed, 23 Mar
 2022 13:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220303082140.240745-1-bhupesh.sharma@linaro.org>
 <20220303082140.240745-3-bhupesh.sharma@linaro.org> <YifhMiBXRMOCamOt@builder.lan>
In-Reply-To: <YifhMiBXRMOCamOt@builder.lan>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 24 Mar 2022 01:56:35 +0530
Message-ID: <CAH=2NtwVfA_OyfV3vopOWqbgv_T==Fdx-P60EniR9qYuvOnAsQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] arm64: dts: qcom: sm8150: Add ufs power-domain entries
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, bhupesh.linux@gmail.com,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, sboyd@kernel.org, tdas@codeaurora.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        robh+dt@kernel.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On Wed, 9 Mar 2022 at 04:35, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
>
> On Thu 03 Mar 02:21 CST 2022, Bhupesh Sharma wrote:
>
> > Add power-domain entries for UFS controller & phy nodes
> > in sm8150 dts.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8150.dtsi | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > index 6012322a5984..7aa879eb24d7 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> > @@ -1637,6 +1637,8 @@ ufs_mem_hc: ufshc@1d84000 {
> >                       phy-names = "ufsphy";
> >                       lanes-per-direction = <2>;
> >                       #reset-cells = <1>;
> > +
> > +                     power-domains = <&gcc UFS_PHY_GDSC>;
>
> It seems odd that the controller would be in the PHY power-domain?

Ok.

> >                       resets = <&gcc GCC_UFS_PHY_BCR>;
> >                       reset-names = "rst";
> >
> > @@ -1687,6 +1689,9 @@ ufs_mem_phy: phy@1d87000 {
> >                       clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
> >                                <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
> >
> > +                     power-domains = <&gcc UFS_CARD_GDSC>,
> > +                                     <&gcc UFS_PHY_GDSC>;
>
> And "card" is typically related to the second UFS interface, so I
> suspect you only would need the last one of these?

Right, I will send a fixed v4 version shortly.

Thanks,
Bhupesh

> > +                     power-domain-names = "ufs_card_gdsc", "ufs_phy_gdsc";
> >                       resets = <&ufs_mem_hc 0>;
> >                       reset-names = "ufsphy";
> >                       status = "disabled";
> > --
> > 2.35.1
> >
