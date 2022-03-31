Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C894EE008
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 20:00:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233126AbiCaSCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 14:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbiCaSCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 14:02:11 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF459154731;
        Thu, 31 Mar 2022 11:00:20 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id e4so342460oif.2;
        Thu, 31 Mar 2022 11:00:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I3BwVGA5gvEgHgvpjpOrGZt3ZZ8DgU2AYuBU6ajRMYQ=;
        b=uSDZWIIRtlEaJYcIDyVSLgndSIavboC0DvL3VUyRAfSkMBODMsfImneMWzzWLQVb6K
         ft4Q50iZvq2oX0PO+QcZpvGJyu1fLOrKQTFdz8iIZNaEKsD8Rf0udPoHh5M8XtW6twZv
         3evbKktEKXqtmrdpx8wAdXCd8n6ORNdXy8grJsgG0SSXV2Tt5KUdSLNkQUkbd7VxcJ5a
         t2TIrj0Qu7/S6qbDXCccTem/d9SEam5L++iQOS7QeBnTeXfIDbdvUhLKKdPH+fbFqdFO
         m8XFOpaPFEmR/qvHXM3Bedk6WlFapsefdCmj/z98wb4nYNMCHmXHW002WnFbUIKYFodb
         Tmxw==
X-Gm-Message-State: AOAM533zjjdiazwgoxwFxcpvNQhxBa/66J64RoFbLIZ9z0kyClW6ga2m
        AwVxfFC0Xt8OmiJKLAQ8ZQ==
X-Google-Smtp-Source: ABdhPJxsFMds5NLOAeqJP1PDVG65OgRHVIDdVYYrMbaAaF2R3OmrHV+UeMG2+Ea+FnB9nREtrySkmg==
X-Received: by 2002:a54:4714:0:b0:2ec:f566:8da5 with SMTP id k20-20020a544714000000b002ecf5668da5mr3005994oik.97.1648749619926;
        Thu, 31 Mar 2022 11:00:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h12-20020a9d6a4c000000b005b9d727d4b9sm97792otn.14.2022.03.31.11.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 11:00:19 -0700 (PDT)
Received: (nullmailer pid 1222855 invoked by uid 1000);
        Thu, 31 Mar 2022 18:00:18 -0000
Date:   Thu, 31 Mar 2022 13:00:18 -0500
From:   Rob Herring <robh@kernel.org>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        angelogioacchino.delregno@collabora.com,
        Yong Wu <yong.wu@mediatek.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v3, 03/10] dt-bindings: media: mtk-vcodec: Adds encoder
 cores dt-bindings for mt8195
Message-ID: <YkXsMoqjOHz4Rf6L@robh.at.kernel.org>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
 <20220317082230.23622-4-irui.wang@mediatek.com>
 <Yj4s0zcHxz3U3wlc@robh.at.kernel.org>
 <ab2b24eeb51048227ad7b2ac659617a7da5b2e45.camel@mediatek.com>
 <YkG8ka1xY2k+HWi1@robh.at.kernel.org>
 <e41e909f85e3891edb6b66d7d5a810af103113c8.camel@mediatek.com>
 <YkMFGbgYq5DhLjt8@robh.at.kernel.org>
 <8e87e98a0b261dcdca9beb41bd1cd5030a4690ab.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e87e98a0b261dcdca9beb41bd1cd5030a4690ab.camel@mediatek.com>
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

