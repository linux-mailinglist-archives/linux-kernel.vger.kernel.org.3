Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B260C4C57DA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 20:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbiBZTqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 14:46:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiBZTqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 14:46:22 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49801D2B53
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:45:46 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id 12so10207091oix.12
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 11:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0LikWpQrgCEVAd/hghIBEOt7qAlJsmKHlkOI041WVQ=;
        b=JuziWhM42LSaP7+BUHxkNfGKuKIjZDXDNL1XEpuTYTW7oe2SdnYhEU0AySdOvp6JMC
         ruIMP3EnxeWKVeiJF+4C9E8b/sAAsGTa3Oy/IMwWkHspp0cDRtARxb08FKXZMybX95fe
         AO2pfTGQdRJG7iji+fehbHt+8VBIN7sg4Q4PdXx7LCI1s6ww1CVjKTrbRb/M2A09mR2I
         M1/kBcqgCHCHKFGdiT+Bw63M6cXy+LZFLGqgZCIbeKa+WqwTF9QVblH7TKam/B1/davv
         p3hVBhOnqkBeYQqPRelTIxY8gj45/QYX24Uy4U4euZLcab7xtVyoG55tl4IRv2yhB9nt
         kBsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0LikWpQrgCEVAd/hghIBEOt7qAlJsmKHlkOI041WVQ=;
        b=j9NAJDuzjq+95S2qvEev+QXPChpPbMCarYBn1Ntn3BGSo4TMFJFgfxpMIGONLyiuGS
         rIC734QlpioBSUyANMWu4yOgbTMj2/815Noq+XONWlhTSv3TnueUxS9AGCqBy4NeJKyl
         yurh894FEyww9yCSMWuN6pMK5mwasydW/GfsFQe+VvuX3x+crqe6lbGq/VY16WCKKuP+
         vyUZi7osI+WfPekX8bY7Mlm8TQafEFYD1OJEg7sR5xT+Bxz30VSPHQNb1O+xaSgXn2o2
         H9dI/i+n7XKFW+4gi/9vXm0kWdz+8Wfc83jPad+HcC9RvENRmdKIHWMJoBI2MfE08gip
         +SMA==
X-Gm-Message-State: AOAM533ds9ZQs/LCzkpyhq0l/GBx/PH44gbmM2BFZIGD6Dpxdfi31D3c
        +v6XBRrie37JANP5I/IEt35P9nrcnjalSmtOTMjtOA==
X-Google-Smtp-Source: ABdhPJz786dnCnXNbTmV4p7Lmn17CQKnslbaJbIHJHc3Hu4lN30zOMD6daZAI1f/AcIyRbYaTykSNVg2TOhmALI/MYY=
X-Received: by 2002:a54:4494:0:b0:2d7:652b:287 with SMTP id
 v20-20020a544494000000b002d7652b0287mr3117288oiv.126.1645904746192; Sat, 26
 Feb 2022 11:45:46 -0800 (PST)
MIME-Version: 1.0
References: <20220224123248.67073-1-bhupesh.sharma@linaro.org>
 <20220224123248.67073-2-bhupesh.sharma@linaro.org> <1645711159.080022.2923124.nullmailer@robh.at.kernel.org>
 <Yhk3NYfTlGqBJiz7@robh.at.kernel.org>
In-Reply-To: <Yhk3NYfTlGqBJiz7@robh.at.kernel.org>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Sun, 27 Feb 2022 01:15:35 +0530
Message-ID: <CAH=2Ntzyd3=fh5PDhHDrUAFTX9GJ6NtNubdPFHqddo3PzyY4xA@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: phy: qcom,qmp: Describe
 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties
To:     Rob Herring <robh@kernel.org>
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Sat, 26 Feb 2022 at 01:38, Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Feb 24, 2022 at 07:59:19AM -0600, Rob Herring wrote:
> > On Thu, 24 Feb 2022 18:02:48 +0530, Bhupesh Sharma wrote:
> > > Since a few boards based on QCoM qmp phy use the
> > > 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties to
> > > describe the ufs phy nodes, add them to the dt-bindings doc as well.
> > >
> > > This fixes the following '$ make dtbs_check' warning(s):
> > >
> > > sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
> > >   'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of
> > >    the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> > >
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Cc: Vinod Koul <vkoul@kernel.org>
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 ++++++++
> > >  1 file changed, 8 insertions(+)
> > >
> >
> > Running 'make dtbs_check' with the schema in this patch gives the
> > following warnings. Consider if they are expected or the schema is
> > incorrect. These may not be new warnings.
> >
> > Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> > This will change in the future.
> >
> > Full log is available here: https://patchwork.ozlabs.org/patch/1597137
> >
> >
> > phy@1c07000: 'lanes@1c06000' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> >       arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
> >       arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
> >       arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml
> >
> > phy@1c0e000: 'lanes@1c0e200' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> >       arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
> >       arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
> >       arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
> >       arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
> >
> > phy@1d87000: 'lanes@1d87400' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> >       arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml
> >
> > phy@627000: 'vdda-phy-max-microamp', 'vddp-ref-clk-always-on', 'vddp-ref-clk-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> >       arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
> >       arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml
>
> I'm curious why these are not fixed too?

Seems I missed this one. Will fix this in v2.
Thanks for pointing it out.

Regards,
Bhupesh
