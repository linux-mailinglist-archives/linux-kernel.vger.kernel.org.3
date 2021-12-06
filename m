Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F68469A00
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:02:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345302AbhLFPEu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:04:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345381AbhLFPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:03:47 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ECF9C0698DD;
        Mon,  6 Dec 2021 07:00:10 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id 4FBD11F44803
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=collabora.com; s=mail;
        t=1638802808; bh=GdCGPmly0UuQ6WjSsNws2p+iDG85TsB+eBdXAeJYWKo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=K0fNGcFVKt7O287APEpkAIFNWACJowOJtubES7YzU18wZK9tNnX6ZS0kbADSNKC+Y
         am0NkVRHfnoQTQJlzPZjKnz30qgm4Whf1fMoJ36ZW7tuuwUON8yNfV5KB1fLGF4qLz
         wRT4fRML+iDArFocVdBPGhXWssHAcEDtuY3zEl7XnqGMC9g8Nu3Z34O6qjezjYx2+p
         Jm3G8SkDOksXBYgZgWNmR8ZXro02agCanHvdBQG3jB7N6mGf3ioJSxk1lPrjf/msEu
         rhasgGlGOHR52V1irMnWJcut59XIHV0ggwnbxyB9JXfc+GJvqg6CTW6oYAXy015cKw
         WjK2fAddW3VRw==
Subject: Re: [PATCH 4/4] memory: mtk-smi: mt8186: Add smi support
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, lc.kan@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-5-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <417ec223-b49a-c8dc-c53a-7831cca4d2d1@collabora.com>
Date:   Mon, 6 Dec 2021 16:00:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211203064027.14993-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/12/21 07:40, Yong Wu ha scritto:
> Add mt8186 SMI support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>


Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
