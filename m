Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47CF51075C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:44:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352135AbiDZSr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbiDZSrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:47:23 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74E4D7CB2F;
        Tue, 26 Apr 2022 11:44:13 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id v65so16967124oig.10;
        Tue, 26 Apr 2022 11:44:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=mx8P3gHsjLCx+sknIhuvMfqYptVzGGmIORChHd23uSc=;
        b=bnaCMeFzPg65bD6gegFjP/ja6Pjb78I7jwypymFD051w3IpVdI4KBkSAKNnljGGv74
         v/y0UZMIfB8bpEoVcX4KiuwZl2puK/2dSVa/tCLigHvcmwOUaqjhLKyAojOnwwKU5O4J
         5RKXZ3hwqK5FJ2DKKZ1T/jI82Qwj+oC/LjwTiF1PImb2D0BgyXFAidaSXmOeaNu4Md6L
         g8rOzx/DdUsc3diXDWwtKPsWRVf7T+6pBHqLYQDCe2+7PMFBJ8QMMDg93iXgB+OTdtgh
         uWP8jAfFQSi7odEBA91wYzMb0puaaMp2/M1pe80Da847rvJ2PLVfVjVCtDBkJok/V0iX
         fNPg==
X-Gm-Message-State: AOAM530JMbZM9qwHsRnSF8Z4fepX0HaI2O7RhbkekY6Q9bPw+zaR8Uxw
        Yzmq8JG6uiSoDnnG/e9JIA==
X-Google-Smtp-Source: ABdhPJxGVx6HmAUiBu/kUnqmIEoBY/yWAcaWyhG1G4W0lFdInZBsLOspIDqniFb2T3g2odMs73GLNQ==
X-Received: by 2002:a54:4e92:0:b0:325:224c:8ff7 with SMTP id c18-20020a544e92000000b00325224c8ff7mr5742089oiy.154.1650998652766;
        Tue, 26 Apr 2022 11:44:12 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u20-20020a4a9e94000000b003291f6ac4b2sm5937954ook.28.2022.04.26.11.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 11:44:12 -0700 (PDT)
Received: (nullmailer pid 2332829 invoked by uid 1000);
        Tue, 26 Apr 2022 18:44:11 -0000
Date:   Tue, 26 Apr 2022 13:44:11 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Vasut <marex@denx.de>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>, arnd@arndb.de,
        Krzysztof Kozlowski <krzk+dt@kernel.org>, soc@kernel.org,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-kernel@vger.kernel.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>, etienne.carriere@st.com
Subject: Re: [PATCH 2/8] dt-bindings: clock: stm32mp1: describes clocks if
 "st,stm32mp1-rcc-secure"
Message-ID: <Ymg9e7sWaFSuNR0a@robh.at.kernel.org>
References: <20220422150952.20587-1-alexandre.torgue@foss.st.com>
 <20220422150952.20587-3-alexandre.torgue@foss.st.com>
 <dd48a7b5-ce08-5fb2-8236-8802ac91d827@denx.de>
 <YmbyUc5uTXoTD/nt@robh.at.kernel.org>
 <a6fa8050-1860-fffb-e7eb-6603d2e0eec4@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6fa8050-1860-fffb-e7eb-6603d2e0eec4@denx.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 25, 2022 at 09:35:13PM +0200, Marek Vasut wrote:
> On 4/25/22 21:11, Rob Herring wrote:
> > On Fri, Apr 22, 2022 at 06:31:25PM +0200, Marek Vasut wrote:
> > > On 4/22/22 17:09, Alexandre Torgue wrote:
> > > > In case of "st,stm32mp1-rcc-secure" (stm32mp1 clock driver with RCC
> > > > security support hardened), "clocks" and "clock-names" describe oscillators
> > > > and are required.
> > > > 
> > > > Signed-off-by: Alexandre Torgue <alexandre.torgue@foss.st.com>
> > > > 
> > > > diff --git a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> > > > index 7a251264582d..bb0e0b92e907 100644
> > > > --- a/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> > > > +++ b/Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.yaml
> > > > @@ -58,14 +58,8 @@ properties:
> > > >              - st,stm32mp1-rcc-secure
> > > >              - st,stm32mp1-rcc
> > > >          - const: syscon
> > > > -
> > > > -  clocks:
> > > > -    description:
> > > > -      Specifies the external RX clock for ethernet MAC.
> > > > -    maxItems: 1
> > > > -
> > > > -  clock-names:
> > > > -    const: ETH_RX_CLK/ETH_REF_CLK
> > > > +  clocks: true
> > > > +  clock-names: true
> > > 
> > > It looks like this should rather be a property than a compatible string --
> > > the compatible string is used by the OS to determine which hardware is
> > > represented by a node, but here it is the same hardware in either case,
> > > "st,stm32mp1-rcc" and "st,stm32mp1-rcc-secure", it is still the same
> > > STM32MP1 RCC block, just configured differently by some bootloader stage.
> > > 
> > > So why not just add one-liner property of the RCC block like ?
> > > st,rcc-in-secure-configuration
> > 
> > Because using compatible was already decided.
> 
> I see ... may I ask why compatible is OK in this case even though this is
> encoding a policy (secure/non-secure configuration of the same clock IP)
> into DT ?

I see 'compatible' as an encoding of what is the programming model of 
the device. Secure vs. non-secure have different models. PCIe hosts vs 
endpoint mode is a similar case where we mostly have 2 compatibles (but 
not always).

I wouldn't say which way we do things is set in stone, but in this case 
we already decided something.

Rob
