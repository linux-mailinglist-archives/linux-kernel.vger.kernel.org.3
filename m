Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1984D7B08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 07:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236483AbiCNGzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 02:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236474AbiCNGzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 02:55:50 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA593FBED;
        Sun, 13 Mar 2022 23:54:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id n18so10047215plg.5;
        Sun, 13 Mar 2022 23:54:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ty6PwcxLzIVrqLfmu+9Ne928mUjT7ENA64son7AJAZo=;
        b=ZGY/KZNA9gTe1grOsoHZT2V1gfXNR7zcB/QMdQc0lY0zzvx6LFNO89ToSoVPvcwdKS
         aMA4qwy4WgaS2gGCJIZUUIszGUL0empqFJVQar4anjnNgukjglDVIzdnng1IkGQ+a4Af
         gnxIdAI9C9/7KOcV2Wu/WR41fNqYybY4sC3gyrWMH0O/XZICKRSflhJ27SgG4K9U2kLN
         d3VBgGhPXuB3BT0PWX8sITD/5PRzmNLaEXV1l0U71G5DpPALuwzS6wJ+RIuZ+oOGvddg
         5z3OwlP+A+BRDd7VtejvLIVjMBrnxDrb9IZoOiCgO1k/m8XL7OC6t2A0k93ZDeaeWxfg
         TcOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ty6PwcxLzIVrqLfmu+9Ne928mUjT7ENA64son7AJAZo=;
        b=YcuHHqbjD83bTnT3xirWmcafeuAIZrmDVyDpZCdpzv3KylKlATz2q6gjuzRH1wanAA
         z+Sp8dp14E0Ux17KHdeUeYOP2BFt+cFyKHtlNmLkl4lkBJrlEbfeObtyFlXQYLLN8S/X
         sO+ANnV99RVumV2xOxYdfMAjVxyUtRFV9XxGsyR/O6oUH0ECozF1T2Iev17iX0nnsw0I
         aq815rfnFHg7cORPCxD/lRGynoRcYsgXSJ2L+zYCO0/BZ4P7eI1cIlrdq6RQu0FOVv4d
         v2jV0oKaiRyXKt/tj0/Ri+KWRPCMb4ZWj282U3FzOHYR0n1Eas61GYs/69PxykbWX6fU
         JdlQ==
X-Gm-Message-State: AOAM5337WFMXLaC00gdZK/8k872OnWKY3l/VEJRkD9SWWh/QBdZcIWTe
        K3eKeL1GlHBtjbN5s5/rDYNgFOpmvUI=
X-Google-Smtp-Source: ABdhPJy9dg1ytDwWF5oBI9JRVSns4+X/cV/eUxiu8GWjgUVo7wm+A3Nzdx5ki2X39sTeFdtdRP7LfA==
X-Received: by 2002:a17:90a:430d:b0:1bc:f340:8096 with SMTP id q13-20020a17090a430d00b001bcf3408096mr23455757pjg.93.1647240880682;
        Sun, 13 Mar 2022 23:54:40 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.53.68])
        by smtp.gmail.com with ESMTPSA id p17-20020a639511000000b0038108d69e8fsm9310536pgd.53.2022.03.13.23.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 23:54:40 -0700 (PDT)
Date:   Mon, 14 Mar 2022 12:24:34 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220314065434.GA43329@9a2d8922b8f1>
References: <20220312180615.68929-1-singh.kuldeep87k@gmail.com>
 <20220312180615.68929-2-singh.kuldeep87k@gmail.com>
 <20220314035118.gbjbrwbsywxljjti@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314035118.gbjbrwbsywxljjti@vireshk-i7>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 09:21:18AM +0530, Viresh Kumar wrote:
> On 12-03-22, 23:36, Kuldeep Singh wrote:
> > Reorder dmas and dma-names property for spi controller node to make it
> > compliant with bindings.
> > 
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> 
> What about a fixes tag ?

Sure, will add one.

> > ---
> >  arch/arm/boot/dts/spear13xx.dtsi | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/spear13xx.dtsi b/arch/arm/boot/dts/spear13xx.dtsi
> > index c87b881b2c8b..45f0b2a33e02 100644
> > --- a/arch/arm/boot/dts/spear13xx.dtsi
> > +++ b/arch/arm/boot/dts/spear13xx.dtsi
> > @@ -284,9 +284,8 @@ spi0: spi@e0100000 {
> >  				#size-cells = <0>;
> >  				interrupts = <0 31 0x4>;
> >  				status = "disabled";
> > -				dmas = <&dwdma0 4 0 0>,
> > -					<&dwdma0 5 0 0>;
> > -				dma-names = "tx", "rx";
> > +				dmas = <&dwdma0 5 0 0>, <&dwdma0 4 0 0>;
> > +				dma-names = "rx", "tx";
> 
> Why does the order matter here since we have dma-names anyway, which
> was correct earlier ?

Dma-names order matters here.
As per pl022 binding, dma-names order specify rx,tx and all DTs which
have tx,rx as order start raising dtbs_chek warning. Thus, need to
reverse this order. Please note, no functional change in this patch
apart from just fixing warning.

Warning:
'rx' was expected
'tx' was expected

Regards
Kuldeep
