Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3680E4BB07D
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 05:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbiBREE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 23:04:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiBREEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 23:04:24 -0500
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BF217AB3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:04:07 -0800 (PST)
Received: by mail-oi1-x230.google.com with SMTP id i5so1825857oih.1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 20:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Cc0i5Hp1cBO88S5Wh/ZFj+Eut0CrK1KUAXY5QZNqRaQ=;
        b=o9UodtKegmwPxKxskRsr899E/IXuMqawC9Cf54nEq4R9iKGilg2jdBYzlYIFBlQ6gS
         wy3pfVzyHt390yuVRxR4/BjLzst9tip7EK1khcTiQWhwX4gP/R0cLMHXN9yCgsZJE6pa
         w9AxRApDy3N4GsJ7wYyx4M7WsLQTbrLfDJ4YolRkbKjnejWN+VxsKEf7ex3OTW7pAaOc
         8uX41dlFYFYVHzXSsUfCFY4LtEvWsU8gwjEOF7jpMXXJQ8t3z6cUEmspqlPwZfJfnCAV
         InBF0anonulKde9PWLLay/hlaQyYqMDcIr2MXiS5CfY/p6R/N3c3W8fGaprBeMOVHquR
         JWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Cc0i5Hp1cBO88S5Wh/ZFj+Eut0CrK1KUAXY5QZNqRaQ=;
        b=x9g48X2UsgQtxqCNLq2maHO9N0oAdS5i0l7XyUYIdPkmZCd4q8PRml+9noc6EO4Wq3
         YWLtQQ8qQogMeysXNLc2vOq+e3N3oIb10AHGzkAbGzAI+B8GAbl9mTCZtW2QiGfo29R7
         bqgBH4TXe0ZZ2wxvULT8rwouMY3vPEDm22e41+Yh01Ys7u8ppI8U/gJFcTWOemwbjnZp
         oh63UanCJO0MmNarLQlfoktzW52XNW4ZhU7JCDls/NSH4e6Bt7hd01kR7BQsKwjl/L5A
         wTqQfvnnloLIbkRk930t0+Y4mrrl/hpSmGQKYXWtbelc+QavzFoTZf04PxSIzCH5PmIj
         tmwQ==
X-Gm-Message-State: AOAM530szktB4wb0IjL7GFTvt6Q4wWdzF/+qtDUsQrtE7+fXnbcGcp0V
        293hQqVvkuWSp8zaz25yzG847w==
X-Google-Smtp-Source: ABdhPJyWPzBreRtGIx5JOPbiuXWXiOhoziZlvRQeF8oTm1Z/qsXChNzghR4kvSjp6g/Mi952G5RJ8w==
X-Received: by 2002:a05:6808:bc6:b0:2d4:3b27:8ab0 with SMTP id o6-20020a0568080bc600b002d43b278ab0mr2620283oik.147.1645157047148;
        Thu, 17 Feb 2022 20:04:07 -0800 (PST)
Received: from yoga ([2600:1700:a0:3dc8:5c39:baff:fe03:898d])
        by smtp.gmail.com with ESMTPSA id bx41sm1007227oib.7.2022.02.17.20.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 20:04:06 -0800 (PST)
Date:   Thu, 17 Feb 2022 22:04:04 -0600
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Abhinav Kumar <quic_abhinavk@quicinc.com>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [Freedreno] [PATCH v2 2/2] drm/msm/dpu: Add SC8180x to hw catalog
Message-ID: <Yg8atGUSHTKG5S8G@yoga>
References: <be397e2e-05ab-5c18-8e2d-16c443f0a6d1@quicinc.com>
 <Ygvisfhi0SY6XdAz@builder.lan>
 <6a3ef247-b26b-d505-cd85-92fb277163dd@quicinc.com>
 <CAA8EJprCaiPW=Kk0B69RNNwAk0xcqaxQA031sfR0ky+BfzcWKQ@mail.gmail.com>
 <ceb861e5-b1c8-d33e-c0b0-bea0b4cc0b66@quicinc.com>
 <CAA8EJppj+OBPVUgvefO38zp1RHpJw5pL0-4DCkgn3iAcPH-ptA@mail.gmail.com>
 <d0cac12e-7c03-2ba3-fb8d-aee09b72a1b1@quicinc.com>
 <YgxbYnpbBeOIkGWi@builder.lan>
 <7b33c826-b141-c6a2-b0eb-18b99ceeda24@quicinc.com>
 <e2fab93e-82a6-4837-4ee5-ee1b16caa84d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e2fab93e-82a6-4837-4ee5-ee1b16caa84d@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Feb 19:10 CST 2022, Dmitry Baryshkov wrote:

