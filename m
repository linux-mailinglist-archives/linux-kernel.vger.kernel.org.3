Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6E64B94BA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 00:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238643AbiBPXwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 18:52:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229820AbiBPXwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 18:52:33 -0500
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77089F4063;
        Wed, 16 Feb 2022 15:52:20 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id d3so1049538ilr.10;
        Wed, 16 Feb 2022 15:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b/JXIitbDZ9HoqIJQDyG8ELeQOdY8UCMjKhFkXYelkw=;
        b=eAKZe+Seh7P0SYBnxfLgH/sgd67U+4UQXJU/+1+vLP6bFNhtAmzjXj0e03i5X6uYCr
         MANiweju6037zb6zhB4Vjo23/k+aaEQrHu4R06EyIL2ZVV16UoOPWXS5xbk5CdgFAXRG
         GC3GFQiBQUWPcLt2OZdOZ2JtHQ9LDiytt0PzCCSc27pJczQgWXpngj4+8wsOSMuqEdpj
         wIxCm8TQvHwAb3HP5qYPBRedrVDggr9JNmo+g+hycBq7mHaP8N9Ubm3QRilwdzjY0c+l
         1vBEHpQJis/mXS1giY9IqwfOV8YbkF3c2XPFiz36kzAOsS2rxdoC5k/y79tt73amRxz6
         0ayA==
X-Gm-Message-State: AOAM531u1UJujwPXSE2Ywf5vAx8Fp0D7jQJJ7E00M0+EvTJeZTS5kvs0
        jz3Gia5pEcQDbOhn6O7Pew==
X-Google-Smtp-Source: ABdhPJzMeZBEmpkyBZ0DqYIbANVj7AN2XmgRUWyZkypg6ORTBG7lSLroGnVPeDY/yrX1DtGyrr1CDQ==
X-Received: by 2002:a92:c567:0:b0:2b8:b4d1:ba3c with SMTP id b7-20020a92c567000000b002b8b4d1ba3cmr202018ilj.50.1645055539773;
        Wed, 16 Feb 2022 15:52:19 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id i13sm800285ila.46.2022.02.16.15.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 15:52:18 -0800 (PST)
Received: (nullmailer pid 1918923 invoked by uid 1000);
        Wed, 16 Feb 2022 23:52:16 -0000
Date:   Wed, 16 Feb 2022 17:52:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     p.zabel@pengutronix.de, airlied@linux.ie, daniel@ffwll.ch,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, alistair@alistair23.me,
        samuel@sholland.org, josua.mayer@jm0.eu,
        letux-kernel@openphoenux.org
Subject: Re: [RFC PATCH 1/6] dt-bindings: display: imx: Add EPDC
Message-ID: <Yg2OMADV6GLG6a4/@robh.at.kernel.org>
References: <20220206080016.796556-1-andreas@kemnade.info>
 <20220206080016.796556-2-andreas@kemnade.info>
 <YgaE06Ktabpf2dJC@robh.at.kernel.org>
 <20220214234517.121e1167@aktux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214234517.121e1167@aktux>
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

On Mon, Feb 14, 2022 at 11:45:17PM +0100, Andreas Kemnade wrote:
> Hi Rob,
> 
> On Fri, 11 Feb 2022 09:46:27 -0600
> Rob Herring <robh@kernel.org> wrote:
> 
> > On Sun, Feb 06, 2022 at 09:00:11AM +0100, Andreas Kemnade wrote:
> > > Add a binding for the Electrophoretic Display Controller found at least
> > > in the i.MX6.  
> > 
> > The first version was in i.MX50 (I helped design the register 
> > interface). Is that version compatible?
> > 
> it has some differences, but that could be detected by EPDC_VERSION
> register. I do not own such a device, so I cannot fully check. I have
> not seen any driver with devicetree for IMX5. For now I am rejecting
> anything which has a EPDC version which I cannot check. 
> 
> > > The timing subnode is directly here to avoid having display parameters
> > > spread all over the plate.
> > > 
> > > Supplies are organized the same way as in the fbdev driver in the
> > > NXP/Freescale kernel forks. The regulators used for that purpose,
> > > like the TPS65185, the SY7636A and MAX17135 have typically a single bit to
> > > start a bunch of regulators of higher or negative voltage with a
> > > well-defined timing. VCOM can be handled separately, but can also be
> > > incorporated into that single bit.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > >  .../bindings/display/imx/fsl,mxc-epdc.yaml    | 159 ++++++++++++++++++
> > >  1 file changed, 159 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> > > 
> > > diff --git a/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml b/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> > > new file mode 100644
> > > index 000000000000..7e0795cc3f70
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/display/imx/fsl,mxc-epdc.yaml
> > > @@ -0,0 +1,159 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/display/imx/fsl,mxc-epdc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Freescale i.MX6 EPDC
> > > +
> > > +maintainers:
> > > +  - Andreas Kemnade <andreas@kemnade.info>
> > > +
> > > +description: |
> > > +  The EPDC is a controller for handling electronic paper displays found in
> > > +  i.MX6 SoCs.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - fsl,imx6sl-epdc
> > > +      - fsl,imx6sll-epdc  
> > 
> > Not compatible with each other?
> > 
> differences are detectable by EPDC_VERSION register, so probably so
> problem. NXP/Freescale kernel uses
> fsl,imx6dl-epdc
> and 
> fsl,imx7d-epdc (used also by imx6 devices with EPDC_VERSION = 3.0)
> in their drivers.
> 
> fsl,imx6dl-epdc
> fsl,imx6sl-epdc
> fsl,imx6sll-epdc
> fsl,imx7d-epdc
> in their dtsis.
> 
> But the general rule is to use as less as possible compatible strings
> if differences can be probed properly, so only one should be
> sufficient? Which one?

If you can probe all the differences, then just 'fsl,imx-epdc' is 
sufficient. Just document that so the next time around I don't forget 
and tell you it needs to be specific.

Rob
