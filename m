Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5027B4EAE29
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 15:09:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237150AbiC2NLc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 09:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiC2NLb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 09:11:31 -0400
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BDA5DF10;
        Tue, 29 Mar 2022 06:09:48 -0700 (PDT)
Received: by mail-ot1-f42.google.com with SMTP id z9-20020a05683020c900b005b22bf41872so12715970otq.13;
        Tue, 29 Mar 2022 06:09:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pgmVS6Ri5wIx578wOnaD17/Gk0HO8xT8dcbeURwXcvM=;
        b=jGGraEXM6HEYbCh2s7/DHpL1QheO2q0stI0MN4yYrXbH8Cwki/ZhPMQ3WLd2VEzGTm
         g1/e/63CHpcCTwUtl01im/IsYQ37vEZMu3q0/XJ6uo7Zqs5oGmWczCreze6PHM1U66M0
         j7trzPNoorEP1TEoYjdzT5LCOkXwdw/JBOSTrEjRaWzf50zdAcOOf8taM1hUM2oXjNNX
         cxDIGhDTZjBd7rp3CFkYYKfud3f4k1i0fssNgdvV9V6TzF3qw4jV5zYroCWKtk245iJ9
         gDe8bRRlvVqLLhgjq00lglqKuNk2RfiwyHYDpnvVu/tjVbvvoEvH65MaIJeDn1iDEbbS
         tDbQ==
X-Gm-Message-State: AOAM533+KjdCvgu91Lp/UMZtzbP5gz60/kN95sYuHSZVMHrYolt+hv4m
        w1FZmRZblCpZ9lGkG1IYmg==
X-Google-Smtp-Source: ABdhPJxz1vLRb+ULvjznOE3SueYbicXZjpLRanPIOSO+cxvPbO6krkNLY2qTn6KPl8CwI3JDJM2gsQ==
X-Received: by 2002:a9d:5614:0:b0:5b2:5fe3:8f1c with SMTP id e20-20020a9d5614000000b005b25fe38f1cmr1052711oti.229.1648559387820;
        Tue, 29 Mar 2022 06:09:47 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id li20-20020a056871421400b000deaa91898fsm6115814oab.40.2022.03.29.06.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 06:09:46 -0700 (PDT)
Received: (nullmailer pid 482676 invoked by uid 1000);
        Tue, 29 Mar 2022 13:09:45 -0000
Date:   Tue, 29 Mar 2022 08:09:45 -0500
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
Message-ID: <YkMFGbgYq5DhLjt8@robh.at.kernel.org>
References: <20220317082230.23622-1-irui.wang@mediatek.com>
 <20220317082230.23622-4-irui.wang@mediatek.com>
 <Yj4s0zcHxz3U3wlc@robh.at.kernel.org>
 <ab2b24eeb51048227ad7b2ac659617a7da5b2e45.camel@mediatek.com>
 <YkG8ka1xY2k+HWi1@robh.at.kernel.org>
 <e41e909f85e3891edb6b66d7d5a810af103113c8.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e41e909f85e3891edb6b66d7d5a810af103113c8.camel@mediatek.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 09:26:37AM +0800, Irui Wang wrote:
> Dear Rob,
> 
> Many thanks for your attention.
> 
> On Mon, 2022-03-28 at 08:48 -0500, Rob Herring wrote:
> > On Sat, Mar 26, 2022 at 10:00:55AM +0800, Irui Wang wrote:
> > > Dear Rob,
> > > 
> > > Thanks for your review and comments.
> > > 
> > > On Fri, 2022-03-25 at 15:57 -0500, Rob Herring wrote:
> > > > On Thu, Mar 17, 2022 at 04:22:23PM +0800, Irui Wang wrote:
> > > > > Adds encoder cores dt-bindings for mt8195.

[...]

> > > > > +      mediatek,core-id:
> > > > > +        $ref: /schemas/types.yaml#/definitions/uint32
> > > > > +        description: |
> > > > > +          Current encoder core id.
> > > > 
> > > > What is this for and what does its value correspond to in the
> > > > h/w.
> > > > We 
> > > > generally don't do made up indices in DT.
> > > 
> > > It's for encoder core id, core@1a020000 must be core-0, 
> > > core@1b020000
> > > must be core-1, we add this property in each child node, so we can 
> > > get core-id in drivers. If it can't ref "uint32" types yaml, would 
> > > you mind giving some more suggestions ?
> > 
> > I still don't understand why it is needed. What is 'core-0'?
> > 
> > Is there some functional difference between the cores? If so,
> > describe 
> > that difference.
> > 
> > Rob
> 
> They are two different pieces of hardware, it's our encoder hardware
> design. There are two encoder hardware cores inside MT8195, named core0
> and core1(we can rename it, but core id should be declared),
> for core0, its module base address is 0x1A02_0000, uses IOMMU
> "vdo0_iommu" and power domain "POWER_DOMAIN_VENC",
> for core1, its module base address is 0x1B02_0000, uses IOMMU
> "vpp_iommu" and power domain "POWER_DOMAIN_VENC_CORE1".
> So the two encoder cores have their own base, IRQ, clock, power, etc.
> Each core can encode independently, moreover, they can work together
> for higher performance. 
> We will describe more details in YAML about it if it's OK for you.

All the resources you list are in the child nodes, so you don't need 0 
and 1 numbering for those. 

Looking at the driver patches, the only thing I see distinguishing 
core numbers is this:

"frame#0 uses core#0, frame#1 uses core#1, frame#2 uses core#0...,

Lock the device and enable the clock by used core, for sequence
header encoding, it always uses core#0."

Is this a requirement in the h/w or just what the driver picked? IOW, 
could frame#0 use core#1?

Rob