> On 16/02/2022 05:16, Abhinav Kumar wrote:
> > 
> > 
> > On 2/15/2022 6:03 PM, Bjorn Andersson wrote:
> > > On Tue 15 Feb 19:34 CST 2022, Abhinav Kumar wrote:
> > > 
> > > > 
> > > > 
> > > > On 2/15/2022 4:20 PM, Dmitry Baryshkov wrote:
> > > > > On Tue, 15 Feb 2022 at 23:21, Abhinav Kumar
> > > > > <quic_abhinavk@quicinc.com> wrote:
> > > > > > On 2/15/2022 10:42 AM, Dmitry Baryshkov wrote:
> > > > > > > On Tue, 15 Feb 2022 at 20:42, Abhinav Kumar
> > > > > > > <quic_abhinavk@quicinc.com> wrote:
> > > > > > > > On 2/15/2022 9:28 AM, Bjorn Andersson wrote:
> > > > > > > > > On Tue 15 Feb 11:14 CST 2022, Abhinav Kumar wrote:
> > > > > > > > > > On 2/14/2022 8:33 PM, Bjorn Andersson wrote:
> > > > > > > > > > > From: Rob Clark <robdclark@chromium.org>
> > > [..]
> > > > > > > (thus leading us to cases when someone would forget to add INTF_EDP
> > > > > > > next to INTF_DP)
> > > > > > > 
> > > > > > > Also, if we are switching from INTF_DP to INTF_EDP, should we stop
> > > > > > > using end-to-end numbering (like MSM_DP_CONTROLLER_2 for INTF_5) and
> > > > > > > add a separate numbering scheme for INTF_EDP?
> > > > > > > 
> > > > > > We should change the controller ID to match what it actually is.
> > > > > > 
> > > > > > Now that you pointed this out, this looks even more confusing to me to
> > > > > > say that  MSM_DP_CONTROLLER_2 is actually a EDP controller because
> > > > > > fundamentally and even hardware block wise they are different.
> > > > > 
> > > > > So, do we split msm_priv->dp too? It's indexed using
> > > > > MSM_DP_CONTROLLER_n entries.
> > > > > Do we want to teach drm/msm/dp code that there are priv->dp[] and
> > > > > priv->edp arrays?
> > > > 
> > > > ok so now priv->dp and priv->edp arrays are also in the picture here :)
> > > > 
> > > > Actually all these questions should have probably come when we
> > > > were figuring
> > > > out how best to re-use eDP and DP driver.
> 
> Well, these questions were evaluated. And this resulted in our suggestion to
> reuse DP driver, INTF_DP type and priv->dp array.
> 
> > > > 
> > > > Either way atleast, its good we are documenting all these
> > > > questions on this
> > > > thread so that anyone can refer this to know what all was missed out :)
> > > > 
> > > > priv->dp is of type msm_dp. When re-using DP driver for eDP and since
> > > > struct msm_dp is the shared struct between dpu and the msm/dp, I
> > > > get your
> > > > point of re-using MSM_DP_CONTROLLER_* as thats being use to index.
> > > > 
> > > > So MSM_DP_CONTROLLER_* is more of an index into the DP driver
> > > > and not really
> > > > a hardware indexing scheme.
> > > > 
> > > > If we split into two arrays, we need more changes to dpu_encoder too.
> > > > 
> > > > Too instrusive a change at this point, even though probably correct.
> > > > 
> > > 
> > > I'm sorry, but performing such a split would create a whole bunch of
> > > duplication and I don't see the reasons yet. Can you please give me an
> > > example of when the DPU _code_ would benefit from being specifically
> > > written for EDP vs DP?
> > > 
> > > Things where it doesn't make sense to enable certain features in
> > > runtime - but really have different implementation for the two interface
> > > types.
> > > 
> > 
> > Like I have mentioned in my previous comment, this would be a big change
> > and I am also not in favor of this big change.
> I'm also not in favour of splitting priv->dp into ->dp and ->edp.
> 
> One of the reasons, pointed out by Bjorn, is that some of interfaces can be
> used for both DP and eDP. Adding them to either of arrays would create
> confusion.
> 
> Second reason being that introducing the split would bring in extra code for
> no additional benefits. From the DPU point of view both DP and eDP
> interfaces look the same.
> 
> > > > But are you seeing more changes required even if we just change
> > > > INTF_DP to
> > > > INTF_eDP for the eDP entries? What are the challenges there?
> > > > 
> > > 
> > > What are the benefits?
> > 
> > In terms of current code, again like I said before in my previous
> > comments several times I do not have an example.
> > 
> > I was keeping the separation in case in future for some features we do
> > need to differentiate eDP and DP.
> 
> And we also might need to separte eDP-behind msm/dp and old-8x74-eDP.
> It the same "possible" future that we might face.
> 
> > 
> > Somehow I also feel this change and below are interlinked that way.
> > 
> > https://patchwork.freedesktop.org/patch/473871/
> > 
> > The only reason we need this change is because both eDP and DP use
> > DRM_MODE_ENCODER_TMDS and specifying the intf_type directly will clear
> > the confusion because DRM_MODE_ENCODER_DSI means DSI and
> > DRM_MODE_ENCODER_VIRTUAL means Writeback but DRM_MODE_ENCODER_TMDS can
> > mean DP OR eDP interface.
> > 
> > The ambiguity was always for eDP and DP.
> > 
> > That led to the discussion about the INTF_* we are specifying in the
> > dpu_hw_catalog only to find the discrepancy.
> > 
> > So now by clearing that ambiguity that change makes sense. That
> > discussion trickled into this one.
> 
> I did some research for the INTF_*. As you probably remember (I didn't) on
> mdp4 and mdp5 chipsets we program the DISP_INTF_SEL registers, telling the
> hardware which hardware is to be driven by each of INTFs.
> The freely available 410E HRD demands that this register is written.
> 
> At some point this became unnecessary, but the DPU driver kept INTF_*
> intact. Including INTF_EDP, INTF_LCDC, INTF_HDMI, etc. However from my
> understanding INTF_EDP would correspond to older eDP interfaces, not to eDP
> panels being connected by the contemporary DP/eDP ports.
> 
> Oh, and last but not least, I'd suggest to follow downstream, which uses
> "dp" to name all of DP/EDP ports. See https://github.com/TheXPerienceProject/android_kernel_xiaomi_courbet/blob/xpe-16.0/arch/arm64/boot/dts/qcom/sdmshrike-sde.dtsi#L89
> 
> So, to summarize my proposal:
> - Keep INTF_EDP reserved for 8x74/8x84
> - Use INTF_DP for all contemporary DP and eDP ports
> - Documet this in dpu_hw_mdss.h
> - Remove INTF_EDP usage in dpu1 driver.
> 

I'm in favour of this.

Regards,
Bjorn
