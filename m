Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1924C19F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:36:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243410AbiBWRge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242141AbiBWRgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:36:32 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1EFE554A2;
        Wed, 23 Feb 2022 09:36:02 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id B13981F41250
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1645637761;
        bh=CSOlJtblEwB4RlgPahvcN3gy+e32KywvGIkmYOzijI0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YVngT9RX4Zl8QM2ArzTdGkd+v6f9P7vNkU8HsSyWpEFDVkJFkdig9Y38uTCEdsr5O
         5t6Ht9ZtyTDN+d1KqBwwOel2VU2Y6WYNaZMuFi3kjgIhHr7/Prog05ocB5CiV5IY2U
         ymtA7PWhTGWrPnYdV0zUaKANpOI6GJ/Jgn30ZmrySwXWP5kKbr/vxIFVvwllKBgATa
         NJkBmrDA9ZRwPK2lbqCDN+jOp/x4V7Lnt3XIN0vA6EYcRWItn8CGNs50sZwyOqazHQ
         RG2MZ7y+cz0OgnTVSm4lttyzqdgJtqyC2coEngJCR7pVwOH33+NjiCD0Zv5dcap+c2
         H3nWRyFpsEdow==
Date:   Wed, 23 Feb 2022 12:35:56 -0500
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Min Guo <Min.Guo@mediatek.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: phy: Add compatible for Mediatek MT8192
Message-ID: <20220223173556.u3dx7ugpxpcpir2n@notapiano>
References: <20220217135620.10559-1-allen-kh.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220217135620.10559-1-allen-kh.cheng@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Allen,

thanks for the patch. Please see the comment below.

On Thu, Feb 17, 2022 at 09:56:20PM +0800, Allen-KH Cheng wrote:
> This commit adds dt-binding documentation of T-Phy for Mediatek MT8192 SoC
> Platform.

Commit messages should be in imperative [1]. I'd suggest the following message:

	Add MT8192 compatible to the Mediatek T-PHY dt-binding.

[1] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#describe-your-changes

Also, the commit title would be better if it had the tag for the tphy file, like
this:

	dt-bindings: phy: mediatek,tphy: Add compatible for MT8192

Otherwise it's not clear that you're changing the T-PHY just from the title.

> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>

Other than that,

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas

> ---
>  Documentation/devicetree/bindings/phy/mediatek,tphy.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> index d279ba222316..7b2e1bc119be 100644
> --- a/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> +++ b/Documentation/devicetree/bindings/phy/mediatek,tphy.yaml
> @@ -81,6 +81,7 @@ properties:
>                - mediatek,mt7629-tphy
>                - mediatek,mt8183-tphy
>                - mediatek,mt8186-tphy
> +              - mediatek,mt8192-tphy
>            - const: mediatek,generic-tphy-v2
>        - items:
>            - enum:
> -- 
> 2.18.0
> 
> 
