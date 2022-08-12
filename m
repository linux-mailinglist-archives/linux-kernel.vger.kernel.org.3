Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3094590F1D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:18:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbiHLKSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbiHLKSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:18:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5C8ABD68;
        Fri, 12 Aug 2022 03:18:23 -0700 (PDT)
X-UUID: afc2ab8757ae49e7b17dcb7b58e74bc2-20220812
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=B+FTuluiWmDsVQOUqUaDNHxDaF82USCHWPcShjP7BSg=;
        b=podX01h/X/elH/y1UR3zYDop7sVhdoJAzfSP2AQDFFqP8O5jGQhsYz+eR+RcwsHVIuO5Z4bRuCLtMtHeqxvPsSQwFo2obShscqkbuZsMHJgUIPLzKOKB/fPTNwNzppU3H6DSTXO0LhNhTpWZ6zCJUdI/UggFj93eHgeDbqOx1xY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:90b5856b-07f5-4065-b7d9-76d81486f2e5,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:5
X-CID-META: VersionHash:3d8acc9,CLOUDID:74c57c9c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: afc2ab8757ae49e7b17dcb7b58e74bc2-20220812
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1983268181; Fri, 12 Aug 2022 18:18:17 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Fri, 12 Aug 2022 18:18:16 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkmbs11n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Fri, 12 Aug 2022 18:18:16 +0800
Message-ID: <9173e1755f76d1fc34e3822eda138749ebbc7f73.camel@mediatek.com>
Subject: Re: [PATCH 3/3] dt-bindings: nvmem: mediatek: efuse: Add support
 for MT8188
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <broonie@kernel.org>, <srinivas.kandagatla@linaro.org>,
        <matthias.bgg@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
Date:   Fri, 12 Aug 2022 18:18:16 +0800
In-Reply-To: <20220715120114.4243-3-johnson.wang@mediatek.com>
References: <20220715120114.4243-1-johnson.wang@mediatek.com>
         <20220715120114.4243-3-johnson.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-07-15 at 20:01 +0800, Johnson Wang wrote:
> Add compatible for MT8188 SoC.
> 
> Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
> ---
> This patch is based on "linux-next"[1].
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> ---
>  Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git
> a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> index b5a1109f2ee1..75e0a516e59a 100644
> --- a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> +++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
> @@ -30,6 +30,7 @@ properties:
>                - mediatek,mt8173-efuse
>                - mediatek,mt8183-efuse
>                - mediatek,mt8186-efuse
> +              - mediatek,mt8188-efuse
>                - mediatek,mt8192-efuse
>                - mediatek,mt8195-efuse
>                - mediatek,mt8516-efuse

Hi Srinivas,

Just a gentle ping on this.
Could you please give me some suggestion on this patch?

Thank you very much.

BRs,
Johnson Wang

