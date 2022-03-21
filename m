Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FD74E345C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 00:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232783AbiCUXcX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 19:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbiCUXcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 19:32:21 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7E3350092;
        Mon, 21 Mar 2022 16:30:50 -0700 (PDT)
X-UUID: 9153bbe7865c4bcc97157c3163476505-20220322
X-UUID: 9153bbe7865c4bcc97157c3163476505-20220322
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1947124393; Tue, 22 Mar 2022 07:30:46 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Mar 2022 07:30:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Mar 2022 07:30:45 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     <trevor.wu@mediatek.com>
CC:     <aaronyu@google.com>, <alsa-devel@alsa-project.org>,
        <angelogioacchino.delregno@collabora.com>, <broonie@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <robh+dt@kernel.org>, <tiwai@suse.com>, <tzungbi@google.com>,
        <yc.hung@mediatek.com>
Subject: Re: [PATCH v3 3/6] ASoC: dt-bindings: mediatek: mt8195: merge mt8195 machine yaml
Date:   Tue, 22 Mar 2022 07:30:45 +0800
Message-ID: <20220321233045.22156-1-miles.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220321072312.14972-4-trevor.wu@mediatek.com>
References: <20220321072312.14972-4-trevor.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Trevor,

>  
> -title: Mediatek MT8195 with MT6359, RT1019 and RT5682 ASoC sound card driver
> +title: Mediatek MT8195 ASoC sound card driver

s/Mediatek/MediaTek/

Thanks,
Miles
>  
>  maintainers:
>    - Trevor Wu <trevor.wu@mediatek.com>
> @@ -14,7 +14,9 @@ description:
>  
>  properties:
>    compatible:
> -    const: mediatek,mt8195_mt6359_rt1019_rt5682
> +    enum:
> +      - mediatek,mt8195_mt6359_rt1019_rt5682
> +      - mediatek,mt8195_mt6359_rt1011_rt5682
>  
>    model:
>      $ref: /schemas/types.yaml#/definitions/string
