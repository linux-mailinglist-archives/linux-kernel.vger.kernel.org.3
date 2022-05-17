Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE70B52A59A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349582AbiEQPEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 11:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349584AbiEQPEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 11:04:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBA0286F1;
        Tue, 17 May 2022 08:04:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id 642481F446FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652799858;
        bh=HLTx3V5C/OLEk5npKnb0rmPGaBqjbq5wK3wrkZrxIQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=njxYRTJEyx5yTxdeQiH/V252FsF0rqTyFmDAZlpkn2YM06QBP8W6+1qSw0rk/AIwe
         gD8pfLNF97nmxJNFZsEazZrm4BaxxFj6g539Vyg0CC4cKIjgZ46hOUsjNFUSvQ+5rE
         01mXrUjWHcRJEgRlGxWbsnHBg+4gZ1r+5Sp993VYSwIEoVBwFF8s3bB4gjEPFOAYA0
         JS+ZBB4KRwxSQPBpzxARzVbcjqdSGq9iZ5PRxibTdHrti1mWjJ+Sorxs4oJTwF222Y
         J01gwsjf78f71dn6IgOGghNCV2yFJUDO+xx9Ao0hBNMylvEN9ceuI/LDY2w90sT1hF
         pFdzY1cIzLrNQ==
Date:   Tue, 17 May 2022 11:04:13 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, sboyd@kernel.org,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        wenst@chromium.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] dt-bindings: arm: mt8192-clock: Remove unnecessary
 'items'
Message-ID: <20220517150413.pnhbvzz2upcmjebi@notapiano>
References: <20220517101514.21639-1-angelogioacchino.delregno@collabora.com>
 <20220517101514.21639-6-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517101514.21639-6-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 12:15:13PM +0200, AngeloGioacchino Del Regno wrote:
> There's no need for 'items' when there's only one item.
> 
> Fixes: 4a803990aeb1 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
>  .../arm/mediatek/mediatek,mt8192-clock.yaml   | 45 +++++++++----------
>  1 file changed, 22 insertions(+), 23 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> index c8c67c033f8c..bb410b178f33 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mt8192-clock.yaml
> @@ -14,29 +14,28 @@ description:
>  
>  properties:
>    compatible:
> -    items:
> -      - enum:
> -          - mediatek,mt8192-scp_adsp
> -          - mediatek,mt8192-imp_iic_wrap_c
> -          - mediatek,mt8192-imp_iic_wrap_e
> -          - mediatek,mt8192-imp_iic_wrap_s
> -          - mediatek,mt8192-imp_iic_wrap_ws
> -          - mediatek,mt8192-imp_iic_wrap_w
> -          - mediatek,mt8192-imp_iic_wrap_n
> -          - mediatek,mt8192-msdc_top
> -          - mediatek,mt8192-msdc
> -          - mediatek,mt8192-mfgcfg
> -          - mediatek,mt8192-imgsys
> -          - mediatek,mt8192-imgsys2
> -          - mediatek,mt8192-vdecsys_soc
> -          - mediatek,mt8192-vdecsys
> -          - mediatek,mt8192-vencsys
> -          - mediatek,mt8192-camsys
> -          - mediatek,mt8192-camsys_rawa
> -          - mediatek,mt8192-camsys_rawb
> -          - mediatek,mt8192-camsys_rawc
> -          - mediatek,mt8192-ipesys
> -          - mediatek,mt8192-mdpsys
> +    enum:
> +      - mediatek,mt8192-scp_adsp
> +      - mediatek,mt8192-imp_iic_wrap_c
> +      - mediatek,mt8192-imp_iic_wrap_e
> +      - mediatek,mt8192-imp_iic_wrap_s
> +      - mediatek,mt8192-imp_iic_wrap_ws
> +      - mediatek,mt8192-imp_iic_wrap_w
> +      - mediatek,mt8192-imp_iic_wrap_n
> +      - mediatek,mt8192-msdc_top
> +      - mediatek,mt8192-msdc
> +      - mediatek,mt8192-mfgcfg
> +      - mediatek,mt8192-imgsys
> +      - mediatek,mt8192-imgsys2
> +      - mediatek,mt8192-vdecsys_soc
> +      - mediatek,mt8192-vdecsys
> +      - mediatek,mt8192-vencsys
> +      - mediatek,mt8192-camsys
> +      - mediatek,mt8192-camsys_rawa
> +      - mediatek,mt8192-camsys_rawb
> +      - mediatek,mt8192-camsys_rawc
> +      - mediatek,mt8192-ipesys
> +      - mediatek,mt8192-mdpsys

This will conflict with the patch removing msdc:

[1] https://lore.kernel.org/all/20220429123133.28869-1-matthias.bgg@kernel.org/

Although if this series is merged before that one, it should be fine.

Thanks,
Nícolas
