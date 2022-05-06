Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4F351CFD8
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 05:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388816AbiEFDxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 23:53:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385096AbiEFDxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 23:53:20 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6456845510
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 20:49:38 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id y14-20020a9d460e000000b00605ee347da1so4206163ote.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 20:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gY3JG7TDfX21nMa2WGN3YpZ2LNRhrr+YzDEPbalak5Q=;
        b=rm12KW9WahZ+pwPBKCJVM2MEWPGf3QaPgdfV77GxfU+PL9qPHhQVxFbBNl1/wX6mMb
         33mlJ2qzs/GataHnbdbJbQFsz94LjdsexJKnrSK4xud5V34rQsH0Qnjmfl1s3dJ1isoB
         49+bB0vzHKrwQM2YNOsVxZHVe7mnBW/dsJTBJaUYxSZwR/g4aTpFnDVXJz0BIQBJwGAo
         csegzBQNKgbI+Cr0+u7SiO4kMSkoFuSfcHOjPE9kFqfD+BQeecZKjqxYmg4gWXdIMx6K
         t3c3SdZcrqBCnZZb3wt5DxgF2PPaMG6vq3yaTpGrZpvJAHkxUjF8L4FifGsxvJygyJZj
         LVhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gY3JG7TDfX21nMa2WGN3YpZ2LNRhrr+YzDEPbalak5Q=;
        b=tVJcp/sFdNAvDt9c/0jTYPkQdoImUNsLAgx8OZ8Upu/9BokqZ17E/Ul7IUZJbmulio
         hE3T+6Y4tOxQ6MNgHOxlzJ+4z7dAMCaxEmNF2Or3mJSxzbB90HKS44MIMuP2h3QjmbbO
         oL/0sMlOOKi9ViFYh3y6CWuHjIhA7jxn9FNysRfDiikvOHBFRXEx3DWKj/RPOp1HsbEQ
         /EIWGN9CmdHnPDvyolV25/QqbiGoflcNDcVw00w4B8dKGQsi2xIFRrsTyXCZTHwzKtAB
         dSoK3u/Uc8rHrJYEhWWkHQs3IpKP5205yGHiy+w/AbBiocINI9J0JL4+WoBi9BtK7ww8
         iHWA==
X-Gm-Message-State: AOAM531F1Gv4XjVtAe89CioiHvgkQ4r/ss4Zd6PA4r3Qz2mnZX4GOScs
        Cjx3OIOWd1Svr0/4lp9/Y36v/A==
X-Google-Smtp-Source: ABdhPJxdBvt/VaAntv7NqdoCyyrKBD09j8Ynb47Z79pap61Oi/wfCocwQtV6PkRBZzAZIdQJH633Kw==
X-Received: by 2002:a05:6830:4420:b0:606:64a6:1deb with SMTP id q32-20020a056830442000b0060664a61debmr93692otv.236.1651808977637;
        Thu, 05 May 2022 20:49:37 -0700 (PDT)
Received: from builder.lan (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id w14-20020a056870e2ce00b000e686d13887sm1150364oad.33.2022.05.05.20.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 20:49:36 -0700 (PDT)
Date:   Thu, 5 May 2022 22:49:34 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH 1/2] ARM: dts: qcom: Add LPG node to pm8941
Message-ID: <YnSazu3rcBMFPxYw@builder.lan>
References: <20220504205411.1510667-1-bjorn.andersson@linaro.org>
 <12122358.O9o76ZdvQC@g550jk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12122358.O9o76ZdvQC@g550jk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 05 May 03:01 CDT 2022, Luca Weiss wrote:

> Hi Bjorn,
> 
> On Mittwoch, 4. Mai 2022 22:54:10 CEST Bjorn Andersson wrote:
> > The PM8941 contains 8 LPG channels, as well as TRILED and LUT blocks.
> > Add a node for these.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm/boot/dts/qcom-pm8941.dtsi | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/qcom-pm8941.dtsi
> > b/arch/arm/boot/dts/qcom-pm8941.dtsi index cdd2bdb77b32..7881a071b372
> > 100644
> > --- a/arch/arm/boot/dts/qcom-pm8941.dtsi
> > +++ b/arch/arm/boot/dts/qcom-pm8941.dtsi
> > @@ -144,6 +144,15 @@ pm8941_1: pm8941@1 {
> >  		#address-cells = <1>;
> >  		#size-cells = <0>;
> > 
> > +		pm8941_lpg: lpg {
> > +			compatible = "qcom,pm8941-lpg";
> > +
> > +			#address-cells = <1>;
> > +			#size-cells = <0>;
> 
> Just curious, why doesn't pm8941 have #pwm-cells = <2>; like the other lpg 
> nodes in [0]?

I guess I didn't have a need for the lpg to be a pwm-chip on this pmic,
yet. This could be added now, or at a later point when someone has a
usecase for the pwm-chip.

> Other than that, the node works fine on pm8941. Will send a patch for enabling 
> notification LED on msm8974-FP2 soon.
> 

If you turn that into a Tested-by, and preferably a Reviewed-by, I would
have what I need to merge the two changes.

Looking forward to the FP2 patch.

Thanks,
Bjorn

> Regards
> Luca
> 
> [0] https://lore.kernel.org/linux-arm-msm/20220505022706.1692554-2-bjorn.andersson@linaro.org/
> 
> 
> > +
> > +			status = "disabled";
> > +		};
> > +
> >  		pm8941_wled: wled@d800 {
> >  			compatible = "qcom,pm8941-wled";
> >  			reg = <0xd800>;
> 
> 
> 
> 
