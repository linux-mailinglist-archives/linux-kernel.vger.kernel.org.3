Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB905B1A28
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 12:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiIHKiZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 06:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiIHKiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 06:38:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44EB5ABF1B;
        Thu,  8 Sep 2022 03:38:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8B7561C43;
        Thu,  8 Sep 2022 10:38:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EC0C433C1;
        Thu,  8 Sep 2022 10:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662633482;
        bh=aVgNvnlf+obNPZ41468yJSBJvyr5RJlsGyre5mdxcLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gBSxgTWuXbBZWViin4YyOhV6IqZykDgfz4WKfqifjkTCw1a01+owwQGyjrVwq4w9x
         OQQTd6eWP83SseyVesif4Xo1Vu+7C9IsDlMjCDBTgQTt3EhWY3q9kdPtzefXvl/EwG
         cx2uvALOusP+EvU4opD7ylyHs81mwuV1KuL9HEBmB/9xLxPY+UIohbiXWb1EdaHLgB
         mtTzhgfjpt3cGxTG3g4P1lTs9gFf5RZu/sL4/T4CoUVA8Z6URnoPqe+cPS4bHcPvqG
         jRXticwyf92yNDifATJqVcrBkg+oq4jJyWOhkRBOex2F6LnmzeBY3wToBK/Fq73Psd
         JUIrBCAVWR1Dw==
Date:   Thu, 8 Sep 2022 11:37:56 +0100
From:   Lee Jones <lee@kernel.org>
To:     matthias.bgg@kernel.org
Cc:     robh+dt@kernel.org, angelogioacchino.delregno@collabora.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        mandyjh.liu@mediatek.com, linux-arm-kernel@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>
Subject: Re: [PATCH v2] dt-bindings: mfd: Rename mediatek,mt8195-scpsys.yaml
Message-ID: <YxnGBN4QEb1yMrGw@google.com>
References: <20220830091110.27857-1-matthias.bgg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220830091110.27857-1-matthias.bgg@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022, matthias.bgg@kernel.org wrote:

> From: Matthias Brugger <mbrugger@suse.com>
> 
> The file describes the scpsys node for all SoCs and not only the mt8195.
> Rename it to reflect this fact.

Actually, this is fairly typical.  Same with actual drivers.

Both tend to adopt the name of the module first supported.

> Signed-off-by: Matthias Brugger <mbrugger@suse.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ---
> 
> Changes in v2:
> - Fix id
> 
>  .../mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml}   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/devicetree/bindings/mfd/{mediatek,mt8195-scpsys.yaml => mediatek,scpsys.yaml} (96%)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> similarity index 96%
> rename from Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> rename to Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> index 3737207d8504..1a5901ca90f5 100644
> --- a/Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml
> +++ b/Documentation/devicetree/bindings/mfd/mediatek,scpsys.yaml
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>  %YAML 1.2
>  ---
> -$id: http://devicetree.org/schemas/mfd/mediatek,mt8195-scpsys.yaml#
> +$id: http://devicetree.org/schemas/mfd/mediatek,scpsys.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>  
>  title: MediaTek System Control Processor System

-- 
Lee Jones [李琼斯]
