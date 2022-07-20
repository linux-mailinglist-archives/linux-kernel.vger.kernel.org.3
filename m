Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDFA57BC6B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238243AbiGTRNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiGTRNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:13:32 -0400
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4456E2D5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:13:28 -0700 (PDT)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-10d6e8990b9so8843128fac.7
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HoP+LDu/HU1wF9IJGHDMn+kWOAJedFh1FJBO+Y+m9wI=;
        b=mogf7qsz00X1dIofsTzhlhaPLNxuzV7xf5lmsre8ViU0i14/IFMwJON2x3AZlcT1Au
         o6zaNwrOtvUSqHpzvxHEtcEhQaosccc1HW4J+orBHHbHQXVGc1pSS04IoBfLs3lwYUDU
         sjzdr+wnIOF8jWNcxL21HMLCo3iT8rxTnsKi1sX+RQ8+1LzKPwOflVqFNRpP8+n0vPO6
         4PpGJz/xmINnvdF4VD7L4b+eB1zQJNT4jT4FFQbhzbXxaWW2QFAJ2uoRYlaxegEwhQOa
         2XFlyOh5tEPw8cuJjuCUbrf/siSDhYUrRmu8KNAvaTWUjNueicTdFdmUUL5zFFrvQ71J
         P2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HoP+LDu/HU1wF9IJGHDMn+kWOAJedFh1FJBO+Y+m9wI=;
        b=o4PRSV5e9q60Oo8knWDyLmZ040PU8LZj8FU/KQHRXN/31caoE5Cun1SyK3/UE2gDr0
         vYttD2RC1lOGGSQ6iVHnw7al0M4j4ZOQxcvPzR6KRUPVQi0tJPURcR5k2/jXAcKrW7g/
         uNE1+QRUyr0I5u5TPiKcVrRCrTzTZ+rqjWemit4cQVbVsP9+cnRzSYEF7bhY3aBX7Kci
         XNOjkERCz+HcEHP+2VgLhBWT7UllRjOpWvBN3VfuAnDCmy2QkNa4lrj2wJMmc2l4jo9/
         tQ14qgtqfcVhVH4zGxurTrZRpfT/TZIRuPHCA9tM1ywwh+YUPtvAfPMr8zLoicKaBEqO
         2twg==
X-Gm-Message-State: AJIora9rH/3DEzxPn/I7jp4RXoQ64EMKvdjTKzVJpoe7mMJzN1kcO4sb
        JtO76S+EnkMCjxP9E7uH0ZiK8Q==
X-Google-Smtp-Source: AGRyM1tnBFgAG96T7IMdNWYNomxwnFUGQntX/YkIBjaKisDyxSyyf069GIvfZFr1FyzvGFm1JGOfLw==
X-Received: by 2002:a05:6870:d5a3:b0:f2:c923:682f with SMTP id u35-20020a056870d5a300b000f2c923682fmr3081371oao.120.1658337208046;
        Wed, 20 Jul 2022 10:13:28 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 189-20020aca07c6000000b00334c2e81dfbsm6831525oih.0.2022.07.20.10.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:13:27 -0700 (PDT)
Date:   Wed, 20 Jul 2022 12:13:24 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     bhupesh.sharma@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, linux-leds@vger.kernel.org, pavel@ucw.cz,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: Fix 'dtbs_check' errors for
 pm8350c & sc8280xp pwm nodes
Message-ID: <Ytg3tIaL5h5b9ewH@builder.lan>
References: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
 <Ytct7QzHOlvXH7s3@builder.lan>
 <60483c44-bc24-2b18-f93d-b67e437b5b72@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60483c44-bc24-2b18-f93d-b67e437b5b72@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 20 Jul 02:31 CDT 2022, bhupesh.sharma@linaro.org wrote:

> Hi Bjorn,
> 
> On 7/20/22 3:49 AM, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> > On Tue 19 Jul 15:50 CDT 2022, Bhupesh Sharma wrote:
> > 
> > > make dtbs_check currently reports the following errors
> > > with pm8350c & sc8280xp pwm nodes:
> > >
> > > arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb:
> > >   pwm@e800: 'reg' does not match any of the regexes:
> > >   '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
> > >
> > > Fix the same.
> > >
> > > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >   arch/arm64/boot/dts/qcom/pm8350c.dtsi        | 1 -
> > >   arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 1 -
> > >   2 files changed, 2 deletions(-)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/pm8350c.dtsi b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> > > index e0bbb67717fe..33f939132571 100644
> > > --- a/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> > > @@ -32,7 +32,6 @@ pm8350c_gpios: gpio@8800 {
> > >   >   		pm8350c_pwm: pwm@e800 {
> > 
> > You need to also drop the unit address.
> > 
> > That said, looking at the dts it's quite nice to have the address of
> > these nodes. So perhaps we should fix up the binding and populate reg
> > instead?
> 
> Well, leaving the unit address in the node label was done to
> preserve the address information which might be needed later
> (for better readibility).
> 

Right, I like this part.

> However, fixing up the binding and populating reg property would
> make more sense if the driver actually needs it. Looking at the
> qcom led driver in its current form, it doesn't seem to require the
> same. Please correct me if I am wrong (as I just had a quick look
> at the same).
> 

That is correct, the current Linux implementation does not make use of
this information.

> However, if we still want to have the unit addresses and the reg
> property for better readibility in the dts, may be we can mark reg
> as an optional property in the binding and leave it up to the
> driver to use it (with a future update) optionally.
> 

Requiring the property only means that the dts is required to have it
specified, not that the driver actually needs to read and use it.

So I'm in favor of amending the DT binding to have the reg specified -
and leaving the Linux driver as is.

Thanks,
Bjorn

> Please let me know your views.
> 
> Regards,
> Bhupesh
> 
> 
> > >   			compatible = "qcom,pm8350c-pwm";
> > > -			reg = <0xe800>;
> > >   			#pwm-cells = <2>;
> > >   			status = "disabled";
> > >   		};
> > > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > > index ae90b97aecb8..69f5bc8127b2 100644
> > > --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > > @@ -62,7 +62,6 @@ pmc8280c_gpios: gpio@8800 {
> > >   >   		pmc8280c_lpg: lpg@e800 {
> > >   			compatible = "qcom,pm8350c-pwm";
> > > -			reg = <0xe800>;
> > >   >   			#address-cells = <1>;
> > >   			#size-cells = <0>;
> > > -- > 2.35.3
> > >
> > 
