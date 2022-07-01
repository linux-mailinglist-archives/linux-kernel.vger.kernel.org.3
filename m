Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5E563C7B
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231732AbiGAWrb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:47:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiGAWr3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:47:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0154F71263;
        Fri,  1 Jul 2022 15:47:28 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DCACF6601802;
        Fri,  1 Jul 2022 23:47:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656715647;
        bh=6rL/5KNfhVkrrbxwBeTnlPeeQGPpZbWTfXtHgSvJc3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VanpHDr4EqVHHyN+VKaj+Oz7YS35DLbn6I2L2gC3xhLEtLp/T7vRpF/IAd06iqhxa
         t2JX+BbsR12GbJWeCMyoaq7iAiJxTET6RYSSOuj0crcpbYTjsH1I+C1IM2I8XadKUl
         WiRc+RHV3Q5oulSEAO1JNXNgebZ5kARTjV2ziSLtqGMRdIwDpKl4lzMBY+JocSRGXW
         tMEmG4euLAaRD4C5hNO0WwPutCh0ccGwb5+KpxTf++DcUC3YFpIYb1uQ1v+xX1r0ef
         S4mbstlHQMMdQd3yWNqmep+b8g/Ye+2lF9G67vl4qO7BP5pSruut4+sZBrBbS6RL7A
         /8B/qfD68SQkQ==
Date:   Fri, 1 Jul 2022 18:47:20 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com, hsinyi@chromium.org,
        allen-kh.cheng@mediatek.com, gtk3@inbox.ru, luca@z3ntu.xyz,
        sam.shih@mediatek.com, sean.wang@mediatek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, wenst@chromium.org
Subject: Re: [PATCH 10/11] arm64: dts: mediatek: cherry: Enable support for
 the SPI NOR flash
Message-ID: <20220701224720.xwtc55lguwhh3fvn@notapiano>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-11-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630153316.308767-11-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:33:15PM +0200, AngeloGioacchino Del Regno wrote:
> This platform has a SPI NOR: enable support for it, completing the
> storage compartment enablement for the entire platform.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
