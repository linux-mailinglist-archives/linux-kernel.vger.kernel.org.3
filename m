Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ED2A5739CF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 17:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236830AbiGMPNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 11:13:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiGMPNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 11:13:13 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B6A145F44
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:13:11 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso4185173pjc.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 08:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nHna6q8haXF012wFoVlU3mi09UNcmJSRQ4P1JKT5xOg=;
        b=CXc23FklogJD5om5a2d6XqaWm8drlrQjWI+VzShzntPDCJYUU/32ANHo0nlRqD/jce
         RsVnYDQg8oJCKAAMA5wvHkXAT4kSRxWjsFidkXSQdduRRwqYTgtWE/BgrmuW2b9a66VE
         PfGbD6jFAsn90/GhjrmzFQrgv/wMn3kNFPmMJkNpvpXBgUSg6ZdaTlj/aGrMCn24ZdVm
         4dY9YAHKqMfCQN0B0rEBNOFHDY/MoUYWDiugzIrOPgCSdbDK5LissQcyCrAD4iElyeMb
         QFCYzDzxooZz/gGb3auvrS5VIEVtlR3RJkw+s6T+m2CjYrn666JNzP2kQcGPVHFclhF2
         s2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nHna6q8haXF012wFoVlU3mi09UNcmJSRQ4P1JKT5xOg=;
        b=rm1mj+UlR9NMe/qi7Gnck3uOfql1UwiJJWFm9iBVPIEddlkv7OVAH5caNoE60ditu+
         t9KMEpP2Xs+QShJ8PIXPNMr29omBuoJXEjd0toZqdrJa52YPa5hiNbh8a+LT9W/NvKOE
         u68/UZGRSYehm85jUaErleBJLzXe6fK8kv7hr0U77v2IAhtY73Ctbly3mnTXbc+Oap6U
         nN5VsR9nLkFMyHIu24RdCeSLDzkymtUT8VWV4SjbBijq1YgQYt5QxggUdpaCSlvicbJB
         WUYFyG2d5iWXxMTXMCy9OfKtBS1RSlyFDxAYl4Chmi9H+ETE51dM+55yFzCn3Nxtk/RN
         ZypA==
X-Gm-Message-State: AJIora/5gwc5yMdr1jJo4E2K1M/O1TSwbpc2C9xA7C7M6sJ5XFOPD2wb
        a0nydebRLtqWvn6uyxJOPq04
X-Google-Smtp-Source: AGRyM1vOlU7utJFqv9U8LPiuqQgbEgKciktWFPD48RHUaXgen/iU/qGci5ug+URJIdPFy938rKFaxA==
X-Received: by 2002:a17:90a:b398:b0:1ef:7e67:6 with SMTP id e24-20020a17090ab39800b001ef7e670006mr10416045pjr.123.1657725191006;
        Wed, 13 Jul 2022 08:13:11 -0700 (PDT)
Received: from workstation ([117.248.1.226])
        by smtp.gmail.com with ESMTPSA id w185-20020a6362c2000000b0041292b732fdsm8138159pgb.38.2022.07.13.08.13.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Jul 2022 08:13:10 -0700 (PDT)
Date:   Wed, 13 Jul 2022 20:43:05 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>,
        Steve Capper <Steve.Capper@arm.com>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: Fix PMU interrupt
Message-ID: <20220713151305.GA4591@workstation>
References: <20220713143429.22624-1-manivannan.sadhasivam@linaro.org>
 <Ys7c0JGAV7AAEjaO@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ys7c0JGAV7AAEjaO@hovoldconsulting.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 04:55:12PM +0200, Johan Hovold wrote:
> On Wed, Jul 13, 2022 at 08:04:29PM +0530, Manivannan Sadhasivam wrote:
> > PPI interrupt should be 7 for the PMU.
> > 
> > Cc: Johan Hovold <johan+linaro@kernel.org>
> > Fixes: 152d1faf1e2f ("arm64: dts: qcom: add SC8280XP platform")
> > Reported-by: Steve Capper <Steve.Capper@arm.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sc8280xp.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > index 268ab423577a..2d7823cb783c 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp.dtsi
> > @@ -477,7 +477,7 @@ memory@80000000 {
> >  
> >  	pmu {
> >  		compatible = "arm,armv8-pmuv3";
> > -		interrupts = <GIC_PPI 5 IRQ_TYPE_LEVEL_HIGH>;
> > +		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
> >  	};
> >  
> >  	psci {
> 
> The interrupt number matches the vendor devicetree I have access to, but
> the vendor source also has IRQ_TYPE_LEVEL_LOW instead of
> IRQ_TYPE_LEVEL_HIGH here.
> 
> Is that another copy-paste error, perhaps?
> 

I don't have access to the documentation of this SoC now but since Steve
tried with IRQ_TYPE_LEVEL_HIGH and it worked for him, I think it is best
to leave it as it is.

Thanks,
Mani

> Johan
