Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE145112C4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 09:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359014AbiD0HrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 03:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358991AbiD0HrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 03:47:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C4E156E38;
        Wed, 27 Apr 2022 00:44:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F4076CE2021;
        Wed, 27 Apr 2022 07:43:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ACF2C385A9;
        Wed, 27 Apr 2022 07:43:55 +0000 (UTC)
Message-ID: <98a01f46-7fb0-6201-c9db-14e15d7e30c4@xs4all.nl>
Date:   Wed, 27 Apr 2022 09:43:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v2] dt-bindings: media: mtk-vcodec: Adds encoder power
 domain property
Content-Language: en-US
To:     Irui Wang <irui.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>
Cc:     Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        allen-kh.cheng@mediatek.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220427033130.18497-1-irui.wang@mediatek.com>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
In-Reply-To: <20220427033130.18497-1-irui.wang@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Irui,

I'm merging this patch from Nícolas F. R. A. Prado, which has already been Acked by Rob:

https://patchwork.linuxtv.org/project/linux-media/patch/20220225225854.81038-4-nfraprado@collabora.com/

If you still want the other changes you made in this patch merged, then please make
a v3 on top of Nícolas' patch.

Regards,

	Hans

On 27/04/2022 05:31, Irui Wang wrote:
> Adds encoder power domain property.
> 
> Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> ---
> changes compared with v1:
> - set "power-domains" as a non-required property
> 
> The 'make dtbs_check' warnings('mediatek,larb') can be fixed by patch:
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=633993
> ---
>  .../devicetree/bindings/media/mediatek,vcodec-encoder.yaml  | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> index deb5b657a2d5..2d1e0c9bd6ee 100644
> --- a/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> +++ b/Documentation/devicetree/bindings/media/mediatek,vcodec-encoder.yaml
> @@ -41,6 +41,9 @@ properties:
>  
>    assigned-clock-parents: true
>  
> +  power-domains:
> +    maxItems: 1
> +
>    iommus:
>      minItems: 1
>      maxItems: 32
> @@ -132,6 +135,7 @@ examples:
>      #include <dt-bindings/clock/mt8173-clk.h>
>      #include <dt-bindings/memory/mt8173-larb-port.h>
>      #include <dt-bindings/interrupt-controller/irq.h>
> +    #include <dt-bindings/power/mt8173-power.h>
>  
>      vcodec_enc_avc: vcodec@18002000 {
>        compatible = "mediatek,mt8173-vcodec-enc";
> @@ -153,6 +157,7 @@ examples:
>        clock-names = "venc_sel";
>        assigned-clocks = <&topckgen CLK_TOP_VENC_SEL>;
>        assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL>;
> +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC>;
>      };
>  
>      vcodec_enc_vp8: vcodec@19002000 {
> @@ -173,4 +178,5 @@ examples:
>        clock-names = "venc_lt_sel";
>        assigned-clocks = <&topckgen CLK_TOP_VENC_LT_SEL>;
>        assigned-clock-parents = <&topckgen CLK_TOP_VCODECPLL_370P5>;
> +      power-domains = <&scpsys MT8173_POWER_DOMAIN_VENC_LT>;
>      };

