Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C727B563C76
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Jul 2022 00:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiGAWnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 18:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiGAWnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 18:43:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6210C71252;
        Fri,  1 Jul 2022 15:43:51 -0700 (PDT)
Received: from notapiano (unknown [194.36.25.35])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1A08E66017F5;
        Fri,  1 Jul 2022 23:43:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1656715430;
        bh=enEhM+ScWkWY6bc7efSirQvyj6tgwMt92c5ptu/umHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DMUmZjWB02mge2cX2TXCLuo2I8S+05Q2LIsD7iwF1zJ+fpVsRzNQe7SiLNx+72uSo
         Z04c1xrsl0S0y/8FcQecaDnol/chS12TVc5BUlGu3rz+6JkHUWwQpnaEeP8wLNM9UR
         So2pDhnxQKsZsGUfEqlROCul+O6SLbnc9+LcJx9NAj/QCGfNfw70/mutuULyo9X74F
         +Nxs04BgtKwe2UlNwU6Z6HnY7Ke7cv7JLKzlEEAfdPYhwf42SmMuby3250NVp7OEPr
         BcyJhSarbX4pQR1KKOSqetRY4FFRX8z5GSnabPz2f/Ptfo/tiglQcJikzX4sjU5H8q
         tL7LbjOvP0n0A==
Date:   Fri, 1 Jul 2022 18:43:42 -0400
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
Subject: Re: [PATCH 08/11] arm64: dts: mediatek: cherry: Enable T-PHYs and
 USB XHCI controllers
Message-ID: <20220701224342.4rw6y6twgn2irssn@notapiano>
References: <20220630153316.308767-1-angelogioacchino.delregno@collabora.com>
 <20220630153316.308767-9-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220630153316.308767-9-angelogioacchino.delregno@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 30, 2022 at 05:33:13PM +0200, AngeloGioacchino Del Regno wrote:
> Add USB functionality by enabling the required PHYs and the XHCI
> controllers.
> This enables all of the supported USB ports on the Cherry boards.
> 
> Please note that u3phy1 also enables u3port1, which is configured
> to be a PCI-Express PHY for the second PCIe controller that is
> found on the MT8195 SoC, which will be enabled in a later commit.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

Thanks,
Nícolas
