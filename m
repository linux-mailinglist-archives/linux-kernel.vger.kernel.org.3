Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4958857B1CB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbiGTHbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbiGTHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:31:34 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F17643FE
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:31:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id w185so15811713pfb.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=OlI5K6hu0PIeIC5kQr6NxkHuZecsOQMdSETH93bObWI=;
        b=JlLadA0btMp8/Wt2su+XdXo3jJ6NeFh8YCR6NPg7ELulYq4egINo2hjtIavkawWNYa
         zxdCfZgQ5GuIdiiJ8NkXVPqO221C6D7ncIO5EPDun5BURqITg2gV5ceKG7cp5shLswyq
         44joKw4hb5KXLTX3Ku8wmzwws2TJdn5h2RBXDB4cdW4dbl/cpEqveU6b2RZ1jOE44Za+
         VGY82r1xeqd8KOT380+UcgMSdSbef/BOQmgnvGqg8hA30xeKqWkMJoT80AkmdVHZCwb1
         8uEBStlxEBHFD1wj5cGdvnnhRsG6o+0hJAtQg3sVsrS2rwSQMQoj8GdllKQHl3v32ks4
         3fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=OlI5K6hu0PIeIC5kQr6NxkHuZecsOQMdSETH93bObWI=;
        b=IfQw3wXtP9BO/j/TXWAcbs4teCh/R+9A+p1PQdn5Fk/qtQppl1wUBlyw89gmEmEnbm
         8JGqT98YOoJWOIbEc+PMVy2SDdPSqit2TrWhfdxSK5o/9SfXSRByGbiYfccY1p2HNhrJ
         eMX6sC0hXmAdBOfhuDoCcOpRHRu2OzlKUhfBkSrmqR+xmTB+tlLxTvT2RXAszix3P3Vu
         Fuse2Dh8KQMDZWeRW+lV1lzZ4f/wB/TuSOB/mQICkyFH/bt6EvVw3slgdw2fwHnSBsTb
         Em01yq0rzU2iVnSiP6VGBu63Q8VuPRZqJAuxqjl1kBnx1c3VKbnpsHtCnF7UaheymDv5
         YDbg==
X-Gm-Message-State: AJIora8IQEEVNRQCEdcSUumeXs78gRhGybq9NvHDyQLqnne8fpoan4EW
        cp6yruRfQLFmqyUaQjsG9YP9Hg==
X-Google-Smtp-Source: AGRyM1uyvRWCfiAYoI2uRyF7TOSUjHofkF+4bMoix38rm0MUBTo+VbC92LtKHDUz2f5ngGhfoSd5TA==
X-Received: by 2002:a05:6a00:24cc:b0:50d:58bf:5104 with SMTP id d12-20020a056a0024cc00b0050d58bf5104mr37881853pfv.36.1658302292028;
        Wed, 20 Jul 2022 00:31:32 -0700 (PDT)
Received: from ?IPV6:2401:4900:1f3b:709e:6fec:df37:6562:5a80? ([2401:4900:1f3b:709e:6fec:df37:6562:5a80])
        by smtp.gmail.com with ESMTPSA id s12-20020a17090a948c00b001f21f7821e0sm543535pjo.2.2022.07.20.00.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Jul 2022 00:31:31 -0700 (PDT)
Message-ID: <60483c44-bc24-2b18-f93d-b67e437b5b72@linaro.org>
Date:   Wed, 20 Jul 2022 13:01:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   bhupesh.sharma@linaro.org
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, linux-leds@vger.kernel.org, pavel@ucw.cz,
        bhupesh.linux@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] arm64: dts: qcom: Fix 'dtbs_check' errors for pm8350c
 & sc8280xp pwm nodes
References: <20220719205058.1004942-1-bhupesh.sharma@linaro.org>
 <Ytct7QzHOlvXH7s3@builder.lan>
In-Reply-To: <Ytct7QzHOlvXH7s3@builder.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 7/20/22 3:49 AM, Bjorn Andersson <bjorn.andersson@linaro.org> wrote:
> On Tue 19 Jul 15:50 CDT 2022, Bhupesh Sharma wrote:
> 
> > make dtbs_check currently reports the following errors
> > with pm8350c & sc8280xp pwm nodes:
> >
> > arch/arm64/boot/dts/qcom/sc7280-herobrine-herobrine-r1.dtb:
> >   pwm@e800: 'reg' does not match any of the regexes:
> >   '^led@[0-9a-f]$', 'pinctrl-[0-9]+'
> >
> > Fix the same.
> >
> > Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > ---
> >   arch/arm64/boot/dts/qcom/pm8350c.dtsi        | 1 -
> >   arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi | 1 -
> >   2 files changed, 2 deletions(-)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pm8350c.dtsi b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> > index e0bbb67717fe..33f939132571 100644
> > --- a/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pm8350c.dtsi
> > @@ -32,7 +32,6 @@ pm8350c_gpios: gpio@8800 {
> >   
> >   		pm8350c_pwm: pwm@e800 {
> 
> You need to also drop the unit address.
> 
> That said, looking at the dts it's quite nice to have the address of
> these nodes. So perhaps we should fix up the binding and populate reg
> instead?

Well, leaving the unit address in the node label was done to
preserve the address information which might be needed later
(for better readibility).

However, fixing up the binding and populating reg property would
make more sense if the driver actually needs it. Looking at the
qcom led driver in its current form, it doesn't seem to require the
same. Please correct me if I am wrong (as I just had a quick look
at the same).

However, if we still want to have the unit addresses and the reg
property for better readibility in the dts, may be we can mark reg
as an optional property in the binding and leave it up to the
driver to use it (with a future update) optionally.

Please let me know your views.

Regards,
Bhupesh 


> >   			compatible = "qcom,pm8350c-pwm";
> > -			reg = <0xe800>;
> >   			#pwm-cells = <2>;
> >   			status = "disabled";
> >   		};
> > diff --git a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > index ae90b97aecb8..69f5bc8127b2 100644
> > --- a/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi
> > @@ -62,7 +62,6 @@ pmc8280c_gpios: gpio@8800 {
> >   
> >   		pmc8280c_lpg: lpg@e800 {
> >   			compatible = "qcom,pm8350c-pwm";
> > -			reg = <0xe800>;
> >   
> >   			#address-cells = <1>;
> >   			#size-cells = <0>;
> > -- 
> > 2.35.3
> >
> 
