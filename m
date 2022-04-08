Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80F84F8DCE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233960AbiDHDpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 23:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiDHDpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:45:12 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F108B6C1;
        Thu,  7 Apr 2022 20:43:10 -0700 (PDT)
X-UUID: e904f502777a4528b0b966f05d543c3c-20220408
X-UUID: e904f502777a4528b0b966f05d543c3c-20220408
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <jiaxin.yu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1523501793; Fri, 08 Apr 2022 11:43:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 8 Apr 2022 11:43:02 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 8 Apr 2022 11:43:01 +0800
Message-ID: <505ab354843d9360887e8052a3dbf6712317c6fd.camel@mediatek.com>
Subject: Re: [v9 2/4] ASoC: mediatek: mt8192: refactor for I2S3 DAI link of
 speaker
From:   Jiaxin Yu <jiaxin.yu@mediatek.com>
To:     "=?ISO-8859-1?Q?N=EDcolas?= F. R. A. Prado" <nfraprado@collabora.com>
CC:     <broonie@kernel.org>, <robh+dt@kernel.org>, <tzungbi@google.com>,
        <angelogioacchino.delregno@collabora.com>, <aaronyu@google.com>,
        <matthias.bgg@gmail.com>, <trevor.wu@mediatek.com>,
        <linmq006@gmail.com>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 8 Apr 2022 11:43:01 +0800
In-Reply-To: <20220407212420.tncc576jo5iwaqk7@notapiano>
References: <20220406100514.11269-1-jiaxin.yu@mediatek.com>
         <20220406100514.11269-3-jiaxin.yu@mediatek.com>
         <20220407212420.tncc576jo5iwaqk7@notapiano>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-04-07 at 17:24 -0400, Nícolas F. R. A. Prado wrote:
> Hi Jiaxin,
> 
> On Wed, Apr 06, 2022 at 06:05:12PM +0800, Jiaxin Yu wrote:
> > MT8192 platform will use rt1015 or rt1015p codec, so through the
> > snd_soc_of_get_dai_link_codecs() to complete the configuration
> > of dai_link's codecs.
> 
> Suggestion for the commit message:
> 
> As part of the refactoring to allow the same machine driver to be
> used for the
> rt1015(p) and rt5682(s) codecs on the MT8192 platform, parse the
> rt1015(p)
> codecs from the speaker-codecs property in the devicetree and wire
> them to the
> I2S3 backend, instead of hardcoding the links and selecting through
> the
> compatible.
> 
Hi Nícolas,

I will update the commit message according to the rule of one row per
75 columns. I will also refer to your suggestions to modify the rest of
the series. Thanks for your review.

Jiaxin.Yu
Thanks.

> > 
> > Signed-off-by: Jiaxin Yu <jiaxin.yu@mediatek.com>
> 
> Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> Tested-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> - Tested on mt8192-asurada-spherion (rt1015p and rt5682). All audio
> paths still
>   work as previous to this refactor. And it's still possible to omit
>   mediatek,hdmi-codec.
> 
> Thanks,
> Nícolas

