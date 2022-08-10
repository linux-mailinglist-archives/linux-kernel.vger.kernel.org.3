Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA3B58F1E0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 19:48:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiHJRsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 13:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbiHJRsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 13:48:30 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380208D3FB;
        Wed, 10 Aug 2022 10:48:15 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id l24so12734067ion.13;
        Wed, 10 Aug 2022 10:48:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=+N6oE2+z+9jwTNAaSVyxqcqUp5JuLCFc7tr+Z6FAGws=;
        b=7yy520wmJ/0YBsPbal+1k6ZnLybDFKDg36EuSfo2QZPVfaoSla2zCmh6r3/svafYlw
         9JhH6OplWSi4LiA7eZxTn+sMfpb0jaV+4Bx3Owrir7CYM4+y8DIBeft7PyiGJEGrntUp
         deT/hlyxrSvMVMQfRMvo+z2WEMeSJGvm2KKER53U39SBv7IKhHM4UFO9YB0MMZs9nDRC
         W0ewPBELf8BNVjw/kUvNCEahZmcc91MKW5qm5IT3dZZruiMhOSHaOrp/tqWlpoFS7srC
         RQ/nxU8ZVxwONi/Y2xUK7I8nwcrDszsy1AC6nY18HtA0c9svzTQZQGlcviNpBJILHtZC
         9lEQ==
X-Gm-Message-State: ACgBeo0A4ZUn5DAWZOm2RlB2kilcFtFNExy8P5G9ofr6mz1UBaENPB6v
        09cpm88uINI3yyFT9LrMMg==
X-Google-Smtp-Source: AA6agR79rHhKYr5RzkGcMvA3P9iJe8YVNwuun47x0eShM+Vw1kbLR7EV9dZX7F59f9epoBEIufX+yQ==
X-Received: by 2002:a02:664a:0:b0:33f:5310:35e1 with SMTP id l10-20020a02664a000000b0033f531035e1mr13120728jaf.214.1660153692739;
        Wed, 10 Aug 2022 10:48:12 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x2-20020a029702000000b0034274a116f1sm7736516jai.20.2022.08.10.10.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 10:48:12 -0700 (PDT)
Received: (nullmailer pid 223548 invoked by uid 1000);
        Wed, 10 Aug 2022 17:48:10 -0000
Date:   Wed, 10 Aug 2022 11:48:10 -0600
From:   Rob Herring <robh@kernel.org>
To:     Aradhya Bhatia <a-bhatia1@ti.com>
Cc:     Tomi Valkeinen <tomba@kernel.org>, Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Darren Etheridge <detheridge@ti.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Krunal Bhargav <k-bhargav@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/8] dt-bindings: display: ti,am65x-dss: Add port
 properties for DSS
Message-ID: <20220810174810.GA200295-robh@kernel.org>
References: <20220719080845.22122-1-a-bhatia1@ti.com>
 <20220719080845.22122-2-a-bhatia1@ti.com>
 <20220720232845.GA4164694-robh@kernel.org>
 <a2e5037c-22c0-8424-4031-0bf587120990@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2e5037c-22c0-8424-4031-0bf587120990@ti.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 04:56:15PM +0530, Aradhya Bhatia wrote:
