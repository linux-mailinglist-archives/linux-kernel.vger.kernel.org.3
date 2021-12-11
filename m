Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CAFC4713D9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 13:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbhLKMtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 07:49:18 -0500
Received: from sibelius.xs4all.nl ([83.163.83.176]:54264 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbhLKMtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 07:49:17 -0500
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id ce912b4f;
        Sat, 11 Dec 2021 13:49:14 +0100 (CET)
Date:   Sat, 11 Dec 2021 13:49:14 +0100 (CET)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Hector Martin <marcan@marcan.st>
Cc:     robh@kernel.org, tglx@linutronix.de, maz@kernel.org,
        sven@svenpeter.dev, alyssa@rosenzweig.io,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <8c099fc2-a319-7c80-3053-ed2b39b86835@marcan.st> (message from
        Hector Martin on Sat, 11 Dec 2021 21:28:10 +0900)
Subject: Re: [PATCH 1/6] dt-bindings: interrupt-controller: apple,aic: Add
 apple,aic2 support
References: <20211209043249.65474-1-marcan@marcan.st>
 <20211209043249.65474-2-marcan@marcan.st>
 <YbI8wBS2mrETiTfw@robh.at.kernel.org> <8c099fc2-a319-7c80-3053-ed2b39b86835@marcan.st>
Message-ID: <d3cb417c9128faf1@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Hector Martin <marcan@marcan.st>
> Date: Sat, 11 Dec 2021 21:28:10 +0900
> 
> On 10/12/2021 02.28, Rob Herring wrote:
> > On Thu, Dec 09, 2021 at 01:32:44PM +0900, Hector Martin wrote:
> <snip>
> >> +  - if:
> >> +      properties:
> >> +        compatible:
> >> +          contains:
> >> +            enum:
> >> +              - apple,aic2
> >> +    then:
> >> +      required:
> >> +        - apple,event-reg
> > 
> > Is this property valid for aic1? If not, you need:
> > 
> > else:
> >    not:
> >      required:
> >        - apple,event-reg
> > 
> 
> Thanks, I wasn't sure how to do this. Took me a second to realize how 
> the logic works here, heh.
> 
> > 
> > I tend to think you should just make this a separate document. There's
> > not a whole lot of sharing (compared to any other interrupt controller).
> 
> Good point. I just kind of defaulted to this way because the driver is 
> the same (and does share a bunch), but indeed the binding doesn't really 
> reflect any of that. I'll split it off into another document for v2. 
> Might as well make the 4-argument interrupt form mandatory then (we use 
> it for all DTs, even the current 1-die machines, on AICv2 SoCs; the 
> driver can handle both but we might as well be stricter with the binding).

Simpler that way, so I'd support that.
