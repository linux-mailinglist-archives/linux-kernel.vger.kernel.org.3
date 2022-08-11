Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43FBA58F81B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 09:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbiHKHGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 03:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234339AbiHKHF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 03:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4795F27146;
        Thu, 11 Aug 2022 00:05:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D9FCE61493;
        Thu, 11 Aug 2022 07:05:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B09C433C1;
        Thu, 11 Aug 2022 07:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660201556;
        bh=vgb3/iTI5YEipl1kcOFAk88wMPI+HRjfXvkzfOk4dAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RMT4dl/aSPCmwBksC4KD8yM9CKqtexuoW8BAjVm5/qyIXmACTc126EsybA4SAAkqR
         VSbhbb/lS6dq6M5pLbOGzsIwflmiNBkKTxgQhzBrtxh3N5eVL0RR3Py1KGTaABU8LJ
         UxTzfX9FmjRjGr0os1hsW2k+KS4Yr+0YVwJKZqUOuu3nng7g0r5FV7uFnryne4IAMT
         9hSL+EGYbKqm5OdsnShfASP9NJ/8sVoOcJVkX0neg8Dt1/PzM85iWBeBZxMGlwXk+k
         kYQ0WSSeXhoy8CWIk191DG3jUlbQxOf2nvrqwCOg7TlsfJ5Nmqgj9LjLlyOIYwNJsD
         hQ0q2RF4GUmmA==
Date:   Thu, 11 Aug 2022 08:05:48 +0100
From:   Lee Jones <lee@kernel.org>
To:     Tinghan Shen <tinghan.shen@mediatek.com>
Cc:     Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>, iommu@lists.linux.dev,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH v6 06/20] dt-bindings: power: mediatek: Add bindings for
 MediaTek SCPSYS
Message-ID: <YvSqTC0aV61sXbd3@google.com>
References: <20220811025813.21492-1-tinghan.shen@mediatek.com>
 <20220811025813.21492-7-tinghan.shen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220811025813.21492-7-tinghan.shen@mediatek.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2022, Tinghan Shen wrote:

> The System Control Processor System (SCPSYS) has several power
> management related tasks in the system. Add the bindings for it.
> 
> Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/mfd/mediatek,mt8195-scpsys.yaml  | 67 +++++++++++++++++++
>  .../power/mediatek,power-controller.yaml      |  2 +-
>  2 files changed, 68 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mfd/mediatek,mt8195-scpsys.yaml

Applied, thanks.

-- 
Lee Jones [李琼斯]
