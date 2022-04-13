Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFD384FEDF5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbiDMD6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiDMD51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:57:27 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA7613D0F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:55:07 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id a19so836806oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 20:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FvzKmQHaXA0DZABJVytp1jfjqBhOZKxzqyShV5ysPaI=;
        b=OAYW9UBBpw4A+iCY4I5EaWlkldsxeOp+anBKmwX62Q0TRRCSFVHoTCU5lunO/PwDLx
         o9Lq+MXt+IxvKdH0+TdwOTFmR5YDmI6ZONy2//sJsfgol5+xR2NEjtKeNDnKFkHRMyLX
         uQV14/xbRAHLShTXWvkTeNZPc7KBdG+lJ2ai5PR/UXkH2YMusFSkfEqo/SBYzYCMwiRZ
         4CwUcjqa5I8qMkUoPikziGCvExKSgudLFV/G9BqZmw6fXq1ERAJUJUcr8gfAmhDtNXAO
         U/SWYihomjkSpBd2ZLvLsVY6dBsmG35qBse0B1wtgjTr82HNcKu1hl4mrtjzl7oddirx
         0AMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FvzKmQHaXA0DZABJVytp1jfjqBhOZKxzqyShV5ysPaI=;
        b=VATXrxPjexDpjuukkRCtobJaJ++8cnv3obdqPbn+6PXbdJWX4PiRMtkmdlf/fWoFDb
         Ib6oi2+L6Hv3efUYrh3EVp8FU9kUdg+5A6wGkvgT1w+S52hrtWL6pTp8vLtSvgvN4vNE
         dCEdQM4LxjIT9Gch3ii/QFBvvXoO6e2QETqE78CNGIcPTKBxI4q/BUZhFbGb89L2gezW
         1Glg8AFtfJvITmFk3eSNgGptQeDeSsDYNX5PRJOGMnwQ+xBSOR+B6Q6JA6PtZkBcvXkA
         gubto6ymL5Fihc3XDRIx1ssM552SDft1ITz2lxuWoj4J0VvE/5sw9q/T2Bi68yIY5Ahy
         ASWw==
X-Gm-Message-State: AOAM532vYpPoa39Rd9RxDPkfcVA5n2zH6hm73W3izttk1Q1ndqlyyLe/
        9viEMQQsje15SOFpZkUVdgekMfLxETw8y2A6
X-Google-Smtp-Source: ABdhPJytHv9MYWBDz80W+4BG+BN0cR8bkxDn1ifdKRCOmARN+MzL0v9/ak+9qWlwCN1TEpvdUahlHA==
X-Received: by 2002:a05:6808:1201:b0:2f9:ef08:1a4f with SMTP id a1-20020a056808120100b002f9ef081a4fmr3263265oil.192.1649822106718;
        Tue, 12 Apr 2022 20:55:06 -0700 (PDT)
Received: from ripper ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id e9-20020a056820060900b003216277bfdasm13576747oow.19.2022.04.12.20.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 20:55:06 -0700 (PDT)
Date:   Tue, 12 Apr 2022 20:57:20 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8350: Add GENI I2C/SPI DMA
 channels
Message-ID: <YlZKIKR1iHO+Btwk@ripper>
References: <20220412215137.2385831-1-bjorn.andersson@linaro.org>
 <20220412215137.2385831-2-bjorn.andersson@linaro.org>
 <YlZALC0DdSPB9n+/@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlZALC0DdSPB9n+/@matsya>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 12 Apr 20:14 PDT 2022, Vinod Koul wrote:

> On 12-04-22, 14:51, Bjorn Andersson wrote:
> > The GENI I2C and SPI controllers may use the GPI DMA engine, define the
> > rx and tx channels for these controllers to enable this.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> >  arch/arm64/boot/dts/qcom/sm8350.dtsi | 108 +++++++++++++++++++++++++++
> >  1 file changed, 108 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/qcom/sm8350.dtsi b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > index 7e585d9e4c68..8547c0b2f060 100644
> > --- a/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/sm8350.dtsi
> > @@ -721,6 +721,9 @@ i2c14: i2c@880000 {
> >  				pinctrl-names = "default";
> >  				pinctrl-0 = <&qup_i2c14_default>;
> >  				interrupts = <GIC_SPI 373 IRQ_TYPE_LEVEL_HIGH>;
> > +				dmas = <&gpi_dma2 0 0 QCOM_GPI_I2C>,
> > +				       <&gpi_dma2 1 0 QCOM_GPI_I2C>;
> > +				dma-names = "tx", "rx";
> 
> I have been thinking about this. I dont feel this is right approach here
> as this is board dependent and having the firmware loaded on the board..
> 
> This was tested on HDK and can fail in MTP or other boards.. which might
> be in FIFO mode
> 

But if the controller is in FIFO mode, then !fifo_disable so we wouldn't
try to pick up the dmas. And in the opposite case, i.e. when
fifo_disable, the introduction of the GPI implementation meant that the
i2c driver wouldn't no longer probe without the dmas specified.

Unfortunately we don't have any i2c busses enabled on the MTP currently,
so I'm not able to validate this easily.


For the SPI driver though, the same logic is used to invoke
spi_geni_grab_gpi_chan(). So dmas will only be considered if
fifo_disabled is set.

That said, in the even that the SPI driver finds a fifo_disabled
controller and dma_request_chan() returns an error, we will fall back to
fifo mode instead. I'm not sure if that's desirable...

If that makes sense, we should at least handle EPROBE_DEFER instead of
falling through to fifo mode.

Regards,
Bjorn

> So, I think it might be apt to move these to board dtsi.. what do you
> think?
> 
> -- 
> ~Vinod
