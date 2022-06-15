Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68ED354BF4D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 03:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239616AbiFOBhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 21:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbiFOBhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 21:37:19 -0400
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F356E220EE;
        Tue, 14 Jun 2022 18:37:18 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id d123so11207765iof.10;
        Tue, 14 Jun 2022 18:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4uaUfSV0gby1lsDQplxLTxlqiLhlJNCPKAfs2EWk4gk=;
        b=ioT8vkNPYy3V0sYvZexIqSQX7vqcEURAwsobeOVeM/REyfrWyk37XMjYmextfdxAlW
         qN6S1THunThnh5e04Dh0l97ztoXmfH8l9qmWUzSFGZioggbFpuJHasO+7Fe0XwBbaA7T
         rezCEgECmvsZTf2X795hFL/wMS0u0txCEbf85PinSA81oqp/I/pBD0gZI9JeVe3ElET0
         Rg2l3r0BVA8BCc9DSp4U979WUjzxPv3BUvuEPNNr41rF47rVzcEIR4ICyhCy6pz3osMs
         15LAYLTEstpTIkYuvQZtqytAc2OuUd4mkk0v10wic7NUiWhePWYbPDYQ7/GORmWCsQty
         J7GQ==
X-Gm-Message-State: AOAM533bOi9XAWF9oahisyejRUm1eKrtpivLoHMi/QWLsCs21X9J2vSr
        +zLhfw2C1ahfKlh++KR4SA==
X-Google-Smtp-Source: ABdhPJyyZmUHUZtXA4fGnSL6OP2IUxOH50zeNSsdnEPD/EIaGtRpm5UuNLDxQGJaB4RF48H5Zpqvfw==
X-Received: by 2002:a6b:d309:0:b0:664:716c:d758 with SMTP id s9-20020a6bd309000000b00664716cd758mr3841714iob.157.1655257038129;
        Tue, 14 Jun 2022 18:37:18 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z194-20020a6bc9cb000000b00669d92868dasm4308317iof.11.2022.06.14.18.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 18:37:15 -0700 (PDT)
Received: (nullmailer pid 3421175 invoked by uid 1000);
        Wed, 15 Jun 2022 01:37:13 -0000
Date:   Tue, 14 Jun 2022 19:37:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH V4 1/7] dt-bindings: soc: add i.MX93 SRC
Message-ID: <20220615013713.GA3408671-robh@kernel.org>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
 <20220609125100.3496633-2-peng.fan@oss.nxp.com>
 <20220614213953.GA2693578-robh@kernel.org>
 <DU0PR04MB94178655FA1B5FCF96BC5DCF88AA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB94178655FA1B5FCF96BC5DCF88AA9@DU0PR04MB9417.eurprd04.prod.outlook.com>
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

On Tue, Jun 14, 2022 at 11:22:43PM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V4 1/7] dt-bindings: soc: add i.MX93 SRC
> > 
> > On Thu, Jun 09, 2022 at 08:50:54PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > Add bindings for i.MX93 System Reset Controller(SRC). SRC supports
> > > resets and power gating for mixes.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  .../bindings/power/fsl,imx93-src.yaml         | 96
> > +++++++++++++++++++
> > >  include/dt-bindings/power/fsl,imx93-power.h   | 11 +++
> > >  2 files changed, 107 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > >  create mode 100644 include/dt-bindings/power/fsl,imx93-power.h
> > >
> > > diff --git
> > > a/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > > b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > > new file mode 100644
> > > index 000000000000..880500a841f7
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/power/fsl,imx93-src.yaml
> > > @@ -0,0 +1,96 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > > +---
> > > +$id:
> > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > >
> > +cetree.org%2Fschemas%2Fpower%2Ffsl%2Cimx93-src.yaml%23&amp;data=0
> > 5%7C
> > >
> > +01%7Cpeng.fan%40nxp.com%7Cbce11534c1f9456c1a4108da4e4e6d4d%7C6
> > 86ea1d3
> > >
> > +bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637908395997226535%7CUnkn
> > own%7CTWF
> > >
> > +pbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVC
> > I6
> > >
> > +Mn0%3D%7C3000%7C%7C%7C&amp;sdata=sTDHZ9BVww%2FFe2pwS%2Fjoz
> > HPwWRmkU1hi
> > > +966eGXzjFSk%3D&amp;reserved=0
> > > +$schema:
> > > +https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevi
> > >
> > +cetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Cpeng
> > .fan%
> > >
> > +40nxp.com%7Cbce11534c1f9456c1a4108da4e4e6d4d%7C686ea1d3bc2b4c6
> > fa92cd9
> > >
> > +9c5c301635%7C0%7C0%7C637908395997226535%7CUnknown%7CTWFpbG
> > Zsb3d8eyJWI
> > >
> > +joiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3
> > 000%
> > >
> > +7C%7C%7C&amp;sdata=xAU2zmsZDWOtCndpmKvMScG1XqjytSUnXLvzxR40p
> > HY%3D&amp
> > > +;reserved=0
> > > +
> > > +title: NXP i.MX93 System Reset Controller
> > > +
> > > +maintainers:
> > > +  - Peng Fan <peng.fan@nxp.com>
> > > +
> > > +description: |
> > > +  The System Reset Controller (SRC) is responsible for the generation
> > > +of
> > > +  all the system reset signals and boot argument latching.
> > > +
> > > +  Its main functions are as follows,
> > > +  - Deals with all global system reset sources from other modules,
> > > +    and generates global system reset.
> > > +  - Responsible for power gating of MIXs (Slices) and their memory
> > > +    low power control.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    items:
> > > +      - const: fsl,imx93-src
> > > +      - const: syscon
> > > +
> > > +  reg:
> > > +    maxItems: 1
> > > +
> > > +  slices:
> > 
> > power-controller
> > 
> > But if there aren't any other child nodes for the SRC, then why do you need this
> > level at all? If there are others, then your binding is incomplete.
> 
> Currently we not need other parts from driver, so I not add them. I just add mix
> slices with name "slices". For U-Boot, we are not using DTB for mem slices,
> so I not add mem slices.
> 
> It has following mix slices.

What's a mix slice?

> 0 EdgeLock Enclave
> 1 AONMIX
> 2 WAKEUPMIX
> 3 DDRMIX
> 4 DDRPHY
> 5 MLMIX
> 6 NICMIX
> 7 HSIOMIX
> 8 MEDIAMIX
> 9 CM33MIX
> 10 CA55 core 0
> 11 CA55 core 1
> 12 CA55 cluster
> 
> It has following mem slices:

What's a mem slice?

> 0 AONMIX memory
> 1 WAKEUPMIX memory
> 2 DDRMIX memory
> 3 DDRPHY memory
> 4 MLMIX memory
> 5 NICMIX memory
> 6 OCRAM
> 7 HSIOMIX memory
> 8 MEDIA memory
> 9 CA55 core 0 memory
> 10 CA55 core 1 memory
> 11 CA55 cluster memory
> 12 L3 cache
> 
> It has some general purpose functions that could
> be covered by SRC node itself.

Please make bindings as complete as possible, not what some u-boot or 
linux currently uses or not.

Rob
