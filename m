Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F3546E891
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 13:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237456AbhLIMkn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 07:40:43 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:51717 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhLIMkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 07:40:42 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 982F36000C;
        Thu,  9 Dec 2021 12:37:06 +0000 (UTC)
Date:   Thu, 9 Dec 2021 13:37:05 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: ti,gpmc-nand: Add missing 'rb-gpios'
Message-ID: <20211209133705.621912fe@xps13>
In-Reply-To: <1744af96-3b71-3d41-12e2-a9052684cb35@kernel.org>
References: <20211206174209.2297565-1-robh@kernel.org>
        <20211209104224.41d42cca@xps13>
        <bebef734-d0d3-e78e-e07a-9160ead1f673@kernel.org>
        <20211209114038.710139a8@xps13>
        <1744af96-3b71-3d41-12e2-a9052684cb35@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

> >>>> With 'unevaluatedProperties' support implemented, the TI GPMC example
> >>>> has a warning:
> >>>>
> >>>> Documentation/devicetree/bindings/memory-controllers/ti,gpmc.example.dt.yaml: nand@0,0: Unevaluated properties are not allowed ('rb-gpios' was unexpected)
> >>>>
> >>>> Add the missing definition for 'rb-gpios'.    
> >>>
> >>> rb-gpios is already defined in nand-controller.yaml. I seems like the
> >>> real problem is that this file does not refer to it. Can you update the
> >>> fix?    
> >>
> >> I don't think we can refer to nand-controller.yaml right now as we are not
> >> fully compatible with it yet. Please see examples below.  
> > 
> > This is a *very* wrong way of defining a NAND setup. I will take the
> > patch to silence the warning, but please convert this representation to  
> 
> Thanks!
> 
> > the 'new' one. I believe on the driver side it should not be too
> > complicated to support having a few of these properties moved to a NAND
> > chip subnode and still support the below binding. Just be very clear
> > that if the legacy bindings are used, only a single chip is supported.  
> 
> I agree with you. It has been that way since ages. I will look at cleaning
> it up whenever possible for me. I think we will have to support the old
> bindings as well as the new one going forward as many legacy platforms
> are using it.

Yes of course, this is even a primary requirement.

Thanks,
Miquèl
