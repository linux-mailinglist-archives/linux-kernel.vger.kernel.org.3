Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8725190FD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243451AbiECWFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243318AbiECWFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:05:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A822424A4;
        Tue,  3 May 2022 15:02:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 86416CE22C8;
        Tue,  3 May 2022 22:02:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC68C385A4;
        Tue,  3 May 2022 22:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651615326;
        bh=nNwLfZyICjcyMLgHH7iT+5XX5lVbO1RBfjuW/N6BTLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Vg4d5xX0/qdcvR5lRmnj3/L4Wyo04ZFQjaTlgojfJ0e5N9gLePT64Yw0B7/baxn2S
         jhdS7Mbam/fYH81IBAq6s82Jcqg0giJI9qb7Ilvk1YjW/G0PTePrrLsJXOLSxRBB4E
         LXSr7qMDU9V1gMHhdMu95RB+QaZDROUkdOEpSwGRyj5/zeAoUSbstruGAC412K+Y/b
         mRM7Zv63L5h6tCcERHZpwcehSRn2+5MLOluVTqc2QHet/SdjwTPal892P7kCgrjxik
         FoTI3zrrhAXSPWYJ87Wjkzeet1XeNQJupzMaoE1YH3rPHQ9hqJTEdauQCyFL33jYpN
         fgtutnJexEuCg==
Received: by pali.im (Postfix)
        id 2F8BD98A; Wed,  4 May 2022 00:02:03 +0200 (CEST)
Date:   Wed, 4 May 2022 00:02:02 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: max63xx: Add GPIO binding
Message-ID: <20220503220202.ksxq65sbacxvituy@pali>
References: <20220429131349.21229-1-pali@kernel.org>
 <YnGj6eZGx+8gVKGW@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YnGj6eZGx+8gVKGW@robh.at.kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 03 May 2022 16:51:37 Rob Herring wrote:
> On Fri, Apr 29, 2022 at 03:13:48PM +0200, Pali Rohár wrote:
> > GPIO is optional and used for WDI logic.
> 
> Nowhere is WDI defined.
> 
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > index ab9641e845db..a97aa0135ef9 100644
> > --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > @@ -27,6 +27,10 @@ properties:
> >      description: This is a 1-byte memory-mapped address
> >      maxItems: 1
> >  
> > +  gpios:
> 
> Usually, we want a name here. Maybe wdi-gpios, but I don't know what WDI 
> is nor have I read the pin name in the datasheet for inspiration.

WDI is name of logic used in the datasheet, it is abbreviation of
WatchDog Input (meaning that from watchdog chip this GPIO has input
direction).

I'm not sure if we need to put gpio direction into the property name or
also word watchdog (or its some abbrev) into name. As node is already
named "watchdog" and direction depends on point of view (chip vs CPU),
which can be in DTS misleading (because DTS describe direction from CPU
point of view).

What for sure makes sense is extending description by explaining WDI
abbreviation.

> > +    description: Optional GPIO used for controlling WDI when WDI bit is not mapped to memory
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > -- 
> > 2.20.1
> > 
> > 
