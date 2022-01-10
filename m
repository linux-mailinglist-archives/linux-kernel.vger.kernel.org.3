Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACEE548965F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 11:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243953AbiAJKbO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 05:31:14 -0500
Received: from muru.com ([72.249.23.125]:48204 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243947AbiAJKa6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 05:30:58 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 274C5805F;
        Mon, 10 Jan 2022 10:31:43 +0000 (UTC)
Date:   Mon, 10 Jan 2022 12:30:54 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org,
        linux-omap <linux-omap@vger.kernel.org>,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Add binding for TI clksel
Message-ID: <YdwK3haVDCxyIioo@atomide.com>
References: <20211217113640.59840-1-tony@atomide.com>
 <YcIZNfTn37uNbj0F@robh.at.kernel.org>
 <YcLElm04V47kP0Z9@atomide.com>
 <CAL_JsqLek5SOypZhTxpLK13x2HEYbLbYYotLGOfM-JTb=QE-Eg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqLek5SOypZhTxpLK13x2HEYbLbYYotLGOfM-JTb=QE-Eg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Rob Herring <robh@kernel.org> [220104 22:06]:
> On Wed, Dec 22, 2021 at 12:24 AM Tony Lindgren <tony@atomide.com> wrote:
> >
> > Hi,
> >
> > * Rob Herring <robh@kernel.org> [211221 18:13]:
> > > On Fri, Dec 17, 2021 at 01:36:40PM +0200, Tony Lindgren wrote:
> > > > +additionalProperties: true
> > >
> > > Like what properties?
> > >
> > > true is only used for common, incomplete schemas referenced by device
> > > schemas.
> >
> > There is a collection of the current component clock child nodes for each
> > clksel instance. I got warnings with "additionalProperties: false", but
> > maybe the child clock nodes need to be somehow specified in the binding?
> 
> If everything else is a child node, then you can do:
> 
> additionalProperties:
>   type: object

OK thanks will do, the additional properties are always child nodes.

Regards,

Tony
