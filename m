Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC5284E5E25
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 06:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347174AbiCXFcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 01:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345762AbiCXFcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 01:32:48 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD4490FC9;
        Wed, 23 Mar 2022 22:31:12 -0700 (PDT)
X-UUID: 3adf9d07ec0d4988b759eb87e86a33be-20220324
X-UUID: 3adf9d07ec0d4988b759eb87e86a33be-20220324
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 162818175; Thu, 24 Mar 2022 13:31:06 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 24 Mar 2022 13:31:05 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 24 Mar 2022 13:31:04 +0800
Message-ID: <6c331bb8e95aa7c1a88a6161622f51ff2fee3f98.camel@mediatek.com>
Subject: Re: [v6 1/4] ASoC: dt-bindings: mt8192-mt6359: add new compatible
 and new properties
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     Tzung-Bi Shih <tzungbi@kernel.org>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>,
        <angelogioacchino.delregno@collabora.com>, <aaronyu@google.com>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <linmq006@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Thu, 24 Mar 2022 13:31:04 +0800
In-Reply-To: <YjvBLf/8M1WUS/L+@google.com>
References: <20220323164442.921-1-jiaxin.yu@mediatek.com>
         <20220323164442.921-2-jiaxin.yu@mediatek.com> <YjvBLf/8M1WUS/L+@google.com>
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

On Thu, 2022-03-24 at 08:54 +0800, Tzung-Bi Shih wrote:
> On Thu, Mar 24, 2022 at 12:44:39AM +0800, Jiaxin Yu wrote:
> > +  speaker-codec:
> 
> If it is possible to have 1 or more items, would "speaker-codecs" be
> a better
> name?

Hi Tzung-Bi,

Yes, it is better to use "speaker-codecs", I will change it that in
driver patch and bindings patch.

Jiaxin.Yu
Thanks
> 
> > +    type: object
> > +    properties:
> > +      sound-dai:
> > +        minItems: 2
> 
> It should be 1.  Consider of rt1015p case.

Yes, I will correct it.