> 
> 
> On 21-Jul-22 04:58, Rob Herring wrote:
> > On Tue, Jul 19, 2022 at 01:38:38PM +0530, Aradhya Bhatia wrote:
> > > Add "ti,oldi-mode" property to indicate the tidss driver the OLDI output
> > > mode. The 2 OLDI TXes on am625-dss allow a 3 different types of panel
> > > connections with the board.
> > > 
> > > 1. Single Link / Single Mode on OLDI TX 0 OR 1.
> > > 2. Single Link / Duplicate Mode on OLDI TX 0 and 1.
> > > 3. Dual Link / Single Mode on OLDI TX 0 and 1.
> > > 
> > > Add "ti,rgb565-to-888" property to override 16bit output from a videoport
> > > for a bridge that only accepts 24bit RGB888 DPI input.
> > > 
> > > On some boards the HDMI bridge takes a 24bit DPI input, but only 16 data
> > > pins are actually enabled from the SoC.  This new property forces the
> > > output to be RGB565 on a specific video port if the bridge requests a
> > > 24bit RGB color space.
> > > 
> > > This assumes that the video port is connected like so:
> > > 
> > > SoC : Bridge
> > > R0 ->   R3
> > > R1 ->   R4
> > > R2 ->   R5
> > > R3 ->   R6
> > > R4 ->   R7
> > > G0 ->   G2
> > > G1 ->   G3
> > > G2 ->   G4
> > > G3 ->   G5
> > > G4 ->   G6
> > > G5 ->   G7
> > > B0 ->   B3
> > > B1 ->   B4
> > > B2 ->   B5
> > > B3 ->   B6
> > > B4 ->   B7
> > > 
> > > On the bridge side R0->R2, G0->G1, B0->B2 would be tied to ground.
> > > The bridge sees 24bits of data,  but the lsb's are always zero.
> > 
> > Unless the bridge ignores the LSBs, that's not the right way to do 16 to
> > 24 bit. The LSBs should be connected to the MSB of the color component
> > to get full color range.
> > 
> > > 
> > > Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> > > ---
> > >   .../bindings/display/ti/ti,am65x-dss.yaml     | 25 +++++++++++++++++--
> > >   1 file changed, 23 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> > > index 6bbce921479d..11d9b3821409 100644
> > > --- a/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> > > +++ b/Documentation/devicetree/bindings/display/ti/ti,am65x-dss.yaml
> > > @@ -80,15 +80,35 @@ properties:
> > >       properties:
> > >         port@0:
> > > -        $ref: /schemas/graph.yaml#/properties/port
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        unevaluatedProperties: false
> > >           description:
> > >             The DSS OLDI output port node form video port 1
> > > +        properties:
> > > +          ti,oldi-mode:
> > > +            description: TI specific property to indicate the mode the OLDI TXes
> > > +              and the display panel are connected in.
> > > +              0 -> OLDI TXes OFF (driver default for am625-dss)
> > > +              1 -> Single link, Single Mode (OLDI0) (driver default for am65x-dss)
> > > +              2 -> Single link, Single Mode (OLDI1)
> > > +              3 -> Single link, Duplicate Mode
> > > +              4 -> Dual link (Only Single Mode)
> > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > +            enum: [0, 1, 2, 3, 4]
> > 
> > Wouldn't 'data-lanes' property work for this purpose.
> > 
> > Generally, we don't put properties in port nodes.
> > 
> Thank you for the suggestions Rob!
> 
> I looked into the "data-lanes" property and it seems that the property
> alone would not be able to help distinguish between the "Single link,
> Duplicate mode" (Mode 3) and "Dual link, Single mode" (Mode 4). For both
> the cases, the property will look like "data-lanes = <0 1>;" in the DT
> node.
> 
> I have an idea on what the driver could use along with the data-lanes
> property to ascertain the OLDI mode.
> 
> By means of number of remote-endpoints in DTS.
> The OLDI output port of DSS can be made to have 2 remote endpoints when
> 2 panels are connected as "Single link, Duplicate Mode" vs only 1 remote
> endpoint for "Dual Link, Single Mode". Based on the count, the driver
> can distinguish between the two when both the data-lanes are activated
> in DT node.

You can only have 1 'remote-endpoint'. However, you can have multiple 
endpoint nodes which is generally used for fanout (output) or muxed 
(input) cases. Your case is fanout as it is the same data sent to 
multiple connections.

data-lanes would be kind of redundant in that case since it would be 1 
lane per endpoint.

> 
> Let me know if you think this method would be appropriate.
> > > +
> > >         port@1:
> > > -        $ref: /schemas/graph.yaml#/properties/port
> > > +        $ref: /schemas/graph.yaml#/$defs/port-base
> > > +        unevaluatedProperties: false
> > >           description:
> > >             The DSS DPI output port node from video port 2
> > > +        properties:
> > > +          ti,rgb565-to-888:
> > > +            description:
> > > +              property to override DPI output to 16bit for 24bit bridge
> > > +            type: boolean
> > 
> > There's work underway for standard way to handle interface formats[1].
> > Please help/comment on that to make sure it works for you.
> > 
> > Rob
> > 
> > [1] https://lore.kernel.org/all/20220628181838.2031-3-max.oss.09@gmail.com/
> 
> I also followed what this patch series is implementing. This seems to be
> applicable for cases where the DPI pins are drawn and forwarded towards
> a simple panel capable of accepting the raw parallel data.
> 
> It does not cover for the bridges with lesser number of formats to
> support.

Not sure what you mean here, but raise it on that thread.

Rob
