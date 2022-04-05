Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 259274F46A5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354946AbiDEUjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1451590AbiDEPxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:53:36 -0400
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0ED1C8A9E;
        Tue,  5 Apr 2022 07:47:22 -0700 (PDT)
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-ddfa38f1c1so14589337fac.11;
        Tue, 05 Apr 2022 07:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8u0j6s/bnO1ru96ZH1GkIYKuWp6uTK4JpdnHlGfuDhA=;
        b=CgnYOJhe9CIGcUbeahSe6iJ1U18lacubNo40QlQBzUV7bghD7Cdit1/i68D2p6ocO7
         jFSTerVt0PZPxAIngnibhIe+jK8xedWID6pWbnR61RBj8LHKN80KEm7YrRhUP1TAjFAj
         vTz192f/akBC8A7K6ZXzSJCtls7nU6k+pI3ZQ33b5uxG2v+vC5sNmhK40bVocwULmMaM
         Hcc19osQjQbhfMlV70eoYOR6uSsFX7olHs2dl5uc9n2tCoUUsL/t+LBVl+UlsmmHDEZr
         4Xaa5xxsIxzKTkJ1OynZK/99JpmZBCRe2XQyWi3IBY5JuNWMSQ/M5Pud2ZZu9LW6mKuN
         1ZBA==
X-Gm-Message-State: AOAM532TsKUa16iU0g4eF9oo7TaT4n7m9oYHj25EihvaO9oNHORCCYSh
        DzB/lHgvJi2Sz2GTvFouaA==
X-Google-Smtp-Source: ABdhPJxTv66QjljJi0z1Dgv/PMrNV/nc5x/lgqp82IxUqPbW5MQNlD8HiscKmc7xmHFADchiD0i1LQ==
X-Received: by 2002:a05:6871:99:b0:d6:ac91:d53c with SMTP id u25-20020a056871009900b000d6ac91d53cmr1673287oaa.10.1649170041832;
        Tue, 05 Apr 2022 07:47:21 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a6-20020a9d4706000000b005cdff2d400bsm5740767otf.24.2022.04.05.07.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 07:47:21 -0700 (PDT)
Received: (nullmailer pid 3259938 invoked by uid 1000);
        Tue, 05 Apr 2022 14:47:20 -0000
Date:   Tue, 5 Apr 2022 09:47:20 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Lizhi Hou <lizhi.hou@xilinx.com>,
        Sonal Santan <sonal.santan@xilinx.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microchip.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH v2 0/3] add fwnode support to reset subsystem
Message-ID: <YkxWeMNw9Ba0KjHM@robh.at.kernel.org>
References: <20220324141237.297207-1-clement.leger@bootlin.com>
 <Ykst0Vb4fk+iALzc@robh.at.kernel.org>
 <20220405092434.6e424ed4@fixe.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220405092434.6e424ed4@fixe.home>
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

+ some Xilinx folks

On Tue, Apr 05, 2022 at 09:24:34AM +0200, Clément Léger wrote:
> Le Mon, 4 Apr 2022 12:41:37 -0500,
> Rob Herring <robh@kernel.org> a écrit :
> 
> > On Thu, Mar 24, 2022 at 03:12:34PM +0100, Clément Léger wrote:
> > > This series is part of a larger series which aims at adding fwnode
> > > support in multiple subsystems [1]. The goal of this series was to
> > > add support for software node in various subsystem but in a first
> > > time only the fwnode support had gained consensus and will be added
> > > to multiple subsystems.  
> > 
> > The goal is describing a solution. What is the problem?
> > 
> > What's the scenario where you have a reset provider not described by 
> > firmware providing resets to devices (consumers) also not described by 
> > firmware.
> 
> Hi Rob, there was a link attached to this series since there was a
> previous one that was sent which described the problem. Here is a link
> to the same thread but to a specific message which clarifies the
> problem and the solutions that were mentionned by other maintainers
> (ACPI overlays, DT overlays, software nodes and so on):
> 
> https://lore.kernel.org/netdev/20220224154040.2633a4e4@fixe.home/

Thanks, but your commit message should explain the problem. The problem 
is not subsystems don't support fwnode.

This is the exact same problem the Xilinx folks are trying to solve with 
their PCIe FPGA cards[1] (and that is not really a v1). They need to 
describe h/w downstream from a 'discoverable' device. Their case is 
further complicated with the dynamic nature of FPGAs. It's also not just 
PCIe. Another usecase is describing downstream devices on USB FTDI 
serial chips which can have GPIO, I2C, SPI downstream. And then you want 
to plug in 10 of those.

I don't think swnodes are going to scale for these usecases. We moved 
h/w description out of the kernel for a reason. Why are we adding that 
back in a new form? The complexity for what folks want to describe is 
only going to increase.

I think DT overlays is the right (or only) solution here. Of course the 
DT maintainer would say that. Actually, I would be happier to not have 
to support overlays in the kernel.

I've told the Xilinx folks the same thing, but I would separate this 
into 2 parts. First is just h/w work in a DT based system. Second is 
creating a base tree an overlay can be applied to. The first part should 
be pretty straightforward. We already have PCI bus bindings. The only 
tricky part is getting address translation working from leaf device thru 
the PCI bus to host bus, but support for that should all be in place 
(given we support ISA buses off of PCI bus). The second part will 
require generating PCI DT nodes at runtime. That may be needed for both 
DT and ACPI systems as we don't always describe all the PCI hierarchy in 
DT. That could work either by the PCI subsystem creating nodes as it
populates devices or your driver could make a request to populate nodes 
for its hierarchy. That's not a hard problem to solve. That's what 
OpenFirmware implementations do already.

Rob


https://lore.kernel.org/lkml/20220216050056.311496-1-lizhi.hou@xilinx.com/
