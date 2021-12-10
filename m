Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60CEA4703FB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbhLJPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:40:02 -0500
Received: from mail-oi1-f170.google.com ([209.85.167.170]:45735 "EHLO
        mail-oi1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242917AbhLJPkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:40:00 -0500
Received: by mail-oi1-f170.google.com with SMTP id 7so13652468oip.12;
        Fri, 10 Dec 2021 07:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kCCPtwBcvbN1Xz9t9SiQk1iylp71eIv8+Pkz9dWfX/o=;
        b=5mcXrRK5K7EY3Qd0xMxPM4LbDUs+KPXzUnaHP0IrH0eKVl8hAV58DmC890Sh/BeurZ
         VHPPzVoVC56KM3UXeKiA5METAiP6f3Lp43xDyqG8BwFNUaxYwZSqgTgIdotwjiOtDfdL
         PV65XAOpxGuk4U2tWUDaA8qg4qc/gp7TbTqmJazHu54UcGpHALlhTcmsRBX1nwv7R6Mj
         cjakRp/Wu/2kJFG68dhfr3gLyWe+J4nB7ytjPFhSjyyg9EM1L9BAZoPrrlGazQNOJNVF
         QHRTCKUmxGJ2dAKhP+V4HvyqRMh7pSXmyffsCghBD3WE5eOJj7ebisgGDWfQkzDJUkni
         PQ9w==
X-Gm-Message-State: AOAM531VKQi/7EfBqlfFCxLh1QqNlGkBftkibRxa73yn2GXOb4FK+t0r
        TRu6TBmVU/wrvMytVNzA9A==
X-Google-Smtp-Source: ABdhPJy6coMM+bLPVOCY2Fuho8xxQorQekIDB7d7Gxhw3bYyY/I6wGSBwaXEbWSrUY0EBeP0ei+R3w==
X-Received: by 2002:a05:6808:10ce:: with SMTP id s14mr12444004ois.137.1639150585255;
        Fri, 10 Dec 2021 07:36:25 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id r23sm588332ooj.37.2021.12.10.07.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 07:36:24 -0800 (PST)
Received: (nullmailer pid 1396912 invoked by uid 1000);
        Fri, 10 Dec 2021 15:36:23 -0000
Date:   Fri, 10 Dec 2021 09:36:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Adam Ford <aford173@gmail.com>
Cc:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-media <linux-media@vger.kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Chris Healy <cphealy@gmail.com>,
        Adam Ford-BE <aford@beaconembedded.com>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        "open list:HANTRO VPU CODEC DRIVER" 
        <linux-rockchip@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        arm-soc <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>
Subject: Re: [PATCH 04/10] dt-bindings: media: nxp,imx8mq-vpu: Support split
 G1 and G2 nodes with vpu-blk-ctrl
Message-ID: <YbNz94G3vwbHCMdB@robh.at.kernel.org>
References: <20211208225030.2018923-1-aford173@gmail.com>
 <20211208225030.2018923-5-aford173@gmail.com>
 <YbHZvysazqYeZ8h3@eze-laptop>
 <CAHCN7xKrHSSsqS9DNL1tMH1Ctpz16FsSgcVbSHXzUWF98v738Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xKrHSSsqS9DNL1tMH1Ctpz16FsSgcVbSHXzUWF98v738Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 05:36:04AM -0600, Adam Ford wrote:
> On Thu, Dec 9, 2021 at 4:26 AM Ezequiel Garcia
> <ezequiel@vanguardiasur.com.ar> wrote:
> >
> > Hi,
> >
> > Thanks for the patch.
> >
> > On Wed, Dec 08, 2021 at 04:50:23PM -0600, Adam Ford wrote:
> > > The G1 and G2 are separate decoder blocks that are enabled by the
> > > vpu-blk-ctrl power-domain controller, which now has a proper driver.
> > > Update the bindings to support separate nodes for the G1 and G2
> > > decoders using the proper driver or the older unified node with
> > > the legacy controls.
> > >
> > > To be compatible with older DT the driver, mark certain items as
> > > deprecated and retain the backwards compatible example.
> > >
> > > Signed-off-by: Adam Ford <aford173@gmail.com>
> > > ---
> > >  .../bindings/media/nxp,imx8mq-vpu.yaml        | 83 ++++++++++++++-----
> > >  1 file changed, 64 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > > index 762be3f96ce9..eeb7bd6281f9 100644
> > > --- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > > +++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
> > > @@ -15,29 +15,39 @@ description:
> > >
> > >  properties:
> > >    compatible:
> > > -    const: nxp,imx8mq-vpu
> > > +    oneOf:
> > > +      - const: nxp,imx8mq-vpu
> > > +        deprecated: true
> > > +      - const: nxp,imx8mq-vpu-g1
> > > +      - const: nxp,imx8mq-vpu-g2
> > >
> > >    reg:
> > > +    minItems: 1
> > >      maxItems: 3
> >
> > Is it really useful to keep the deprecated binding nxp,imx8mq-vpu
> > as something supported by the binding file?
> 
> Since I was told that the driver needed to be backwards compatible, i
> wanted to make sure that any attempts to build the old device tree
> would not fail

I'm not convinced changing the binding at all is correct. 'The driver 
structure is changing and I want the binding to align with it' is not a 
reason. Are G1 and G2 actually separate, independent blocks where we 
could have 1 or both of them? And what about other platforms using this 
block?

Even if the driver handles the old binding, a new dtb with an old kernel 
is broken. It's up to the platform to care or not, but you have to 
highlight that.


> > In other words, can we drop the deprecated binding from this file,
> > while keeping the support in the driver for legacy device-trees?
> 
> I was trying to represent both the old driver binding and the new one
> at the same time.  I thought that's what I was told to do.

I don't care so much if we have a schema for old binding. I'd rather 
have warnings if the binding has not been updated. Eventually I want to 
be able to test for compatibility by testing DTs with different schema 
versions. We've got to get to 0 warnings first though...

Rob
