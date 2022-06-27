Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3765D55D888
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240398AbiF0ThP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:37:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238466AbiF0ThM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:37:12 -0400
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
        by lindbergh.monkeyblade.net (Postfix) with SMTP id E44C66357
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 12:37:10 -0700 (PDT)
Received: (qmail 130357 invoked by uid 1000); 27 Jun 2022 15:37:10 -0400
Date:   Mon, 27 Jun 2022 15:37:10 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Bastien Nocera <hadess@hadess.net>,
        Peter Chen <peter.chen@kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Roger Quadros <rogerq@kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Subject: Re: [PATCH v22 2/3] usb: misc: Add onboard_usb_hub driver
Message-ID: <YroG5keFWVJo8JVR@rowland.harvard.edu>
References: <CAD=FV=VEztPLhsrJecZUdyHCW7ZfFTVvxyqY5CqRVv2mWyrLog@mail.gmail.com>
 <YquoSMiQS+RG8rOM@google.com>
 <CAD=FV=W81pSEUbzw2ZQgs_TJ9MLnHQHiDopZXZ6bHdS7QMzAyA@mail.gmail.com>
 <YqvMffveCPiKQEUk@google.com>
 <CAD=FV=UJOStPfRR3Hq2DmRBSH-HCtZ16hAU9eVH5w6Hm=WSJRQ@mail.gmail.com>
 <YqytDNB2y4+qT8GD@google.com>
 <CAD=FV=UT0XtMjZ9syQPGXeTEaUrwGTb_LgDow+cofgmx4D30VA@mail.gmail.com>
 <Yrnzl8k81f9JTMIQ@google.com>
 <Yrn8y4GGZm+NyXIi@rowland.harvard.edu>
 <Yrn/rfrzSWod5SCT@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yrn/rfrzSWod5SCT@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 12:06:21PM -0700, Matthias Kaehlcke wrote:
> On Mon, Jun 27, 2022 at 02:54:03PM -0400, Alan Stern wrote:
> > On Mon, Jun 27, 2022 at 11:14:47AM -0700, Matthias Kaehlcke wrote:
> > > 
> > >   Further there must be only one platform device for onboard hubs with a
> > >   companion hub (the hub is a single physical device). To achieve this two
> > 
> > What do you mean by "companion hub"?  I think you are using the wrong 
> > word here.  If you're talking about the relation between the two logical 
> > hubs (one attached to the SuperSpeed bus and one attached to the 
> > Low/Full/High-speed bus) within a physical USB-3 hub, the correct term 
> > for this is "peer".  See the existing usages in hub.h, hub.c, and 
> > port.c.
> > 
> > "Companion" refers to something completely different (i.e., the UHCI or 
> > OHCI controllers that handle Low/Full-speed connections on behalf of a 
> > High-speed EHCI controller).
> 
> Yes it's the relation between the two logical hub. The term 'companion-hub'
> stems from the binding and has been around since v6 of this series. I guess
> we should update the binding if the terminology isn't correct.

That sounds like a good idea.

Alan Stern
