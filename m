Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76C44C4F47
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 21:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235796AbiBYUJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 15:09:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiBYUI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 15:08:56 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 712931F03AD;
        Fri, 25 Feb 2022 12:08:23 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id d134-20020a4a528c000000b00319244f4b04so7841376oob.8;
        Fri, 25 Feb 2022 12:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eSN9xBrzll6WZ5DtL2zb4WDB6X1vP1dIkQzJiEVk3gs=;
        b=zu2Pcj/6rZhTNNRJ6d7Tu4gFSaTzDka5CxWjUNtymjj3llZuMI8sKJX7Pmj3h3xjQu
         KBwHmLaA3+D2rRJAE+6rbju6nhmqiVdjFS9Z2eG/oNRPvYyBjSfeCtk+TFgq1o6P/3e+
         XTJMX5SfSODCGO4HF55lpXEIbNczhDA0Vym/eQuYTYpYvqRJsWazpDiJSRgbuIkviKfE
         y79GZer59dkr6vCYfMDZBRvp0vCp+y1yuESSRna/cUIAAXVCI/9mdsigcJAoXhQQCZV3
         /Ua9B3P67G8RSonnuSlCRWmFCKm/tGNYW5iJPZPvxMoC2Cq58bhA96pv+NEV73SvMev6
         oFGQ==
X-Gm-Message-State: AOAM5306gF1R+Huh9VcZ+rTx3Vd6RH0pDMNUbQpRqKJmZWjTEdBIztgj
        uYTgAjSysIqQQxk+Orfvkg==
X-Google-Smtp-Source: ABdhPJz8rtS1F8qP+GJ8zMHk8V/DpQMJtqZDeBbUq+EMimoP4vbaCgTou2GcIA44VfSPZnqQT44Cew==
X-Received: by 2002:a05:6870:45aa:b0:d4:5d51:b0ac with SMTP id y42-20020a05687045aa00b000d45d51b0acmr2155254oao.59.1645819702787;
        Fri, 25 Feb 2022 12:08:22 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id a12-20020a9d5c8c000000b005ad51592bd8sm1600580oti.49.2022.02.25.12.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 12:08:22 -0800 (PST)
Received: (nullmailer pid 1348651 invoked by uid 1000);
        Fri, 25 Feb 2022 20:08:21 -0000
Date:   Fri, 25 Feb 2022 14:08:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>
Cc:     agross@kernel.org, bhupesh.linux@gmail.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: Re: [PATCH 2/2] dt-bindings: phy: qcom,qmp: Describe
 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties
Message-ID: <Yhk3NYfTlGqBJiz7@robh.at.kernel.org>
References: <20220224123248.67073-1-bhupesh.sharma@linaro.org>
 <20220224123248.67073-2-bhupesh.sharma@linaro.org>
 <1645711159.080022.2923124.nullmailer@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645711159.080022.2923124.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 07:59:19AM -0600, Rob Herring wrote:
> On Thu, 24 Feb 2022 18:02:48 +0530, Bhupesh Sharma wrote:
> > Since a few boards based on QCoM qmp phy use the
> > 'vdda-max-microamp' & 'vdda-pll-max-microamp' properties to
> > describe the ufs phy nodes, add them to the dt-bindings doc as well.
> > 
> > This fixes the following '$ make dtbs_check' warning(s):
> > 
> > sm8350-microsoft-surface-duo2.dt.yaml: phy@1d87000:
> >   'vdda-max-microamp', 'vdda-pll-max-microamp' do not match any of
> >    the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> > 
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Cc: Vinod Koul <vkoul@kernel.org>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/phy/qcom,qmp-phy.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> 
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
> 
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
> 
> Full log is available here: https://patchwork.ozlabs.org/patch/1597137
> 
> 
> phy@1c07000: 'lanes@1c06000' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	arch/arm/boot/dts/qcom-sdx55-mtp.dt.yaml
> 	arch/arm/boot/dts/qcom-sdx55-t55.dt.yaml
> 	arch/arm/boot/dts/qcom-sdx55-telit-fn980-tlb.dt.yaml
> 
> phy@1c0e000: 'lanes@1c0e200' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/qcom/sc7280-crd.dt.yaml
> 	arch/arm64/boot/dts/qcom/sc7280-herobrine.dt.yaml
> 	arch/arm64/boot/dts/qcom/sc7280-idp2.dt.yaml
> 	arch/arm64/boot/dts/qcom/sc7280-idp.dt.yaml
> 
> phy@1d87000: 'lanes@1d87400' does not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/qcom/sm8450-qrd.dt.yaml
> 
> phy@627000: 'vdda-phy-max-microamp', 'vddp-ref-clk-always-on', 'vddp-ref-clk-max-microamp' do not match any of the regexes: '^phy@[0-9a-f]+$', 'pinctrl-[0-9]+'
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-gemini.dt.yaml
> 	arch/arm64/boot/dts/qcom/msm8996-xiaomi-scorpio.dt.yaml

I'm curious why these are not fixed too?

Rob