On Wed, Mar 30, 2022 at 04:48:47PM +0800, Irui Wang wrote:
> Dear Rob,
> 
> A sample encoder hardware block diagram attached.
> On Tue, 2022-03-29 at 08:09 -0500, Rob Herring wrote:
> > On Tue, Mar 29, 2022 at 09:26:37AM +0800, Irui Wang wrote:
> > > Dear Rob,
> > > 
> > > Many thanks for your attention.
> > > 
> > > On Mon, 2022-03-28 at 08:48 -0500, Rob Herring wrote:
> > > > On Sat, Mar 26, 2022 at 10:00:55AM +0800, Irui Wang wrote:
> > > > > Dear Rob,
> > > > > 
> > > > > Thanks for your review and comments.
> > > > > 
> > > > > On Fri, 2022-03-25 at 15:57 -0500, Rob Herring wrote:
> > > > > > On Thu, Mar 17, 2022 at 04:22:23PM +0800, Irui Wang wrote:
> > > > > > > Adds encoder cores dt-bindings for mt8195.
> > 
> > [...]
> > 
> > > > > > > +      mediatek,core-id:
> > > > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > +        description: |
> > > > > > > +          Current encoder core id.
> > > > > > 
> > > > > > What is this for and what does its value correspond to in the
> > > > > > h/w.
> > > > > > We 
> > > > > > generally don't do made up indices in DT.
> > > > > 
> > > > > It's for encoder core id, core@1a020000 must be core-0, 
> > > > > core@1b020000
> > > > > must be core-1, we add this property in each child node, so we
> > > > > can 
> > > > > get core-id in drivers. If it can't ref "uint32" types yaml,
> > > > > would 
> > > > > you mind giving some more suggestions ?
> > > > 
> > > > I still don't understand why it is needed. What is 'core-0'?
> > > > 
> > > > Is there some functional difference between the cores? If so,
> > > > describe 
> > > > that difference.
> > > > 
> > > > Rob
> > > 
> > > They are two different pieces of hardware, it's our encoder
> > > hardware
> > > design. There are two encoder hardware cores inside MT8195, named
> > > core0
> > > and core1(we can rename it, but core id should be declared),
> > > for core0, its module base address is 0x1A02_0000, uses IOMMU
> > > "vdo0_iommu" and power domain "POWER_DOMAIN_VENC",
> > > for core1, its module base address is 0x1B02_0000, uses IOMMU
> > > "vpp_iommu" and power domain "POWER_DOMAIN_VENC_CORE1".
> > > So the two encoder cores have their own base, IRQ, clock, power,
> > > etc.
> > > Each core can encode independently, moreover, they can work
> > > together
> > > for higher performance. 
> > > We will describe more details in YAML about it if it's OK for you.
> > 
> > All the resources you list are in the child nodes, so you don't need
> > 0 
> > and 1 numbering for those. 
> > 
> > Looking at the driver patches, the only thing I see distinguishing 
> > core numbers is this:
> > 
> > "frame#0 uses core#0, frame#1 uses core#1, frame#2 uses core#0...,
> > 
> > Lock the device and enable the clock by used core, for sequence
> > header encoding, it always uses core#0."
> > 
> > Is this a requirement in the h/w or just what the driver picked?
> > IOW, 
> > could frame#0 use core#1?
> No, it's a requirement in the h/w, driver trigger core start encoding
> is in order.
> About the encoder hardware block diagram, please check below:
> --------------------------------------------------------------
> Input Buffer: 0     1     2     3     4     5     6
>               |     |     |     |     |     |     |
>               v     |     v     |     v     |     v
>           +-------+ | +-------+ | +-------+ | +-------+
>           | core0 | | | core0 | | | core0 | | | core0 |
>           +-------+ | +-------+ | +-------+ | +-------+
>               |     |     |     |     |     |     |
>               |     v     |     v     |     v     |
>               | +-------+ | +-------+ | +-------+ |
>               | | core1 | | | core1 | | | core1 | |
>               | +-------+ | +-------+ | +-------+ |
>               |     |     |     |     |     |     |
>               v     v     v     v     v     v     v    <parent>
> --------------------------------------------------------------
>                         core || index                  <child>
>                              \/
>        +-----------------------------------------------+
>        |                  core0/core1                  |
>        |          enable/disable power/clk/irq         |
>        +-----------------------------------------------+
> --------------------------------------------------------------
> As above , there are parent and child devices, child mean each venc
> core, the child device controls the information of each core
> independent which inlcude power/clk/irq.
> When start encoding, input buffer 0 will be encoded by core0, and input
> buffer 1 can be encoded by core1 even if buffer 0 has not been encoded
> done yet, after buffer 0 encoded done, buffer 2 will be encoded by
> core0, and buffer 1 encoded done by core1. These two encoder cores will
> encode each input in this overlapping manner.
> 
> We need manage each child device in parent device by core-id property.
> And we also need record current encoding input buffer, encode done
> output buffers and which one core is in used through core-id, because
> the two cores are encoding at the same time under one parent driver.

Okay, please summarize the h/w requirement in the property description.

You might put the above diagram in the top description too.

Rob
