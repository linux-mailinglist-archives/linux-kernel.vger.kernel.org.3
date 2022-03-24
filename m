Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91EA74E5EAB
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 07:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348192AbiCXG11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 02:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiCXG1Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 02:27:25 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F316DEDA;
        Wed, 23 Mar 2022 23:25:54 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id b130so1638961pga.13;
        Wed, 23 Mar 2022 23:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dwDYUTHimQOgoxdkP8sjUxdcESsR/QK5BJW0KPL4v+M=;
        b=pGphB0wGqeHh0tXFHs9/r2BIMpxutQtSbYKLKe3d+08y+zJTH030ndCKamAQQuqFSx
         WtDfAJwybEaGIjL9n/UfJ5DEK7kfiZk1a1of6Ts6LX17eT1eOuhEFMIaqMO3PCZFoyiE
         D/KuJ0isIQYcfACmWYEzQYo+jNITKZIQI4AyyuWz+a14q/w+zU44rJsGn0DYhwuwY+Sv
         Wlj69HoE8Ruxt73jXKPH4iW3KgmYg6olr6zKQmKsVnl++t4zD0vKVif2/1RR8WUcsOoz
         CTYZcxz1mpKCL/LmaIrh1jnLzGxFY0CPzLO8hAdl38WnYKYZLUZkhnk1eE5yy7h/Eyq2
         +jYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dwDYUTHimQOgoxdkP8sjUxdcESsR/QK5BJW0KPL4v+M=;
        b=y8kFYDnG/pp9cRJ4+n4/xchwFsnVZdLd3JXy5xgtH3leapEAPe7QZql5ceeggPdh2h
         ck+jd9NrHkNUsCSh2pSXXRWXC+5/SCZbRVrj9vrvjZGm0vFMzkyQyCaYHdDZnwrH3Pm7
         3FkLk8WhPnYU0bl4Zo2R7PnHf0ezzLOCQxrc+AWPcb9cOz0vuhA6mluQkWuQSVNCetaA
         JR+qxeYM4U8ghd6xDBJ+ZVt5+f19mra5huCXK+Ra67IJB7B2axdBNQ+CGykQRkuFB0AA
         FtFDOY0iUq7xi71tZ59bneZRvrLMwEtoV0JUcGfplwWpNwbvpDWZ8p4NStwABWeVzDuV
         C/Yg==
X-Gm-Message-State: AOAM532G1n0RwFVzTtdztuQMdl/Aw9rPdai1EIctPyPpsEoJZJ3SYDYl
        VyEC7JKLGWSSbBD8DAA/gZQ=
X-Google-Smtp-Source: ABdhPJxfRsmaap5/p4sWElWvELb49XKGWxiVS20Y8jWLuFnhXpOyQVwz+ldkHm5/uH7/ZY+CB7KEeQ==
X-Received: by 2002:a65:604a:0:b0:375:5cc8:7458 with SMTP id a10-20020a65604a000000b003755cc87458mr2863442pgp.205.1648103154065;
        Wed, 23 Mar 2022 23:25:54 -0700 (PDT)
Received: from 9a2d8922b8f1 ([122.161.51.18])
        by smtp.gmail.com with ESMTPSA id h6-20020a636c06000000b00363a2533b17sm1466081pgc.8.2022.03.23.23.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 23:25:53 -0700 (PDT)
Date:   Thu, 24 Mar 2022 11:55:47 +0530
From:   Kuldeep Singh <singh.kuldeep87k@gmail.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>, soc@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ARM: dts: spear13xx: Update SPI dma properties
Message-ID: <20220324062547.GA15504@9a2d8922b8f1>
References: <20220323175920.93155-1-singh.kuldeep87k@gmail.com>
 <20220324023904.h2qfxzxlznggbsyr@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324023904.h2qfxzxlznggbsyr@vireshk-i7>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 08:09:04AM +0530, Viresh Kumar wrote:
> On 23-03-22, 23:29, Kuldeep Singh wrote:
> > Reorder dmas and dma-names property for spi controller node to make it
> > compliant with bindings.
> > 
> > Fixes: 6e8887f60f60 ("ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT")
> > Signed-off-by: Kuldeep Singh <singh.kuldeep87k@gmail.com>
> > ---
> > v2:
> > - Add fixes tag
> > - Remove 1/2 patch from series as it's not required
> > - v1 discussion link:
> >   https://lore.kernel.org/linux-devicetree/20220312180615.68929-2-singh.kuldeep87k@gmail.com/
> > 
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
> >  			};
> >  
> >  			rtc@e0580000 {
> 
> Rob,
> 
> I tried to ask this at V1 as well [1]. Why do we need a patch like
> this ? Isn't this a DT tooling issue, where it is asking for a fixed
> order of values ?

Fixed order of values is important in case of properties like
compatibles etc. In case of dma-names, yes order shouldn't matter here.

This patch is more of appeasing dtbs_check warning rather than fixing
something. It's safe to go with this patch.
I am not sure if there's a provision to exclude dma-names from fix
ordering checks. Rob can help here in providing better insights.

- Kuldeep
