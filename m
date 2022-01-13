Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E25048DAD4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 16:44:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236199AbiAMPoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 10:44:10 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47528 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiAMPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 10:44:08 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: kholk11)
        with ESMTPSA id CE6311F45F52
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1642088647;
        bh=6/+dlfLNM3D+Hszt2Kwf7aTx6h2TAzm3RNgnr8cTYlc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=jlRat1S8v7MXsUqwaDakFYZpb9nfOUeFwnRiVgojVB2kaP54DY/TDPrzBxZGiHBzR
         vmP/zuu2O2UrtAuYIY2k9rfhFYmIp1IXctc8f63ULezIfKZGD6EZwJE50dvhcuyVsX
         1dnZ2iE/CypEUn/mRu+oAoe1UFvO4vul0R9QZEoiNPQ1I8o0ZcnajKtj8TQOfLVpIg
         rlr34Wv92+UL6Knd68KrQUsloADAPSqIrA2aUg5SZX/8EwOtRLp5Z1/xYlSLZupE6M
         ZCoRJrIuOn5lsNbdgfiN30FTlk4moPwVCuCvKL2jpfuTNPeQjN2Tx1g145hf9Wax/r
         M35/ausu2Ha0Q==
Subject: Re: [PATCH v3 4/7] dt-bindings: memory: mediatek: Add mt8186 support
To:     Yong Wu <yong.wu@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Joerg Roedel <joro@8bytes.org>, Tomasz Figa <tfiga@chromium.org>,
        linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, youlin.pei@mediatek.com,
        anan.sun@mediatek.com, lc.kan@mediatek.com, yi.kuo@mediatek.com,
        anthony.huang@mediatek.com
References: <20220113111057.29918-1-yong.wu@mediatek.com>
 <20220113111057.29918-5-yong.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Message-ID: <153264b6-1cdb-c130-d72e-6dc29bb1afd9@collabora.com>
Date:   Thu, 13 Jan 2022 16:44:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20220113111057.29918-5-yong.wu@mediatek.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/01/22 12:10, Yong Wu ha scritto:
> Add mt8186 smi support in the bindings.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

