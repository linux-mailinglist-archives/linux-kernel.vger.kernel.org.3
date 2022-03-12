Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 434784D6F36
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 14:32:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbiCLNdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 08:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiCLNdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 08:33:00 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 617D650E3A;
        Sat, 12 Mar 2022 05:31:51 -0800 (PST)
X-UUID: 99baf5ba28184cf080b2aedc2d23801a-20220312
X-UUID: 99baf5ba28184cf080b2aedc2d23801a-20220312
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <trevor.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1999243638; Sat, 12 Mar 2022 21:31:45 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 12 Mar 2022 21:31:44 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Mar 2022 21:31:43 +0800
Message-ID: <bb5737baf5c7430ccc40d7cfeaa1bc1a7c8890af.camel@mediatek.com>
Subject: Re: [PATCH 2/5] dt-bindings: mediatek: mt8195: add reset property
From:   Trevor Wu <trevor.wu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     <broonie@kernel.org>, <tiwai@suse.com>, <matthias.bgg@gmail.com>,
        <alsa-devel@alsa-project.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <aaronyu@google.com>, <yc.hung@mediatek.com>
Date:   Sat, 12 Mar 2022 21:31:43 +0800
In-Reply-To: <Yip3z3XoarN8TeMn@robh.at.kernel.org>
References: <20220308072435.22460-1-trevor.wu@mediatek.com>
         <20220308072435.22460-3-trevor.wu@mediatek.com>
         <Yip3z3XoarN8TeMn@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-03-10 at 16:12 -0600, Rob Herring wrote:
> On Tue, Mar 08, 2022 at 03:24:32PM +0800, Trevor Wu wrote:
> > Add required properties "resets" and "reset_names", which are used
> > to
> > specify audiosys hw reset for mt8195 afe driver.
> 
> The subject needs to be more specific and indicate this applies to
> ASoC 
> and mt8195-afe-pcm. Try to write subjects that could only ever
> appear 
> once as you can never make the same change twice.
> 
> Rob

Hi Rob,

Thanks for your suggestion.
I will revise the subject to "ASoC: dt-bindings: mediatek: mt8195-afe-
pcm: add reset property" in v2.

Thanks,
Trevor

