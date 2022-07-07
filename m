Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829F156A1E7
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235374AbiGGM1h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbiGGM1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7EF1220F0;
        Thu,  7 Jul 2022 05:27:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54D1962353;
        Thu,  7 Jul 2022 12:27:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85928C3411E;
        Thu,  7 Jul 2022 12:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657196853;
        bh=UZItbwI5mnC5YfXqsXOrg8hDLSaCl6949bJX4LeLHM4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gt6PBEsdnmii/ibuuz55rvlno8I2Rd6JySORPbjGrn4wO28KnR7X3aCP3t5Ho5Pvk
         HlV+A4QH4RZd1geKQZzSWJlwtmoxscPeTeM/TCJTuUkQxztIdtGbuHYMMcftuY7UJg
         XKnwcbzQNf0Fgf4BghGTWkMZ9PZOzUsn5SUvKQIFiH11s9v+3QbrKTjifnoCt/Jbcj
         sG76CCxHc0ccPdDy4gWni4AyD8gWnRq/7zb3qWtJktNLNDFxEqxNKgMQbO6yxaBoFV
         Qrqpilzvx3PZINS+1iLHi165Gid7MhbvP7DgWUCO98arYUpk27zndfj6Rec9qb4G84
         +PyPx81Vyk7+g==
Received: by pali.im (Postfix)
        id 96E3A7B1; Thu,  7 Jul 2022 14:27:30 +0200 (CEST)
Date:   Thu, 7 Jul 2022 14:27:30 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kabel@kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: watchdog: max63xx: Add GPIO binding
Message-ID: <20220707122730.45jtopop5cj7beni@pali>
References: <20220705001023.14660-1-pali@kernel.org>
 <20220706150726.GA40600-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220706150726.GA40600-robh@kernel.org>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 July 2022 09:07:26 Rob Herring wrote:
> On Tue, Jul 05, 2022 at 02:10:22AM +0200, Pali Rohár wrote:
> > GPIO is optional and used for WDI logic.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> > Changes in v3:
> > * Extend description
> > ---
> >  Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > index ab9641e845db..a0cf9e6c371d 100644
> > --- a/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > +++ b/Documentation/devicetree/bindings/watchdog/maxim,max63xx.yaml
> > @@ -27,6 +27,10 @@ properties:
> >      description: This is a 1-byte memory-mapped address
> >      maxItems: 1
> >  
> > +  gpios:
> 
> As I said before, add a name prefix: wdi-gpios

So gpio with output direction should be really named that is input?

I really do not understand this kind of thinking and making every device
tree description totally illogical and inconsistent with all other.

> > +    description: Optional GPIO used for controlling WDI (watchdog input) when WDI bit is not mapped to memory
> 
> Wrap lines at 80 unless wrapping at 100 provides some benefit.
> 
> yamllint is set to 110 because I don't want to fix everyone's line wrap, 
> not because that's the standard.
> 
> 
> > +    maxItems: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > -- 
> > 2.20.1
> > 
> > 
