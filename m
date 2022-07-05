Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D075674D7
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 18:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbiGEQwQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 12:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiGEQwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 12:52:14 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30DEC1DA7E;
        Tue,  5 Jul 2022 09:52:14 -0700 (PDT)
Received: from notapiano (pool-98-113-53-228.nycmny.fios.verizon.net [98.113.53.228])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BCF8766015CC;
        Tue,  5 Jul 2022 17:52:11 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657039932;
        bh=UttKVZOt1YH4wTXBPy+uccKMn+S4wfEPch8Ann4x4fU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OmPk0x2Rpj3k94LO12T8Dh8hCCCwft5+4WUti3Av8PMbU2OA/qaysosNCWac2Wr7n
         muoJGNj/HWNIYntLIJICsdA+WOh/ih/e2PYMCJ46moeAYQmltmBXofEfenIbTCNVJy
         cIyHoaXpscWhFAoYd7HkfbJGzCG9skQos5Xl9Ibgehj37EuTbsEi8dczFQx+ay6vKS
         6CSiIFafFfEzqRuMwwTNdgnhxSpIkwO64hGGUUTfPl+tAlBk0pWHqrjZpey1vhr8M3
         YVo3DV0w+Zo9gsfo+jpgX6arZgdFBKF+g9vOOlFIx+qNPZnJ0leyX9gSGyPBpvgPh+
         jn5orayEpx2JA==
Date:   Tue, 5 Jul 2022 12:52:08 -0400
From:   =?utf-8?B?TsOtY29sYXMgRi4gUi4gQS4=?= Prado 
        <nfraprado@collabora.com>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sean.wang@mediatek.com, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: mt8195: Add gpio-line-names
 property
Message-ID: <20220705165208.wvwlgx3gosw66xhr@notapiano>
References: <20220630110453.186526-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630110453.186526-1-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 01:04:53PM +0200, AngeloGioacchino Del Regno wrote:
> Add the 'gpio-line-names' property to mt8195-pinctrl, as this will be
> used in devicetrees to describe pin names.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
